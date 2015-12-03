From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not recover from previous remained wrong dnodes
Date: Thu,  3 Dec 2015 15:06:24 -0800
Message-ID: <1449183984-67646-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If device does not support discard, some obsolete dnodes can be recovered
by roll-forward. This patch enhances the recovery flow.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index cbf74f4..fad010f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -168,6 +168,32 @@ static void recover_inode(struct inode *inode, struct page *page)
 			ino_of_node(page), name);
 }
 
+static bool is_same_inode(struct inode *inode, struct page *ipage)
+{
+	struct f2fs_inode *ri = F2FS_INODE(ipage);
+	struct timespec disk;
+
+	if (!IS_INODE(ipage))
+		return true;
+
+	disk.tv_sec = le64_to_cpu(ri->i_ctime);
+	disk.tv_nsec = le32_to_cpu(ri->i_ctime_nsec);
+	if (timespec_compare(&inode->i_ctime, &disk) > 0)
+		return false;
+
+	disk.tv_sec = le64_to_cpu(ri->i_atime);
+	disk.tv_nsec = le32_to_cpu(ri->i_atime_nsec);
+	if (timespec_compare(&inode->i_atime, &disk) > 0)
+		return false;
+
+	disk.tv_sec = le64_to_cpu(ri->i_mtime);
+	disk.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
+	if (timespec_compare(&inode->i_mtime, &disk) > 0)
+		return false;
+
+	return true;
+}
+
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 {
 	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
@@ -197,7 +223,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 			goto next;
 
 		entry = get_fsync_inode(head, ino_of_node(page));
-		if (!entry) {
+		if (entry) {
+			if (!is_same_inode(entry->inode, page))
+				goto next;
+		} else {
 			if (IS_INODE(page) && is_dent_dnode(page)) {
 				err = recover_inode_page(sbi, page);
 				if (err)
-- 
2.4.9 (Apple Git-60)
