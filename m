From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: use bio count instead of F2FS_WRITEBACK
 page count
Date: Wed, 18 May 2016 09:17:00 +0800
Message-ID: <1b8251a2-bc07-cfe2-21b0-c189cf74ca1f@huawei.com>
References: <1463532272-64148-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463532272-64148-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/5/18 8:44, Jaegeuk Kim wrote:
> This can reduce page counting overhead.

We change to increase one reference for one bio, but block layer can split or
merge bios by itself, and write_end will be called per bio, so the reference may
be maintained incorrectly?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  2 +-
>  fs/f2fs/data.c       | 26 +++++++++++++++-----------
>  fs/f2fs/debug.c      |  6 +++---
>  fs/f2fs/f2fs.h       |  4 ++--
>  fs/f2fs/super.c      |  2 +-
>  5 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index d04113b..447e2a9 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -914,7 +914,7 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
>  	for (;;) {
>  		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
>  
> -		if (!get_pages(sbi, F2FS_WRITEBACK))
> +		if (!atomic_read(&sbi->nr_wb_bios))
>  			break;
>  
>  		io_schedule_timeout(5*HZ);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 1013836..faef666 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -71,10 +71,9 @@ static void f2fs_write_end_io(struct bio *bio)
>  			f2fs_stop_checkpoint(sbi);
>  		}
>  		end_page_writeback(page);
> -		dec_page_count(sbi, F2FS_WRITEBACK);
>  	}
> -
> -	if (!get_pages(sbi, F2FS_WRITEBACK) && wq_has_sleeper(&sbi->cp_wait))
> +	if (atomic_dec_and_test(&sbi->nr_wb_bios) &&
> +				wq_has_sleeper(&sbi->cp_wait))
>  		wake_up(&sbi->cp_wait);
>  
>  	bio_put(bio);
> @@ -98,6 +97,14 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
>  	return bio;
>  }
>  
> +static inline void __submit_bio(struct f2fs_sb_info *sbi, int rw,
> +						struct bio *bio)
> +{
> +	if (!is_read_io(rw))
> +		atomic_inc(&sbi->nr_wb_bios);
> +	submit_bio(rw, bio);
> +}
> +
>  static void __submit_merged_bio(struct f2fs_bio_info *io)
>  {
>  	struct f2fs_io_info *fio = &io->fio;
> @@ -110,7 +117,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
>  	else
>  		trace_f2fs_submit_write_bio(io->sbi->sb, fio, io->bio);
>  
> -	submit_bio(fio->rw, io->bio);
> +	__submit_bio(io->sbi, fio->rw, io->bio);
>  	io->bio = NULL;
>  }
>  
> @@ -228,7 +235,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  		return -EFAULT;
>  	}
>  
> -	submit_bio(fio->rw, bio);
> +	__submit_bio(fio->sbi, fio->rw, bio);
>  	return 0;
>  }
>  
> @@ -248,9 +255,6 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>  
>  	down_write(&io->io_rwsem);
>  
> -	if (!is_read)
> -		inc_page_count(sbi, F2FS_WRITEBACK);
> -
>  	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
>  						io->fio.rw != fio->rw))
>  		__submit_merged_bio(io);
> @@ -1047,7 +1051,7 @@ got_it:
>  		 */
>  		if (bio && (last_block_in_bio != block_nr - 1)) {
>  submit_and_realloc:
> -			submit_bio(READ, bio);
> +			__submit_bio(F2FS_I_SB(inode), READ, bio);
>  			bio = NULL;
>  		}
>  		if (bio == NULL) {
> @@ -1090,7 +1094,7 @@ set_error_page:
>  		goto next_page;
>  confused:
>  		if (bio) {
> -			submit_bio(READ, bio);
> +			__submit_bio(F2FS_I_SB(inode), READ, bio);
>  			bio = NULL;
>  		}
>  		unlock_page(page);
> @@ -1100,7 +1104,7 @@ next_page:
>  	}
>  	BUG_ON(pages && !list_empty(pages));
>  	if (bio)
> -		submit_bio(READ, bio);
> +		__submit_bio(F2FS_I_SB(inode), READ, bio);
>  	return 0;
>  }
>  
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 37615b2..a188973 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -48,7 +48,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
>  	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
>  	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
> -	si->wb_pages = get_pages(sbi, F2FS_WRITEBACK);
> +	si->wb_bios = atomic_read(&sbi->nr_wb_bios);
>  	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
>  	si->rsvd_segs = reserved_segments(sbi);
>  	si->overp_segs = overprovision_segments(sbi);
> @@ -299,8 +299,8 @@ static int stat_show(struct seq_file *s, void *v)
>  		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
>  				si->ext_tree, si->zombie_tree, si->ext_node);
>  		seq_puts(s, "\nBalancing F2FS Async:\n");
> -		seq_printf(s, "  - inmem: %4d, wb: %4d\n",
> -			   si->inmem_pages, si->wb_pages);
> +		seq_printf(s, "  - inmem: %4d, wb_bios: %4d\n",
> +			   si->inmem_pages, si->wb_bios);
>  		seq_printf(s, "  - nodes: %4d in %4d\n",
>  			   si->ndirty_node, si->node_pages);
>  		seq_printf(s, "  - dents: %4d in dirs:%4d\n",
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1351178..bc45a2c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -650,7 +650,6 @@ struct f2fs_sm_info {
>   * dirty dentry blocks, dirty node blocks, and dirty meta blocks.
>   */
>  enum count_type {
> -	F2FS_WRITEBACK,
>  	F2FS_DIRTY_DENTS,
>  	F2FS_DIRTY_DATA,
>  	F2FS_DIRTY_NODES,
> @@ -813,6 +812,7 @@ struct f2fs_sb_info {
>  	block_t discard_blks;			/* discard command candidats */
>  	block_t last_valid_block_count;		/* for recovery */
>  	u32 s_next_generation;			/* for NFS support */
> +	atomic_t nr_wb_bios;			/* # of writeback bios */
>  	atomic_t nr_pages[NR_COUNT_TYPE];	/* # of pages, see count_type */
>  
>  	struct f2fs_mount_info mount_opt;	/* mount options */
> @@ -2017,7 +2017,7 @@ struct f2fs_stat_info {
>  	int ndirty_dent, ndirty_dirs, ndirty_data, ndirty_files;
>  	int nats, dirty_nats, sits, dirty_sits, fnids;
>  	int total_count, utilization;
> -	int bg_gc, inmem_pages, wb_pages;
> +	int bg_gc, inmem_pages, wb_bios;
>  	int inline_xattr, inline_inode, inline_dir, orphans;
>  	unsigned int valid_count, valid_node_count, valid_inode_count;
>  	unsigned int bimodal, avg_vblocks;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 9df6d72..c21e662 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -649,7 +649,7 @@ static void f2fs_put_super(struct super_block *sb)
>  	mutex_unlock(&sbi->umount_mutex);
>  
>  	/* our cp_error case, we can wait for any writeback page */
> -	if (get_pages(sbi, F2FS_WRITEBACK))
> +	if (atomic_read(&sbi->nr_wb_bios))
>  		f2fs_flush_merged_bios(sbi);
>  
>  	iput(sbi->node_inode);
> 
