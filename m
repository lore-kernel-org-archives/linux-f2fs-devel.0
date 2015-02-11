From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: fix sparse warnings
Date: Tue, 10 Feb 2015 17:25:21 -0800
Message-ID: <1423617922-87948-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch resolves the following warnings.

include/trace/events/f2fs.h:150:1: warning: expression using sizeof bool
include/trace/events/f2fs.h:180:1: warning: expression using sizeof bool
include/trace/events/f2fs.h:990:1: warning: expression using sizeof bool
include/trace/events/f2fs.h:990:1: warning: expression using sizeof bool
include/trace/events/f2fs.h:150:1: warning: odd constant _Bool cast (ffffffffffffffff becomes 1)
include/trace/events/f2fs.h:180:1: warning: odd constant _Bool cast (ffffffffffffffff becomes 1)
include/trace/events/f2fs.h:990:1: warning: odd constant _Bool cast (ffffffffffffffff becomes 1)
include/trace/events/f2fs.h:990:1: warning: odd constant _Bool cast (ffffffffffffffff becomes 1)

fs/f2fs/checkpoint.c:27:19: warning: symbol 'inode_entry_slab' was not declared. Should it be static?
fs/f2fs/checkpoint.c:577:15: warning: cast to restricted __le32
fs/f2fs/checkpoint.c:592:15: warning: cast to restricted __le32

fs/f2fs/trace.c:19:1: warning: symbol 'pids' was not declared. Should it be static?
fs/f2fs/trace.c:21:21: warning: symbol 'last_io' was not declared. Should it be static?

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c        |  4 ++--
 fs/f2fs/f2fs.h              |  1 +
 fs/f2fs/gc.h                |  2 --
 fs/f2fs/trace.c             |  4 ++--
 include/trace/events/f2fs.h | 13 +++++++------
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 58d88df..7f794b7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -574,7 +574,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	if (crc_offset >= blk_size)
 		goto invalid_cp1;
 
-	crc = le32_to_cpu(*((__u32 *)((unsigned char *)cp_block + crc_offset)));
+	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
 	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
 		goto invalid_cp1;
 
@@ -589,7 +589,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	if (crc_offset >= blk_size)
 		goto invalid_cp2;
 
-	crc = le32_to_cpu(*((__u32 *)((unsigned char *)cp_block + crc_offset)));
+	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
 	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
 		goto invalid_cp2;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 337204d..7fa3313 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1681,6 +1681,7 @@ extern const struct address_space_operations f2fs_meta_aops;
 extern const struct inode_operations f2fs_dir_inode_operations;
 extern const struct inode_operations f2fs_symlink_inode_operations;
 extern const struct inode_operations f2fs_special_inode_operations;
+extern struct kmem_cache *inode_entry_slab;
 
 /*
  * inline.c
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index d5ff97c..b4a65be 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -40,8 +40,6 @@ struct gc_inode_list {
 	struct radix_tree_root iroot;
 };
 
-extern struct kmem_cache *inode_entry_slab;
-
 /*
  * inline functions
  */
diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index ce01a2c..875aa81 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -16,9 +16,9 @@
 #include "f2fs.h"
 #include "trace.h"
 
-RADIX_TREE(pids, GFP_ATOMIC);
+static RADIX_TREE(pids, GFP_ATOMIC);
 static spinlock_t pids_lock;
-struct last_io_info last_io;
+static struct last_io_info last_io;
 
 static inline void __print_last_io(void)
 {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 6962982..5422dbf 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -149,14 +149,14 @@ DEFINE_EVENT(f2fs__inode, f2fs_sync_file_enter,
 
 TRACE_EVENT(f2fs_sync_file_exit,
 
-	TP_PROTO(struct inode *inode, bool need_cp, int datasync, int ret),
+	TP_PROTO(struct inode *inode, int need_cp, int datasync, int ret),
 
 	TP_ARGS(inode, need_cp, datasync, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(bool,	need_cp)
+		__field(int,	need_cp)
 		__field(int,	datasync)
 		__field(int,	ret)
 	),
@@ -185,7 +185,7 @@ TRACE_EVENT(f2fs_sync_fs,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(bool,	dirty)
+		__field(int,	dirty)
 		__field(int,	wait)
 	),
 
@@ -989,14 +989,15 @@ TRACE_EVENT(f2fs_issue_discard,
 
 TRACE_EVENT(f2fs_issue_flush,
 
-	TP_PROTO(struct super_block *sb, bool nobarrier, bool flush_merge),
+	TP_PROTO(struct super_block *sb, unsigned int nobarrier,
+					unsigned int flush_merge),
 
 	TP_ARGS(sb, nobarrier, flush_merge),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(bool, nobarrier)
-		__field(bool, flush_merge)
+		__field(unsigned int, nobarrier)
+		__field(unsigned int, flush_merge)
 	),
 
 	TP_fast_assign(
-- 
2.1.1
