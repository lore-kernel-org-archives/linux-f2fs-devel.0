From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] vfs: introduce UMOUNT_WAIT which waits for umount completion
Date: Wed, 13 Sep 2017 13:09:41 -0700
Message-ID: <20170913200941.39420-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces UMOUNT_WAIT flag for umount(2) which let user wait for
its completion. This would fix a kernel panic caused by block device access by
filesystem, after device_shutdown during kernel_restart. This can happen due
to delayed umount -- reboot process already succeeded to unmount filesystem,
but its instance is sitll alive.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/namespace.c     | 12 +++++++++++-
 include/linux/fs.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f8893dc6a989..b1ac89915b10 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -21,6 +21,7 @@
 #include <linux/fs_struct.h>	/* get_fs_root et.al. */
 #include <linux/fsnotify.h>	/* fsnotify_vfsmount_delete */
 #include <linux/uaccess.h>
+#include <linux/file.h>
 #include <linux/proc_ns.h>
 #include <linux/magic.h>
 #include <linux/bootmem.h>
@@ -1629,7 +1630,8 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
 	int retval;
 	int lookup_flags = 0;
 
-	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
+	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW |
+			UMOUNT_WAIT))
 		return -EINVAL;
 
 	if (!may_mount())
@@ -1652,12 +1654,20 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
 	retval = -EPERM;
 	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
 		goto dput_and_out;
+	if (flags & UMOUNT_WAIT)
+		flush_delayed_fput();
 
 	retval = do_umount(mnt, flags);
 dput_and_out:
 	/* we mustn't call path_put() as that would clear mnt_expiry_mark */
 	dput(path.dentry);
 	mntput_no_expire(mnt);
+	if (!retval && (flags & UMOUNT_WAIT)) {
+		if (likely(!(current->flags & PF_KTHREAD)))
+			task_work_run();
+		else
+			flush_scheduled_work();
+	}
 out:
 	return retval;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 83341a6a553e..cb62af7a03e7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1283,6 +1283,7 @@ struct mm_struct;
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 #define MNT_EXPIRE	0x00000004	/* Mark for expiry */
 #define UMOUNT_NOFOLLOW	0x00000008	/* Don't follow symlink on umount */
+#define UMOUNT_WAIT	0x00000010	/* Wait to unmount completely */
 #define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
 
 /* sb->s_iflags */
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
