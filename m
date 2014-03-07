From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 5/5] f2fs: add a wait queue to avoid unnecessary,
	build_free_nid
Date: Fri, 07 Mar 2014 18:43:39 +0800
Message-ID: <5319A2DB.8040705@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WLsOA-00030l-6S
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 10:52:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLsO9-0006r8-7f for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 10:52:26 +0000
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Previously, when we try to alloc free nid while the build free nid
is going, the allocer will be run into the flow that waiting for
"nm_i->build_lock", see following:
	/* We should not use stale free nids created by build_free_nids */
---->	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
		f2fs_bug_on(list_empty(&nm_i->free_nid_list));
		list_for_each(this, &nm_i->free_nid_list) {
			i = list_entry(this, struct free_nid, list);
			if (i->state == NID_NEW)
				break;
		}

		f2fs_bug_on(i->state != NID_NEW);
		*nid = i->nid;
		i->state = NID_ALLOC;
		nm_i->fcnt--;
		spin_unlock(&nm_i->free_nid_list_lock);
		return true;
	}
	spin_unlock(&nm_i->free_nid_list_lock);

	/* Let's scan nat pages and its caches to get free nids */
---->	mutex_lock(&nm_i->build_lock);
	build_free_nids(sbi);
	mutex_unlock(&nm_i->build_lock);
and this will cause another unnecessary building free nid if the current
building free nid job is done.
So here we introduce a wait_queue to avoid this issue.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h |    1 +
 fs/f2fs/node.c |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f845e92..7ae193e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -256,6 +256,7 @@ struct f2fs_nm_info {
 	spinlock_t free_nid_list_lock;	/* protect free nid list */
 	unsigned int fcnt;		/* the number of free node id */
 	struct mutex build_lock;	/* lock for build free nids */
+	wait_queue_head_t build_wq;	/* wait queue for build free nids */
 
 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4b7861d..ab44711 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1422,7 +1422,13 @@ retry:
 	spin_lock(&nm_i->free_nid_list_lock);
 
 	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
+	if (on_build_free_nids(nm_i)) {
+		spin_unlock(&nm_i->free_nid_list_lock);
+		wait_event(nm_i->build_wq, !on_build_free_nids(nm_i));
+		goto retry;
+	}
+
+	if (nm_i->fcnt) {
 		f2fs_bug_on(list_empty(&nm_i->free_nid_list));
 		list_for_each(this, &nm_i->free_nid_list) {
 			i = list_entry(this, struct free_nid, list);
@@ -1443,6 +1449,7 @@ retry:
 	mutex_lock(&nm_i->build_lock);
 	build_free_nids(sbi);
 	mutex_unlock(&nm_i->build_lock);
+	wake_up_all(&nm_i->build_wq);
 	goto retry;
 }
 
@@ -1813,6 +1820,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&nm_i->dirty_nat_entries);
 
 	mutex_init(&nm_i->build_lock);
+	init_waitqueue_head(&nm_i->build_wq);
 	spin_lock_init(&nm_i->free_nid_list_lock);
 	rwlock_init(&nm_i->nat_tree_lock);
 
-- 
1.7.7



------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
