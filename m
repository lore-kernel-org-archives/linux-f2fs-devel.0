From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] Space leak in f2fs
Date: Sun, 17 May 2015 22:44:21 -0700
Message-ID: <20150518054421.GA21292@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <5552FA7D.7000704@huawei.com>
 <20150513174417.GA56247@jaegeuk-mac02.mot.com>
 <20150514002417.GC68412@jaegeuk-mac02>
 <5553FD09.9030508@huawei.com>
 <20150514211250.GA76424@jaegeuk-mac02.mot.com>
 <015e01d08ee9$ac8e1060$05aa3120$@samsung.com>
 <20150516005436.GA10530@jaegeuk-mac02.mot.com>
 <000001d09114$7e0318d0$7a094a70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000001d09114$7e0318d0$7a094a70$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'hujianyang' <hujianyang@huawei.com>, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Mon, May 18, 2015 at 10:43:14AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Saturday, May 16, 2015 8:56 AM
> > To: Chao Yu
> > Cc: 'hujianyang'; linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] Space leak in f2fs
> > 
> > Hi Chao,
> > 
> > On Fri, May 15, 2015 at 04:31:43PM +0800, Chao Yu wrote:
> > > Hi Jaegeuk,
> > >
> > 
> > [snip]
> > 
> > > > +	/* if orphan inode, we don't need to write its data */
> > > > +	if (is_orphan_inode(sbi, inode->i_ino))
> > > > +		goto out;
> > >
> > > When user create a temp file by invoking open with O_TMPFILE flag,
> > > in ->tmpfile our temp file will be added into orphan list as its
> > > nlink is zero.
> > >
> > > If we skip writting out data for this orphan inode, later, even though
> > > we add nlink/directory entry for orphan inode by calling linkat,
> > > our file will contain inconsistent data between in-memory and on-disk.
> > >
> > > So how about considering for this case?
> > 
> > Right.
> > How about the below patch?
> > 
> > >
> > > BTW, the previous fixing patch looks good to me.
> > 
> > But, my new concern here is a memory pressure. If we do not drop the inode
> > when iput was called, we need to wait for another time slot to reclaim its
> > memory.
> 
> Agree. Please see below.
> 
> > 
> > Thanks,
> > 
> > ---
> >  fs/f2fs/checkpoint.c | 19 +++++++++++++++++++
> >  fs/f2fs/data.c       |  8 ++++++++
> >  fs/f2fs/dir.c        |  1 +
> >  fs/f2fs/f2fs.h       |  2 ++
> >  fs/f2fs/super.c      | 14 +++++++++++++-
> >  5 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 7b7a9d8..74875fb 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -378,6 +378,20 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int
> > type)
> >  	spin_unlock(&im->ino_lock);
> >  }
> > 
> > +static bool __exist_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
> > +{
> > +	struct inode_management *im = &sbi->im[type];
> > +	struct ino_entry *e;
> > +	bool exist = false;
> > +
> > +	spin_lock(&im->ino_lock);
> > +	e = radix_tree_lookup(&im->ino_root, ino);
> > +	if (e)
> > +		exist = true;
> > +	spin_unlock(&im->ino_lock);
> > +	return exist;
> > +}
> > +
> >  void add_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
> >  {
> >  	/* add new dirty ino entry into list */
> > @@ -458,6 +472,11 @@ void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
> >  	__remove_ino_entry(sbi, ino, ORPHAN_INO);
> >  }
> > 
> > +bool is_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
> > +{
> > +	return __exist_ino_entry(sbi, ino, ORPHAN_INO);
> > +}
> > +
> >  static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
> >  {
> >  	struct inode *inode = f2fs_iget(sbi->sb, ino);
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index b0cc2aa..d883c14 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1749,6 +1749,14 @@ write:
> >  		goto out;
> >  	}
> > 
> > +	/*
> > +	 * if orphan inode, we don't need to write its data,
> > +	 * but, tmpfile is not the case.
> > +	 */
> > +	if (is_orphan_inode(sbi, inode->i_ino) &&
> > +			!is_inode_flag_set(F2FS_I(inode), FI_TMP_INODE))
> 
> For normal inode, all dirty pages will not be written out, and after that pages
> can be reclaimed by VM any time due to they are be cleaned when flush. Then any
> process who held the orphan inode may not read any original data correctly from
> this inode.

