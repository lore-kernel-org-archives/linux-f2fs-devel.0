From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: report error of do_checkpoint
Date: Wed, 23 Dec 2015 17:50:30 +0800
Message-ID: <010c01d13d67$73c2ff20$5b48fd60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aBg4m-0000ZE-1D
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 09:51:20 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aBg4j-0005Ua-6y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 09:51:20 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZT02HXP218I9D0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 18:51:09 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

do_checkpoint and write_checkpoint can fail due to reasons like triggering
in a readonly fs or encountering IO error of storage device.

So it's better to report such error info to user, let user be aware of
failure of doing checkpoint.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 29 +++++++++++++++++++----------
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/file.c       |  5 +++--
 fs/f2fs/recovery.c   |  2 +-
 fs/f2fs/segment.c    |  5 +++--
 fs/f2fs/super.c      |  5 +++--
 6 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fdd43f7..9cdb161 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -910,7 +910,7 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
 	finish_wait(&sbi->cp_wait, &wait);
 }
 
-static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
@@ -936,7 +936,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	while (get_pages(sbi, F2FS_DIRTY_META)) {
 		sync_meta_pages(sbi, META, LONG_MAX);
 		if (unlikely(f2fs_cp_error(sbi)))
-			return;
+			return -EIO;
 	}
 
 	next_free_nid(sbi, &last_nid);
@@ -1021,7 +1021,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* need to wait for end_io results */
 	wait_on_all_pages_writeback(sbi);
 	if (unlikely(f2fs_cp_error(sbi)))
-		return;
+		return -EIO;
 
 	/* write out checkpoint buffer at block 0 */
 	update_meta_page(sbi, ckpt, start_blk++);
@@ -1049,7 +1049,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	wait_on_all_pages_writeback(sbi);
 
 	if (unlikely(f2fs_cp_error(sbi)))
-		return;
+		return -EIO;
 
 	filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LONG_MAX);
 	filemap_fdatawait_range(META_MAPPING(sbi), 0, LONG_MAX);
@@ -1075,19 +1075,22 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	release_ino_entry(sbi);
 
 	if (unlikely(f2fs_cp_error(sbi)))
-		return;
+		return -EIO;
 
 	clear_prefree_segments(sbi, cpc);
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
+
+	return 0;
 }
 
 /*
  * We guarantee that this checkpoint procedure will not fail.
  */
-void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	unsigned long long ckpt_ver;
+	int err = 0;
 
 	mutex_lock(&sbi->cp_mutex);
 
@@ -1095,14 +1098,19 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		(cpc->reason == CP_FASTBOOT || cpc->reason == CP_SYNC ||
 		(cpc->reason == CP_DISCARD && !sbi->discard_blks)))
 		goto out;
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		err = -EIO;
 		goto out;
-	if (f2fs_readonly(sbi->sb))
+	}
+	if (f2fs_readonly(sbi->sb)) {
+		err = -EROFS;
 		goto out;
+	}
 
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "start block_ops");
 
-	if (block_operations(sbi))
+	err = block_operations(sbi);
+	if (err)
 		goto out;
 
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish block_ops");
@@ -1124,7 +1132,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	flush_sit_entries(sbi, cpc);
 
 	/* unlock all the fs_lock[] in do_checkpoint() */
-	do_checkpoint(sbi, cpc);
+	err = do_checkpoint(sbi, cpc);
 
 	unblock_operations(sbi);
 	stat_inc_cp_count(sbi->stat_info);
@@ -1138,6 +1146,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
 out:
 	mutex_unlock(&sbi->cp_mutex);
+	return err;
 }
 
 void init_ino_entry_info(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0f4d329..0d23962 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1838,7 +1838,7 @@ void update_dirty_page(struct inode *, struct page *);
 void add_dirty_dir_inode(struct inode *);
 void remove_dirty_inode(struct inode *);
 void sync_dirty_inodes(struct f2fs_sb_info *, enum inode_type);
-void write_checkpoint(struct f2fs_sb_info *, struct cp_control *);
+int write_checkpoint(struct f2fs_sb_info *, struct cp_control *);
 void init_ino_entry_info(struct f2fs_sb_info *);
 int __init create_checkpoint_caches(void);
 void destroy_checkpoint_caches(void);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f56023d..2e3d797 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1620,6 +1620,7 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct cp_control cpc;
 	int flush_data;
+	int err;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1636,10 +1637,10 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 	cpc.reason = __get_cp_reason(sbi);
 
 	mutex_lock(&sbi->gc_mutex);
-	write_checkpoint(sbi, &cpc);
+	err = write_checkpoint(sbi, &cpc);
 	mutex_unlock(&sbi->gc_mutex);
 
-	return 0;
+	return err;
 }
 
 static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 7fcb6e4..589b20b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -623,7 +623,7 @@ out:
 			.reason = CP_RECOVERY,
 		};
 		mutex_unlock(&sbi->cp_mutex);
-		write_checkpoint(sbi, &cpc);
+		err = write_checkpoint(sbi, &cpc);
 	} else {
 		mutex_unlock(&sbi->cp_mutex);
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c247450..a3474ba 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1118,6 +1118,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
 	unsigned int start_segno, end_segno;
 	struct cp_control cpc;
+	int err = 0;
 
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
@@ -1148,12 +1149,12 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 				sbi->segs_per_sec) - 1, end_segno);
 
 		mutex_lock(&sbi->gc_mutex);
-		write_checkpoint(sbi, &cpc);
+		err = write_checkpoint(sbi, &cpc);
 		mutex_unlock(&sbi->gc_mutex);
 	}
 out:
 	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
-	return 0;
+	return err;
 }
 
 static bool __has_curseg_space(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c3070c1..597b533 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -579,6 +579,7 @@ static void f2fs_put_super(struct super_block *sb)
 int f2fs_sync_fs(struct super_block *sb, int sync)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int err = 0;
 
 	trace_f2fs_sync_fs(sb, sync);
 
@@ -588,14 +589,14 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 		cpc.reason = __get_cp_reason(sbi);
 
 		mutex_lock(&sbi->gc_mutex);
-		write_checkpoint(sbi, &cpc);
+		err = write_checkpoint(sbi, &cpc);
 		mutex_unlock(&sbi->gc_mutex);
 	} else {
 		f2fs_balance_fs(sbi);
 	}
 	f2fs_trace_ios(NULL, 1);
 
-	return 0;
+	return err;
 }
 
 static int f2fs_freeze(struct super_block *sb)
-- 
2.6.3



------------------------------------------------------------------------------
