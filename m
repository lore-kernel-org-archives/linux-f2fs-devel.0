From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: do not increase link count during recovery
Date: Thu,  2 Apr 2015 10:49:24 -0700
Message-ID: <1427996965-10578-4-git-send-email-jaegeuk@kernel.org>
References: <1427996965-10578-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427996965-10578-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there are multiple fsynced dnodes having a dent flag, roll-forward routine
sets FI_INC_LINK for their inode, and recovery_dentry increases its link count
accordingly.
That results in normal file having a link count as 2, so we can't unlink those
files.

This was added to handle several inode blocks having same inode number with
different directory paths.
But, current f2fs doesn't replay all of path changes and only recover its dentry
for the last fsynced inode block.
So, there is no reason to do this.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 679c465..63b720b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -93,10 +93,9 @@ static int recover_dentry(struct inode *inode, struct page *ipage)
 	}
 retry:
 	de = f2fs_find_entry(dir, &name, &page);
-	if (de && inode->i_ino == le32_to_cpu(de->ino)) {
-		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
+	if (de && inode->i_ino == le32_to_cpu(de->ino))
 		goto out_unmap_put;
-	}
+
 	if (de) {
 		einode = f2fs_iget(inode->i_sb, le32_to_cpu(de->ino));
 		if (IS_ERR(einode)) {
@@ -187,11 +186,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 			goto next;
 
 		entry = get_fsync_inode(head, ino_of_node(page));
-		if (entry) {
-			if (IS_INODE(page) && is_dent_dnode(page))
-				set_inode_flag(F2FS_I(entry->inode),
-							FI_INC_LINK);
-		} else {
+		if (!entry) {
 			if (IS_INODE(page) && is_dent_dnode(page)) {
 				err = recover_inode_page(sbi, page);
 				if (err)
-- 
2.1.1
