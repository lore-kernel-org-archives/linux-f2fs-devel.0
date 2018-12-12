From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V4 6/9] f2fs: use IS_VERITY() to check inode's
 fsverity status
Date: Wed, 12 Dec 2018 09:37:33 +0530
Message-ID: <20181212040736.2849-7-chandan@linux.vnet.ibm.com>
References: <20181212040736.2849-1-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gWvpN-0000uW-1a
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Dec 2018 04:08:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWvpL-00Cyf8-IA
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Dec 2018 04:08:52 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBC3xBmU001311
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 11 Dec 2018 23:08:45 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pasjs2rvw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 11 Dec 2018 23:08:45 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Wed, 12 Dec 2018 04:08:45 -0000
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

This commit removes the f2fs specific f2fs_verity_file() and makes use
of the generic IS_VERITY() macro or file_is_verity() to check for the
verity status of an inode.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 fs/f2fs/f2fs.h  | 7 +------
 fs/f2fs/file.c  | 6 +++---
 fs/f2fs/inode.c | 4 +++-
 fs/f2fs/super.c | 1 +
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f9c8b0afc1de..54bd93c7b630 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3448,18 +3448,13 @@ static inline void f2fs_set_encrypted_inode(struct inode *inode)
 #endif
 }
 
-static inline bool f2fs_verity_file(struct inode *inode)
-{
-	return file_is_verity(inode);
-}
-
 /*
  * Returns true if the reads of the inode's data need to undergo some
  * postprocessing step, like decryption or authenticity verification.
  */
 static inline bool f2fs_post_read_required(struct inode *inode)
 {
-	return f2fs_encrypted_file(inode) || f2fs_verity_file(inode);
+	return f2fs_encrypted_file(inode) || IS_VERITY(inode);
 }
 
 #define F2FS_FEATURE_FUNCS(name, flagname) \
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6c7ad15000b9..2eb4821d95d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -491,7 +491,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
-	if (f2fs_verity_file(inode)) {
+	if (IS_VERITY(inode)) {
 		err = fsverity_file_open(inode, filp);
 		if (err)
 			return err;
@@ -701,7 +701,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 	struct f2fs_inode *ri;
 	unsigned int flags;
 
-	if (f2fs_verity_file(inode)) {
+	if (IS_VERITY(inode)) {
 		/*
 		 * For fs-verity we need to override i_size with the original
 		 * data i_size.  This requires I/O to the file which with
@@ -800,7 +800,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err)
 		return err;
 
-	if (f2fs_verity_file(inode)) {
+	if (IS_VERITY(inode)) {
 		err = fsverity_prepare_setattr(dentry, attr);
 		if (err)
 			return err;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d731d23aedee..ff9126616d65 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -45,9 +45,11 @@ void f2fs_set_inode_flags(struct inode *inode)
 		new_fl |= S_DIRSYNC;
 	if (file_is_encrypt(inode))
 		new_fl |= S_ENCRYPTED;
+	if (file_is_verity(inode))
+		new_fl |= S_VERITY;
 	inode_set_flags(inode, new_fl,
 			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
-			S_ENCRYPTED);
+			S_ENCRYPTED|S_VERITY);
 }
 
 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4287cf348d3c..73320202bd01 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2207,6 +2207,7 @@ static int f2fs_set_verity(struct inode *inode, loff_t data_i_size)
 		return err;
 
 	file_set_verity(inode);
+	f2fs_set_inode_flags(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
-- 
2.19.1
