From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH] f2fs: obsolete FI_ACL_MODE
Date: Sun, 30 Jul 2017 00:40:09 -0700
Message-ID: <20170730074009.GA13293@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170726143330.7481-1-chao@kernel.org>
 <88df46f8-1330-5985-1781-a5635ad051f6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dbipl-0004TT-GG
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Jul 2017 07:40:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dbipk-0000Bn-9k
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Jul 2017 07:40:17 +0000
Content-Disposition: inline
In-Reply-To: <88df46f8-1330-5985-1781-a5635ad051f6@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 07/29, Chao Yu wrote:
> Hi Jaegeuk,
> 
> Could you take time to have a look at this? Is this change reasonable?
> 
> Thanks,
> 
> On 2017/7/26 22:33, Chao Yu wrote:
> > From: Chao Yu <yuchao0@huawei.com>
> > 
> > Previously, in order to avoid losing important inode metadata after
> > checkpoint & sudden power-off, f2fs uses synchronous approach for
> > updating inode metadata, so attribute in inode cache will be updated
> > to node page cache, after flushing dirty node pages in checkpoint,
> > these attribute in node page can be persisted.
> > 
> > However, f2fs has changed to use asynchronous inode metadata update
> > approach in commit 0f18b462b2e5 ("flush inode metadata when checkpoint
> > is doing"), with this change, we can obsolete synchrounous metadata
> > update approach including old acl updating method.>

Hmm, async doesn't mean guaranteed inode updates here, so it seems we can't
simply remove this still.

Thanks,

> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/acl.c   |  8 +++-----
> >  fs/f2fs/f2fs.h  | 13 -------------
> >  fs/f2fs/file.c  | 43 ++++---------------------------------------
> >  fs/f2fs/xattr.c |  6 +-----
> >  4 files changed, 8 insertions(+), 62 deletions(-)
> > 
> > diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> > index b4b8438c42ef..25eaf243ee2e 100644
> > --- a/fs/f2fs/acl.c
> > +++ b/fs/f2fs/acl.c
> > @@ -215,7 +215,8 @@ static int __f2fs_set_acl(struct inode *inode, int type,
> >  			error = posix_acl_update_mode(inode, &inode->i_mode, &acl);
> >  			if (error)
> >  				return error;
> > -			set_acl_inode(inode, inode->i_mode);
> > +			inode->i_ctime = current_time(inode);
> > +			f2fs_mark_inode_dirty_sync(inode, true);
> >  		}
> >  		break;
> >  
> > @@ -231,10 +232,8 @@ static int __f2fs_set_acl(struct inode *inode, int type,
> >  
> >  	if (acl) {
> >  		value = f2fs_acl_to_disk(F2FS_I_SB(inode), acl, &size);
> > -		if (IS_ERR(value)) {
> > -			clear_inode_flag(inode, FI_ACL_MODE);
> > +		if (IS_ERR(value))
> >  			return PTR_ERR(value);
> > -		}
> >  	}
> >  
> >  	error = f2fs_setxattr(inode, name_index, "", value, size, ipage, 0);
> > @@ -243,7 +242,6 @@ static int __f2fs_set_acl(struct inode *inode, int type,
> >  	if (!error)
> >  		set_cached_acl(inode, type, acl);
> >  
> > -	clear_inode_flag(inode, FI_ACL_MODE);
> >  	return error;
> >  }
> >  
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 5cfffd6f0209..07a6697a0589 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -561,7 +561,6 @@ struct f2fs_inode_info {
> >  	unsigned char i_dir_level;	/* use for dentry level for large dir */
> >  	unsigned int i_current_depth;	/* use only in directory structure */
> >  	unsigned int i_pino;		/* parent inode number */
> > -	umode_t i_acl_mode;		/* keep file acl mode temporarily */
> >  
> >  	/* Use below internally in f2fs*/
> >  	unsigned long flags;		/* use to pass per-file flags */
> > @@ -1957,7 +1956,6 @@ enum {
> >  	FI_AUTO_RECOVER,	/* indicate inode is recoverable */
> >  	FI_DIRTY_DIR,		/* indicate directory has dirty pages */
> >  	FI_INC_LINK,		/* need to increment i_nlink */
> > -	FI_ACL_MODE,		/* indicate acl mode */
> >  	FI_NO_ALLOC,		/* should not allocate any blocks */
> >  	FI_FREE_NID,		/* free allocated nide */
> >  	FI_NO_EXTENT,		/* not to use the extent cache */
> > @@ -2016,13 +2014,6 @@ static inline void clear_inode_flag(struct inode *inode, int flag)
> >  	__mark_inode_dirty_flag(inode, flag, false);
> >  }
> >  
> > -static inline void set_acl_inode(struct inode *inode, umode_t mode)
> > -{
> > -	F2FS_I(inode)->i_acl_mode = mode;
> > -	set_inode_flag(inode, FI_ACL_MODE);
> > -	f2fs_mark_inode_dirty_sync(inode, false);
> > -}
> > -
> >  static inline void f2fs_i_links_write(struct inode *inode, bool inc)
> >  {
> >  	if (inc)
> > @@ -2295,10 +2286,6 @@ static inline int get_extra_isize(struct inode *inode)
> >  	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
> >  }
> >  
> > -#define get_inode_mode(i) \
> > -	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
> > -	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
> > -
> >  #define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
> >  	(offsetof(struct f2fs_inode, i_extra_end) -	\
> >  	offsetof(struct f2fs_inode, i_extra_isize))	\
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index e13f0ada1110..f8d3f4f928e7 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -763,36 +763,6 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
> >  	return 0;
> >  }
> >  
> > -#ifdef CONFIG_F2FS_FS_POSIX_ACL
> > -static void __setattr_copy(struct inode *inode, const struct iattr *attr)
> > -{
> > -	unsigned int ia_valid = attr->ia_valid;
> > -
> > -	if (ia_valid & ATTR_UID)
> > -		inode->i_uid = attr->ia_uid;
> > -	if (ia_valid & ATTR_GID)
> > -		inode->i_gid = attr->ia_gid;
> > -	if (ia_valid & ATTR_ATIME)
> > -		inode->i_atime = timespec_trunc(attr->ia_atime,
> > -						inode->i_sb->s_time_gran);
> > -	if (ia_valid & ATTR_MTIME)
> > -		inode->i_mtime = timespec_trunc(attr->ia_mtime,
> > -						inode->i_sb->s_time_gran);
> > -	if (ia_valid & ATTR_CTIME)
> > -		inode->i_ctime = timespec_trunc(attr->ia_ctime,
> > -						inode->i_sb->s_time_gran);
> > -	if (ia_valid & ATTR_MODE) {
> > -		umode_t mode = attr->ia_mode;
> > -
> > -		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
> > -			mode &= ~S_ISGID;
> > -		set_acl_inode(inode, mode);
> > -	}
> > -}
> > -#else
> > -#define __setattr_copy setattr_copy
> > -#endif
> > -
> >  int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
> >  {
> >  	struct inode *inode = d_inode(dentry);
> > @@ -854,18 +824,13 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
> >  		size_changed = true;
> >  	}
> >  
> > -	__setattr_copy(inode, attr);
> > +	setattr_copy(inode, attr);
> >  
> > -	if (attr->ia_valid & ATTR_MODE) {
> > -		err = posix_acl_chmod(inode, get_inode_mode(inode));
> > -		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
> > -			inode->i_mode = F2FS_I(inode)->i_acl_mode;
> > -			clear_inode_flag(inode, FI_ACL_MODE);
> > -		}
> > -	}
> > +	if (attr->ia_valid & ATTR_MODE)
> > +		err = posix_acl_chmod(inode, inode->i_mode);
> >  
> >  	/* file size may changed here */
> > -	f2fs_mark_inode_dirty_sync(inode, size_changed);
> > +	f2fs_mark_inode_dirty_sync(inode, size_changed && !err);
> >  
> >  	/* inode change will produce dirty node pages flushed by checkpoint */
> >  	f2fs_balance_fs(F2FS_I_SB(inode), true);
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > index ef3a3721ea6b..d0420870f79f 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -654,14 +654,10 @@ static int __f2fs_setxattr(struct inode *inode, int index,
> >  	if (error)
> >  		goto exit;
> >  
> > -	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
> > -		inode->i_mode = F2FS_I(inode)->i_acl_mode;
> > -		inode->i_ctime = current_time(inode);
> > -		clear_inode_flag(inode, FI_ACL_MODE);
> > -	}
> >  	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
> >  			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
> >  		f2fs_set_encrypted_inode(inode);
> > +	inode->i_ctime = current_time(inode);
> >  	f2fs_mark_inode_dirty_sync(inode, true);
> >  	if (!error && S_ISDIR(inode->i_mode))
> >  		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
