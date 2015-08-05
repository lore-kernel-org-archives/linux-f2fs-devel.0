From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: invalidate temporary meta page
Date: Wed, 05 Aug 2015 17:26:33 +0800
Message-ID: <00a001d0cf60$ea45fe10$bed1fa30$@samsung.com>
References: <00e801d0c921$647ad660$2d708320$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <00e801d0c921$647ad660$2d708320$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

Any comments?

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Tuesday, July 28, 2015 6:37 PM
> To: Jaegeuk Kim
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: invalidate temporary meta page
> 
> To avoid meeting garbage data in next free node block at the end of warm
> node chain when doing recovery, we will try to zero out that invalid block.
> 
> If the device is not support discard, our way for zeroing out block is:
> grabbing a temporary zeroed page in meta inode, then, issue write request
> with this page.
> 
> But, we forget to release that temporary page, so our memory usage will
> increase without gaining any hit ratio benefit, so it's better to free it
> for saving memory.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/checkpoint.c | 13 ++++++++++++-
>  fs/f2fs/f2fs.h       |  2 +-
>  fs/f2fs/recovery.c   | 11 ++++++++++-
>  fs/f2fs/segment.c    |  9 ++++++---
>  4 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 6fb696d..84e0dfe 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -888,12 +888,15 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control
> *cpc)
>  	__u32 crc32 = 0;
>  	int i;
>  	int cp_payload_blks = __cp_payload(sbi);
> +	block_t discard_blk = NEXT_FREE_BLKADDR(sbi, curseg);
> +	bool invalidate = false;
> 
>  	/*
>  	 * This avoids to conduct wrong roll-forward operations and uses
>  	 * metapages, so should be called prior to sync_meta_pages below.
>  	 */
> -	discard_next_dnode(sbi, NEXT_FREE_BLKADDR(sbi, curseg));
> +	if (discard_next_dnode(sbi, discard_blk))
> +		invalidate = true;
> 
>  	/* Flush all the NAT/SIT pages */
>  	while (get_pages(sbi, F2FS_DIRTY_META)) {
> @@ -1022,6 +1025,14 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control
> *cpc)
>  	/* wait for previous submitted meta pages writeback */
>  	wait_on_all_pages_writeback(sbi);
> 
> +	/*
> +	 * invalidate meta page which is used temporarily for zeroing out
> +	 * block at the end of warm node chain.
> +	 */
> +	if (invalidate)
> +		invalidate_mapping_pages(META_MAPPING(sbi), discard_blk,
> +								discard_blk);
> +
>  	release_dirty_inode(sbi);
> 
>  	if (unlikely(f2fs_cp_error(sbi)))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5d1f88c..0a6b9f1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1714,7 +1714,7 @@ void invalidate_blocks(struct f2fs_sb_info *, block_t);
>  void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
>  void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
>  void release_discard_addrs(struct f2fs_sb_info *);
> -void discard_next_dnode(struct f2fs_sb_info *, block_t);
> +bool discard_next_dnode(struct f2fs_sb_info *, block_t);
>  int npages_for_summary_flush(struct f2fs_sb_info *, bool);
>  void allocate_new_segments(struct f2fs_sb_info *);
>  int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 24a8c1d..07a36e4 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -561,11 +561,20 @@ out:
> 
>  	clear_sbi_flag(sbi, SBI_POR_DOING);
>  	if (err) {
> -		discard_next_dnode(sbi, blkaddr);
> +		bool invalidate = false;
> +
> +		if (discard_next_dnode(sbi, blkaddr))
> +			invalidate = true;
> 
>  		/* Flush all the NAT/SIT pages */
>  		while (get_pages(sbi, F2FS_DIRTY_META))
>  			sync_meta_pages(sbi, META, LONG_MAX);
> +
> +		/* invalidate temporary meta page */
> +		if (invalidate)
> +			invalidate_mapping_pages(META_MAPPING(sbi),
> +							blkaddr, blkaddr);
> +
>  		set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
>  		mutex_unlock(&sbi->cp_mutex);
>  	} else if (need_writecp) {
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4712dbc..1ad3cf3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -517,7 +517,7 @@ static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
>  	return blkdev_issue_discard(sbi->sb->s_bdev, start, len, GFP_NOFS, 0);
>  }
> 
> -void discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
> +bool discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
>  {
>  	int err = -ENOTSUPP;
> 
> @@ -527,13 +527,16 @@ void discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
>  		unsigned int offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> 
>  		if (f2fs_test_bit(offset, se->discard_map))
> -			return;
> +			return false;
> 
>  		err = f2fs_issue_discard(sbi, blkaddr, 1);
>  	}
> 
> -	if (err)
> +	if (err) {
>  		update_meta_page(sbi, NULL, blkaddr);
> +		return true;
> +	}
> +	return false;
>  }
> 
>  static void __add_discard_entry(struct f2fs_sb_info *sbi,
> --
> 2.4.2
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
