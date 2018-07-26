From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH RFC] fsck.f2fs: write checkpoint out of place
 first
Date: Thu, 26 Jul 2018 19:52:58 +0800
Message-ID: <ba2d2576-1ee5-b887-48e0-a29ced4d3985@huawei.com>
References: <20180724152849.240933-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fiepV-0004aC-7f
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 11:53:13 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fiepT-0097nO-C2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 11:53:13 +0000
In-Reply-To: <20180724152849.240933-1-guoweichao@huawei.com>
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
To: Weichao Guo <guoweichao@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/24 23:28, Weichao Guo wrote:
> We may encounter both checkpoints invalid in such a case:
> 1. write checkpoint A, B, C;
> 2. sudden power-cut during write checkpoint D;
> 3. fsck changes the total block count of checkpoint C;
> 4. sudden power-cut during fsck write checkpoint C in place
> 
>  ---------           ---------
> |  ver C  |         |  ver D  |
> |   ...   |         |   ...   |
> | content |         | content |
> |   ...   |         |   ...   |
> |  ver C  |         |         |
> |  ver A  |         |  ver B  |
>  ---------           ---------
> 
> As the total # of checkpoint C is changed, an old cp block
> like ver A or an invalid cp block may be referenced.
> To avoid both checkpoints invalid, and considering fsck should
> not update the checkpoint version, fsck could write checkpoint
> out of place first and then write checkpoint in place. This
> makes sure the file system is fixed by fsck and at least one
> of the two checkpoints is valid.
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fsck/fsck.c  | 13 ++++++++++++-
>  fsck/mount.c | 13 ++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 91c8529..28320d5 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -1954,6 +1954,7 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
>  	u32 i;
>  	int ret;
>  	u_int32_t crc = 0;
> +	int phase = 0;
>  
>  	if (is_set_ckpt_flags(cp, CP_ORPHAN_PRESENT_FLAG)) {
>  		orphan_blks = __start_sum_addr(sbi) - 1;
> @@ -1975,9 +1976,11 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
>  	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
>  
>  	cp_blk_no = get_sb(cp_blkaddr);
> -	if (sbi->cur_cp == 2)
> +	/* write checkpoint with current version out of place first */
> +	if (sbi->cur_cp == 1)
>  		cp_blk_no += 1 << get_sb(log_blocks_per_seg);
>  
> +next_step:
>  	ret = dev_write_block(cp, cp_blk_no++);
>  	ASSERT(ret >= 0);
>  
> @@ -2002,6 +2005,14 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
>  	/* Write nat bits */
>  	if (flags & CP_NAT_BITS_FLAG)
>  		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
> +
> +	if (phase == 0) {
> +		cp_blk_no = get_sb(cp_blkaddr);
> +		if (sbi->cur_cp == 2)
> +			cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> +		phase++;
> +		goto next_step;

Before goes to second round, we need to keep all cached data being persistent,
so additional fsync() is needed?

Since we are trying to implement OPU style checkpoint() in f2fs-tools, can you
check whether all caller of {fix,write}_checkpoint() need such logic?

Thanks,

> +	}
>  }
>  
>  int check_curseg_offset(struct f2fs_sb_info *sbi)
> diff --git a/fsck/mount.c b/fsck/mount.c
> index e5574c5..8d7a9bb 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -2088,6 +2088,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  	u32 flags = CP_UMOUNT_FLAG;
>  	int i, ret;
>  	u_int32_t crc = 0;
> +	int phase = 0;
>  
>  	if (is_set_ckpt_flags(cp, CP_ORPHAN_PRESENT_FLAG)) {
>  		orphan_blks = __start_sum_addr(sbi) - 1;
> @@ -2105,9 +2106,11 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
>  
>  	cp_blk_no = get_sb(cp_blkaddr);
> -	if (sbi->cur_cp == 2)
> +	/* write checkpoint with current version out of place first */
> +	if (sbi->cur_cp == 1)
>  		cp_blk_no += 1 << get_sb(log_blocks_per_seg);
>  
> +next_step:
>  	/* write the first cp */
>  	ret = dev_write_block(cp, cp_blk_no++);
>  	ASSERT(ret >= 0);
> @@ -2142,6 +2145,14 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  	/* write the last cp */
>  	ret = dev_write_block(cp, cp_blk_no++);
>  	ASSERT(ret >= 0);
> +
> +	if (phase == 0) {
> +		cp_blk_no = get_sb(cp_blkaddr);
> +		if (sbi->cur_cp == 2)
> +			cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> +		phase++;
> +		goto next_step;
> +	}
>  }
>  
>  void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
