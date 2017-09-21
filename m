From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Wed, 20 Sep 2017 17:34:09 -0700
Message-ID: <20170921003409.GA11365@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170920173831.GA7151@jaegeuk-macbookpro.roam.corp.google.com>
 <20170920183825.GD32076@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170920183825.GD32076@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/20, Al Viro wrote:
> On Wed, Sep 20, 2017 at 10:38:31AM -0700, Jaegeuk Kim wrote:
> > This patch introduces UMOUNT_WAIT flag for umount(2) which let user wait for
> > umount(2) to complete filesystem shutdown. This should fix a kernel panic
> > triggered when a living filesystem tries to access dead block device after
> > device_shutdown done by kernel_restart as below.
> 
> NAK.  This is just papering over the race you've got; it does not fix it.
> You count upon the kernel threads in question having already gotten past
> scheduling delayed fput, but what's there to guarantee that?  You are
> essentially adding a "flush all pending fput that had already been
> scheduled" syscall.  It
> 	a) doesn't belong in umount(2) and
> 	b) doesn't fix the race.
>
> It might change the timing enough to have your specific reproducer survive,
> but that kind of approach is simply wrong.
> Incidentally, the name is a misnomer - it does *NOT* wait for completion of
> fs shutdown.  Proof: have a filesystem mounted in two namespaces and issue
> that thing in one of them.  Then observe how it's still alive, well and
> accessible in another.

Yes, I wrote the description incorrectly. Let me try describing UMOUNT_WAIT
which waits for any pending delayed works only like what you said. In normal
cases where other namespace is still active, this doesn't work at all.

> The only case that gets affected by it is when another mount is heading for
> shutdown and is in a very specific part of that.  That is waited for.
> If it's just before *OR* just past that stage, you are fucked.
> 
> And yes, "just past" is also affected.  Look:
> CPU1: delayed_fput()
>         struct llist_node *node = llist_del_all(&delayed_fput_list);
> delayed_fput_list() is empty now
>         llist_for_each_entry_safe(f, t, node, f_u.fu_llist)
>                 __fput(f);
> CPU2: your umount UMOUNT_WAIT
> 	flush_delayed_fput()
> 		does nothing, the list is empty

		how about waiting for workqueue completion here?

> 	....

	If all the __fput()s are not finished, do_umount() will return -EBUSY.

> 	flush_scheduled_work()
> 		waits for delayed_fput() to finish
> CPU1:
> 	finish __fput()
> 	call mntput() from it
> 	schedule_delayed_work(&delayed_mntput_work, 1);
> CPU2:
> 	OK, everything scheduled prior to call of flush_scheduled_work() is completed,
> we are done.
> 	return from umount(2)
> 	(in bogus userland code) tell it to shut devices down
> ...
> oops, that delayed_mntput_work we'd scheduled there got to run.  Too bad...

Is this doable?

---
 fs/file_table.c      |  6 ++++++
 fs/namespace.c       | 26 +++++++++++++++++++++++++-
 include/linux/file.h |  1 +
 include/linux/fs.h   |  1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 72e861a35a7f..35b32ffdb934 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -263,6 +263,12 @@ void flush_delayed_fput(void)
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
+void flush_delayed_fput_wait(void)
+{
+	delayed_fput(NULL);
+	flush_delayed_work(&delayed_fput_work);
+}
+
 void fput(struct file *file)
 {
 	if (atomic_long_dec_and_test(&file->f_count)) {
diff --git a/fs/namespace.c b/fs/namespace.c
index f8893dc6a989..e2586a38c83c 100644
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
@@ -1133,6 +1134,12 @@ static void delayed_mntput(struct work_struct *unused)
 }
 static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
+void flush_delayed_mntput_wait(void)
+{
+	delayed_mntput(NULL);
+	flush_delayed_work(&delayed_mntput_work);
+}
+
 static void mntput_no_expire(struct mount *mnt)
 {
 	rcu_read_lock();
@@ -1629,7 +1636,8 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
 	int retval;
 	int lookup_flags = 0;
 
-	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
+	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW |
+			UMOUNT_WAIT))
 		return -EINVAL;
 
 	if (!may_mount())
@@ -1653,11 +1661,27 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
 	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
 		goto dput_and_out;
 
+	/* flush delayed_fput to put mnt_count */
+	if (flags & UMOUNT_WAIT)
+		flush_delayed_fput_wait();
+
 	retval = do_umount(mnt, flags);
 dput_and_out:
 	/* we mustn't call path_put() as that would clear mnt_expiry_mark */
 	dput(path.dentry);
 	mntput_no_expire(mnt);
+
+	if (!retval && (flags & UMOUNT_WAIT)) {
+		/*
+		 * If the last delayed_fput() is called during do_umount()
+		 * and makes mnt_count zero, we need to guarantee to register
+		 * delayed_mntput by waiting for delayed_fput work again.
+		 */
+		flush_delayed_fput_wait();
+
+		/* flush delayed_mntput_work to put sb->s_active */
+		flush_delayed_mntput_wait();
+	}
 out:
 	return retval;
 }
diff --git a/include/linux/file.h b/include/linux/file.h
index 61eb82cbafba..ffb4236cde39 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -84,6 +84,7 @@ extern void put_unused_fd(unsigned int fd);
 extern void fd_install(unsigned int fd, struct file *file);
 
 extern void flush_delayed_fput(void);
+extern void flush_delayed_fput_wait(void);
 extern void __fput_sync(struct file *);
 
 #endif /* __LINUX_FILE_H */
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