Urg, right.
Indeed, I have not to do this for orphan inodes.

> 
> And here is the unlink description in POSIX:
> "If one or more processes have the file open when the last link is removed,
> the link shall be removed before unlink() returns, but the removal of the
> file contents shall be postponed until all references to the file are closed."
> 
> To my understanding for above description, we should keep data of helded orphan
> inode in memory or on disk until it is not referenced by any processes.
> 
> How do you think of it?
> 
> using "if (is_orphan_inode(sbi, inode->i_ino) && !atomic_read(&inode->i_count))"
> to skip writing at the beginning of ->writepage()?

Hmm, IMO, we can't use i_count without i_lock. And this doesn't clearly address
the original race condition.

For now, simply we'd better keep v2 which only truncates data blocks in
f2fs_drop_inode.

Thank you for pointing this out.

Thanks,

> 
> Thanks,
> 
> > +		goto out;
> > +
> >  	if (!wbc->for_reclaim)
> >  		need_balance_fs = true;
> >  	else if (has_not_enough_free_secs(sbi, 0))
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index 3e92376..a2ea1b9 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -648,6 +648,7 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
> >  	update_inode(inode, page);
> >  	f2fs_put_page(page, 1);
> > 
> > +	set_inode_flag(F2FS_I(inode), FI_TMP_INODE);
> >  	clear_inode_flag(F2FS_I(inode), FI_NEW_INODE);
> >  fail:
> >  	up_write(&F2FS_I(inode)->i_sem);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index cdcae06..de21d38 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1337,6 +1337,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
> >  /* used for f2fs_inode_info->flags */
> >  enum {
> >  	FI_NEW_INODE,		/* indicate newly allocated inode */
> > +	FI_TMP_INODE,		/* indicate tmpfile */
> >  	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
> >  	FI_DIRTY_DIR,		/* indicate directory has dirty pages */
> >  	FI_INC_LINK,		/* need to increment i_nlink */
> > @@ -1726,6 +1727,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *);
> >  void release_orphan_inode(struct f2fs_sb_info *);
> >  void add_orphan_inode(struct f2fs_sb_info *, nid_t);
> >  void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
> > +bool is_orphan_inode(struct f2fs_sb_info *, nid_t);
> >  void recover_orphan_inodes(struct f2fs_sb_info *);
> >  int get_valid_checkpoint(struct f2fs_sb_info *);
> >  void update_dirty_page(struct inode *, struct page *);
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 7464d08..98af3bf 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -430,9 +430,21 @@ static int f2fs_drop_inode(struct inode *inode)
> >  	 *  - f2fs_write_data_page
> >  	 *    - f2fs_gc -> iput -> evict
> >  	 *       - inode_wait_for_writeback(inode)
> > +	 * In order to avoid that, f2fs_write_data_page does not write data
> > +	 * pages for orphan inode except tmpfile.
> > +	 * Nevertheless, we need to truncate the tmpfile's data to avoid
> > +	 * needless cleaning.
> >  	 */
> > -	if (!inode_unhashed(inode) && inode->i_state & I_SYNC)
> > +	if (is_inode_flag_set(F2FS_I(inode), FI_TMP_INODE) &&
> > +						inode->i_state & I_SYNC) {
> > +		spin_unlock(&inode->i_lock);
> > +		i_size_write(inode, 0);
> > +
> > +		if (F2FS_HAS_BLOCKS(inode))
> > +			f2fs_truncate(inode);
> > +		spin_lock(&inode->i_lock);
> >  		return 0;
> > +	}
> >  	return generic_drop_inode(inode);
> >  }
> > 
> > --
> > 2.1.1
