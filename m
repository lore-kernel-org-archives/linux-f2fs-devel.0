From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: clean up argument of recover_data
Date: Tue, 01 Dec 2015 11:43:59 +0800
Message-ID: <000301d12bea$a508bd10$ef1a3730$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In recover_data, value of argument 'type' will be CURSEG_WARM_NODE all
the time, remove it for cleanup.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/recovery.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index cbf74f4..3ab9b92 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -459,8 +459,7 @@ out:
 	return err;
 }
 
-static int recover_data(struct f2fs_sb_info *sbi,
-				struct list_head *head, int type)
+static int recover_data(struct f2fs_sb_info *sbi, struct list_head *head)
 {
 	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
@@ -469,7 +468,7 @@ static int recover_data(struct f2fs_sb_info *sbi,
 	block_t blkaddr;
 
 	/* get node pages in the current segment */
-	curseg = CURSEG_I(sbi, type);
+	curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	while (1) {
@@ -556,7 +555,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
 	need_writecp = true;
 
 	/* step #2: recover data */
-	err = recover_data(sbi, &inode_list, CURSEG_WARM_NODE);
+	err = recover_data(sbi, &inode_list);
 	if (!err)
 		f2fs_bug_on(sbi, !list_empty(&inode_list));
 out:
-- 
2.6.3
