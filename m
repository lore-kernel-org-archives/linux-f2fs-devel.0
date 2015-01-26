From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH v2 05/10] f2fs: introduce infra macro and data
 structure of rb-tree extent cache
Date: Mon, 26 Jan 2015 13:49:46 +0800
Message-ID: <006101d0392c$06879f00$1396dd00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Introduce infra macro and data structure for rb-tree based extent cache:

Macros:
 * EXT_TREE_VEC_SIZE: indicate vector size for gang lookup in extent tree.
 * F2FS_MIN_EXTENT_LEN: indicate minimum length of extent managed in cache.
 * EXTENT_CACHE_SHRINK_NUMBER: indicate number of extent in cache will be shrunk.

Basic data structures for extent cache:
 * struct extent_tree: extent tree entry per inode.
 * struct extent_node: extent info node linked in extent tree.

Besides, adding new extent cache related fields in f2fs_sb_info.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/f2fs.h | 36 ++++++++++++++++++++++++++++++++----
 fs/f2fs/node.h |  1 +
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8e1d78d..63edc22 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -267,13 +267,33 @@ enum {
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
 
+/* vector size for gang look-up from extent cache that consists of radix tree */
+#define EXT_TREE_VEC_SIZE	64
+
 /* for in-memory extent cache entry */
-#define F2FS_MIN_EXTENT_LEN	16	/* minimum extent length */
+#define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
+
+/* number of extent info in extent cache we try to shrink */
+#define EXTENT_CACHE_SHRINK_NUMBER	128
 
 struct extent_info {
-	unsigned int fofs;	/* start offset in a file */
-	u32 blk;		/* start block address of the extent */
-	unsigned int len;	/* length of the extent */
+	unsigned int fofs;		/* start offset in a file */
+	u32 blk;			/* start block address of the extent */
+	unsigned int len;		/* length of the extent */
+};
+
+struct extent_node {
+	struct rb_node rb_node;		/* rb node located in rb-tree */
+	struct list_head list;		/* node in global extent list of sbi */
+	struct extent_info ei;		/* extent info */
+};
+
+struct extent_tree {
+	nid_t ino;			/* inode number */
+	struct rb_root root;		/* root of extent info rb-tree */
+	rwlock_t lock;			/* protect extent info rb-tree */
+	atomic_t refcount;		/* reference count of rb-tree */
+	unsigned int count;		/* # of extent node in rb-tree*/
 };
 
 /*
@@ -553,6 +573,14 @@ struct f2fs_sb_info {
 	struct list_head dir_inode_list;	/* dir inode list */
 	spinlock_t dir_inode_lock;		/* for dir inode list lock */
 
+	/* for extent tree cache */
+	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
+	struct rw_semaphore extent_tree_lock;	/* locking extent radix tree */
+	struct list_head extent_list;		/* lru list for shrinker */
+	spinlock_t extent_lock;			/* locking extent lru list */
+	int total_ext_tree;			/* extent tree count */
+	atomic_t total_ext_node;		/* extent info count */
+
 	/* basic filesystem units */
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
 	unsigned int log_blocksize;		/* log2 block size */
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index f405bbf..c56026f 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -120,6 +120,7 @@ enum mem_type {
 	NAT_ENTRIES,	/* indicates the cached nat entry */
 	DIRTY_DENTS,	/* indicates dirty dentry pages */
 	INO_ENTRIES,	/* indicates inode entries */
+	EXTENT_CACHE,	/* indicates extent cache */
 	BASE_CHECK,	/* check kernel status */
 };
 
-- 
2.2.1
