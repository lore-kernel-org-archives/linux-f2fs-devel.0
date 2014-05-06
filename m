From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 3/6] f2fs: add a tracepoint for
 f2fs_write_{meta,node,data}_page
Date: Tue, 06 May 2014 16:48:26 +0800
Message-ID: <004501cf6908$123c99d0$36b5cd70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a tracepoint for f2fs_write_{meta,node,data}_page to trace when
page is writting out.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c        |    2 ++
 fs/f2fs/data.c              |    2 ++
 fs/f2fs/node.c              |    2 ++
 include/trace/events/f2fs.h |    7 +++++++
 4 files changed, 13 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b6f6ead..7962aaf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -160,6 +160,8 @@ static int f2fs_write_meta_page(struct page *page,
 	struct inode *inode = page->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 
+	trace_f2fs_writepage(page, META);
+
 	if (unlikely(sbi->por_doing))
 		goto redirty_out;
 	if (wbc->for_reclaim)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ea58fb6..b997d55 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -788,6 +788,8 @@ static int f2fs_write_data_page(struct page *page,
 		.rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE,
 	};
 
+	trace_f2fs_writepage(page, DATA);
+
 	if (page->index < end_index)
 		goto write;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 059aaf5..49bdddb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1199,6 +1199,8 @@ static int f2fs_write_node_page(struct page *page,
 		.rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE,
 	};
 
+	trace_f2fs_writepage(page, NODE);
+
 	if (unlikely(sbi->por_doing))
 		goto redirty_out;
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 483804b..d70991e 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -751,6 +751,13 @@ DECLARE_EVENT_CLASS(f2fs__page,
 		__entry->dirty)
 );
 
+DEFINE_EVENT(f2fs__page, f2fs_writepage,
+
+	TP_PROTO(struct page *page, int type),
+
+	TP_ARGS(page, type)
+);
+
 DEFINE_EVENT(f2fs__page, f2fs_set_page_dirty,
 
 	TP_PROTO(struct page *page, int type),
-- 
1.7.9.5


