From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/8] fsck.f2fs: count child directories correctly
	for i_links
Date: Thu,  2 Apr 2015 10:50:51 -0700
Message-ID: <1427997055-10715-4-git-send-email-jaegeuk@kernel.org>
References: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjGw-00027Z-JG
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:18 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjGu-0002eH-PJ for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:18 +0000
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

If some of children including directories are corrupted, we should not include
them into i_links of their parent.
This patch fixes that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index debae1c..828d889 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -793,7 +793,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 	u16 name_len;;
 	int ret = 0;
 	int fixed = 0;
-	int i;
+	int i, slots;
 
 	/* readahead inode blocks */
 	for (i = 0; i < max; i++) {
@@ -864,6 +864,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 		memcpy(name, filenames[i], name_len);
 		hash_code = f2fs_dentry_hash((const unsigned char *)name,
 								name_len);
+		slots = (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
 
 		/* fix hash_code made by old buggy code */
 		if (le32_to_cpu(dentry[i].hash_code) != hash_code) {
@@ -874,12 +875,12 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 
 		/* Becareful. 'dentry.file_type' is not imode. */
 		if (ftype == F2FS_FT_DIR) {
-			*child_cnt = *child_cnt + 1;
 			if ((name[0] == '.' && name_len == 1) ||
 				(name[0] == '.' && name[1] == '.' &&
 							name_len == 2)) {
 				i++;
 				free(name);
+				*child_cnt = *child_cnt + 1;
 				continue;
 			}
 		}
@@ -899,23 +900,22 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 
 		if (ret && config.fix_on) {
 			int j;
-			int slots = (name_len + F2FS_SLOT_LEN - 1) /
-				F2FS_SLOT_LEN;
+
 			for (j = 0; j < slots; j++)
 				clear_bit(i + j, bitmap);
 			FIX_MSG("Unlink [0x%x] - %s len[0x%x], type[0x%x]",
 					le32_to_cpu(dentry[i].ino),
 					name, name_len,
 					dentry[i].file_type);
-			i += slots;
-			free(name);
 			fixed = 1;
-			continue;
+		} else if (ret == 0) {
+			if (ftype == F2FS_FT_DIR)
+				*child_cnt = *child_cnt + 1;
+			dentries++;
+			*child_files = *child_files + 1;
 		}
 
-		i += (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
-		dentries++;
-		*child_files = *child_files + 1;
+		i += slots;
 		free(name);
 	}
 	return fixed ? -1 : dentries;
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
