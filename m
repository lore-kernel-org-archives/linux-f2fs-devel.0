From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: indicate shutdown f2fs to allow unmount successfully
Date: Sun, 15 Jul 2018 10:11:12 +0900
Message-ID: <20180715011112.11475-3-jaegeuk@kernel.org>
References: <20180715011112.11475-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180715011112.11475-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Once we shutdown f2fs, we have to flush stale pages in order to unmount
the system. In order to make stable, we need to stop fault injection as well.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 1 +
 fs/f2fs/f2fs.h       | 7 +++++++
 fs/f2fs/file.c       | 4 ++++
 fs/f2fs/inode.c      | 3 +++
 fs/f2fs/node.c       | 3 ++-
 fs/f2fs/super.c      | 5 +----
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 37ec0f16448e..3837fd6505f4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -28,6 +28,7 @@ struct kmem_cache *f2fs_inode_entry_slab;
 
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
+	f2fs_build_fault_attr(sbi, 0);
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1d5c8d543eda..a3a62600f0bc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1066,6 +1066,7 @@ enum {
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_DISABLE_ATOMIC_WRITE,		/* turn off atomic write */
+	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
 };
 
 enum {
@@ -3373,4 +3374,10 @@ static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
 			F2FS_I_SB(inode)->s_ndevs);
 }
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate);
+#else
+#define f2fs_build_fault_attr(sbi, rate)		do { } while (0)
+#endif
+
 #endif
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b029a4ed3bb0..e84c5288c60b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1893,6 +1893,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		}
 		if (sb) {
 			f2fs_stop_checkpoint(sbi, false);
+			set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 			thaw_bdev(sb->s_bdev, sb);
 		}
 		break;
@@ -1902,13 +1903,16 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		if (ret)
 			goto out;
 		f2fs_stop_checkpoint(sbi, false);
+		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
 		f2fs_stop_checkpoint(sbi, false);
+		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_METAFLUSH:
 		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
 		f2fs_stop_checkpoint(sbi, false);
+		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f121c864f4c0..f91dd017a65c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -159,6 +159,9 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)))
+		return true;
+
 	if (!f2fs_enable_inode_chksum(sbi, page) ||
 			PageDirty(page) || PageWriteback(page))
 		return true;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b0267d3823b4..1061dd18b09c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1146,7 +1146,8 @@ static int read_node_page(struct page *page, int op_flags)
 
 	f2fs_get_node_info(sbi, page->index, &ni);
 
-	if (unlikely(ni.blk_addr == NULL_ADDR)) {
+	if (unlikely(ni.blk_addr == NULL_ADDR) ||
+			is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
 		ClearPageUptodate(page);
 		return -ENOENT;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1dc6809fac38..1cb5d1e4fcfd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -57,8 +57,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_CHECKPOINT]	= "checkpoint error",
 };
 
-static void f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
-						unsigned int rate)
+void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate)
 {
 	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
@@ -1379,9 +1378,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, POSIX_ACL);
 #endif
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	f2fs_build_fault_attr(sbi, 0);
-#endif
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.17.0.441.gb46fe60e1d-goog
