From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: check if inode's state is dirty or not
 before skip fsync
Date: Thu, 4 Dec 2014 16:58:29 -0800
Message-ID: <20141205005828.GA1756@jaegeuk-mac02>
References: <1417417520-7192-1-git-send-email-cm224.lee@samsung.com>
 <20141201225257.GA67455@jaegeuk-mac02.mot.com>
 <20141202042131.GC7824@lcm>
 <20141202194219.GA73433@jaegeuk-mac02.mot.com>
 <20141203014638.GA17349@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141203014638.GA17349@lcm>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Dec 03, 2014 at 10:46:38AM +0900, Changman Lee wrote:
> Hi Jaegeuk,
> 
> Thanks for explanation.
> 
> On Tue, Dec 02, 2014 at 11:42:19AM -0800, Jaegeuk Kim wrote:
> > On Tue, Dec 02, 2014 at 01:21:31PM +0900, Changman Lee wrote:
> > > Hi,
> > > 
> > > f2fs_dirty_inode just set fi->flag as FI_DIRTY_INODE not to
> > > call update_inode_page. Instead, we do it when f2fs_write_indoe is called.
> > > Do you have any reason to do like this?
> > 
> > Actually, I'd like to use inode caches instead of dirty node pages as much as
> > possible to mitigate memory pressure as well as reduce node page writes.
> > But, the reality is that f2fs triggers update_inode_page frequently, since some
> > inode information like i_blocks and i_links should be recovered consistently
> > from sudden power-cuts.
> 
> I got it. No objection.
> 
> > 
> > > How about move update_inode_page from write_inode to dirty_inode?
> > > And we can update inode page when mark_inode_dirty or
> > > mark_inode_dirty_sync is called. Then, we control write I/O in
> > > write_inode according to wbc->sync_mode.
> > 
> > What do you mean controlling write I/O in write_inode?
> > The write_inode does not trigger any I/Os.
> > We're controlling node page writes by f2fs_write_node_pages.
> 
> Sorry, it's not enough for my explanation.
> At __writeback_single_inode, it calls write_inode if inode is dirty.
> And at ext4_write_inode and btrfs_write_inode, they issue write
> according to wbc->sync_mode. However, current f2fs doesn't issue any
> write i/o. Could you review it?

Hi,

Well, I'm not quite sure that f2fs should do this.
In terms of recovery, we don't need to do this.

> 
> > 
> > Anyway, if we call update_inode_page in mark_inode_dirty, f2fs would suffer from
> > a lot of dirty node pages.
> 
> Got it. But I think we should write dirty node after
> update_inode_page in write_inode if wbc->sync_mode == WB_SYNC_ALL.

Why do we have to do this?
Again, there is no problem wrt recovery, but that causes unnecessary IOs.

> 
> 
> Finally, I have one more question.
> At f2fs_sync_file, in the case of need_cp is true and file_wrong_pino
> f2fs calls write_inode. But the inode isn't written back. Is it okay?
> Could you elaborate on it?

No problem. That pino will be used only for fsynced inodes after checkpoint.

Thanks,

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > > Could you consider this once?
> > > 
> > > Thanks,
> > > 
> > > On Mon, Dec 01, 2014 at 02:52:57PM -0800, Jaegeuk Kim wrote:
> > > > On Mon, Dec 01, 2014 at 04:05:20PM +0900, Changman Lee wrote:
> > > > > It makes sense to check inode's state than check if
> > > > > inode page is dirty or not.
> > > > 
> > > > Nice catch.
> > > > However, we should leave the original condition, since write_inode can be called
> > > > in prior to this fsync call.
> > > > And, this is not a proper fix, since it still can skip to write its inode page. 
> > > > 
> > > > How about this one?
> > > > 
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 146e58a..6690599 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -168,6 +168,12 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> > > >  		return ret;
> > > >  	}
> > > >  
> > > > +	/* if the inode is dirty, let's recover all the time */
> > > > +	if (is_inode_flag_set(fi, FI_DIRTY_INODE)) {
> > > > +		update_inode_page(inode);
> > > > +		goto go_write;
> > > > +	}
> > > > +
> > > >  	/*
> > > >  	 * if there is no written data, don't waste time to write recovery info.
> > > >  	 */
> > > > -- 
> > > > 2.1.1
> > > > 
> > > > > 
> > > > > Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> > > > > ---
> > > > >  fs/f2fs/file.c | 7 ++-----
> > > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > index 7c2ec3e..0c5ae87 100644
> > > > > --- a/fs/f2fs/file.c
> > > > > +++ b/fs/f2fs/file.c
> > > > > @@ -173,14 +173,11 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> > > > >  	 */
> > > > >  	if (!is_inode_flag_set(fi, FI_APPEND_WRITE) &&
> > > > >  			!exist_written_data(sbi, ino, APPEND_INO)) {
> > > > > -		struct page *i = find_get_page(NODE_MAPPING(sbi), ino);
> > > > >  
> > > > >  		/* But we need to avoid that there are some inode updates */
> > > > > -		if ((i && PageDirty(i)) || need_inode_block_update(sbi, ino)) {
> > > > > -			f2fs_put_page(i, 0);
> > > > > +		if (is_inode_flag_set(fi, FI_DIRTY_INODE) ||
> > > > > +					need_inode_block_update(sbi, ino))
> > > > >  			goto go_write;
> > > > > -		}
> > > > > -		f2fs_put_page(i, 0);
> > > > >  
> > > > >  		if (is_inode_flag_set(fi, FI_UPDATE_WRITE) ||
> > > > >  				exist_written_data(sbi, ino, UPDATE_INO))
> > > > > -- 
> > > > > 1.9.1
> > > > > 
> > > > > 
> > > > > ------------------------------------------------------------------------------
> > > > > Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> > > > > from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> > > > > with Interactivity, Sharing, Native Excel Exports, App Integration & more
> > > > > Get technology previously reserved for billion-dollar corporations, FREE
> > > > > http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> > > > > _______________________________________________
> > > > > Linux-f2fs-devel mailing list
> > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
