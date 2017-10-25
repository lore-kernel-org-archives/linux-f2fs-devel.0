From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: add missing quota_initialize in f2fs_set_acl
Date: Wed, 25 Oct 2017 08:30:58 +0200
Message-ID: <20171025063058.GA99117@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171023221409.59148-1-jaegeuk@kernel.org>
 <f20fe8e5-b3f1-59f9-a9be-e16732f52e83@huawei.com>
 <20171025054419.GB83348@jaegeuk-macbookpro.roam.corp.google.com>
 <fa22fb69-e026-dbbb-d5ba-19fdfd9d2df3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa22fb69-e026-dbbb-d5ba-19fdfd9d2df3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/25, Chao Yu wrote:
> On 2017/10/25 13:44, Jaegeuk Kim wrote:
> > On 10/24, Chao Yu wrote:
> >> On 2017/10/24 6:14, Jaegeuk Kim wrote:
> >>> This patch adds to call quota_intialize in f2fs_set_acl.
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/acl.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> >>> index 436b3a1464d9..f6471f9d707e 100644
> >>> --- a/fs/f2fs/acl.c
> >>> +++ b/fs/f2fs/acl.c
> >>> @@ -209,6 +209,10 @@ static int __f2fs_set_acl(struct inode *inode, int type,
> >>>  	int error;
> >>>  	umode_t mode = inode->i_mode;
> >>>  
> >>> +	error = dquot_initialize(inode);
> >>> +	if (error)
> >>> +		return error;
> >>
> >> Could you move this to f2fs_setxattr, and also add missing dquot_initialize in
> >> unlink and rename like ext4?
> > 
> > I've checked that f2fs_unlink and f2fs_rename are calling dquot_initialize().
> 
> ext4_unlink:
> 
> 	retval = dquot_initialize(dir);
> 	if (retval)
> 		return retval;
> 	retval = dquot_initialize(d_inode(dentry));
> 	if (retval)
> 		return retval;
> 
> f2fs_unlink:
> 
> 	err = dquot_initialize(dir);
> 	if (err)
> 		return err;
> 
> ext4_rename
> 
> 	retval = dquot_initialize(old.dir);
> 	if (retval)
> 		return retval;
> 	retval = dquot_initialize(new.dir);
> 	if (retval)
> 		return retval;
> 
> 	/* Initialize quotas before so that eventual writes go
> 	 * in separate transaction */
> 	if (new.inode) {
> 		retval = dquot_initialize(new.inode);
> 		if (retval)
> 			return retval;
> 	}
> 
> f2fs_rename
> 
> 	err = dquot_initialize(old_dir);
> 	if (err)
> 		goto out;
> 
> 	err = dquot_initialize(new_dir);
> 	if (err)
> 		goto out;
> 
> ext4 call one more dquot_initialize than f2fs, I didn't look into this in
> detail, but it's better to check that. :)

Ah, okay. :)

This patch adds to call quota_intialize in f2fs_set_acl, f2fs_unlink,
and f2fs_rename.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 9 +++++++++
 fs/f2fs/xattr.c | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 944f7a6940b6..35d982a475b1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -436,6 +436,9 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		return -EIO;
 
 	err = dquot_initialize(dir);
+	if (err)
+		return err;
+	err = dquot_initialize(inode);
 	if (err)
 		return err;
 
@@ -815,6 +818,12 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		goto out;
 
+	if (new_inode) {
+		err = dquot_initialize(new_inode);
+		if (err)
+			goto out;
+	}
+
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 147b481c6902..8801db019892 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -686,6 +686,10 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
 	/* this case is only from init_inode_metadata */
 	if (ipage)
 		return __f2fs_setxattr(inode, index, name, value,
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
