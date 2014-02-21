From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] f2fs: introduce help macro
	on_build_free_nids()
Date: Fri, 21 Feb 2014 18:08:29 +0800
Message-ID: <5307259D.7050208@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WGnAJ-0001yE-Uo
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Feb 2014 10:17:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGnAH-0001Ga-Ro for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Feb 2014 10:17:07 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Introduce help macro on_build_free_nids() which just uses build_lock
to judge whether the building free nid is going, so that we can remove
the on_build_free_nids field from f2fs_sb_info.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h |    2 --
 fs/f2fs/node.c |    6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 91f4c5e..8cc7166 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -48,7 +48,6 @@
 #define ver_after(a, b)	(typecheck(unsigned long long, a) &&		\
 		typecheck(unsigned long long, b) &&			\
 		((long long)((a) - (b)) > 0))
-
 typedef u32 block_t;	/*
 			 * should not change u32, since it is the on-disk block
 			 * address format, __le32.
@@ -417,7 +416,6 @@ struct f2fs_sb_info {
 	struct mutex node_write;		/* locking node writes */
 	struct mutex writepages;		/* mutex for writepages() */
 	bool por_doing;				/* recovery is doing or not */
-	bool on_build_free_nids;		/* build_free_nids is doing */
 	wait_queue_head_t cp_wait;
 
 	/* for orphan inode management */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d452185..8c5981e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -21,6 +21,8 @@
 #include "segment.h"
 #include <trace/events/f2fs.h>
 
+#define on_build_free_nids(nmi) mutex_is_locked(&nm_i->build_lock)
+
 static struct kmem_cache *nat_entry_slab;
 static struct kmem_cache *free_nid_slab;
 
@@ -1426,7 +1428,7 @@ retry:
 	spin_lock(&nm_i->free_nid_list_lock);
 
 	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->fcnt && !sbi->on_build_free_nids) {
+	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
 		f2fs_bug_on(list_empty(&nm_i->free_nid_list));
 		list_for_each(this, &nm_i->free_nid_list) {
 			i = list_entry(this, struct free_nid, list);
@@ -1445,9 +1447,7 @@ retry:
 
 	/* Let's scan nat pages and its caches to get free nids */
 	mutex_lock(&nm_i->build_lock);
-	sbi->on_build_free_nids = true;
 	build_free_nids(sbi);
-	sbi->on_build_free_nids = false;
 	mutex_unlock(&nm_i->build_lock);
 	goto retry;
 }
-- 
1.7.7


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
