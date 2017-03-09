From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/4 v2] f2fs: build stat_info before orphan inode recovery
Date: Thu, 9 Mar 2017 15:21:45 -0800
Message-ID: <20170309232145.GD4125@jaegeuk.local>
References: <20170307221303.6757-1-jaegeuk@kernel.org>
 <20170307221303.6757-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170307221303.6757-2-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o move its location up more

>From e993253fef6c4a07a65e6038c2c0cae684844047 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 7 Mar 2017 13:41:22 -0800
Subject: [PATCH] f2fs: build stat_info before orphan inode recovery

f2fs_sync_fs() -> write_checkpoint() calls stat_inc_cp_count(sbi->stat_info),
which needs stat_info allocation.
Otherwise, we can hit:

[254042.598623]  ? count_shadow_nodes+0xa0/0xa0
[254042.598633]  f2fs_sync_fs+0x65/0xd0 [f2fs]
[254042.598645]  f2fs_balance_fs_bg+0xe4/0x1c0 [f2fs]
[254042.598657]  f2fs_write_node_pages+0x34/0x1a0 [f2fs]
[254042.598664]  ? pagevec_lookup_entries+0x1e/0x30
[254042.598673]  do_writepages+0x1e/0x30
[254042.598682]  __writeback_single_inode+0x45/0x330
[254042.598688]  writeback_single_inode+0xd7/0x190
[254042.598694]  write_inode_now+0x86/0xa0
[254042.598699]  iput+0x122/0x200
[254042.598709]  f2fs_fill_super+0xd4a/0x14d0 [f2fs]
[254042.598717]  mount_bdev+0x184/0x1c0
[254042.598934]  ? f2fs_commit_super+0x100/0x100 [f2fs]
[254042.599142]  f2fs_mount+0x15/0x20 [f2fs]
[254042.599349]  mount_fs+0x39/0x160
[254042.599554]  ? __alloc_percpu+0x15/0x20
[254042.599759]  vfs_kern_mount+0x67/0x110
[254042.599972]  do_mount+0x1bb/0xc80
[254042.600175]  ? memdup_user+0x42/0x60
[254042.600380]  SyS_mount+0x83/0xd0
[254042.600583]  entry_SYSCALL_64_fastpath+0x1e/0xad

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 96fe8ed73100..939cb7bfa7bc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -789,9 +789,6 @@ static void f2fs_put_super(struct super_block *sb)
 	/* be sure to wait for any on-going discard commands */
 	f2fs_wait_discard_bio(sbi, NULL_ADDR);
 
-	/* write_checkpoint can update stat informaion */
-	f2fs_destroy_stats(sbi);
-
 	/*
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
@@ -811,6 +808,9 @@ static void f2fs_put_super(struct super_block *sb)
 	destroy_node_manager(sbi);
 	destroy_segment_manager(sbi);
 
+	/* write_checkpoint can update stat informaion */
+	f2fs_destroy_stats(sbi);
+
 	kfree(sbi->ckpt);
 	kobject_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
@@ -1985,6 +1985,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	init_ino_entry_info(sbi);
 
+	err = f2fs_build_stats(sbi);
+	if (err)
+		goto free_devices;
+
 	/* setup f2fs internal modules */
 	err = build_segment_manager(sbi);
 	if (err) {
@@ -2046,10 +2050,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_root_inode;
 	}
 
-	err = f2fs_build_stats(sbi);
-	if (err)
-		goto free_root_inode;
-
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
 
@@ -2143,7 +2143,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		remove_proc_entry("segment_bits", sbi->s_proc);
 		remove_proc_entry(sb->s_id, f2fs_proc_root);
 	}
-	f2fs_destroy_stats(sbi);
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
@@ -2165,6 +2164,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	destroy_node_manager(sbi);
 free_sm:
 	destroy_segment_manager(sbi);
+	f2fs_destroy_stats(sbi);
 free_devices:
 	destroy_device_list(sbi);
 	kfree(sbi->ckpt);
-- 
2.11.0
