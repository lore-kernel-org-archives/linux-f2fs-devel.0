From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: add tracepoint for f2fs_filemap_fault()
Date: Tue, 2 Apr 2019 18:52:21 +0800
Message-ID: <20190402105222.28374-4-yuchao0@huawei.com>
References: <20190402105222.28374-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hBH2L-0000fw-JS
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 10:53:01 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hBH2K-00BrHV-8B
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 10:53:01 +0000
In-Reply-To: <20190402105222.28374-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds tracepoint for f2fs_filemap_fault().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
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
index a3916b4dd57e..1b39b50511f5 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1253,6 +1253,32 @@ DEFINE_EVENT(f2fs__page, f2fs_commit_inmem_page,
 	TP_ARGS(page, type)
 );
 
+TRACE_EVENT(f2fs_filemap_fault,
+
+	TP_PROTO(struct inode *inode, pgoff_t index, int ret),
+
+	TP_ARGS(inode, index, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t, index)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->index	= index;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %d",
+		show_dev_ino(__entry),
+		(unsigned long)__entry->index,
+		ret)
+);
+
 TRACE_EVENT(f2fs_writepages,
 
 	TP_PROTO(struct inode *inode, struct writeback_control *wbc, int type),
-- 
2.18.0.rc1
