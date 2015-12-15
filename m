From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 8/8] f2fs: fix to avoid deadlock between checkpoint and
 writepages
Date: Tue, 15 Dec 2015 14:01:28 -0800
Message-ID: <20151215220128.GB66113@jaegeuk.local>
References: <00fb01d136fa$97e29d70$c7a7d850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00fb01d136fa$97e29d70$c7a7d850$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Tue, Dec 15, 2015 at 01:36:08PM +0800, Chao Yu wrote:
> This patch fixes to move f2fs_balance_fs out of sbi->writepages'
> coverage to avoid potential ABBA deadlock which was found by lockdep:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&sbi->writepages);
>                                 lock(&sbi->cp_mutex);
>                                 lock(&sbi->writepages);
>    lock(&sbi->cp_mutex);
> 
>   *** DEADLOCK ***

I expect it will be fine if syncing is done by f2fs_balance_fs_bg().

Thanks,

> 
> stack of CPU0:
> [<ffffffff810b8dd1>] __lock_acquire+0x1321/0x1770
> [<ffffffff810b92d7>] lock_acquire+0xb7/0x130
> [<ffffffff817ad082>] mutex_lock_nested+0x52/0x380
> [<ffffffffa07b767b>] f2fs_balance_fs+0x8b/0xa0 [f2fs]
> [<ffffffffa07afb5b>] f2fs_write_data_page+0x33b/0x460 [f2fs]
> [<ffffffffa07ab79a>] __f2fs_writepage+0x1a/0x50 [f2fs]
> [<ffffffffa07ac693>] T.1541+0x293/0x560 [f2fs]
> [<ffffffffa07aca8c>] f2fs_write_data_pages+0x12c/0x230 [f2fs]
> [<ffffffff8118adb3>] do_writepages+0x23/0x40
> [<ffffffff8117c545>] __filemap_fdatawrite_range+0xb5/0xf0
> [<ffffffff8117c623>] filemap_write_and_wait_range+0xa3/0xd0
> [<ffffffffa079cc20>] f2fs_symlink+0x180/0x300 [f2fs]
> [<ffffffff81208187>] vfs_symlink+0xb7/0xe0
> [<ffffffff8120acc5>] SyS_symlinkat+0xc5/0x100
> [<ffffffff81205ad6>] SyS_symlink+0x16/0x20
> [<ffffffff817b15d7>] entry_SYSCALL_64_fastpath+0x12/0x6f
> 
> stack of CPU1
> [<ffffffff810b92d7>] lock_acquire+0xb7/0x130
> [<ffffffff817ad082>] mutex_lock_nested+0x52/0x380
> [<ffffffffa07aca7e>] f2fs_write_data_pages+0x11e/0x230 [f2fs]
> [<ffffffff8118adb3>] do_writepages+0x23/0x40
> [<ffffffff8117c545>] __filemap_fdatawrite_range+0xb5/0xf0
> [<ffffffff8117c9ef>] filemap_fdatawrite+0x1f/0x30
> [<ffffffffa07a728d>] sync_dirty_inodes+0x4d/0xd0 [f2fs]
> [<ffffffffa07a7381>] block_operations+0x71/0x160 [f2fs]
> [<ffffffffa07a85f8>] write_checkpoint+0xe8/0xbb0 [f2fs]
> [<ffffffffa07a043f>] f2fs_sync_fs+0x8f/0xf0 [f2fs]
> [<ffffffffa07b63af>] f2fs_balance_fs_bg+0x6f/0xd0 [f2fs]
> [<ffffffffa07b1c97>] f2fs_write_node_pages+0x57/0x150 [f2fs]
> [<ffffffff8118adb3>] do_writepages+0x23/0x40
> [<ffffffff8122c9ed>] __writeback_single_inode+0x6d/0x3d0
> [<ffffffff8122ec87>] writeback_sb_inodes+0x2c7/0x520
> [<ffffffff8122f193>] wb_writeback+0x133/0x330
> [<ffffffff8122f478>] wb_do_writeback+0xe8/0x270
> [<ffffffff8122f680>] wb_workfn+0x80/0x1f0
> [<ffffffff81081a1c>] process_one_work+0x20c/0x5c0
> [<ffffffff81083c62>] worker_thread+0x132/0x5f0
> [<ffffffff8108918e>] kthread+0xde/0x100
> [<ffffffff817b193f>] ret_from_fork+0x3f/0x70
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/data.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2e97057..985671d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -506,7 +506,6 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
>  	u64 end_offset;
>  
>  	while (len) {
> -		f2fs_balance_fs(sbi);
>  		f2fs_lock_op(sbi);
>  
>  		/* When reading holes, we need its node page */
> @@ -1186,7 +1185,7 @@ out:
>  	if (err)
>  		ClearPageUptodate(page);
>  	unlock_page(page);
> -	if (need_balance_fs)
> +	if (need_balance_fs && !test_opt(sbi, DATA_FLUSH))
>  		f2fs_balance_fs(sbi);
>  	if (wbc->for_reclaim) {
>  		f2fs_submit_merged_bio(sbi, DATA, WRITE);
> @@ -1617,6 +1616,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
>  
>  	if (rw == WRITE) {
> +		f2fs_balance_fs(sbi);
> +
>  		if (serialized)
>  			mutex_lock(&sbi->writepages);
>  		__allocate_data_blocks(inode, offset, count);
> -- 
> 2.6.3
> 
