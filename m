From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: limit # of inmemory pages
Date: Mon, 23 Oct 2017 22:50:08 +0200
Message-ID: <20171023205008.GA55522@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171019021516.65627-1-jaegeuk@kernel.org>
 <0cf05e1f-845f-cb5b-46b0-11a7f214e1a1@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0cf05e1f-845f-cb5b-46b0-11a7f214e1a1@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/23, Chao Yu wrote:
> On 2017/10/19 10:15, Jaegeuk Kim wrote:
> > If some abnormal users try lots of atomic write operations, f2fs is able to
> > produce pinned pages in the main memory which affects system performance.
> > This patch limits that as 20% over total memory size, and if f2fs reaches
> > to the limit, it will drop all the inmemory pages.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> The code looks good to me, but we will fail all atomic writes by telling them
> ENOMEM when all atomic write takes 20% memory of total size, but our user may
> be confused as there may be lots of free memory, it's hard to let user to
> understand this condition...
> 
> Atomic commit won't delay much time after atomic writing, so is that due
> to incorrect usage of atomic write in application?

Yup, this is just to avoid malicious user behaviors. And I can't imagine what
user can do differently according to any given error number.

Thanks,

> 
> Thanks,
> 
> > ---
> >  fs/f2fs/data.c    |  8 ++++++++
> >  fs/f2fs/f2fs.h    |  3 +++
> >  fs/f2fs/node.c    |  4 ++++
> >  fs/f2fs/node.h    |  1 +
> >  fs/f2fs/segment.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  fs/f2fs/super.c   |  1 +
> >  6 files changed, 55 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 95fdbe3e6cca..7fd09837820a 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1944,6 +1944,12 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
> >  
> >  	trace_f2fs_write_begin(inode, pos, len, flags);
> >  
> > +	if (f2fs_is_atomic_file(inode) &&
> > +			!available_free_memory(sbi, INMEM_PAGES)) {
> > +		err = -ENOMEM;
> > +		goto fail;
> > +	}
> > +
> >  	/*
> >  	 * We should check this at this moment to avoid deadlock on inode page
> >  	 * and #0 page. The locking rule for inline_data conversion should be:
> > @@ -2021,6 +2027,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
> >  fail:
> >  	f2fs_put_page(page, 1);
> >  	f2fs_write_failed(mapping, pos + len);
> > +	if (f2fs_is_atomic_file(inode))
> > +		drop_inmem_pages_all(sbi);
> >  	return err;
> >  }
> >  
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index a53fa3dbccf8..e0ef31cb2cc6 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -606,6 +606,7 @@ struct f2fs_inode_info {
> >  #endif
> >  	struct list_head dirty_list;	/* dirty list for dirs and files */
> >  	struct list_head gdirty_list;	/* linked in global dirty list */
> > +	struct list_head inmem_ilist;	/* list for inmem inodes */
> >  	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
> >  	struct task_struct *inmem_task;	/* store inmemory task */
> >  	struct mutex inmem_lock;	/* lock for inmemory pages */
> > @@ -971,6 +972,7 @@ enum inode_type {
> >  	DIR_INODE,			/* for dirty dir inode */
> >  	FILE_INODE,			/* for dirty regular/symlink inode */
> >  	DIRTY_META,			/* for all dirtied inode metadata */
> > +	ATOMIC_FILE,			/* for all atomic files */
> >  	NR_INODE_TYPE,
> >  };
> >  
> > @@ -2556,6 +2558,7 @@ void destroy_node_manager_caches(void);
> >   */
> >  bool need_SSR(struct f2fs_sb_info *sbi);
> >  void register_inmem_page(struct inode *inode, struct page *page);
> > +void drop_inmem_pages_all(struct f2fs_sb_info *sbi);
> >  void drop_inmem_pages(struct inode *inode);
> >  void drop_inmem_page(struct inode *inode, struct page *page);
> >  int commit_inmem_pages(struct inode *inode);
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index b95b2784e7d8..ac629d6258ca 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -74,6 +74,10 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
> >  				atomic_read(&sbi->total_ext_node) *
> >  				sizeof(struct extent_node)) >> PAGE_SHIFT;
> >  		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
> > +	} else if (type == INMEM_PAGES) {
> > +		/* it allows 20% / total_ram for inmemory pages */
> > +		mem_size = get_pages(sbi, F2FS_INMEM_PAGES);
> > +		res = mem_size < (val.totalram / 5);
> >  	} else {
> >  		if (!sbi->sb->s_bdi->wb.dirty_exceeded)
> >  			return true;
> > diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> > index e91b08b4a51a..0ee3e5ff49a3 100644
> > --- a/fs/f2fs/node.h
> > +++ b/fs/f2fs/node.h
> > @@ -140,6 +140,7 @@ enum mem_type {
> >  	DIRTY_DENTS,	/* indicates dirty dentry pages */
> >  	INO_ENTRIES,	/* indicates inode entries */
> >  	EXTENT_CACHE,	/* indicates extent cache */
> > +	INMEM_PAGES,	/* indicates inmemory pages */
> >  	BASE_CHECK,	/* check kernel status */
> >  };
> >  
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index bfbcff8339c5..049bbeb8ebff 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -186,6 +186,7 @@ bool need_SSR(struct f2fs_sb_info *sbi)
> >  
> >  void register_inmem_page(struct inode *inode, struct page *page)
> >  {
> > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	struct f2fs_inode_info *fi = F2FS_I(inode);
> >  	struct inmem_pages *new;
> >  
> > @@ -204,6 +205,10 @@ void register_inmem_page(struct inode *inode, struct page *page)
> >  	mutex_lock(&fi->inmem_lock);
> >  	get_page(page);
> >  	list_add_tail(&new->list, &fi->inmem_pages);
> > +	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> > +	if (list_empty(&fi->inmem_ilist))
> > +		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
> > +	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >  	inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
> >  	mutex_unlock(&fi->inmem_lock);
> >  
> > @@ -262,12 +267,41 @@ static int __revoke_inmem_pages(struct inode *inode,
> >  	return err;
> >  }
> >  
> > +void drop_inmem_pages_all(struct f2fs_sb_info *sbi)
> > +{
> > +	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
> > +	struct inode *inode;
> > +	struct f2fs_inode_info *fi;
> > +next:
> > +	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> > +	if (list_empty(head)) {
> > +		spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> > +		return;
> > +	}
> > +	fi = list_first_entry(head, struct f2fs_inode_info, inmem_ilist);
> > +	inode = igrab(&fi->vfs_inode);
> > +	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> > +
> > +	if (inode) {
> > +		drop_inmem_pages(inode);
> > +		iput(inode);
> > +	}
> > +	congestion_wait(BLK_RW_ASYNC, HZ/50);
> > +	cond_resched();
> > +	goto next;
> > +}
> > +
> >  void drop_inmem_pages(struct inode *inode)
> >  {
> > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	struct f2fs_inode_info *fi = F2FS_I(inode);
> >  
> >  	mutex_lock(&fi->inmem_lock);
> >  	__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
> > +	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> > +	if (!list_empty(&fi->inmem_ilist))
> > +		list_del_init(&fi->inmem_ilist);
> > +	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >  	mutex_unlock(&fi->inmem_lock);
> >  
> >  	clear_inode_flag(inode, FI_ATOMIC_FILE);
> > @@ -399,6 +433,10 @@ int commit_inmem_pages(struct inode *inode)
> >  		/* drop all uncommitted pages */
> >  		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
> >  	}
> > +	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> > +	if (!list_empty(&fi->inmem_ilist))
> > +		list_del_init(&fi->inmem_ilist);
> > +	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >  	mutex_unlock(&fi->inmem_lock);
> >  
> >  	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 840a0876005b..fc3b74e53670 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -651,6 +651,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
> >  	init_rwsem(&fi->i_sem);
> >  	INIT_LIST_HEAD(&fi->dirty_list);
> >  	INIT_LIST_HEAD(&fi->gdirty_list);
> > +	INIT_LIST_HEAD(&fi->inmem_ilist);
> >  	INIT_LIST_HEAD(&fi->inmem_pages);
> >  	mutex_init(&fi->inmem_lock);
> >  	init_rwsem(&fi->dio_rwsem[READ]);
> > 
