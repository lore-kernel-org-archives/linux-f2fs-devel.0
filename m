From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/4] f2fs: introduce __{find,grab}_extent_tree
Date: Thu, 19 Mar 2015 19:24:59 +0800
Message-ID: <000101d06237$702d3a80$5087af80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YYYaH-0005At-7v
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Mar 2015 11:25:53 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YYYaE-0004IL-VO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Mar 2015 11:25:53 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NLG0067VIEUVA70@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Mar 2015 20:25:43 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces __{find,grab}_extent_tree for reusing by following
patches.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 79 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index edeba35..a73df90 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -393,6 +393,49 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 		et->cached_en = NULL;
 }
 
+static struct extent_tree *__find_extent_tree(struct f2fs_sb_info *sbi,
+							nid_t ino)
+{
+	struct extent_tree *et;
+
+	down_read(&sbi->extent_tree_lock);
+	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
+	if (!et) {
+		up_read(&sbi->extent_tree_lock);
+		return NULL;
+	}
+	atomic_inc(&et->refcount);
+	up_read(&sbi->extent_tree_lock);
+
+	return et;
+}
+
+static struct extent_tree *__grab_extent_tree(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et;
+	nid_t ino = inode->i_ino;
+
+	down_write(&sbi->extent_tree_lock);
+	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
+	if (!et) {
+		et = f2fs_kmem_cache_alloc(extent_tree_slab, GFP_NOFS);
+		f2fs_radix_tree_insert(&sbi->extent_tree_root, ino, et);
+		memset(et, 0, sizeof(struct extent_tree));
+		et->ino = ino;
+		et->root = RB_ROOT;
+		et->cached_en = NULL;
+		rwlock_init(&et->lock);
+		atomic_set(&et->refcount, 0);
+		et->count = 0;
+		sbi->total_ext_tree++;
+	}
+	atomic_inc(&et->refcount);
+	up_write(&sbi->extent_tree_lock);
+
+	return et;
+}
+
 static struct extent_node *__lookup_extent_tree(struct extent_tree *et,
 							unsigned int fofs)
 {
@@ -537,14 +580,9 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 
 	trace_f2fs_lookup_extent_tree_start(inode, pgofs);
 
-	down_read(&sbi->extent_tree_lock);
-	et = radix_tree_lookup(&sbi->extent_tree_root, inode->i_ino);
-	if (!et) {
-		up_read(&sbi->extent_tree_lock);
+	et = __find_extent_tree(sbi, inode->i_ino);
+	if (!et)
 		return false;
-	}
-	atomic_inc(&et->refcount);
-	up_read(&sbi->extent_tree_lock);
 
 	read_lock(&et->lock);
 	en = __lookup_extent_tree(et, pgofs);
@@ -569,7 +607,6 @@ static void f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 							block_t blkaddr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	nid_t ino = inode->i_ino;
 	struct extent_tree *et;
 	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 = NULL;
 	struct extent_node *den = NULL;
@@ -578,22 +615,7 @@ static void f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 
 	trace_f2fs_update_extent_tree(inode, fofs, blkaddr);
 
-	down_write(&sbi->extent_tree_lock);
-	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
-	if (!et) {
-		et = f2fs_kmem_cache_alloc(extent_tree_slab, GFP_NOFS);
-		f2fs_radix_tree_insert(&sbi->extent_tree_root, ino, et);
-		memset(et, 0, sizeof(struct extent_tree));
-		et->ino = ino;
-		et->root = RB_ROOT;
-		et->cached_en = NULL;
-		rwlock_init(&et->lock);
-		atomic_set(&et->refcount, 0);
-		et->count = 0;
-		sbi->total_ext_tree++;
-	}
-	atomic_inc(&et->refcount);
-	up_write(&sbi->extent_tree_lock);
+	et = __grab_extent_tree(inode);
 
 	write_lock(&et->lock);
 
@@ -731,14 +753,9 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 	if (!test_opt(sbi, EXTENT_CACHE))
 		return;
 
-	down_read(&sbi->extent_tree_lock);
-	et = radix_tree_lookup(&sbi->extent_tree_root, inode->i_ino);
-	if (!et) {
-		up_read(&sbi->extent_tree_lock);
+	et = __find_extent_tree(sbi, inode->i_ino);
+	if (!et)
 		goto out;
-	}
-	atomic_inc(&et->refcount);
-	up_read(&sbi->extent_tree_lock);
 
 	/* free all extent info belong to this extent tree */
 	write_lock(&et->lock);
-- 
2.3.1



------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
