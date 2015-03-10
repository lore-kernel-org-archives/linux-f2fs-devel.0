From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH] f2fs: fix to truncate inline data past EOF
Date: Tue, 10 Mar 2015 13:00:59 +0800
Message-ID: <004f01d05aef$599b2dd0$0cd18970$@samsung.com>
References: <00d101d05728$aac41570$004c4050$@samsung.com>
 <20150305213346.GA17190@jaegeuk-mac02.mot.com>
 <004501d05a10$511e4820$f35ad860$@samsung.com>
 <20150309034855.GA4472@jaegeuk-mac02>
 <000601d05a43$6a8c6980$3fa53c80$@samsung.com>
 <20150309161536.GA6792@jaegeuk-mac02>
 <004501d05ad6$6cd7af40$46870dc0$@samsung.com>
 <20150310030003.GA14756@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150310030003.GA14756@jaegeuk-mac02>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, March 10, 2015 11:00 AM
> To: Chao Yu
> Cc: 'Changman Lee'; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] f2fs: fix to truncate inline data past EOF
> 
> Hi Chao,
> 
> On Tue, Mar 10, 2015 at 10:02:46AM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> 
> [snip]
> 
> > > > > +static int truncate_partial_data_page(struct inode *inode, u64 from, bool force)
> > > > >  {
> > > > >  	unsigned offset = from & (PAGE_CACHE_SIZE - 1);
> > > > >  	struct page *page;
> > > > >
> > > > > -	if (!offset)
> > > > > +	if (!offset && !force)
> > > >
> > > > We truncate on-disk inode page and #0 page separately, so IMO there is a very
> > > > small chance the following issue will occur.
> > > >
> > > > (0 < truncated_size < MAX_INLINE_SIZE)
> > > > ->f2fs_setattr
> > > >   ->truncate_setsize #0 page has been truncated partially
> > > >   ->f2fs_truncate
> > > >     ->truncate_blocks
> > > > 					invalidate #0 page by reclaimer
> > > > 					update #0 page with original data in inode page by reader
> > >
> > > 					truncate_setsize called truncate_pagesize.
> > > 					so #0 page was truncated successfully.
> >
> > Yeah, but it's partially truncating as 0 < truncated_size < MAX_INLINE_SIZE,
> > After truncating, we still keep [0, truncated_size) valid data in #0 page, and
> > our #0 page status is uptodate | !dirty.
> >
> > So what I mean is that mm can reclaim this #0 page, then if someone else read
> > the #0 page again, we will update the #0 page with original data in inode page
> > since inode page haven't truncated yet.
> 
> The truncate_blocks dropped inline_data in inode page, which is modified by
> this patch.
> And, the cached #0 page was truncated by truncate_setsize.
> Even if this page was evicted and reloaded again, the data would be filled with
> the inode page having truncated inline_data.
> So, it seems there is no problem.
> 
> BTW, do you mean like this scenario?

Yeah, actually it is. ;-)

> 
> -> f2fs_setattr
>  ->truncate_setsize: #0 page has been truncated partially
>  ->f2fs_truncate
>  					invalidate #0 page by reclaimer
>  					update #0 page with original data in inode page by reader
> 
>     ->truncate_blocks
>       (*)-> truncate_inline_inode
>     (*)-> truncate_partial_data_page(,, force)
>        find_data_page(,, force)  <- we can use *force* here.
> 
> Then, I agree that two functions as noted (*) above would be necessary.
> 
> >
> > If this happened, if we don't truncate #0 page in following code of truncate_blocks,
> > we will remain the original data for user, it's wrong.
> >
> > IMO, it's better to truncate inode page and #0 page together, or truncate #0 page
> > in truncate_partial_data_page.
> >
> > How do you think?
> >
> > >
> > > >       ->truncate_inline_inode
> > > >       ->truncate_partial_data_page
> > > >         we will fail to truncate #0 page because we can't find valid blkaddr for
> > > >         #0 page in find_data_page(,,false)
> > > >
> > > > How about using find_data_page(,,true) to check weather this page is update or not
> > > > for this condition.
> > >
> > > Oh, I realized that we don't need to call truncate_partial_data_page, since the
> > > cached #0 page was truncated already. We don't care about that.
> >
> > IMO, we should care about this #0 page if above example can happen.
> >
> > > So, do we need to add just truncate_inline_inode() like below?
> > >
> > > >
> > > > >  		return 0;
> > > > >
> > > > >  	page = find_data_page(inode, from >> PAGE_CACHE_SHIFT, false);
> > > > > @@ -489,6 +489,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
> > > > >  	pgoff_t free_from;
> > > > >  	int count = 0, err = 0;
> > > > >  	struct page *ipage;
> > > > > +	bool truncate_page = false;
> > > > >
> > > > >  	trace_f2fs_truncate_blocks_enter(inode, from);
> > > > >
> > > > > @@ -504,6 +505,9 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
> > > > >  	}
> > > > >
> > > > >  	if (f2fs_has_inline_data(inode)) {
> > > > > +		truncate_inline_inode(ipage, from);
> > > > > +		set_page_dirty(ipage);
> > > >
> > > > If @from is the same as MAX_INLINE_DATA, we will change nothing in inode page,
> > > > How about skipping set_page_dirty for inode page in this condition?
> > >
> > > Agreed.
> > > How about adding this in truncate_inline_inode?
> > >
> > > 	if (from >= MAX_INLINE_DATA)
> > > 		return;
> > > 	...
> > > 	set_page_dirty(ipage);
> >
> > Yeah, that's good.
> >
> > And What I suggest is:
> >
> > bool truncate_inline_inode(struct page *ipage, u64 from)
> > {
> > 	/*
> > 	 * we should never truncate inline data past max inline data size,
> > 	 * because we always convert inline inode to normal one before
> > 	 * truncating real data if new size is past max inline data size.
> > 	 */
> > 	f2fs_bug_on(F2FS_P_SB(ipage), from > MAX_INLINE_DATA);
> >
> > 	if (from == MAX_INLINE_DATA)
> 
> 	if (from >= MAX_INLINE_DATA)  to handle when f2fs_bug_on is bypassed.

Agreed, we should handle this condition.

> 
> > 		return false;
> > 	...
> > 	return true;
> > }
> >
> > in truncate_blocks()
> >
> >  	if (f2fs_has_inline_data(inode)) {
> > 		if (truncate_inline_inode(ipage, from))
> > 			set_page_dirty(ipage);
> >
> > So by this way, we can distinguish between a bug and invalid truncating in
> > truncate_inline_inode, and also we can avoid unneeded set_dirty_page for inode
> > page in other call path.
> 
> Ok, it's not a big deal.

Thanks for your help! Let me send a v2 patch.

Regards,
Chao

[sinp]
