From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] fsck.f2fs: fix wrong hash_code made by
	previous buggy code
Date: Wed, 15 Oct 2014 20:59:11 -0700
Message-ID: <1413431951-27137-4-git-send-email-jaegeuk@kernel.org>
References: <1413431951-27137-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XecDm-00069u-3M
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Oct 2014 03:59:26 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XecDl-0007mj-4w for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Oct 2014 03:59:26 +0000
In-Reply-To: <1413431951-27137-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The previous f2fs remained wrong hash_code for international characters.
So, fsck.f2fs should fix that hash_code with current valid names.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8e3ecc8..9997d0c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -401,6 +401,10 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		DBG(3, "ino[0x%x] has inline dentry!\n", nid);
 		ret = fsck_chk_inline_dentries(sbi, node_blk,
 					&child_cnt, &child_files);
+		if (ret < 0) {
+			/* should fix this bug all the time */
+			need_fix = 1;
+		}
 		goto check;
 	}
 
@@ -607,6 +611,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 	u32 hash_code;
 	u16 name_len;;
 	int ret = 0;
+	int fixed = 0;
 	int i;
 
 	for (i = 0; i < max;) {
@@ -621,7 +626,12 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 		hash_code = f2fs_dentry_hash((const unsigned char *)name,
 								name_len);
 
-		ASSERT(le32_to_cpu(dentry[i].hash_code) == hash_code);
+		/* fix hash_code made by old buggy code */
+		if (le32_to_cpu(dentry[i].hash_code) != hash_code) {
+			dentry[i].hash_code = hash_code;
+			fixed = 1;
+			FIX_MSG("hash_code[%d] of %s", i, name);
+		}
 
 		ftype = dentry[i].file_type;
 
@@ -670,7 +680,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 		*child_files = *child_files + 1;
 		free(name);
 	}
-	return dentries;
+	return fixed ? -1 : dentries;
 }
 
 int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
@@ -688,12 +698,17 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 			(unsigned long *)de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
 			NR_INLINE_DENTRY, 1);
-	DBG(1, "[%3d] Inline Dentry Block Done : "
+	if (dentries < 0) {
+		DBG(1, "[%3d] Inline Dentry Block Fixed hash_codes\n\n",
+			fsck->dentry_depth);
+	} else {
+		DBG(1, "[%3d] Inline Dentry Block Done : "
 				"dentries:%d in %d slots (len:%d)\n\n",
 			fsck->dentry_depth, dentries,
 			(int)NR_INLINE_DENTRY, F2FS_NAME_LEN);
+	}
 	fsck->dentry_depth--;
-	return 0;
+	return dentries;
 }
 
 int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
@@ -715,10 +730,17 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			de_blk->dentry, de_blk->filename,
 			NR_DENTRY_IN_BLOCK, last_blk);
 
-	DBG(1, "[%3d] Dentry Block [0x%x] Done : "
+	if (dentries < 0) {
+		ret = dev_write_block(de_blk, blk_addr);
+		ASSERT(ret >= 0);
+		DBG(1, "[%3d] Dentry Block [0x%x] Fixed hash_codes\n\n",
+			fsck->dentry_depth, blk_addr);
+	} else {
+		DBG(1, "[%3d] Dentry Block [0x%x] Done : "
 				"dentries:%d in %d slots (len:%d)\n\n",
 			fsck->dentry_depth, blk_addr, dentries,
 			NR_DENTRY_IN_BLOCK, F2FS_NAME_LEN);
+	}
 	fsck->dentry_depth--;
 	free(de_blk);
 	return 0;
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
