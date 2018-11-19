From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix m_may_create to make OPU DIO write
 correctly
Date: Mon, 19 Nov 2018 14:24:04 +0800
Message-ID: <beca2c1c-034c-c77e-6dd7-1c26fe919835@huawei.com>
References: <20181116194142.6343-1-zhujia13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gOcyu-0003h1-NH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 06:24:24 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gOcyq-005zu9-VN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 06:24:24 +0000
In-Reply-To: <20181116194142.6343-1-zhujia13@huawei.com>
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
To: Jia Zhu <zhujia13@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, jaizhu.zj@gmail.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jia,

On 2018/11/17 3:41, Jia Zhu wrote:
> Commit 7bc0f46d418a ("f2fs: fix out-place-update DIO write")

Commit 7bc0f46d418a was just in dev-test branch, so the commit id will
change after being merged into linus' tree.

> added a parameter map.m_may_create to replace @create for
> triggering OPU allocation correctly.
> 
> But we find it is still in-place-update when used AndroBench
> to test this feature.In f2fs_map_blocks(), @create has been
> overwritten by the code below. So the function can not allocate
> new block address and directly go out.
> code:
> create = dio->op == REQ_OP_WRITE;
> if (dio->flags & DIO_SKIP_HOLES) {
> 	if (fs_startblk <= ((i_size_read(dio->inode) -1) >>i_blkbits))
> 		create = 0;
> 		}

For DIO_SKIP_HOLES flag's semantics, it needs local filesystem to skip
allocating physical data block if we encounter hole inside filesize during
DIO write.

How about keeping this semantics since we are still using it in
f2fs_direct_IO().

	err = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
			iter, rw == WRITE ? get_data_block_dio_write :
			get_data_block_dio, NULL, f2fs_dio_submit_bio,
			DIO_LOCKING | DIO_SKIP_HOLES);
				      ^^^^^^^^^^^^^^^

> 
> This patch use @map.m_may_create to replace @create to avoid
> this problem.
> 
> Signed-off-by: Jia Zhu <zhujia13@huawei.com>
> ---
>  fs/f2fs/data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8780f3d..9b61cba 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1034,7 +1034,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	pgofs =	(pgoff_t)map->m_lblk;
>  	end = pgofs + maxblocks;
>  
> -	if (!create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
> +	if (!map->m_may_create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {

So here, how about just skip returning existed block address during aligned
DIO writing in LFS-mode?

	if (!create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
		if (test_opt(sbi, LFS) && flag == F2FS_GET_BLOCK_DIO &&
							map->m_may_create)
			goto next_dnode;

>  		map->m_pblk = ei.blk + pgofs - ei.fofs;
>  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
>  		map->m_flags = F2FS_MAP_MAPPED;
> @@ -1093,7 +1093,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  				set_inode_flag(inode, FI_APPEND_WRITE);
>  		}
>  	} else {
> -		if (create) {
> +		if (map->m_may_create) {

We don't need to change this condition due to DIO_SKIP_HOLES, right?

Thanks,

>  			if (unlikely(f2fs_cp_error(sbi))) {
>  				err = -EIO;
>  				goto sync_out;
> 
