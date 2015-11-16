From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix memory leak of kobject in error path of fill_super
Date: Mon, 16 Nov 2015 20:38:25 +0800
Message-ID: <008c01d1206b$c9cf4a90$5d6ddfb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_sb_info::s_kobj should be released in error path of fill_super,
otherwise it will lead to memory leak.

This bug was found by kmemleak:

dmesg:
kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8800838dc358 (size 8):
  comm "mount", pid 4154, jiffies 4297482839 (age 1911.412s)
  hex dump (first 8 bytes):
    7a 72 61 6d 31 00 ff ff                          zram1...
  backtrace:
    [<ffffffff817a3668>] kmemleak_alloc+0x28/0x50
    [<ffffffff811dc99f>] __kmalloc_track_caller+0xef/0x1c0
    [<ffffffff8119d1c5>] kstrdup+0x45/0x80
    [<ffffffff8119d228>] kstrdup_const+0x28/0x30
    [<ffffffff813d2333>] kvasprintf_const+0x63/0xa0
    [<ffffffff813c59fc>] kobject_set_name_vargs+0x3c/0xa0
    [<ffffffff813c5a85>] kobject_add_varg+0x25/0x60
    [<ffffffff813c5b13>] kobject_init_and_add+0x53/0x70
    [<ffffffffa07ced19>] f2fs_fill_super+0x9d9/0xc40 [f2fs]
    [<ffffffff811ff0b2>] mount_bdev+0x192/0x1d0
    [<ffffffffa07cd3e5>] f2fs_mount+0x15/0x20 [f2fs]
    [<ffffffff811fec93>] mount_fs+0x43/0x170
    [<ffffffff81220256>] vfs_kern_mount+0x76/0x160
    [<ffffffff812211c8>] do_mount+0x258/0xdc0
    [<ffffffff81221dab>] SyS_mount+0x7b/0xc0
    [<ffffffff817aecd7>] entry_SYSCALL_64_fastpath+0x12/0x6f
...

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9d0ea11..f394d20 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1362,6 +1362,8 @@ try_onemore:
 
 free_kobj:
 	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
 free_proc:
 	if (sbi->s_proc) {
 		remove_proc_entry("segment_info", sbi->s_proc);
-- 
2.6.3
