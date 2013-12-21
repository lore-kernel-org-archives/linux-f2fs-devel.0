From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH 2/3] f2fs: update several comments
Date: Sat, 21 Dec 2013 18:02:14 +0800
Message-ID: <000101cefe33$c7e0aaa0$57a1ffe0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Update several comments:
1. use f2fs_{un}lock_op install of mutex_{un}lock_op.
2. update comment of get_data_block().
3. update description of node offset.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c |   14 ++++++++------
 fs/f2fs/dir.c  |    4 ++--
 fs/f2fs/f2fs.h |    2 +-
 fs/f2fs/node.c |    8 ++++----
 fs/f2fs/node.h |    8 +++++++-
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a0950bc..bdc6093 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -516,8 +516,8 @@ repeat:
  * Caller ensures that this data page is never allocated.
  * A new zero-filled data page is allocated in the page cache.
  *
- * Also, caller should grab and release a mutex by calling mutex_lock_op() and
- * mutex_unlock_op().
+ * Also, caller should grab and release a rwsem by calling f2fs_lock_op() and
+ * f2fs_unlock_op().
  * Note that, npage is set only by make_empty_dir.
  */
 struct page *get_new_data_page(struct inode *inode,
@@ -603,10 +603,12 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 }
 
 /*
- * This function should be used by the data read flow only where it
- * does not check the "create" flag that indicates block allocation.
- * The reason for this special functionality is to exploit VFS readahead
- * mechanism.
+ * get_data_block() now supported readahead/bmap/rw direct_IO with mapped bh.
+ * If original data blocks are allocated, then give them to blockdev.
+ * Otherwise,
+ *     a. preallocate requested block addresses
+ *     b. do not use extent cache for better performance
+ *     c. give the block addresses to blockdev
  */
 static int get_data_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3f3b661..9781400 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -429,8 +429,8 @@ next:
 }
 
 /*
- * Caller should grab and release a mutex by calling mutex_lock_op() and
- * mutex_unlock_op().
+ * Caller should grab and release a rwsem by calling f2fs_lock_op() and
+ * f2fs_unlock_op().
  */
 int __f2fs_add_link(struct inode *dir, const struct qstr *name, struct inode *inode)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8cbc5a6..97080f1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -165,7 +165,7 @@ enum {
 	LOOKUP_NODE,			/* look up a node without readahead */
 	LOOKUP_NODE_RA,			/*
 					 * look up a node with readahead called
-					 * by get_datablock_ro.
+					 * by get_data_block.
 					 */
 };
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3565caf..768bd96 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -394,8 +394,8 @@ got:
 
 /*
  * Caller should call f2fs_put_dnode(dn).
- * Also, it should grab and release a mutex by calling mutex_lock_op() and
- * mutex_unlock_op() only if ro is not set RDONLY_NODE.
+ * Also, it should grab and release a rwsem by calling f2fs_lock_op() and
+ * f2fs_unlock_op() only if ro is not set RDONLY_NODE.
  * In the case of RDONLY_NODE, we don't need to care about mutex.
  */
 int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
@@ -803,8 +803,8 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
 }
 
 /*
- * Caller should grab and release a mutex by calling mutex_lock_op() and
- * mutex_unlock_op().
+ * Caller should grab and release a rwsem by calling f2fs_lock_op() and
+ * f2fs_unlock_op().
  */
 void remove_inode_page(struct inode *inode)
 {
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 3496bb3..c4c7988 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -224,7 +224,13 @@ static inline block_t next_blkaddr_of_node(struct page *node_page)
  *    |            `- direct node (5 + N => 5 + 2N - 1)
  *    `- double indirect node (5 + 2N)
  *                 `- indirect node (6 + 2N)
- *                       `- direct node (x(N + 1))
+ *                       `- direct node
+ *                 ......
+ *                 `- indirect node ((6 + 2N) + x(N + 1))
+ *                       `- direct node
+ *                 ......
+ *                 `- indirect node ((6 + 2N) + (N - 1)(N + 1))
+ *                       `- direct node
  */
 static inline bool IS_DNODE(struct page *node_page)
 {
-- 
1.7.9.5

