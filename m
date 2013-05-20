From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: fix to unlock page before exit
Date: Mon, 20 May 2013 12:16:07 +0900
Message-ID: <1369019767-17321-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1369019767-17321-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1369019767-17321-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we got an error after lock_page, we should unlock it before exit.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/recovery.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 5fcdd08..edb89a3 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -343,7 +343,7 @@ static int recover_data(struct f2fs_sb_info *sbi,
 		lock_page(page);
 
 		if (cp_ver != cpver_of_node(page))
-			goto unlock_out;
+			break;
 
 		entry = get_fsync_inode(head, ino_of_node(page));
 		if (!entry)
@@ -351,7 +351,7 @@ static int recover_data(struct f2fs_sb_info *sbi,
 
 		err = do_recover_data(sbi, entry->inode, page, blkaddr);
 		if (err)
-			goto out;
+			break;
 
 		if (entry->blkaddr == blkaddr) {
 			iput(entry->inode);
@@ -362,7 +362,6 @@ next:
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 	}
-unlock_out:
 	unlock_page(page);
 out:
 	__free_pages(page, 0);
-- 
1.8.1.3.566.gaa39828
