From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: handle errors during
	recover_orphan_inodes
Date: Wed, 21 Sep 2016 20:54:58 -0700
Message-ID: <20160922035458.5002-4-jaegeuk@kernel.org>
References: <20160922035458.5002-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bmv72-0007od-MO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 03:55:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bmv71-0004e6-NW
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 03:55:52 +0000
In-Reply-To: <20160922035458.5002-1-jaegeuk@kernel.org>
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

This patch fixes to handle EIO during recover_orphan_inode() given the below
panic.

F2FS-fs : inject IO error in f2fs_read_end_io+0xe6/0x100 [f2fs]
------------[ cut here ]------------
RIP: 0010:[<ffffffffc0b244e3>]  [<ffffffffc0b244e3>] f2fs_evict_inode+0x433/0x470 [f2fs]
RSP: 0018:ffff92f8b7fb7c30  EFLAGS: 00010246
RAX: ffff92fb88a13500 RBX: ffff92f890566ea0 RCX: 00000000fd3c255c
RDX: 0000000000000001 RSI: ffff92fb88a13d90 RDI: ffff92fb8ee127e8
RBP: ffff92f8b7fb7c58 R08: 0000000000000001 R09: ffff92fb88a13d58
R10: 000000005a6a9373 R11: 0000000000000001 R12: 00000000fffffffb
R13: ffff92fb8ee12000 R14: 00000000000034ca R15: ffff92fb8ee12620
FS:  00007f1fefd8e880(0000) GS:ffff92fb95600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc211d34cdb CR3: 000000012d43a000 CR4: 00000000001406e0
Stack:
 ffff92f890566ea0 ffff92f890567078 ffffffffc0b5a0c0 ffff92f890566f28
 ffff92fb888b2000 ffff92f8b7fb7c80 ffffffffbc27ff55 ffff92f890566ea0
 ffff92fb8bf10000 ffffffffc0b5a0c0 ffff92f8b7fb7cb0 ffffffffbc28090d
Call Trace:
 [<ffffffffbc27ff55>] evict+0xc5/0x1a0
 [<ffffffffbc28090d>] iput+0x1ad/0x2c0
 [<ffffffffc0b3304c>] recover_orphan_inodes+0x10c/0x2e0 [f2fs]
 [<ffffffffc0b2e0f4>] f2fs_fill_super+0x884/0x1150 [f2fs]
 [<ffffffffbc2644ac>] mount_bdev+0x18c/0x1c0
 [<ffffffffc0b2d870>] ? f2fs_commit_super+0x100/0x100 [f2fs]
 [<ffffffffc0b2a755>] f2fs_mount+0x15/0x20 [f2fs]
 [<ffffffffbc264e49>] mount_fs+0x39/0x170
 [<ffffffffbc28555b>] vfs_kern_mount+0x6b/0x160
 [<ffffffffbc2881df>] do_mount+0x1cf/0xd00
 [<ffffffffbc287f2c>] ? copy_mount_options+0xac/0x170
 [<ffffffffbc289003>] SyS_mount+0x83/0xd0
 [<ffffffffbc8ee880>] entry_SYSCALL_64_fastpath+0x23/0xc1

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 27 +++++++++++++++++----------
 fs/f2fs/super.c      |  1 +
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index cd9fd7b..d1560bb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -535,6 +535,17 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct inode *inode;
 	struct node_info ni;
+	int err = acquire_orphan_inode(sbi);
+
+	if (err) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_msg(sbi->sb, KERN_WARNING,
+				"%s: orphan failed (ino=%x), run fsck to fix.",
+				__func__, ino);
+		return err;
+	}
+
+	__add_ino_entry(sbi, ino, ORPHAN_INO);
 
 	inode = f2fs_iget_retry(sbi->sb, ino);
 	if (IS_ERR(inode)) {
@@ -555,17 +566,13 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 
 	/* ENOMEM was fully retried in f2fs_evict_inode. */
 	if (ni.blk_addr != NULL_ADDR) {
-		int err = acquire_orphan_inode(sbi);
-
-		if (err) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_msg(sbi->sb, KERN_WARNING,
-				"%s: orphan failed (ino=%x), run fsck to fix.",
-					__func__, ino);
-			return err;
-		}
-		__add_ino_entry(sbi, ino, ORPHAN_INO);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"%s: orphan failed (ino=%x), run fsck to fix.",
+				__func__, ino);
+		return -EIO;
 	}
+	__remove_ino_entry(sbi, ino, ORPHAN_INO);
 	return 0;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 95986a9..e7bb153 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1893,6 +1893,7 @@ free_root_inode:
 	sb->s_root = NULL;
 free_node_inode:
 	mutex_lock(&sbi->umount_mutex);
+	release_ino_entry(sbi, true);
 	f2fs_leave_shrinker(sbi);
 	iput(sbi->node_inode);
 	mutex_unlock(&sbi->umount_mutex);
-- 
2.8.3


------------------------------------------------------------------------------
