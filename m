From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V4 9/9] fsverity: Move verity status check to
 fsverity_prepare_setattr
Date: Wed, 12 Dec 2018 09:37:36 +0530
Message-ID: <20181212040736.2849-10-chandan@linux.vnet.ibm.com>
References: <20181212040736.2849-1-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gWvpp-0005qQ-7R
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Dec 2018 04:09:21 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWvpn-00CRnl-RA
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Dec 2018 04:09:21 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBC3xDXw134738
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 11 Dec 2018 23:09:14 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pasabksg8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 11 Dec 2018 23:09:13 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Wed, 12 Dec 2018 04:09:13 -0000
In-Reply-To: <20181212040736.2849-1-chandan@linux.vnet.ibm.com>
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
Cc: dedekind1@gmail.com, tytso@mit.edu, corbet@lwn.net, jhogan@kernel.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ralf@linux-mips.org, ebiggers@kernel.org, paul.burton@mips.com, adilger.kernel@dilger.ca, green.hu@gmail.com, richard@nod.at, schwidefsky@de.ibm.com, jaegeuk@kernel.org, deanbo422@gmail.com, viro@zeniv.linux.org.uk

Instead of conditionally checking for verity status of an inode before
invoking fsverity_prepare_setattr(), this commit moves the check inside the
definition of fsverity_prepare_setattr().

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 fs/ext4/inode.c          | 8 +++-----
 fs/f2fs/file.c           | 8 +++-----
 fs/verity/setup.c        | 2 +-
 include/linux/fsverity.h | 5 ++++-
 4 files changed, 11 insertions(+), 12 deletions(-)

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
index bc463dc601b1..154556d72691 100644
--- a/fs/verity/setup.c
+++ b/fs/verity/setup.c
@@ -796,7 +796,7 @@ EXPORT_SYMBOL_GPL(fsverity_file_open);
  */
 int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
 {
-	if (attr->ia_valid & ATTR_SIZE) {
+	if (IS_VERITY(d_inode(dentry)) && (attr->ia_valid & ATTR_SIZE)) {
 		pr_debug("Denying truncate of verity file (ino %lu)\n",
 			 d_inode(dentry)->i_ino);
 		return -EPERM;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index c770025606e1..9ccc8ad9652a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -69,7 +69,10 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 static inline int fsverity_prepare_setattr(struct dentry *dentry,
 					   struct iattr *attr)
 {
-	return -EOPNOTSUPP;
+	if (IS_VERITY(d_inode(dentry)))
+		return -EOPNOTSUPP;
+
+	return 0;
 }
 
 static inline int fsverity_prepare_getattr(struct inode *inode)
-- 
2.19.1
