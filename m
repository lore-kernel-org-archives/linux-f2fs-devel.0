From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to release inode page	in
 get_new_data_page
Date: Wed, 5 Aug 2015 08:12:50 -0700
Message-ID: <20150805151250.GA81884@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <00f501d0be1d$e89f08d0$b9dd1a70$@samsung.com>
 <001701d0cdec$d74ba820$85e2f860$@samsung.com>
 <009f01d0cf60$b96a5cf0$2c3f16d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <009f01d0cf60$b96a5cf0$2c3f16d0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Aug 05, 2015 at 05:25:12PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> How about using v3 instead of v2 since it fixes the same type issue
> in f2fs_convert_inline_dir?

Fixed.
Thanks,

> 
> Thanks,
> 
> > -----Original Message-----
> > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > Sent: Monday, August 03, 2015 9:03 PM
> > To: 'Jaegeuk Kim'
> > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to release inode page in get_new_data_page
> > 
> > >From c0f2abda489150d5d458aaae9026f1243daea604 Mon Sep 17 00:00:00 2001
> > From: Chao Yu <chao2.yu@samsung.com>
> > Date: Tue, 14 Jul 2015 18:14:06 +0800
> > Subject: [PATCH v3] f2fs: fix to release inode page correctly
> > 
> > In following call path, we will pass a locked and referenced ipage
> > pointer to get_new_data_page:
> >  - init_inode_metadata
> >   - make_empty_dir
> >    - get_new_data_page
> > 
> > There are two exit paths in get_new_data_page when error occurs:
> > 1) grab_cache_page fails, ipage will not be released;
> > 2) f2fs_reserve_block fails, ipage will be released in callee.
> > 
> > So, it's not consistent for error handling in get_new_data_page.
> > 
> > For f2fs_reserve_block, it's not very easy to change the rule
> > of error handling, since it's already complicated.
> > 
> > Here we deside to choose an easy way to fix this issue:
> > If any error occur in get_new_data_page, we will ensure releasing
> > ipage in this function.
> > 
> > The same issue is in f2fs_convert_inline_dir, fix that too.
> > 
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> > v3:
> >  * fix the same issue in f2fs_convert_inline_dir.
> > 
> >  fs/f2fs/data.c   | 11 +++++++++--
> >  fs/f2fs/inline.c | 13 ++++++++++---
> >  2 files changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index e58562e..5da0529 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -387,7 +387,8 @@ repeat:
> >   *
> >   * Also, caller should grab and release a rwsem by calling f2fs_lock_op() and
> >   * f2fs_unlock_op().
> > - * Note that, ipage is set only by make_empty_dir.
> > + * Note that, ipage is set only by make_empty_dir, and if any error occur,
> > + * ipage should be released by this function.
> >   */
> >  struct page *get_new_data_page(struct inode *inode,
> >  		struct page *ipage, pgoff_t index, bool new_i_size)
> > @@ -398,8 +399,14 @@ struct page *get_new_data_page(struct inode *inode,
> >  	int err;
> >  repeat:
> >  	page = grab_cache_page(mapping, index);
> > -	if (!page)
> > +	if (!page) {
> > +		/*
> > +		 * before exiting, we should make sure ipage will be released
> > +		 * if any error occur.
> > +		 */
> > +		f2fs_put_page(ipage, 1);
> >  		return ERR_PTR(-ENOMEM);
> > +	}
> > 
> >  	set_new_dnode(&dn, inode, ipage, NULL, 0);
> >  	err = f2fs_reserve_block(&dn, index);
> > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > index a13ffcc..79d18d5 100644
> > --- a/fs/f2fs/inline.c
> > +++ b/fs/f2fs/inline.c
> > @@ -360,6 +360,10 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
> >  	return 0;
> >  }
> > 
> > +/*
> > + * NOTE: ipage is grabbed by caller, but if any error occurs, we should
> > + * release ipage in this function.
> > + */
> >  static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
> >  				struct f2fs_inline_dentry *inline_dentry)
> >  {
> > @@ -369,8 +373,10 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
> >  	int err;
> > 
> >  	page = grab_cache_page(dir->i_mapping, 0);
> > -	if (!page)
> > +	if (!page) {
> > +		f2fs_put_page(ipage, 1);
> >  		return -ENOMEM;
> > +	}
> > 
> >  	set_new_dnode(&dn, dir, ipage, NULL, 0);
> >  	err = f2fs_reserve_block(&dn, 0);
> > @@ -434,8 +440,9 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
> >  						slots, NR_INLINE_DENTRY);
> >  	if (bit_pos >= NR_INLINE_DENTRY) {
> >  		err = f2fs_convert_inline_dir(dir, ipage, dentry_blk);
> > -		if (!err)
> > -			err = -EAGAIN;
> > +		if (err)
> > +			return err;
> > +		err = -EAGAIN;
> >  		goto out;
> >  	}
> > 
> > --
> > 2.4.2
> > 
> > 
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
