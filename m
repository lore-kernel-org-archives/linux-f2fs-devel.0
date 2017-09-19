From: Chao Yu <chao@kernel.org>
Subject: [PATCH 5/6] f2fs: trace f2fs_remove_discard
Date: Tue, 19 Sep 2017 23:30:15 +0800
Message-ID: <20170919153016.4116-5-chao@kernel.org>
References: <20170919153016.4116-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919153016.4116-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds tracepoint to trace f2fs_remove_discard.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c           | 2 ++
 include/trace/events/f2fs.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 412ac3a68be3..85f909419b69 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -794,6 +794,8 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
+	trace_f2fs_remove_discard(dc->bdev, dc->start, dc->len);
+
 	f2fs_bug_on(sbi, dc->ref);
 
 	if (dc->error == -EOPNOTSUPP)
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 8955e75dd48e..407713ef5981 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1286,6 +1286,13 @@ DEFINE_EVENT(f2fs_discard, f2fs_issue_discard,
 	TP_ARGS(dev, blkstart, blklen)
 );
 
+DEFINE_EVENT(f2fs_discard, f2fs_remove_discard,
+
+	TP_PROTO(struct block_device *dev, block_t blkstart, block_t blklen),
+
+	TP_ARGS(dev, blkstart, blklen)
+);
+
 TRACE_EVENT(f2fs_issue_reset_zone,
 
 	TP_PROTO(struct block_device *dev, block_t blkstart),
-- 
2.14.1.145.gb3622a4ee
