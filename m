From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: indicate shutdown f2fs to allow
 unmount successfully
Date: Fri,  6 Jul 2018 14:09:02 -0700
Message-ID: <20180706210903.77887-3-jaegeuk@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fbXye-0000fW-Fv
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 21:09:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fbXya-00BetS-NT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 21:09:16 +0000
In-Reply-To: <20180706210903.77887-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Once we shutdown f2fs, we have to flush stale pages in order to unmount
the system. In order to make stable, we need to stop fault injection as well.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/data.c       |  4 ++++
 fs/f2fs/f2fs.h       |  7 +++++++
 fs/f2fs/file.c       |  4 ++++
 fs/f2fs/inode.c      |  3 +++
 fs/f2fs/node.c       | 11 +++++++++--
 fs/f2fs/super.c      |  5 +----
 7 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ee10b40309a1..8b698bd54490 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -28,6 +28,7 @@ struct kmem_cache *f2fs_inode_entry_slab;
 
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
+	f2fs_build_fault_attr(sbi, 0);
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e8e78bb64a7..c3f9b9baf140 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1829,6 +1829,10 @@ static int __write_data_page(struct page *page, bool *submitted,
 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(page->mapping, -EIO);
+
+		if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
+			goto out;
+
 		/*
 		 * don't drop any dirty dentry pages for keeping lastest
 		 * directory structure.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3cde41fb40a1..cc1ad4c8103c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1069,6 +1069,7 @@ enum {
 	SBI_POR_DOING,				/* recovery is doing or not */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
+	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
 };
 
 enum {
@@ -3398,4 +3399,10 @@ static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
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
index e8dfda4b4fcb..5e29d4053748 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1902,6 +1902,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		}
 		if (sb) {
 			f2fs_stop_checkpoint(sbi, false);
+			set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 			thaw_bdev(sb->s_bdev, sb);
 		}
 		break;
@@ -1911,13 +1912,16 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
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
index 4c5e354a572c..8211f5c288a1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -160,6 +160,9 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)))
+		return true;
+
 #ifdef CONFIG_F2FS_CHECK_FS
 	if (!f2fs_enable_inode_chksum(sbi, page))
 #else
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0f076fb0d828..7293ea65f343 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1150,7 +1150,8 @@ static int read_node_page(struct page *page, int op_flags)
 
 	f2fs_get_node_info(sbi, page->index, &ni);
 
-	if (unlikely(ni.blk_addr == NULL_ADDR)) {
+	if (unlikely(ni.blk_addr == NULL_ADDR) ||
+			is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
 		ClearPageUptodate(page);
 		return -ENOENT;
 	}
@@ -1372,8 +1373,14 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 
 	trace_f2fs_writepage(page, NODE);
 
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
+			dec_page_count(sbi, F2FS_DIRTY_NODES);
+			unlock_page(page);
+			return 0;
+		}
 		goto redirty_out;
+	}
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 383e3bff7c22..5562ff05c14e 100644
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
 
@@ -1380,9 +1379,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, POSIX_ACL);
 #endif
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	f2fs_build_fault_attr(sbi, 0);
-#endif
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
