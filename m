From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches
 first
Date: Wed, 08 Jul 2015 17:41:57 +0800
Message-ID: <00af01d0b962$8682d880$93888980$@samsung.com>
References: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org>
 <1435713946-6910-2-git-send-email-jaegeuk@kernel.org>
 <COL402-EAS277B75C19DA375A394DDFCEAB970@phx.gbl>
 <20150704062917.GD15817@jaegeuk-mac02.hsd1.ca.comcast.net>
 <004401d0b7e6$ee859f80$cb90de80$@samsung.com>
 <20150706221624.GA26544@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150706221624.GA26544@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, July 07, 2015 6:16 AM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches first
> 
> On Mon, Jul 06, 2015 at 08:25:23PM +0800, Chao Yu wrote:
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Saturday, July 04, 2015 2:29 PM
> > > To: Chao Yu
> > > Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches first
> > >
> > > On Thu, Jul 02, 2015 at 08:39:43PM +0800, Chao Yu wrote:
> > > > > -----Original Message-----
> > > > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > > > Sent: Wednesday, July 01, 2015 9:26 AM
> > > > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > > > linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org;
> > > > > linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > > > Cc: Jaegeuk Kim; Jaegeuk Kim
> > > > > Subject: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches first
> > > > >
> > > > > If an extent_tree entry has a zero reference count, we can drop it from the
> > > > > cache in higher priority rather than currently referencing entries.
> > > > >
> > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > ---
> > > > >  fs/f2fs/data.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
> > > > >  1 file changed, 41 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > index 8f059e0..a0a0e2b 100644
> > > > > --- a/fs/f2fs/data.c
> > > > > +++ b/fs/f2fs/data.c
> > > > > @@ -661,21 +661,54 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi,
> int
> > > > > nr_shrink)
> > > > >  	struct radix_tree_root *root = &sbi->extent_tree_root;
> > > > >  	unsigned int found;
> > > > >  	unsigned int node_cnt = 0, tree_cnt = 0;
> > > > > +	int remained;
> > > > >
> > > > >  	if (!test_opt(sbi, EXTENT_CACHE))
> > > > >  		return 0;
> > > > >
> > > > > +	if (!down_write_trylock(&sbi->extent_tree_lock))
> > > > > +		goto out;
> > > > > +
> > > > > +	/* 1. remove unreferenced extent tree */
> > > >
> > > > We always release extent node and tree from inode with lowest ino,
> > > > why not random ino?
> > >
> > > Here what I want to do is to
> > > 1. drop unreferenced inodes' extent trees;
> > >    the inodes were already evicted before,
> > > 2. drop LRU ordered extent nodes.
> >
> > Actually, I got it, you codes show this method very clearly. :)
> >
> > >
> > > You're right. We don't need to drop it having the lowest ino first.
> > > Actually, I was supposed to add an LRU list for extent_trees.
> > > But, do we need to really take care of its order for already evicted inodes?
> > >
> > > Here, we should think about two types of hit ratios.
> > > One is for inodes, and the other is for data.
> > > The VFS maintains inode_cache in an LRU order, while its data is cached via
> > > page cache also conrolled by LRU. And, whenever inode is evicted, VFS drops
> > > all the cached data.
> > > So, I believe we should give a higher priority to inodes rather than data.
> > >
> > > And, in order to increase the hit ratio, we're trying to keep an extent tree
> > > and its nodes even if its corresponding inode was evicted.
> > > So, I concluded that the dropping order would not be critical especially for
> > > the already evicted inodes.
> >
> > >From perspective of shrinking memory size, I think you're completely right,
> > because we can regard extent tree and its nodes as metadata of one inode, if
> > VFS evict one inode, all its data and metadata include data in extent cache
> > should be evicted.
> >
> > But from perspective of arising hit ratio of our cache, I'm not sure this is
> > the best way.
> >
> > I guess in this method, we may encounter lower coverage area of dnode + extent
> > cache and double caches exist issue, like:
> > a) all data of inode is evicted by VFS, and its tree and nodes in extent cache
> > is evicted too, resulting lower hit raito of further access.
> 
> Well, f2fs_evict_inode does not destroy whole its extent tree and nodes right
> away, but just drops the refcount of the extent tree. So, I expect that this
> gives another chance of cache hit for further data access.

Agreed.

> Moreover, since this only matters with memory pressure, the unreferenced extent
> trees and nodes would be kept long enough beyond the normal situation.

I'm worry about the 'only matters' thing, I will investigate it if I have time.

> 
> > b) data and node cache of inode is exist in VFS, and its tree and nodes in extent
> > cache is exist too.
> 
> We know that this is a separate issue, since there is no such code to check
> whether data and node cache exist along with extent cache entries.

Well, just thought, for multimedia objects, like a movie file, most time
we will just read it, there will no further writes in it. So why not
building extent cache for reaccessing, and meanwhile releasing dnode pages
for saving memory?

> And, I don't think we should eliminate such the duplicate, since the extent
> cache is a supplemenray subset of data and node caches.

Right.

> 
> >
> > >
> > > >
> > > > And this step releasing breaks the rule of lru runs.
> > > >
> > > > Some unreferenced file has high hit ratio and some referenced file may
> > > > have low hit ratio. Why not release low hit ratio extent tree at first?
> > >
> > > But, still user has opened the referenced file to further access, right?
> >
> > It depends on access model.
> >
> > What I mean is that if extent cache of one inode can be hit for many times,
> > we can assume the access model is re-accessly, that means, we can expect
> > this cache can be hit more times. On the contrary, we can release it if it
> > is necessary.
> 
> Yes, exactly it depends on user workloads.
> 
> As a counter example,
> 1. thread A wrote extents and remained the file as it was opened to use later,
> 2. thread B wrote many extents newly and never touched.
> 
> After #2, if shrinker was activated, the extents cached by thread A would
> be evicted, resulting in cache misses on further thread A's accesses.

I didn't understand, if thread A's file is opened for reusing, from long-term
view, it will have high hit ratio in its extent cache than thread B's, Why
thread B's extent cache is not be evicted firstly.

> 
> IMO, this can happen when a bunch of data blocks were written without updates,
> while some opened library/database files will access the data sooner or later.

You mean the file with one time written in its life, like lib file or multimedia
file?

So I guess what you mean is that, some app keeps file opened for long time, and
will access it again sooner or later, at least we should keep these referenced
extent cache visible rather than evicting them before evicting unreferenced one's.

Thanks,

> 
> Thanks,
> 
> >
> > Thanks,
> >
> > > And, the unreferenced file was evicted by VFS.
> > >
> > > Thanks,
> > >
> > > ------------------------------------------------------------------------------
> > > Don't Limit Your Business. Reach for the Cloud.
> > > GigeNET's Cloud Solutions provide you with the tools and support that
> > > you need to offload your IT needs and focus on growing your business.
> > > Configured For All Businesses. Start Your Cloud Today.
> > > https://www.gigenetcloud.com/
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
