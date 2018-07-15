From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid potential deadlock in f2fs_sbi_store
Date: Sun, 15 Jul 2018 10:10:17 +0900
Message-ID: <20180715011017.11237-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1feVYT-0003Xm-Ti
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 01:10:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1feVYQ-000SxR-99
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 01:10:29 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

[  155.018460] ======================================================
[  155.021431] WARNING: possible circular locking dependency detected
[  155.024339] 4.18.0-rc3+ #5 Tainted: G           OE
[  155.026879] ------------------------------------------------------
[  155.029783] umount/2901 is trying to acquire lock:
[  155.032187] 00000000c4282f1f (kn->count#130){++++}, at: kernfs_remove+0x1f/0x30
[  155.035439]
[  155.035439] but task is already holding lock:
[  155.038892] 0000000056e4307b (&type->s_umount_key#41){++++}, at: deactivate_super+0x33/0x50
[  155.042602]
[  155.042602] which lock already depends on the new lock.
[  155.042602]
[  155.047465]
[  155.047465] the existing dependency chain (in reverse order) is:
[  155.051354]
[  155.051354] -> #1 (&type->s_umount_key#41){++++}:
[  155.054768]        f2fs_sbi_store+0x61/0x460 [f2fs]
[  155.057083]        kernfs_fop_write+0x113/0x1a0
[  155.059277]        __vfs_write+0x36/0x180
[  155.061250]        vfs_write+0xbe/0x1b0
[  155.063179]        ksys_write+0x55/0xc0
[  155.065068]        do_syscall_64+0x60/0x1b0
[  155.067071]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  155.069529]
[  155.069529] -> #0 (kn->count#130){++++}:
[  155.072421]        __kernfs_remove+0x26f/0x2e0
[  155.074452]        kernfs_remove+0x1f/0x30
[  155.076342]        kobject_del.part.5+0xe/0x40
[  155.078354]        f2fs_put_super+0x12d/0x290 [f2fs]
[  155.080500]        generic_shutdown_super+0x6c/0x110
[  155.082655]        kill_block_super+0x21/0x50
[  155.084634]        kill_f2fs_super+0x9c/0xc0 [f2fs]
[  155.086726]        deactivate_locked_super+0x3f/0x70
[  155.088826]        cleanup_mnt+0x3b/0x70
[  155.090584]        task_work_run+0x93/0xc0
[  155.092367]        exit_to_usermode_loop+0xf0/0x100
[  155.094466]        do_syscall_64+0x162/0x1b0
[  155.096312]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  155.098603]
[  155.098603] other info that might help us debug this:
[  155.098603]
[  155.102418]  Possible unsafe locking scenario:
[  155.102418]
[  155.105134]        CPU0                    CPU1
[  155.107037]        ----                    ----
[  155.108910]   lock(&type->s_umount_key#41);
[  155.110674]                                lock(kn->count#130);
[  155.113010]                                lock(&type->s_umount_key#41);
[  155.115608]   lock(kn->count#130);

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5344e21853b2..bca1236fd6fa 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -287,8 +287,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
 
-	if (gc_entry)
-		down_read(&sbi->sb->s_umount);
+	if (gc_entry) {
+		if (!down_read_trylock(&sbi->sb->s_umount))
+			return -EAGAIN;
+	}
 	ret = __sbi_store(a, sbi, buf, count);
 	if (gc_entry)
 		up_read(&sbi->sb->s_umount);
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
