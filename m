From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/8] f2fs: support data flush in checkpoint
Date: Tue, 15 Dec 2015 13:58:42 -0800
Message-ID: <20151215215842.GA66113@jaegeuk.local>
References: <00f801d136fa$324a5070$96def150$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00f801d136fa$324a5070$96def150$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Tue, Dec 15, 2015 at 01:33:18PM +0800, Chao Yu wrote:
> Previously, when finishing a checkpoint, we only keep consistency of all fs
> meta info including meta inode, node inode, dentry page of directory inode,
> so, after a sudden power cut, f2fs can recover from last checkpoint with
> full directory structure.
> 
> But during checkpoint, we didn't flush dirty pages of regular and symlink
> inode, so such dirty datas still in memory will be lost in that moment of
> power off.
> 
> In order to reduce the chance of lost data, this patch tries to flush user
> data before starting a checkpoint. So user's data written between two
> checkpoint which may not be fsynced could be saved.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/checkpoint.c | 11 +++++++++++
>  fs/f2fs/f2fs.h       |  5 +++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index f33c4d7..217571f 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -849,6 +849,17 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  
>  	blk_start_plug(&plug);
>  
> +retry_flush_datas:
> +	/* write all the dirty data pages */
> +	if (get_pages(sbi, F2FS_DIRTY_DATAS)) {
> +		sync_dirty_inodes(sbi, FILE_INODE);
> +		if (unlikely(f2fs_cp_error(sbi))) {
> +			err = -EIO;
> +			goto out;
> +		}
> +		goto retry_flush_datas;
> +	}
> +

Please don't do like this; our checkpoint should be different from system sync.
I don't want to increase the checkpoint latency at all even in f2fs_gc as well.

I think that something like this would be better.

In f2fs_balance_fs_bg(),
	if (!avaliable_free_memory() || ...) {
		if (test_opt(DATA_FLUSH))
			sync_dirty_inodes(FILE_INODE);
		f2fs_sync_fs();
	}

Please add its mount option with a disabled one first.

>  retry_flush_dents:
>  	f2fs_lock_all(sbi);
>  	/* write all the dirty dentry pages */
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d8bef3c..2477b2f5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -648,6 +648,7 @@ struct f2fs_sm_info {
>  enum count_type {
>  	F2FS_WRITEBACK,
>  	F2FS_DIRTY_DENTS,
> +	F2FS_DIRTY_DATAS,

This should be F2FS_DIRTY_DATA.

And, it'd better to merge this part into your previous patch:
 "f2fs: record dirty status of regular/symlink inodes"

I'll do that, so please check it out later from dev-test.

>  	F2FS_DIRTY_NODES,
>  	F2FS_DIRTY_META,
>  	F2FS_INMEM_PAGES,
> @@ -1068,6 +1069,8 @@ static inline void inode_inc_dirty_pages(struct inode *inode)
>  	atomic_inc(&F2FS_I(inode)->dirty_pages);
>  	if (S_ISDIR(inode->i_mode))
>  		inc_page_count(F2FS_I_SB(inode), F2FS_DIRTY_DENTS);
> +	else
> +		inc_page_count(F2FS_I_SB(inode), F2FS_DIRTY_DATAS);

ditto.

>  }
>  
>  static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
> @@ -1085,6 +1088,8 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
>  
>  	if (S_ISDIR(inode->i_mode))
>  		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_DENTS);
> +	else
> +		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_DATAS);

ditto.

>  }
>  
>  static inline int get_pages(struct f2fs_sb_info *sbi, int count_type)
> -- 
> 2.6.3
> 
