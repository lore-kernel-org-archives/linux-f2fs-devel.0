From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix to do build_stat prior to the recovery
	procedure
Date: Wed, 19 Feb 2014 18:29:23 +0900
Message-ID: <1392802163-25825-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WG3Uo-0008Ij-18
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Feb 2014 09:31:14 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WG3Uk-0004aq-J1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Feb 2014 09:31:13 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N1800BV9L3LE670@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Feb 2014 18:30:57 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

At the end of the recovery procedure, write_checkpoint is called and updates
the cp count which is managed by f2fs stat.
But, previously build_stat() is called after the recovery procedure, which
results in:

BUG: unable to handle kernel NULL pointer dereference at 000000000000012c
IP: [<ffffffffa03b1030>] write_checkpoint+0x720/0xbc0 [f2fs]
Call Trace:
 [<ffffffff810a6b44>] ? mark_held_locks+0x74/0x140
 [<ffffffff8109a3e0>] ? __init_waitqueue_head+0x60/0x60
 [<ffffffffa03bf036>] recover_fsync_data+0x656/0xf20 [f2fs]
 [<ffffffff812ee3eb>] ? security_d_instantiate+0x1b/0x30
 [<ffffffffa03aeb4d>] f2fs_fill_super+0x94d/0xa00 [f2fs]
 [<ffffffff811a9825>] mount_bdev+0x1a5/0x1f0
 [<ffffffff8114915e>] ? __get_free_pages+0xe/0x40
 [<ffffffffa03ae200>] ? f2fs_remount+0x130/0x130 [f2fs]
 [<ffffffffa03aa575>] f2fs_mount+0x15/0x20 [f2fs]
 [<ffffffff811aa713>] mount_fs+0x43/0x1b0
 [<ffffffff811c7124>] vfs_kern_mount+0x74/0x160
 [<ffffffff811c5cb1>] ? __get_fs_type+0x51/0x60
 [<ffffffff811c9727>] do_mount+0x237/0xb50
 [<ffffffff811c936a>] ? copy_mount_options+0x3a/0x170

So, this patche changes the order of recovery_fsync_data() and
f2fs_build_stats().

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/super.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1a85f83..475560e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -989,28 +989,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_root_inode;
 	}
 
-	/* recover fsynced data */
-	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
-		err = recover_fsync_data(sbi);
-		if (err)
-			f2fs_msg(sb, KERN_ERR,
-				"Cannot recover all fsync data errno=%ld", err);
-	}
-
-	/*
-	 * If filesystem is not mounted as read-only then
-	 * do start the gc_thread.
-	 */
-	if (!(sb->s_flags & MS_RDONLY)) {
-		/* After POR, we can run background GC thread.*/
-		err = start_gc_thread(sbi);
-		if (err)
-			goto free_gc;
-	}
-
 	err = f2fs_build_stats(sbi);
 	if (err)
-		goto free_gc;
+		goto free_root_inode;
 
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
@@ -1032,17 +1013,36 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
 							"%s", sb->s_id);
 	if (err)
-		goto fail;
+		goto free_proc;
 
+	/* recover fsynced data */
+	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
+		err = recover_fsync_data(sbi);
+		if (err)
+			f2fs_msg(sb, KERN_ERR,
+				"Cannot recover all fsync data errno=%ld", err);
+	}
+
+	/*
+	 * If filesystem is not mounted as read-only then
+	 * do start the gc_thread.
+	 */
+	if (!(sb->s_flags & MS_RDONLY)) {
+		/* After POR, we can run background GC thread.*/
+		err = start_gc_thread(sbi);
+		if (err)
+			goto free_kobj;
+	}
 	return 0;
-fail:
+
+free_kobj:
+	kobject_del(&sbi->s_kobj);
+free_proc:
 	if (sbi->s_proc) {
 		remove_proc_entry("segment_info", sbi->s_proc);
 		remove_proc_entry(sb->s_id, f2fs_proc_root);
 	}
 	f2fs_destroy_stats(sbi);
-free_gc:
-	stop_gc_thread(sbi);
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
