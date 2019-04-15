From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 4/5] f2fs: add tracepoint for f2fs_filemap_fault()
Date: Mon, 15 Apr 2019 15:22:19 +0800
Message-ID: <20190415072219.1613-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds tracepoint for f2fs_filemap_fault().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix wrong type of @ret parameter
 fs/f2fs/file.c              |  2 ++
 include/trace/events/f2fs.h | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 30d49467578e..578486e03427 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -39,6 +39,8 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
+	trace_f2fs_filemap_fault(inode, vmf->pgoff, ret);
+
 	return ret;
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index a3916b4dd57e..cfa0dcdd1462 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1253,6 +1253,32 @@ DEFINE_EVENT(f2fs__page, f2fs_commit_inmem_page,
 	TP_ARGS(page, type)
 );
 
+TRACE_EVENT(f2fs_filemap_fault,
+
+	TP_PROTO(struct inode *inode, pgoff_t index, enum vm_fault_reason ret),
+
+	TP_ARGS(inode, index, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t, index)
+		__field(enum vm_fault_reason, ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->index	= index;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %u",
+		show_dev_ino(__entry),
+		(unsigned long)__entry->index,
+		ret)
+);
+
 TRACE_EVENT(f2fs_writepages,
 
 	TP_PROTO(struct inode *inode, struct writeback_control *wbc, int type),
-- 
2.18.0.rc1
