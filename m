From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev][RFC PATCH 06/10] f2fs: add core functions for rb-tree
 extent cache
Date: Mon, 26 Jan 2015 13:39:23 +0800
Message-ID: <005c01d0392a$8d59b2e0$a80d18a0$@samsung.com>
References: <000a01d02e37$8e245890$aa6d09b0$@samsung.com>
 <20150123014802.GA17947@jaegeuk-mac02>
 <00ed01d036d4$28fb0310$7af10930$@samsung.com>
 <20150123194328.GC22493@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150123194328.GC22493@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, January 24, 2015 3:43 AM
> To: Chao Yu
> Cc: 'Changman Lee'; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][RFC PATCH 06/10] f2fs: add core functions for rb-tree extent cache
> 
> On Fri, Jan 23, 2015 at 02:15:56PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Friday, January 23, 2015 9:48 AM
> > > To: Chao Yu
> > > Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > > Subject: Re: [f2fs-dev][RFC PATCH 06/10] f2fs: add core functions for rb-tree extent cache
> > >
> > > On Mon, Jan 12, 2015 at 03:14:48PM +0800, Chao Yu wrote:
> > > > This patch adds core functions including slab cache init function and
> > > > init/lookup/update/shrink/destroy function for rb-tree based extent cache.
> > > >
> > > > Thank Jaegeuk Kim and Changman Lee as they gave much suggestion about detail
> > > > design and implementation of extent cache.
> > > >
> > > > Todo:
> > > >  * add a cached_ei into struct extent_tree for a quick recent cache.
> > > >  * register rb-based extent cache shrink with mm shrink interface.
> > > >  * disable dir inode's extent cache.
> > > >
> 

[snip]

> > > > +static void f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
> > > > +							block_t blkaddr)
> > > > +{
> > > > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > > > +	nid_t ino = inode->i_ino;
> > > > +	struct extent_tree *et;
> > > > +	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 = NULL;
> > > > +	struct extent_node *den = NULL;
> > > > +	struct extent_info *pei;
> > > > +	struct extent_info ei;
> > > > +	unsigned int endofs;
> > > > +
> > > > +	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
> > > > +		return;
> > > > +
> > > > +retry:
> > > > +	down_write(&sbi->extent_tree_lock);
> > > > +	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
> > > > +	if (!et) {
> > > > +		et = kmem_cache_alloc(extent_tree_slab, GFP_ATOMIC);
> > >
> > > et = f2fs_kmem_cache_alloc(.., GFP_ATOMIC);
> >
> > How about modifying as below to avoid holding extent_tree_lock for long time?
> 
> Hmm. I don't think it doesn't take such the long time.
> It's GFP_ATOMIC.
> 
> Moreover, for radix_tree, I prefer to use f2fs_radix_tree_insert with GFP_NOIO.
> Since, we actually don't need to call kmem_cache_free.

How about use following code?

	f2fs_kmem_cache_alloc(extent_tree_slab, GFP_NOFS);
	f2fs_radix_tree_insert(&sbi->extent_tree_root, ino, et);

in init_extent_cache_info()
	INIT_RADIX_TREE(&sbi->extent_tree_root, GFP_NOIO);

> 
> >
> > et = kmem_cache_alloc(extent_tree_slab, GFP_ATOMIC);
> > if (!et) {
> > 	up_write(&sbi->extent_tree_lock);
> > 	cond_resched();
> > 	goto retry;
> > }
> >
> > >
> > > > +		if (!et) {
> > > > +			up_write(&sbi->extent_tree_lock);
> > > > +			goto retry;
> > > > +		}
> > > > +		if (radix_tree_insert(&sbi->extent_tree_root, ino, et)) {
> > > > +			up_write(&sbi->extent_tree_lock);
> > > > +			kmem_cache_free(extent_tree_slab, et);
> >
> > cond_resched()?
> 
> I'm not sure why this should be needed.
> There is rw_semaphore, so we have already a rescheduling point.
> 

[snip]

> > > Can we just remove en1 and en2 in __insert_extent_tree?
> >
> > en1 and en2 is newly added, in __attach_extent_node we do not add en1 and en2 into
> > lru list, so if you do not want to keep split part in lru list, let's just remove
> > the below codes.
> 
> What I meant was, how about avoiding attaching en1 and en2, if they are splits whose
> lens are less than F2FS_MIN_EXTENT_LEN in advance?

Oh, it's better, I will do it.

[snip]

> > > No use of tree_cnt.
> >
> > This is used by trace function in RFC PATCH 10/10.
> 
> Well, then, it needs to add tree_cnt in Patch #10. :)

OK, let's move it. :)

Thanks,

> 
> Thanks,
> 
> >
> > Thanks for your review! :)
> >
> > Regards,
> > Yu
> >
> > >
> > > Thanks,
> >
> > [snip]
