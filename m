From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: order free nid allocator
Date: Sat, 30 Sep 2017 17:37:40 +0800
Message-ID: <20170930093740.16087-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dyEDq-0004B7-8v
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Sep 2017 09:38:10 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dyEDo-0002sH-9v
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Sep 2017 09:38:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, there is no restrict order among free nid allocators, if
there are no free nids being cached in memory, previous allocator will
try to load them by scanning NAT pages, but after that, these newly
loaded free nids could be grabbed by later allocators, result in long
delay of previous allocator during nid allocation.

This patch tries to refactor alloc_nid flow to serialize allocators.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix deadlock due to incorrectly using of down_trylock.
 fs/f2fs/f2fs.h |  3 ++-
 fs/f2fs/node.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c07690ce9a46..97ac7e6ab14b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -722,7 +722,8 @@ struct f2fs_nm_info {
 	struct list_head free_nid_list;		/* list for free nids excluding preallocated nids */
 	unsigned int nid_cnt[MAX_NID_STATE];	/* the number of free node id */
 	spinlock_t nid_list_lock;	/* protect nid lists ops */
-	struct mutex build_lock;	/* lock for build free nids */
+	struct semaphore build_lock;	/* lock for build free nids */
+	atomic_t allocator;		/* # of free nid allocators */
 	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
 	unsigned char *nat_block_bitmap;
 	unsigned short *free_nid_count;	/* free nid count of NAT block */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b95b2784e7d8..f6464b1faf03 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2041,9 +2041,9 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 
 void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 {
-	mutex_lock(&NM_I(sbi)->build_lock);
+	down(&NM_I(sbi)->build_lock);
 	__build_free_nids(sbi, sync, mount);
-	mutex_unlock(&NM_I(sbi)->build_lock);
+	up(&NM_I(sbi)->build_lock);
 }
 
 /*
@@ -2055,22 +2055,30 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
+	bool alloc_failed = false, lock_build = false, ret = false;
+
+	spin_lock(&nm_i->nid_list_lock);
 retry:
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
 		f2fs_show_injection_info(FAULT_ALLOC_NID);
-		return false;
+		goto out;
 	}
 #endif
-	spin_lock(&nm_i->nid_list_lock);
 
-	if (unlikely(nm_i->available_nids == 0)) {
-		spin_unlock(&nm_i->nid_list_lock);
-		return false;
-	}
+	if (unlikely(nm_i->available_nids == 0))
+		goto out;
 
 	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->nid_cnt[FREE_NID] && !on_build_free_nids(nm_i)) {
+	if (nm_i->nid_cnt[FREE_NID] >= atomic_read(&nm_i->allocator) +
+						(alloc_failed ? 0 : 1)) {
+		if (!lock_build) {
+			if (!down_trylock(&nm_i->build_lock))
+				lock_build = true;
+			else
+				goto build;
+		}
+
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
 		i = list_first_entry(&nm_i->free_nid_list,
 					struct free_nid, list);
@@ -2083,14 +2091,38 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 
 		update_free_nid_bitmap(sbi, *nid, false, false);
 
-		spin_unlock(&nm_i->nid_list_lock);
-		return true;
+		ret = true;
+		goto out;
+	}
+build:
+	if (!alloc_failed) {
+		alloc_failed = true;
+		atomic_inc(&nm_i->allocator);
 	}
 	spin_unlock(&nm_i->nid_list_lock);
 
+	if (lock_build) {
+		lock_build = false;
+		up(&nm_i->build_lock);
+	}
+
 	/* Let's scan nat pages and its caches to get free nids */
-	build_free_nids(sbi, true, false);
+	down(&nm_i->build_lock);
+	lock_build = true;
+
+	if (nm_i->nid_cnt[FREE_NID] < atomic_read(&nm_i->allocator))
+		__build_free_nids(sbi, true, false);
+
+	spin_lock(&nm_i->nid_list_lock);
 	goto retry;
+
+out:
+	if (alloc_failed)
+		atomic_dec(&nm_i->allocator);
+	spin_unlock(&nm_i->nid_list_lock);
+	if (lock_build)
+		up(&nm_i->build_lock);
+	return ret;
 }
 
 /*
@@ -2154,7 +2186,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
 		return 0;
 
-	if (!mutex_trylock(&nm_i->build_lock))
+	if (down_trylock(&nm_i->build_lock))
 		return 0;
 
 	spin_lock(&nm_i->nid_list_lock);
@@ -2168,7 +2200,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 		nr_shrink--;
 	}
 	spin_unlock(&nm_i->nid_list_lock);
-	mutex_unlock(&nm_i->build_lock);
+	up(&nm_i->build_lock);
 
 	return nr - nr_shrink;
 }
@@ -2654,7 +2686,8 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	INIT_RADIX_TREE(&nm_i->nat_set_root, GFP_NOIO);
 	INIT_LIST_HEAD(&nm_i->nat_entries);
 
-	mutex_init(&nm_i->build_lock);
+	sema_init(&nm_i->build_lock, 1);
+	atomic_set(&nm_i->allocator, 0);
 	spin_lock_init(&nm_i->nid_list_lock);
 	init_rwsem(&nm_i->nat_tree_lock);
 
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
