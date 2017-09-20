From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Wed, 20 Sep 2017 10:38:31 -0700
Message-ID: <20170920173831.GA7151@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170913200941.39420-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces UMOUNT_WAIT flag for umount(2) which let user wait for
umount(2) to complete filesystem shutdown. This should fix a kernel panic
triggered when a living filesystem tries to access dead block device after
device_shutdown done by kernel_restart as below.

Term: namespace(mnt_get_count())

1. create_new_namespaces() creates ns1 and ns2,

  /data(1)    ns1(1)    ns2(1)
    |          |          |
     ---------------------
               |
        sb->s_active = 3

2. after binder_proc_clear_zombies() for ns2 and ns1 triggers
  - delayed_fput()
    - delayed_mntput_work(ns2)

  /data(1)    ns1(1)
    |          |
     ----------
          |
    sb->s_active = 2

3. umount() for /data is successed.

  ns1(1)
    |
 sb->s_active = 1

4. device_shutdown() by init

5.  - delayed_mntput_work(ns1)
     - put_super(), since sb->s_active = 0
       - -EIO

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/namespace.c     | 12 +++++++++++-
 include/linux/fs.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f8893dc6a989..f2c15c4f6e23 100644
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
@@ -1653,11 +1655,19 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
 	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
 		goto dput_and_out;
 
+	/* flush delayed_fput to put mnt_count */
+	if (flags & UMOUNT_WAIT)
+		flush_delayed_fput();
+
 	retval = do_umount(mnt, flags);
 dput_and_out:
 	/* we mustn't call path_put() as that would clear mnt_expiry_mark */
 	dput(path.dentry);
 	mntput_no_expire(mnt);
+
+	/* flush delayed_mntput_work to put sb->s_active */
+	if (!retval && (flags & UMOUNT_WAIT))
+		flush_scheduled_work();
 out:
 	return retval;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6e1fd5d21248..69f0fd53c9c7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1278,6 +1278,7 @@ struct mm_struct;
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 #define MNT_EXPIRE	0x00000004	/* Mark for expiry */
 #define UMOUNT_NOFOLLOW	0x00000008	/* Don't follow symlink on umount */
+#define UMOUNT_WAIT	0x00000010	/* Wait to unmount completely */
 #define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
 
 /* sb->s_iflags */
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
