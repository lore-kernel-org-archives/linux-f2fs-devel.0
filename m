From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches
 first
Date: Fri, 3 Jul 2015 23:29:17 -0700
Message-ID: <20150704062917.GD15817@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org>
 <1435713946-6910-2-git-send-email-jaegeuk@kernel.org>
 <COL402-EAS277B75C19DA375A394DDFCEAB970@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <COL402-EAS277B75C19DA375A394DDFCEAB970@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchaochina@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jul 02, 2015 at 08:39:43PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, July 01, 2015 9:26 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org;
> > linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim; Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches first
> > 
> > If an extent_tree entry has a zero reference count, we can drop it from the
> > cache in higher priority rather than currently referencing entries.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 41 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 8f059e0..a0a0e2b 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -661,21 +661,54 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int
> > nr_shrink)
> >  	struct radix_tree_root *root = &sbi->extent_tree_root;
> >  	unsigned int found;
> >  	unsigned int node_cnt = 0, tree_cnt = 0;
> > +	int remained;
> > 
> >  	if (!test_opt(sbi, EXTENT_CACHE))
> >  		return 0;
> > 
> > +	if (!down_write_trylock(&sbi->extent_tree_lock))
> > +		goto out;
> > +
> > +	/* 1. remove unreferenced extent tree */
> 
> We always release extent node and tree from inode with lowest ino,
> why not random ino?

Here what I want to do is to
1. drop unreferenced inodes' extent trees;
   the inodes were already evicted before,
2. drop LRU ordered extent nodes.

You're right. We don't need to drop it having the lowest ino first.
Actually, I was supposed to add an LRU list for extent_trees.
But, do we need to really take care of its order for already evicted inodes?

Here, we should think about two types of hit ratios.
One is for inodes, and the other is for data.
The VFS maintains inode_cache in an LRU order, while its data is cached via
page cache also conrolled by LRU. And, whenever inode is evicted, VFS drops
all the cached data.
So, I believe we should give a higher priority to inodes rather than data.

And, in order to increase the hit ratio, we're trying to keep an extent tree
and its nodes even if its corresponding inode was evicted.
So, I concluded that the dropping order would not be critical especially for
the already evicted inodes.

> 
> And this step releasing breaks the rule of lru runs.
> 
> Some unreferenced file has high hit ratio and some referenced file may
> have low hit ratio. Why not release low hit ratio extent tree at first?

But, still user has opened the referenced file to further access, right?
And, the unreferenced file was evicted by VFS.

Thanks,
