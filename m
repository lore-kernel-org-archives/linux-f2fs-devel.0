From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: check if inode's state is dirty or not
 before skip fsync
Date: Tue, 02 Dec 2014 13:21:31 +0900
Message-ID: <20141202042131.GC7824@lcm>
References: <1417417520-7192-1-git-send-email-cm224.lee@samsung.com>
 <20141201225257.GA67455@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20141201225257.GA67455@jaegeuk-mac02.mot.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

f2fs_dirty_inode just set fi->flag as FI_DIRTY_INODE not to
call update_inode_page. Instead, we do it when f2fs_write_indoe is called.
Do you have any reason to do like this?
How about move update_inode_page from write_inode to dirty_inode?
And we can update inode page when mark_inode_dirty or
mark_inode_dirty_sync is called. Then, we control write I/O in
write_inode according to wbc->sync_mode.
Could you consider this once?

Thanks,

On Mon, Dec 01, 2014 at 02:52:57PM -0800, Jaegeuk Kim wrote:
> On Mon, Dec 01, 2014 at 04:05:20PM +0900, Changman Lee wrote:
> > It makes sense to check inode's state than check if
> > inode page is dirty or not.
> 
> Nice catch.
> However, we should leave the original condition, since write_inode can be called
> in prior to this fsync call.
> And, this is not a proper fix, since it still can skip to write its inode page. 
> 
> How about this one?
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 146e58a..6690599 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -168,6 +168,12 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  		return ret;
>  	}
>  
> +	/* if the inode is dirty, let's recover all the time */
> +	if (is_inode_flag_set(fi, FI_DIRTY_INODE)) {
> +		update_inode_page(inode);
> +		goto go_write;
> +	}
> +
>  	/*
>  	 * if there is no written data, don't waste time to write recovery info.
>  	 */
> -- 
> 2.1.1
> 
> > 
> > Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> > ---
> >  fs/f2fs/file.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 7c2ec3e..0c5ae87 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -173,14 +173,11 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >  	 */
> >  	if (!is_inode_flag_set(fi, FI_APPEND_WRITE) &&
> >  			!exist_written_data(sbi, ino, APPEND_INO)) {
> > -		struct page *i = find_get_page(NODE_MAPPING(sbi), ino);
> >  
> >  		/* But we need to avoid that there are some inode updates */
> > -		if ((i && PageDirty(i)) || need_inode_block_update(sbi, ino)) {
> > -			f2fs_put_page(i, 0);
> > +		if (is_inode_flag_set(fi, FI_DIRTY_INODE) ||
> > +					need_inode_block_update(sbi, ino))
> >  			goto go_write;
> > -		}
> > -		f2fs_put_page(i, 0);
> >  
> >  		if (is_inode_flag_set(fi, FI_UPDATE_WRITE) ||
> >  				exist_written_data(sbi, ino, UPDATE_INO))
> > -- 
> > 1.9.1
> > 
> > 
> > ------------------------------------------------------------------------------
> > Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> > from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> > with Interactivity, Sharing, Native Excel Exports, App Integration & more
> > Get technology previously reserved for billion-dollar corporations, FREE
> > http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
