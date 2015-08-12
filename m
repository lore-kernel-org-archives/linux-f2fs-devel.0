From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: do not write any node pages related
 to orphan inodes
Date: Wed, 12 Aug 2015 10:10:41 -0700
Message-ID: <20150812171041.GA27478@jaegeuk-mac02.mot.com>
References: <1439330562-17646-1-git-send-email-jaegeuk@kernel.org>
 <00b901d0d4e3$b9a4e2c0$2ceea840$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00b901d0d4e3$b9a4e2c0$2ceea840$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Chang log from v1:
 - remove inappropriate remained flag ops suggested by Chao

Thanks,

>From 8ab2c8bacedb74d35dfe481d43a8fb1291650c39 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 11 Aug 2015 12:45:39 -0700
Subject: [PATCH] f2fs: do not write any node pages related to orphan inodes

We should not write node pages when deleting orphan inodes.
In order to do that, we can eaisly set POR_DOING flag earlier before entering
orphan inode routine.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 4 ----
 fs/f2fs/recovery.c   | 4 +---
 fs/f2fs/super.c      | 6 +++++-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0958c83..890e4d4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -497,8 +497,6 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
-	set_sbi_flag(sbi, SBI_POR_DOING);
-
 	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
 	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
 
@@ -514,7 +512,6 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 			err = recover_orphan_inode(sbi, ino);
 			if (err) {
 				f2fs_put_page(page, 1);
-				clear_sbi_flag(sbi, SBI_POR_DOING);
 				return err;
 			}
 		}
@@ -522,7 +519,6 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	}
 	/* clear Orphan Flag */
 	clear_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG);
-	clear_sbi_flag(sbi, SBI_POR_DOING);
 	return 0;
 }
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d2ef0c9..faec2ca 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -545,14 +545,12 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&inode_list);
 
-	/* step #1: find fsynced inode numbers */
-	set_sbi_flag(sbi, SBI_POR_DOING);
-
 	/* prevent checkpoint */
 	mutex_lock(&sbi->cp_mutex);
 
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
+	/* step #1: find fsynced inode numbers */
 	err = find_fsync_dnodes(sbi, &inode_list);
 	if (err)
 		goto out;
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

