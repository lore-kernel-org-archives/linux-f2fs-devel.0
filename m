From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: shrink unreferenced extent_caches first
Date: Tue, 30 Jun 2015 18:25:46 -0700
Message-ID: <1435713946-6910-2-git-send-email-jaegeuk@kernel.org>
References: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZA6mm-0006DD-0V
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 01:26:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZA6ml-0003PK-8m for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 01:25:59 +0000
In-Reply-To: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org>
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

If an extent_tree entry has a zero reference count, we can drop it from the
cache in higher priority rather than currently referencing entries.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f059e0..a0a0e2b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -661,21 +661,54 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct radix_tree_root *root = &sbi->extent_tree_root;
 	unsigned int found;
 	unsigned int node_cnt = 0, tree_cnt = 0;
+	int remained;
 
 	if (!test_opt(sbi, EXTENT_CACHE))
 		return 0;
 
+	if (!down_write_trylock(&sbi->extent_tree_lock))
+		goto out;
+
+	/* 1. remove unreferenced extent tree */
+	while ((found = radix_tree_gang_lookup(root,
+				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
+		unsigned i;
+
+		ino = treevec[found - 1]->ino + 1;
+		for (i = 0; i < found; i++) {
+			struct extent_tree *et = treevec[i];
+
+			if (!atomic_read(&et->refcount)) {
+				write_lock(&et->lock);
+				node_cnt += __free_extent_tree(sbi, et, true);
+				write_unlock(&et->lock);
+
+				radix_tree_delete(root, et->ino);
+				kmem_cache_free(extent_tree_slab, et);
+				sbi->total_ext_tree--;
+				tree_cnt++;
+
+				if (node_cnt + tree_cnt >= nr_shrink)
+					goto unlock_out;
+			}
+		}
+	}
+	up_write(&sbi->extent_tree_lock);
+
+	/* 2. remove LRU extent entries */
+	if (!down_write_trylock(&sbi->extent_tree_lock))
+		goto out;
+
+	remained = nr_shrink - (node_cnt + tree_cnt);
+
 	spin_lock(&sbi->extent_lock);
 	list_for_each_entry_safe(en, tmp, &sbi->extent_list, list) {
-		if (!nr_shrink--)
+		if (!remained--)
 			break;
 		list_del_init(&en->list);
 	}
 	spin_unlock(&sbi->extent_lock);
 
-	if (!down_write_trylock(&sbi->extent_tree_lock))
-		goto out;
-
 	while ((found = radix_tree_gang_lookup(root,
 				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
 		unsigned i;
@@ -687,14 +720,12 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 			write_lock(&et->lock);
 			node_cnt += __free_extent_tree(sbi, et, false);
 			write_unlock(&et->lock);
-			if (!atomic_read(&et->refcount) && !et->count) {
-				radix_tree_delete(root, et->ino);
-				kmem_cache_free(extent_tree_slab, et);
-				sbi->total_ext_tree--;
-				tree_cnt++;
-			}
+
+			if (node_cnt + tree_cnt >= nr_shrink)
+				break;
 		}
 	}
+unlock_out:
 	up_write(&sbi->extent_tree_lock);
 out:
 	trace_f2fs_shrink_extent_tree(sbi, node_cnt, tree_cnt);
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
