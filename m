From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: speed up shrinking extent tree
 entries
Date: Mon, 21 Dec 2015 23:36:53 -0800
Message-ID: <20151222073653.GA20789@jaegeuk.local>
References: <1450755521-20015-1-git-send-email-jaegeuk@kernel.org>
 <1450755521-20015-2-git-send-email-jaegeuk@kernel.org>
 <00bd01d13c78$8a2afc30$9e80f490$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00bd01d13c78$8a2afc30$9e80f490$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Dec 22, 2015 at 01:20:13PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> We should update &total_zombie_tree whenever removing unreferenced
> extent tree during shrinking:
> - f2fs_shrink_extent_tree
> if (!atomic_read(&et->refcount)) {
> 	...
> 	atomic_dec(&sbi->total_ext_tree);
> 	atomic_dec(&sbi->total_zombie_tree);
> 	...

Sure. :)

Thanks,

> }
> 
> Other parts look good to me. :)
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> 
> Thanks,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, December 22, 2015 11:39 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 2/2] f2fs: speed up shrinking extent tree entries
> > 
> > If there is no candidates for shrinking slab entries, we don't need to traverse
> > any trees at all.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/extent_cache.c | 12 ++++++++++++
> >  fs/f2fs/f2fs.h         |  1 +
> >  fs/f2fs/shrinker.c     |  2 +-
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index 0e97d6af..32693af 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -71,6 +71,8 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
> >  		atomic_set(&et->refcount, 0);
> >  		et->count = 0;
> >  		atomic_inc(&sbi->total_ext_tree);
> > +	} else {
> > +		atomic_dec(&sbi->total_zombie_tree);
> >  	}
> >  	atomic_inc(&et->refcount);
> >  	up_write(&sbi->extent_tree_lock);
> > @@ -547,10 +549,14 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int
> > nr_shrink)
> >  	unsigned int found;
> >  	unsigned int node_cnt = 0, tree_cnt = 0;
> >  	int remained;
> > +	bool do_free = false;
> > 
> >  	if (!test_opt(sbi, EXTENT_CACHE))
> >  		return 0;
> > 
> > +	if (!atomic_read(&sbi->total_zombie_tree))
> > +		goto free_node;
> > +
> >  	if (!down_write_trylock(&sbi->extent_tree_lock))
> >  		goto out;
> > 
> > @@ -580,6 +586,7 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int
> > nr_shrink)
> >  	}
> >  	up_write(&sbi->extent_tree_lock);
> > 
> > +free_node:
> >  	/* 2. remove LRU extent entries */
> >  	if (!down_write_trylock(&sbi->extent_tree_lock))
> >  		goto out;
> > @@ -591,9 +598,13 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int
> > nr_shrink)
> >  		if (!remained--)
> >  			break;
> >  		list_del_init(&en->list);
> > +		do_free = true;
> >  	}
> >  	spin_unlock(&sbi->extent_lock);
> > 
> > +	if (do_free == false)
> > +		goto unlock_out;
> > +
> >  	/*
> >  	 * reset ino for searching victims from beginning of global extent tree.
> >  	 */
> > @@ -651,6 +662,7 @@ void f2fs_destroy_extent_tree(struct inode *inode)
> > 
> >  	if (inode->i_nlink && !is_bad_inode(inode) && et->count) {
> >  		atomic_dec(&et->refcount);
> > +		atomic_dec(&sbi->total_zombie_tree);
> >  		return;
> >  	}
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index a7f6191..90fb970 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -763,6 +763,7 @@ struct f2fs_sb_info {
> >  	struct list_head extent_list;		/* lru list for shrinker */
> >  	spinlock_t extent_lock;			/* locking extent lru list */
> >  	atomic_t total_ext_tree;		/* extent tree count */
> > +	atomic_t total_zombie_tree;		/* extent zombie tree count */
> >  	atomic_t total_ext_node;		/* extent info count */
> > 
> >  	/* basic filesystem units */
> > diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> > index a11e099..93606f2 100644
> > --- a/fs/f2fs/shrinker.c
> > +++ b/fs/f2fs/shrinker.c
> > @@ -32,7 +32,7 @@ static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
> > 
> >  static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
> >  {
> > -	return atomic_read(&sbi->total_ext_tree) +
> > +	return atomic_read(&sbi->total_zombie_tree) +
> >  				atomic_read(&sbi->total_ext_node);
> >  }
> > 
> > --
> > 2.5.4 (Apple Git-61)
> > 
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
