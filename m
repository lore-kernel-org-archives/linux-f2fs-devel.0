From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V5 9/9] fsverity: Move verity status check to
 fsverity_prepare_setattr
Date: Wed, 12 Dec 2018 15:20:18 +0530
Message-ID: <20181212095018.12648-10-chandan@linux.vnet.ibm.com>
References: <20181212095018.12648-1-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gX1C2-0003fn-86
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Dec 2018 09:52:38 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gX1Bm-00Cypa-J3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Dec 2018 09:52:38 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBC9nUtl048537
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 12 Dec 2018 04:52:16 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2payvp0ntg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 12 Dec 2018 04:52:16 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Wed, 12 Dec 2018 09:52:15 -0000
In-Reply-To: <20181212095018.12648-1-chandan@linux.vnet.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, linux-mips@linux-mips.org, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, dedekind1@gmail.com, tytso@mit.edu, corbet@lwn.net, jhogan@kernel.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ralf@linux-mips.org, ebiggers@kernel.org, paul.burton@mips.com, adilger.kernel@dilger.ca, green.hu@gmail.com, richard@nod.at, schwidefsky@de.ibm.com, jaegeuk@kernel.org, deanbo422@gmail.com, viro@zeniv.linux.org.uk

Instead of conditionally checking for verity status of an inode before
invoking fsverity_prepare_setattr(), this commit moves the check inside the
definition of fsverity_prepare_setattr().

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
(EB: fix the !CONFIG_FS_VERITY case and inline the IS_VERITY() check)
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c          |  8 +++-----
 fs/f2fs/file.c           |  8 +++-----
 fs/verity/setup.c        | 14 ++------------
 include/linux/fsverity.h | 25 ++++++++++++++++++++++---
 4 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 703f55635824..44561e68886b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5510,11 +5510,9 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	if (error)
 		return error;
 
-	if (IS_VERITY(inode)) {
-		error = fsverity_prepare_setattr(dentry, attr);
-		if (error)
-			return error;
-	}
+	error = fsverity_prepare_setattr(dentry, attr);
+	if (error)
+		return error;
 
 	if (is_quota_modification(inode, attr)) {
 		error = dquot_initialize(inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 925c0d9608da..422907ca37c6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -798,11 +798,9 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err)
 		return err;
 
-	if (IS_VERITY(inode)) {
-		err = fsverity_prepare_setattr(dentry, attr);
-		if (err)
-			return err;
-	}
+	err = fsverity_prepare_setattr(dentry, attr);
+	if (err)
+		return err;
 
 	if (is_quota_modification(inode, attr)) {
 		err = dquot_initialize(inode);
diff --git a/fs/verity/setup.c b/fs/verity/setup.c
index 4ecaeb89166b..2b707589999c 100644
--- a/fs/verity/setup.c
+++ b/fs/verity/setup.c
@@ -767,17 +767,7 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
-/**
- * fsverity_prepare_setattr - prepare to change a verity inode's attributes
- * @dentry: dentry through which the inode is being changed
- * @attr: attributes to change
- *
- * Verity files are immutable, so deny truncates.  This isn't covered by the
- * open-time check because sys_truncate() takes a path, not a file descriptor.
- *
- * Return: 0 on success, -errno on failure
- */
-int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
+int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	if (attr->ia_valid & ATTR_SIZE) {
 		pr_debug("Denying truncate of verity file (ino %lu)\n",
@@ -786,7 +776,7 @@ int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsverity_prepare_setattr);
+EXPORT_SYMBOL_GPL(__fsverity_prepare_setattr);
 
 /**
  * fsverity_prepare_getattr - prepare to get a verity inode's attributes
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 0ce170c2c167..099fc34936fa 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -26,7 +26,8 @@ extern int fsverity_ioctl_measure(struct file *filp, void __user *arg);
 
 /* setup.c */
 extern int __fsverity_file_open(struct inode *inode, struct file *filp);
-extern int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
+extern int __fsverity_prepare_setattr(struct dentry *dentry,
+				      struct iattr *attr);
 extern int fsverity_prepare_getattr(struct inode *inode);
 extern void fsverity_cleanup_inode(struct inode *inode);
 extern loff_t fsverity_full_i_size(const struct inode *inode);
@@ -63,8 +64,8 @@ static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
 	return -EOPNOTSUPP;
 }
 
-static inline int fsverity_prepare_setattr(struct dentry *dentry,
-					   struct iattr *attr)
+static inline int __fsverity_prepare_setattr(struct dentry *dentry,
+					     struct iattr *attr)
 {
 	return -EOPNOTSUPP;
 }
@@ -129,4 +130,22 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/**
+ * fsverity_prepare_setattr - prepare to change a verity inode's attributes
+ * @dentry: dentry through which the inode is being changed
+ * @attr: attributes to change
+ *
+ * Verity files are immutable, so deny truncates.  This isn't covered by the
+ * open-time check because sys_truncate() takes a path, not a file descriptor.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static inline int fsverity_prepare_setattr(struct dentry *dentry,
+					   struct iattr *attr)
+{
+	if (IS_VERITY(d_inode(dentry)))
+		return __fsverity_prepare_setattr(dentry, attr);
+	return 0;
+}
+
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.19.1
