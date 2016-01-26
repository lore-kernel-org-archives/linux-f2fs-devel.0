From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 4/6] f2fs: avoid multiple node page writes due
 to	inline_data
Date: Tue, 26 Jan 2016 10:48:20 -0800
Message-ID: <20160126184820.GB39785@jaegeuk.gateway>
References: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
 <1453759531-16076-4-git-send-email-jaegeuk@kernel.org>
 <008b01d157fc$40e660b0$c2b32210$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <008b01d157fc$40e660b0$c2b32210$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Tue, Jan 26, 2016 at 01:41:05PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, January 26, 2016 6:05 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 4/6] f2fs: avoid multiple node page writes due to inline_data
> > 
> > The sceanrio is:
> > 1. create fully node blocks
> > 2. flush node blocks
> > 3. write inline_data for all the node blocks again
> > 4. flush node blocks redundantly
> > 
> > So, this patch tries to flush inline_data when flushing node blocks.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c   |  1 +
> >  fs/f2fs/inline.c |  2 ++
> >  fs/f2fs/node.c   | 39 +++++++++++++++++++++++++++++++++++++++
> >  fs/f2fs/node.h   | 15 +++++++++++++++
> >  4 files changed, 57 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 89a37ba..260c0eb 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1463,6 +1463,7 @@ restart:
> >  		if (pos + len <= MAX_INLINE_DATA) {
> >  			read_inline_data(page, ipage);
> >  			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
> > +			set_inline_node(ipage);
> >  			sync_inode_page(&dn);
> >  		} else {
> >  			err = f2fs_convert_inline_page(&dn, page);
> > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > index 8df13e5..fc4d298 100644
> > --- a/fs/f2fs/inline.c
> > +++ b/fs/f2fs/inline.c
> > @@ -159,6 +159,7 @@ no_update:
> > 
> >  	/* clear inline data and flag after data writeback */
> >  	truncate_inline_inode(dn->inode_page, 0);
> > +	clear_inline_node(dn->inode_page);
> >  clear_out:
> >  	stat_dec_inline_inode(dn->inode);
> >  	f2fs_clear_inline_inode(dn->inode);
> > @@ -233,6 +234,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
> >  	set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
> > 
> >  	sync_inode_page(&dn);
> > +	clear_inline_node(dn.inode_page);
> >  	f2fs_put_dnode(&dn);
> >  	return 0;
> >  }
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 23b800d..94a6755 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1154,6 +1154,37 @@ void sync_inode_page(struct dnode_of_data *dn)
> >  	dn->node_changed = ret ? true: false;
> >  }
> > 
> > +static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
> > +{
> > +	struct inode *inode;
> > +	struct page *page;
> > +
> > +	/* should flush inline_data before evict_inode */
> > +	inode = ilookup(sbi->sb, ino);
> > +	if (!inode)
> > +		return;
> > +
> > +	page = pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
> > +	if (!page)
> > +		goto iput_out;
> > +
> > +	if (!PageUptodate(page))
> > +		goto page_out;
> > +
> > +	if (!PageDirty(page))
> > +		goto page_out;
> > +
> > +	if (!clear_page_dirty_for_io(page))
> > +		goto page_out;
> > +
> > +	if (!f2fs_write_inline_data(inode, page))
> 
> better to redirty the page when fail except -EAGAIN?

Agreed.

> 
> > +		inode_dec_dirty_pages(inode);
> > +page_out:
> > +	f2fs_put_page(page, 1);
> > +iput_out:
> > +	iput(inode);
> > +}
> > +
> >  int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
> >  					struct writeback_control *wbc)
> >  {
> > @@ -1221,6 +1252,14 @@ continue_unlock:
> >  				goto continue_unlock;
> >  			}
> > 
> > +			/* flush inline_data */
> > +			if (!ino && is_inline_node(page)) {
> > +				clear_inline_node(page);
> 
> Should clear after flushed inline data? otherwise if we failed to flush
> inline data, we will lose the change to flush it before node flush.

My intention was just letting it go and flush by ->writepage later.
So, the above set_page_dirty() would handle this, right?

Thanks,

> 
> Thanks,
> 
> > +				unlock_page(page);
> > +				flush_inline_data(sbi, ino_of_node(page));
> > +				continue;
> > +			}
> > +
> >  			if (!clear_page_dirty_for_io(page))
> >  				goto continue_unlock;
> > 
> > diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> > index 23bd992..1f4f9d4 100644
> > --- a/fs/f2fs/node.h
> > +++ b/fs/f2fs/node.h
> > @@ -379,6 +379,21 @@ static inline int is_node(struct page *page, int type)
> >  #define is_fsync_dnode(page)	is_node(page, FSYNC_BIT_SHIFT)
> >  #define is_dent_dnode(page)	is_node(page, DENT_BIT_SHIFT)
> > 
> > +static inline int is_inline_node(struct page *page)
> > +{
> > +	return PageChecked(page);
> > +}
> > +
> > +static inline void set_inline_node(struct page *page)
> > +{
> > +	SetPageChecked(page);
> > +}
> > +
> > +static inline void clear_inline_node(struct page *page)
> > +{
> > +	ClearPageChecked(page);
> > +}
> > +
> >  static inline void set_cold_node(struct inode *inode, struct page *page)
> >  {
> >  	struct f2fs_node *rn = F2FS_NODE(page);
> > --
> > 2.6.3
> > 
> > 
> > ------------------------------------------------------------------------------
> > Site24x7 APM Insight: Get Deep Visibility into Application Performance
> > APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> > Monitor end-to-end web transactions and take corrective actions now
> > Troubleshoot faster and improve end-user experience. Signup Now!
> > http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
