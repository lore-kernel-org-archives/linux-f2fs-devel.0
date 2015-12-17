From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: add a tracepoint for sync_dirty_inodes
Date: Thu, 17 Dec 2015 17:17:16 +0800
Message-ID: <006e01d138ab$d0c1a610$7244f230$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a tracepoint for sync_dirty_inodes.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c        |  8 ++++++++
 include/trace/events/f2fs.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 53044ea..fdd43f7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -803,6 +803,11 @@ void sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	struct list_head *head;
 	struct inode *inode;
 	struct f2fs_inode_info *fi;
+	bool is_dir = (type == DIR_INODE);
+
+	trace_f2fs_sync_dirty_inodes_enter(sbi->sb, is_dir,
+				get_pages(sbi, is_dir ?
+				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
 retry:
 	if (unlikely(f2fs_cp_error(sbi)))
 		return;
@@ -812,6 +817,9 @@ retry:
 	head = &sbi->inode_list[type];
 	if (list_empty(head)) {
 		spin_unlock(&sbi->inode_lock[type]);
+		trace_f2fs_sync_dirty_inodes_exit(sbi->sb, is_dir,
+				get_pages(sbi, is_dir ?
+				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
 		return;
 	}
 	fi = list_entry(head->next, struct f2fs_inode_info, dirty_list);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 00b4a63..a1b4888 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1265,6 +1265,44 @@ TRACE_EVENT(f2fs_destroy_extent_tree,
 		__entry->node_cnt)
 );
 
+DECLARE_EVENT_CLASS(f2fs_sync_dirty_inodes,
+
+	TP_PROTO(struct super_block *sb, int type, int count),
+
+	TP_ARGS(sb, type, count),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(int, type)
+		__field(int, count)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->type	= type;
+		__entry->count	= count;
+	),
+
+	TP_printk("dev = (%d,%d), %s, dirty count = %d",
+		show_dev(__entry),
+		show_file_type(__entry->type),
+		__entry->count)
+);
+
+DEFINE_EVENT(f2fs_sync_dirty_inodes, f2fs_sync_dirty_inodes_enter,
+
+	TP_PROTO(struct super_block *sb, int type, int count),
+
+	TP_ARGS(sb, type, count)
+);
+
+DEFINE_EVENT(f2fs_sync_dirty_inodes, f2fs_sync_dirty_inodes_exit,
+
+	TP_PROTO(struct super_block *sb, int type, int count),
+
+	TP_ARGS(sb, type, count)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.6.3
