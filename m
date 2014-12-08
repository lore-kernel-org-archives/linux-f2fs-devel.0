From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: clear track info related to write
 mode all the time
Date: Mon, 8 Dec 2014 10:53:25 -0800
Message-ID: <20141208185325.GA18956@jaegeuk-mac02.mot.com>
References: <1418020182-5356-1-git-send-email-cm224.lee@samsung.com>
 <1418020182-5356-3-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418020182-5356-3-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On Mon, Dec 08, 2014 at 03:29:42PM +0900, Changman Lee wrote:
> In case of checkpoint is called at fsync, we should clear track info.
> Otherwise, remained track info may influence to inode flag next
> eviction.

In do_checkpoint, release_dirty_inode() already removed UPDATE|APPEND_INO.
So, let's just drop the inode flags.

Thanks,

> 
> Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> ---
>  fs/f2fs/file.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 3c27e0e..3860fb8 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -177,6 +177,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  	nid_t ino = inode->i_ino;
>  	int ret = 0;
>  	bool need_cp = false;
> +	bool flush = true;
>  	struct writeback_control wbc = {
>  		.sync_mode = WB_SYNC_ALL,
>  		.nr_to_write = LONG_MAX,
> @@ -238,10 +239,11 @@ go_write:
>  
>  		/*
>  		 * We've secured consistency through sync_fs. Following pino
> -		 * will be used only for fsynced inodes after checkpoint.
> +		 * will be used only for inodes to be fsynced after checkpoint.
>  		 */
>  		try_to_fix_pino(inode);
> -		goto out;
> +		flush = false;
> +		goto flush_cleanup;
>  	}
>  sync_nodes:
>  	sync_node_pages(sbi, ino, &wbc);
> @@ -256,13 +258,15 @@ sync_nodes:
>  	if (ret)
>  		goto out;
>  
> -	/* once recovery info is written, don't need to tack this */
> +	/* once recovery info is written, don't need to track this */
> +flush_cleanup:
>  	remove_dirty_inode(sbi, ino, APPEND_INO);
>  	clear_inode_flag(fi, FI_APPEND_WRITE);
>  flush_out:
>  	remove_dirty_inode(sbi, ino, UPDATE_INO);
>  	clear_inode_flag(fi, FI_UPDATE_WRITE);
> -	ret = f2fs_issue_flush(sbi);
> +	if (flush)
> +		ret = f2fs_issue_flush(sbi);
>  out:
>  	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
>  	return ret;
> -- 
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
