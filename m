From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V3 5/9] ext4: use IS_VERITY() to check inode's
 fsverity status
Date: Sat,  8 Dec 2018 12:21:40 +0530
Message-ID: <20181208065144.19486-6-chandan@linux.vnet.ibm.com>
References: <20181208065144.19486-1-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gVWTw-0006X3-MN
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Dec 2018 06:52:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gVWTv-006Bvm-5r
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Dec 2018 06:52:56 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB86mOBR080548
 for <linux-f2fs-devel@lists.sourceforge.net>; Sat, 8 Dec 2018 01:52:49 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p87ssahr7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sat, 08 Dec 2018 01:52:49 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Sat, 8 Dec 2018 06:52:48 -0000
In-Reply-To: <20181208065144.19486-1-chandan@linux.vnet.ibm.com>
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

This commit removes the ext4 specific ext4_verity_inode() and makes
use of the generic IS_ENCRYPTED() macro or ext4_test_inode_flag() to
check for the encryption status of an inode.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 fs/ext4/ext4.h     |  9 ---------
 fs/ext4/file.c     |  2 +-
 fs/ext4/inode.c    | 10 ++++++----
 fs/ext4/readpage.c |  2 +-
 fs/ext4/super.c    |  1 +
 5 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index db21df885186..64bf9fb7ef18 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2296,15 +2296,6 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 					      struct ext4_group_desc *gdp);
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
-static inline bool ext4_verity_inode(struct inode *inode)
-{
-#ifdef CONFIG_EXT4_FS_VERITY
-	return ext4_test_inode_flag(inode, EXT4_INODE_VERITY);
-#else
-	return false;
-#endif
-}
-
 #ifdef CONFIG_FS_ENCRYPTION
 static inline int ext4_fname_setup_filename(struct inode *dir,
 			const struct qstr *iname,
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index cb4b69ef01a2..30fbd663354f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -444,7 +444,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 	if (ret)
 		return ret;
 
-	if (ext4_verity_inode(inode)) {
+	if (IS_VERITY(inode)) {
 		ret = fsverity_file_open(inode, filp);
 		if (ret)
 			return ret;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8a55255a6c32..703f55635824 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3883,7 +3883,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		return 0;
 #endif
 
-	if (ext4_verity_inode(inode))
+	if (IS_VERITY(inode))
 		return 0;
 
 	/*
@@ -4724,7 +4724,7 @@ static bool ext4_should_use_dax(struct inode *inode)
 		return false;
 	if (ext4_test_inode_flag(inode, EXT4_INODE_ENCRYPT))
 		return false;
-	if (ext4_verity_inode(inode))
+	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
 		return false;
 	return true;
 }
@@ -4748,9 +4748,11 @@ void ext4_set_inode_flags(struct inode *inode)
 		new_fl |= S_DAX;
 	if (flags & EXT4_ENCRYPT_FL)
 		new_fl |= S_ENCRYPTED;
+	if (flags & EXT4_VERITY_FL)
+		new_fl |= S_VERITY;
 	inode_set_flags(inode, new_fl,
 			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|S_DAX|
-			S_ENCRYPTED);
+			S_ENCRYPTED|S_VERITY);
 }
 
 static blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
@@ -5508,7 +5510,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	if (error)
 		return error;
 
-	if (ext4_verity_inode(inode)) {
+	if (IS_VERITY(inode)) {
 		error = fsverity_prepare_setattr(dentry, attr);
 		if (error)
 			return error;
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 7252f0a60cdb..2c037df629dd 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -206,7 +206,7 @@ static void mpage_end_io(struct bio *bio)
 static inline loff_t ext4_readpage_limit(struct inode *inode)
 {
 #ifdef CONFIG_EXT4_FS_VERITY
-	if (ext4_verity_inode(inode)) {
+	if (IS_VERITY(inode)) {
 		if (inode->i_verity_info)
 			/* limit to end of metadata region */
 			return fsverity_full_i_size(inode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16fb483a6f4a..35ed3c48f8d2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1344,6 +1344,7 @@ static int ext4_set_verity(struct inode *inode, loff_t data_i_size)
 	err = ext4_reserve_inode_write(handle, inode, &iloc);
 	if (err == 0) {
 		ext4_set_inode_flag(inode, EXT4_INODE_VERITY);
+		ext4_set_inode_flags(inode);
 		EXT4_I(inode)->i_disksize = data_i_size;
 		err = ext4_mark_iloc_dirty(handle, inode, &iloc);
 	}
-- 
2.19.1
