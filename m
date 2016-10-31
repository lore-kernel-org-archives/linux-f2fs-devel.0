From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid infinite loop in the EIO case on
	recover_orphan_inodes
Date: Mon, 31 Oct 2016 16:30:27 -0700
Message-ID: <20161031233027.25783-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c1M2H-0007Ry-QE
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 31 Oct 2016 23:30:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c1M2G-0005M0-0j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 31 Oct 2016 23:30:37 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch should fix an infinite loop case below.

F2FS-fs : inject IO error in f2fs_read_end_io+0xf3/0x120 [f2fs]
F2FS-fs (nvme0n1p1): recover_orphan_inode: orphan failed (ino=39ac1a), run fsck to fix.
...
[<ffffffffc0b11ede>] sync_meta_pages+0xae/0x270 [f2fs]
[<ffffffffc0b288dd>] ? flush_sit_entries+0x8d/0x960 [f2fs]
[<ffffffffc0b13801>] write_checkpoint+0x361/0xf20 [f2fs]
[<ffffffffb40e979d>] ? trace_hardirqs_on+0xd/0x10
[<ffffffffc0b0a199>] ? f2fs_sync_fs+0x79/0x190 [f2fs]
[<ffffffffc0b0a1a5>] f2fs_sync_fs+0x85/0x190 [f2fs]
[<ffffffffc0b2560e>] f2fs_balance_fs_bg+0x7e/0x1c0 [f2fs]
[<ffffffffc0b216c4>] f2fs_write_node_pages+0x34/0x320 [f2fs]
[<ffffffffb41dff21>] do_writepages+0x21/0x30
[<ffffffffb429edb1>] __writeback_single_inode+0x61/0x760
[<ffffffffb490a937>] ? _raw_spin_unlock+0x27/0x40
[<ffffffffb42a0805>] writeback_single_inode+0xd5/0x190
[<ffffffffb42a0959>] write_inode_now+0x99/0xc0
[<ffffffffb4289a16>] iput+0x1f6/0x2c0
[<ffffffffc0b0e3be>] f2fs_fill_super+0xe0e/0x1300 [f2fs]
[<ffffffffb426c394>] ? sget_userns+0x4f4/0x530
[<ffffffffb426c692>] mount_bdev+0x182/0x1b0
[<ffffffffc0b0d5b0>] ? f2fs_commit_super+0x100/0x100 [f2fs]
[<ffffffffc0b0a375>] f2fs_mount+0x15/0x20 [f2fs]
[<ffffffffb426d038>] mount_fs+0x38/0x170
[<ffffffffb428ec9b>] vfs_kern_mount+0x6b/0x160
[<ffffffffb4291d9e>] do_mount+0x1be/0xd60
[<ffffffffb4291a57>] ? copy_mount_options+0xb7/0x220
[<ffffffffb4292c54>] SyS_mount+0x94/0xd0
[<ffffffffb490b345>] entry_SYSCALL_64_fastpath+0x23/0xc6

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9749758..72603f1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1889,6 +1889,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_lock(&sbi->umount_mutex);
 	release_ino_entry(sbi, true);
 	f2fs_leave_shrinker(sbi);
+	/*
+	 * Some dirty meta pages can be produced by recover_orphan_inodes()
+	 * failed by EIO. Then, iput(node_inode) can trigger balance_fs_bg()
+	 * followed by write_checkpoint() through f2fs_write_node_pages(), which
+	 * falls into an infinite loop in sync_meta_pages().
+	 */
+	truncate_inode_pages_final(META_MAPPING(sbi));
 	iput(sbi->node_inode);
 	mutex_unlock(&sbi->umount_mutex);
 free_nm:
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
