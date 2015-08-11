From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not write any node pages related to orphan inodes
Date: Tue, 11 Aug 2015 15:02:42 -0700
Message-ID: <1439330562-17646-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should not write node pages when deleting orphan inodes.
In order to do that, we can eaisly set POR_DOING flag earlier before entering
orphan inode routine.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 3 ---
 fs/f2fs/super.c    | 6 +++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d2ef0c9..cdcca7c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -545,9 +545,6 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&inode_list);
 
-	/* step #1: find fsynced inode numbers */
-	set_sbi_flag(sbi, SBI_POR_DOING);
-
 	/* prevent checkpoint */
 	mutex_lock(&sbi->cp_mutex);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4db5cd9..cfe3f95 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1165,7 +1165,9 @@ try_onemore:
 	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
 	init_rwsem(&sbi->node_write);
-	clear_sbi_flag(sbi, SBI_POR_DOING);
+
+	/* disallow all the data/node/meta page writes */
+	set_sbi_flag(sbi, SBI_POR_DOING);
 	spin_lock_init(&sbi->stat_lock);
 
 	init_rwsem(&sbi->read_io.io_rwsem);
@@ -1309,6 +1311,8 @@ try_onemore:
 			goto free_kobj;
 		}
 	}
+	/* recover_fsync_data() cleared this already */
+	clear_sbi_flag(sbi, SBI_POR_DOING);
 
 	/*
 	 * If filesystem is not mounted as read-only then
-- 
2.1.1

