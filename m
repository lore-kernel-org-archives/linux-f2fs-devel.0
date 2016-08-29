From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: add roll-forward recovery process for
 encrypted dentry
Date: Mon, 29 Aug 2016 10:05:20 -0700
Message-ID: <20160829170520.GC94184@jaegeuk>
References: <1472441276-133832-1-git-send-email-liushuoran@huawei.com>
 <1472441276-133832-2-git-send-email-liushuoran@huawei.com>
 <289d62ec-3295-1858-8047-c4cd03176757@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <289d62ec-3295-1858-8047-c4cd03176757@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: Shuoran Liu <liushuoran@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Aug 30, 2016 at 12:06:09AM +0800, Chao Yu wrote:
> Hi all,
> 
> On 2016/8/29 11:27, Shuoran Liu wrote:
> > Add roll-forward recovery process for encrypted dentry, so the first fsync
> > issued to an encrypted file does not need writing checkpoint.
> > 
> > This improves the performance of the following test at thousands of small
> > files: open -> write -> fsync -> close
> 
> I didn't find any functionality regression until now, from aspect of improving
> performance, I think it's worth to use this method.
> 
> To Jaegeuk, how do you think of this modification?

I think it seems fine. :)
I'll test a little bit.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
> > ---
> >  fs/f2fs/dir.c      | 75 ++++++++++++++++++++++++++++++++++--------------------
> >  fs/f2fs/f2fs.h     |  4 +++
> >  fs/f2fs/file.c     |  2 --
> >  fs/f2fs/recovery.c | 16 +++++-------
> >  4 files changed, 58 insertions(+), 39 deletions(-)
> > 
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index 9054aea..8eca6dd 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -212,31 +212,17 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
> >  	return de;
> >  }
> >  
> > -/*
> > - * Find an entry in the specified directory with the wanted name.
> > - * It returns the page where the entry was found (as a parameter - res_page),
> > - * and the entry itself. Page is returned mapped and unlocked.
> > - * Entry is guaranteed to be valid.
> > - */
> > -struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
> > -			const struct qstr *child, struct page **res_page)
> > +struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
> > +			struct fscrypt_name *fname, struct page **res_page)
> >  {
> >  	unsigned long npages = dir_blocks(dir);
> >  	struct f2fs_dir_entry *de = NULL;
> >  	unsigned int max_depth;
> >  	unsigned int level;
> > -	struct fscrypt_name fname;
> > -	int err;
> > -
> > -	err = fscrypt_setup_filename(dir, child, 1, &fname);
> > -	if (err) {
> > -		*res_page = ERR_PTR(err);
> > -		return NULL;
> > -	}
> >  
> >  	if (f2fs_has_inline_dentry(dir)) {
> >  		*res_page = NULL;
> > -		de = find_in_inline_dir(dir, &fname, res_page);
> > +		de = find_in_inline_dir(dir, fname, res_page);
> >  		goto out;
> >  	}
> >  
> > @@ -256,11 +242,35 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
> >  
> >  	for (level = 0; level < max_depth; level++) {
> >  		*res_page = NULL;
> > -		de = find_in_level(dir, level, &fname, res_page);
> > +		de = find_in_level(dir, level, fname, res_page);
> >  		if (de || IS_ERR(*res_page))
> >  			break;
> >  	}
> >  out:
> > +	return de;
> > +}
> > +
> > +/*
> > + * Find an entry in the specified directory with the wanted name.
> > + * It returns the page where the entry was found (as a parameter - res_page),
> > + * and the entry itself. Page is returned mapped and unlocked.
> > + * Entry is guaranteed to be valid.
> > + */
> > +struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
> > +			const struct qstr *child, struct page **res_page)
> > +{
> > +	struct f2fs_dir_entry *de = NULL;
> > +	struct fscrypt_name fname;
> > +	int err;
> > +
> > +	err = fscrypt_setup_filename(dir, child, 1, &fname);
> > +	if (err) {
> > +		*res_page = ERR_PTR(err);
> > +		return NULL;
> > +	}
> > +
> > +	de = __f2fs_find_entry(dir, &fname, res_page);
> > +
> >  	fscrypt_free_filename(&fname);
> >  	return de;
> >  }
> > @@ -599,6 +609,24 @@ fail:
> >  	return err;
> >  }
> >  
> > +int __f2fs_do_add_link(struct inode *dir, struct fscrypt_name *fname,
> > +				struct inode *inode, nid_t ino, umode_t mode)
> > +{
> > +	struct qstr new_name;
> > +	int err = -EAGAIN;
> > +
> > +	new_name.name = fname_name(fname);
> > +	new_name.len = fname_len(fname);
> > +
> > +	if (f2fs_has_inline_dentry(dir))
> > +		err = f2fs_add_inline_entry(dir, &new_name, inode, ino, mode);
> > +	if (err == -EAGAIN)
> > +		err = f2fs_add_regular_entry(dir, &new_name, inode, ino, mode);
> > +
> > +	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
> > +	return err;
> > +}
> > +
> >  /*
> >   * Caller should grab and release a rwsem by calling f2fs_lock_op() and
> >   * f2fs_unlock_op().
> > @@ -607,24 +635,15 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
> >  				struct inode *inode, nid_t ino, umode_t mode)
> >  {
> >  	struct fscrypt_name fname;
> > -	struct qstr new_name;
> >  	int err;
> >  
> >  	err = fscrypt_setup_filename(dir, name, 0, &fname);
> >  	if (err)
> >  		return err;
> >  
> > -	new_name.name = fname_name(&fname);
> > -	new_name.len = fname_len(&fname);
> > -
> > -	err = -EAGAIN;
> > -	if (f2fs_has_inline_dentry(dir))
> > -		err = f2fs_add_inline_entry(dir, &new_name, inode, ino, mode);
> > -	if (err == -EAGAIN)
> > -		err = f2fs_add_regular_entry(dir, &new_name, inode, ino, mode);
> > +	err = __f2fs_do_add_link(dir, &fname, inode, ino, mode);
> >  
> >  	fscrypt_free_filename(&fname);
> > -	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
> >  	return err;
> >  }
> >  
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 14f5fe2..78d7641 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1914,6 +1914,8 @@ struct page *init_inode_metadata(struct inode *, struct inode *,
> >  void update_parent_metadata(struct inode *, struct inode *, unsigned int);
> >  int room_for_filename(const void *, int, int);
> >  void f2fs_drop_nlink(struct inode *, struct inode *);
> > +struct f2fs_dir_entry *__f2fs_find_entry(struct inode *, struct fscrypt_name*,
> > +							struct page **);
> >  struct f2fs_dir_entry *f2fs_find_entry(struct inode *, const struct qstr *,
> >  							struct page **);
> >  struct f2fs_dir_entry *f2fs_parent_dir(struct inode *, struct page **);
> > @@ -1925,6 +1927,8 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *,
> >  			const struct qstr *, f2fs_hash_t , unsigned int);
> >  int f2fs_add_regular_entry(struct inode *, const struct qstr *,
> >  						struct inode *, nid_t, umode_t);
> > +int __f2fs_do_add_link(struct inode *, struct fscrypt_name*, struct inode *,
> > +			nid_t, umode_t);
> >  int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *, nid_t,
> >  			umode_t);
> >  void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *,
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 47abb96..8a0976e 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -135,8 +135,6 @@ static inline bool need_do_checkpoint(struct inode *inode)
> >  
> >  	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
> >  		need_cp = true;
> > -	else if (file_enc_name(inode) && need_dentry_mark(sbi, inode->i_ino))
> > -		need_cp = true;
> >  	else if (file_wrong_pino(inode))
> >  		need_cp = true;
> >  	else if (!space_for_roll_forward(sbi))
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 9e652d5..026f807 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -96,7 +96,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
> >  	struct f2fs_inode *raw_inode = F2FS_INODE(ipage);
> >  	nid_t pino = le32_to_cpu(raw_inode->i_pino);
> >  	struct f2fs_dir_entry *de;
> > -	struct qstr name;
> > +	struct fscrypt_name fname;
> >  	struct page *page;
> >  	struct inode *dir, *einode;
> >  	struct fsync_inode_entry *entry;
> > @@ -120,19 +120,17 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
> >  
> >  	dir = entry->inode;
> >  
> > -	if (file_enc_name(inode))
> > -		return 0;
> > -
> > -	name.len = le32_to_cpu(raw_inode->i_namelen);
> > -	name.name = raw_inode->i_name;
> > +	memset(&fname, 0, sizeof(struct fscrypt_name));
> > +	fname.disk_name.len = le32_to_cpu(raw_inode->i_namelen);
> > +	fname.disk_name.name = raw_inode->i_name;
> >  
> > -	if (unlikely(name.len > F2FS_NAME_LEN)) {
> > +	if (unlikely(fname.disk_name.len > F2FS_NAME_LEN)) {
> >  		WARN_ON(1);
> >  		err = -ENAMETOOLONG;
> >  		goto out;
> >  	}
> >  retry:
> > -	de = f2fs_find_entry(dir, &name, &page);
> > +	de = __f2fs_find_entry(dir, &fname, &page);
> >  	if (de && inode->i_ino == le32_to_cpu(de->ino))
> >  		goto out_unmap_put;
> >  
> > @@ -156,7 +154,7 @@ retry:
> >  	} else if (IS_ERR(page)) {
> >  		err = PTR_ERR(page);
> >  	} else {
> > -		err = __f2fs_add_link(dir, &name, inode,
> > +		err = __f2fs_do_add_link(dir, &fname, inode,
> >  					inode->i_ino, inode->i_mode);
> >  	}
> >  	goto out;
> > 
