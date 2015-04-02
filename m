From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/8] fsck.f2fs: fix corrupted dentries
Date: Thu,  2 Apr 2015 10:50:50 -0700
Message-ID: <1427997055-10715-3-git-send-email-jaegeuk@kernel.org>
References: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjGt-00027A-DZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjGs-0004gY-Cz for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:15 +0000
In-Reply-To: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes corrupted dentries such as name_len == 0.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index ecb18f2..debae1c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -796,22 +796,24 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 	int i;
 
 	/* readahead inode blocks */
-	for (i = 0; i < max;) {
-		if (test_bit(i, bitmap) == 0) {
-			i++;
+	for (i = 0; i < max; i++) {
+		if (test_bit(i, bitmap) == 0)
 			continue;
-		}
+
 		ino = le32_to_cpu(dentry[i].ino);
 
 		if (IS_VALID_NID(sbi, ino)) {
 			struct node_info ni;
 
 			get_node_info(sbi, ino, &ni);
-			if (IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
+			if (IS_VALID_BLK_ADDR(sbi, ni.blk_addr)) {
 				dev_reada_block(ni.blk_addr);
+				name_len = le16_to_cpu(dentry[i].name_len);
+				if (name_len > 0)
+					i += (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN - 1;
+				continue;
+			}
 		}
-		name_len = le16_to_cpu(dentry[i].name_len);
-		i += (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
 	}
 
 	for (i = 0; i < max;) {
@@ -820,31 +822,44 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 			continue;
 		}
 		if (!IS_VALID_NID(sbi, le32_to_cpu(dentry[i].ino))) {
-			DBG(1, "Bad dentry 0x%x with invalid NID/ino 0x%x",
-			    i, le32_to_cpu(dentry[i].ino));
+			ASSERT_MSG("Bad dentry 0x%x with invalid NID/ino 0x%x",
+				    i, le32_to_cpu(dentry[i].ino));
 			if (config.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x with bad ino 0x%x",
 					i, le32_to_cpu(dentry[i].ino));
 				clear_bit(i, bitmap);
-				i++;
 				fixed = 1;
-				continue;
 			}
+			i++;
+			continue;
 		}
+
 		ftype = dentry[i].file_type;
-		if ((ftype <= F2FS_FT_UNKNOWN || ftype > F2FS_FT_LAST_FILE_TYPE) && config.fix_on) {
-			DBG(1, "Bad dentry 0x%x with unexpected ftype 0x%x",
-			    i, ftype);
+		if ((ftype <= F2FS_FT_UNKNOWN || ftype > F2FS_FT_LAST_FILE_TYPE)) {
+			ASSERT_MSG("Bad dentry 0x%x with unexpected ftype 0x%x", i, ftype);
 			if (config.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x with bad ftype 0x%x",
 					i, ftype);
 				clear_bit(i, bitmap);
-				i++;
 				fixed = 1;
-				continue;
 			}
+			i++;
+			continue;
 		}
+
 		name_len = le16_to_cpu(dentry[i].name_len);
+
+		if (name_len == 0) {
+			ASSERT_MSG("Bad dentry 0x%x with zero name_len", i);
+			if (config.fix_on) {
+				FIX_MSG("Clear bad dentry 0x%x", i);
+				clear_bit(i, bitmap);
+				fixed = 1;
+			}
+			i++;
+			continue;
+		}
+
 		name = calloc(name_len + 1, 1);
 		memcpy(name, filenames[i], name_len);
 		hash_code = f2fs_dentry_hash((const unsigned char *)name,
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
