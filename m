From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH] posix_acl: convert posix_acl.a_refcount from atomic_t to refcount_t
Date: Wed, 29 Nov 2017 13:19:31 +0200
Message-ID: <1511954371-15420-1-git-send-email-elena.reshetova@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, peterz@infradead.org, keescook@chromium.org, Elena Reshetova <elena.reshetova@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

atomic_t variables are currently used to implement reference
counters with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. This is important since overflows and underflows
can lead to use-after-free situation and be exploitable.

The variable posix_acl.a_refcount is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in lib/refcount.c
have different memory ordering guarantees than their atomic
counterparts.
The full comparison can be seen in
https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
in state to be merged to the documentation tree.
Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in
some rare cases it might matter.
Please double check that you don't have some undocumented
memory guarantees for this variable usage.

For the posix_acl.a_refcount it might make a difference
in following places:
 - get_cached_acl(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart. However this operation is performed under
   rcu_read_lock(), so this should be fine.
 - posix_acl_release(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and control dependency on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 fs/f2fs/acl.c             | 2 +-
 fs/posix_acl.c            | 6 +++---
 include/linux/posix_acl.h | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 2bb7c9f..1118241 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -270,7 +270,7 @@ static struct posix_acl *f2fs_acl_clone(const struct posix_acl *acl,
 				sizeof(struct posix_acl_entry);
 		clone = kmemdup(acl, size, flags);
 		if (clone)
-			atomic_set(&clone->a_refcount, 1);
+			refcount_set(&clone->a_refcount, 1);
 	}
 	return clone;
 }
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index eebf5f6..2fd0fde 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -43,7 +43,7 @@ struct posix_acl *get_cached_acl(struct inode *inode, int type)
 		rcu_read_lock();
 		acl = rcu_dereference(*p);
 		if (!acl || is_uncached_acl(acl) ||
-		    atomic_inc_not_zero(&acl->a_refcount))
+		    refcount_inc_not_zero(&acl->a_refcount))
 			break;
 		rcu_read_unlock();
 		cpu_relax();
@@ -164,7 +164,7 @@ EXPORT_SYMBOL(get_acl);
 void
 posix_acl_init(struct posix_acl *acl, int count)
 {
-	atomic_set(&acl->a_refcount, 1);
+	refcount_set(&acl->a_refcount, 1);
 	acl->a_count = count;
 }
 EXPORT_SYMBOL(posix_acl_init);
@@ -197,7 +197,7 @@ posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
 		           sizeof(struct posix_acl_entry);
 		clone = kmemdup(acl, size, flags);
 		if (clone)
-			atomic_set(&clone->a_refcount, 1);
+			refcount_set(&clone->a_refcount, 1);
 	}
 	return clone;
 }
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index b2b7255..540595a 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -12,6 +12,7 @@
 #include <linux/bug.h>
 #include <linux/slab.h>
 #include <linux/rcupdate.h>
+#include <linux/refcount.h>
 #include <uapi/linux/posix_acl.h>
 
 struct posix_acl_entry {
@@ -24,7 +25,7 @@ struct posix_acl_entry {
 };
 
 struct posix_acl {
-	atomic_t		a_refcount;
+	refcount_t		a_refcount;
 	struct rcu_head		a_rcu;
 	unsigned int		a_count;
 	struct posix_acl_entry	a_entries[0];
@@ -41,7 +42,7 @@ static inline struct posix_acl *
 posix_acl_dup(struct posix_acl *acl)
 {
 	if (acl)
-		atomic_inc(&acl->a_refcount);
+		refcount_inc(&acl->a_refcount);
 	return acl;
 }
 
@@ -51,7 +52,7 @@ posix_acl_dup(struct posix_acl *acl)
 static inline void
 posix_acl_release(struct posix_acl *acl)
 {
-	if (acl && atomic_dec_and_test(&acl->a_refcount))
+	if (acl && refcount_dec_and_test(&acl->a_refcount))
 		kfree_rcu(acl, a_rcu);
 }
 
-- 
2.7.4
