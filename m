From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix m_may_create to make OPU DIO
 write correctly
Date: Tue, 20 Nov 2018 19:58:40 +0800
Message-ID: <c72e1624-1c9f-1a21-385e-badb2fc5d641@kernel.org>
References: <20181116194142.6343-1-zhujia13@huawei.com>
 <20181119202935.206643-1-zhujia13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gP4gA-0008NI-95
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Nov 2018 11:58:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gP4g6-00F0t7-Hj
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Nov 2018 11:58:54 +0000
In-Reply-To: <20181119202935.206643-1-zhujia13@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jia Zhu <zhujia13@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: jaizhu.zj@gmail.com, linux-f2fs-devel@lists.sourceforge.net

On 2018-11-20 4:29, Jia Zhu wrote:
> Previously, we added a parameter @map.m_may_create to trigger OPU
> allocation and call f2fs_balance_fs() correctly.
> 
> But in get_more_blocks(), @create has been overwritten by below code.
> So the function f2fs_map_blocks() will not allocate new block address
> but directly go out. Meanwile,there are several functions calling
> f2fs_map_blocks() directly and @map.m_may_create not initialized.

Oh, I missed to check all f2fs_map_blocks structure referrers, sorry.

> CODE:
> create = dio->op == REQ_OP_WRITE;
> 	if (dio->flags & DIO_SKIP_HOLES) {
> 		if (fs_startblk <= ((i_size_read(dio->inode) - 1) >>
> 						i_blkbits))
> 			create = 0;
> 	}
> 
> This patch fixes it.
> 
> Signed-off-by: Jia Zhu <zhujia13@huawei.com>> ---

It will be better to add simple change logs here to indicate how you modify your
patch comparing to previous one, please keep that rule for your next patch. ;)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  fs/f2fs/data.c | 5 +++++
>  fs/f2fs/file.c | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index aa8843a..7226300 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1052,6 +1052,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	end = pgofs + maxblocks;
>  
>  	if (!create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
> +		if (test_opt(sbi, LFS) && flag == F2FS_GET_BLOCK_DIO &&
> +							map->m_may_create)
> +			goto next_dnode;
> +
>  		map->m_pblk = ei.blk + pgofs - ei.fofs;
>  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
>  		map->m_flags = F2FS_MAP_MAPPED;
> @@ -1261,6 +1265,7 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
>  	map.m_next_pgofs = NULL;
>  	map.m_next_extent = NULL;
>  	map.m_seg_type = NO_CHECK_TYPE;
> +	map.m_may_create = false;
>  	last_lblk = F2FS_BLK_ALIGN(pos + len);
>  
>  	while (map.m_lblk < last_lblk) {
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 3271830..ff82350 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2201,7 +2201,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  {
>  	struct inode *inode = file_inode(filp);
>  	struct f2fs_map_blocks map = { .m_next_extent = NULL,
> -					.m_seg_type = NO_CHECK_TYPE };
> +					.m_seg_type = NO_CHECK_TYPE ,
> +					.m_may_create = false };
>  	struct extent_info ei = {0, 0, 0};
>  	pgoff_t pg_start, pg_end, next_pgofs;
>  	unsigned int blk_per_seg = sbi->blocks_per_seg;
> @@ -2935,6 +2936,7 @@ int f2fs_precache_extents(struct inode *inode)
>  	map.m_next_pgofs = NULL;
>  	map.m_next_extent = &m_next_extent;
>  	map.m_seg_type = NO_CHECK_TYPE;
> +	map.m_may_create = false;
>  	end = F2FS_I_SB(inode)->max_file_blocks;
>  
>  	while (map.m_lblk < end) {
> 
