From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce __check_rb_tree_consistence
Date: Mon, 17 Apr 2017 18:21:43 +0800
Message-ID: <20170417102143.120176-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d03nU-00016f-U2
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Apr 2017 10:22:16 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d03nQ-0006VB-Pg
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Apr 2017 10:22:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce __check_rb_tree_consistence to check consistence of rb-tree
based discard cache in runtime.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/extent_cache.c | 32 ++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h         |  2 ++
 fs/f2fs/segment.c      | 15 +++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 221ad086ee00..2f98d7039701 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -159,6 +159,38 @@ struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
 	return re;
 }
 
+bool __check_rb_tree_consistence(struct f2fs_sb_info *sbi,
+						struct rb_root *root)
+{
+#ifdef CONFIG_F2FS_CHECK_FS
+	struct rb_node *cur = rb_first(root), *next;
+	struct rb_entry *cur_re, *next_re;
+
+	if (!cur)
+		return true;
+
+	while (cur) {
+		next = rb_next(cur);
+		if (!next)
+			return true;
+
+		cur_re = rb_entry(cur, struct rb_entry, rb_node);
+		next_re = rb_entry(next, struct rb_entry, rb_node);
+
+		if (cur_re->ofs + cur_re->len > next_re->ofs) {
+			f2fs_msg(sbi->sb, KERN_INFO, "inconsistent rbtree, "
+				"cur(%u, %u) next(%u, %u)",
+				cur_re->ofs, cur_re->len,
+				next_re->ofs, next_re->len);
+			return false;
+		}
+
+		cur = next;
+	}
+#endif
+	return true;
+}
+
 static struct kmem_cache *extent_tree_slab;
 static struct kmem_cache *extent_node_slab;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bd3519059ae8..62fcb52be0ba 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2622,6 +2622,8 @@ struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
 		struct rb_entry **prev_entry, struct rb_entry **next_entry,
 		struct rb_node ***insert_p, struct rb_node **insert_parent,
 		bool force);
+bool __check_rb_tree_consistence(struct f2fs_sb_info *sbi,
+						struct rb_root *root);
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
 bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
 void f2fs_drop_extent_tree(struct inode *inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 08b9e3806a50..4be74c99643d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -833,6 +833,7 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 	if (blkaddr > di.lstart) {
 		dc->len = blkaddr - dc->lstart;
 		__relocate_discard_cmd(dcc, dc);
+		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
 		modified = true;
 	}
 
@@ -842,11 +843,15 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 					di.start + blkaddr + 1 - di.lstart,
 					di.lstart + di.len - 1 - blkaddr,
 					NULL, NULL);
+			f2fs_bug_on(sbi,
+				!__check_rb_tree_consistence(sbi, &dcc->root));
 		} else {
 			dc->lstart++;
 			dc->len--;
 			dc->start++;
 			__relocate_discard_cmd(dcc, dc);
+			f2fs_bug_on(sbi,
+				!__check_rb_tree_consistence(sbi, &dcc->root));
 		}
 	}
 }
@@ -906,6 +911,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 			__is_discard_back_mergeable(&di, &prev_dc->di)) {
 			prev_dc->di.len += di.len;
 			__relocate_discard_cmd(dcc, prev_dc);
+			f2fs_bug_on(sbi,
+				!__check_rb_tree_consistence(sbi, &dcc->root));
 			di = prev_dc->di;
 			tdc = prev_dc;
 			merged = true;
@@ -920,13 +927,17 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 			__relocate_discard_cmd(dcc, next_dc);
 			if (tdc)
 				__remove_discard_cmd(sbi, tdc);
-
+			f2fs_bug_on(sbi,
+				!__check_rb_tree_consistence(sbi, &dcc->root));
 			merged = true;
 		}
 
-		if (!merged)
+		if (!merged) {
 			__insert_discard_tree(sbi, bdev, di.lstart, di.start,
 							di.len, NULL, NULL);
+			f2fs_bug_on(sbi,
+				!__check_rb_tree_consistence(sbi, &dcc->root));
+		}
  next:
 		prev_dc = next_dc;
 		if (!prev_dc)
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
