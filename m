From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: measure inode.i_blocks as generic filesystem
Date: Wed, 14 Jun 2017 23:00:56 +0800
Message-ID: <20170614150056.29733-2-chao@kernel.org>
References: <20170614150056.29733-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614150056.29733-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Both in memory or on disk, generic filesystems record i_blocks with
512bytes sized sector count, also VFS sub module such as disk quota
follows this rule, but f2fs records it with 4096bytes sized block
count, this difference leads to that once we use dquota's function
which inc/dec iblocks, it will make i_blocks of f2fs being inconsistent
between in memory and on disk.

In order to resolve this issue, this patch changes to make in-memory
i_blocks of f2fs recording sector count instead of block count,
meanwhile leaving on-disk i_blocks recording block count.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 23 +++++++++++++----------
 fs/f2fs/file.c  |  1 -
 fs/f2fs/inode.c |  5 +++--
 fs/f2fs/node.c  |  2 +-
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dd5449423fd2..91db1d07f9f8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1352,10 +1352,10 @@ static inline int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
  */
 static inline int F2FS_HAS_BLOCKS(struct inode *inode)
 {
-	if (F2FS_I(inode)->i_xattr_nid)
-		return inode->i_blocks > F2FS_DEFAULT_ALLOCATED_BLOCKS + 1;
-	else
-		return inode->i_blocks > F2FS_DEFAULT_ALLOCATED_BLOCKS;
+	block_t xattr_block = F2FS_I(inode)->i_xattr_nid ? 1 : 0;
+
+	return (inode->i_blocks >> F2FS_LOG_SECTORS_PER_BLOCK) >
+			(F2FS_DEFAULT_ALLOCATED_BLOCKS + xattr_block);
 }
 
 static inline bool f2fs_has_xattr_block(unsigned int ofs)
@@ -1363,7 +1363,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
-static inline void f2fs_i_blocks_write(struct inode *, blkcnt_t, bool);
+static inline void f2fs_i_blocks_write(struct inode *, block_t, bool);
 static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
 {
@@ -1401,11 +1401,13 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,
-						blkcnt_t count)
+						block_t count)
 {
+	blkcnt_t sectors = count << F2FS_LOG_SECTORS_PER_BLOCK;
+
 	spin_lock(&sbi->stat_lock);
 	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
-	f2fs_bug_on(sbi, inode->i_blocks < count);
+	f2fs_bug_on(sbi, inode->i_blocks < sectors);
 	sbi->total_valid_block_count -= (block_t)count;
 	spin_unlock(&sbi->stat_lock);
 	f2fs_i_blocks_write(inode, count, false);
@@ -1856,13 +1858,14 @@ static inline void f2fs_i_links_write(struct inode *inode, bool inc)
 }
 
 static inline void f2fs_i_blocks_write(struct inode *inode,
-					blkcnt_t diff, bool add)
+					block_t diff, bool add)
 {
 	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
 	bool recover = is_inode_flag_set(inode, FI_AUTO_RECOVER);
+	blkcnt_t sectors = diff << F2FS_LOG_SECTORS_PER_BLOCK;
 
-	inode->i_blocks = add ? inode->i_blocks + diff :
-				inode->i_blocks - diff;
+	inode->i_blocks = add ? inode->i_blocks + sectors :
+				inode->i_blocks - sectors;
 	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac8b943817e6..4f4def5010c0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -665,7 +665,6 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(inode, stat);
-	stat->blocks <<= 3;
 	return 0;
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 868d71436ebc..1ff5bd418d87 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -16,6 +16,7 @@
 
 #include "f2fs.h"
 #include "node.h"
+#include "segment.h"
 
 #include <trace/events/f2fs.h>
 
@@ -129,7 +130,7 @@ static int do_read_inode(struct inode *inode)
 	i_gid_write(inode, le32_to_cpu(ri->i_gid));
 	set_nlink(inode, le32_to_cpu(ri->i_links));
 	inode->i_size = le64_to_cpu(ri->i_size);
-	inode->i_blocks = le64_to_cpu(ri->i_blocks);
+	inode->i_blocks = SECTOR_FROM_BLOCK(le64_to_cpu(ri->i_blocks));
 
 	inode->i_atime.tv_sec = le64_to_cpu(ri->i_atime);
 	inode->i_ctime.tv_sec = le64_to_cpu(ri->i_ctime);
@@ -267,7 +268,7 @@ int update_inode(struct inode *inode, struct page *node_page)
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
 	ri->i_size = cpu_to_le64(i_size_read(inode));
-	ri->i_blocks = cpu_to_le64(inode->i_blocks);
+	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks));
 
 	if (et) {
 		read_lock(&et->lock);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f522378224aa..f6f46be139f4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1011,7 +1011,7 @@ int remove_inode_page(struct inode *inode)
 
 	/* 0 is possible, after f2fs_new_inode() has failed */
 	f2fs_bug_on(F2FS_I_SB(inode),
-			inode->i_blocks != 0 && inode->i_blocks != 1);
+			inode->i_blocks != 0 && inode->i_blocks != 8);
 
 	/* will put inode & node pages */
 	truncate_node(&dn);
-- 
2.13.0.90.g1eb437020
