From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 5/6] f2fs: trace f2fs_remove_discard
Date: Wed,  4 Oct 2017 09:08:36 +0800
Message-ID: <20171004010837.9809-5-chao@kernel.org>
References: <20171004010837.9809-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171004010837.9809-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds tracepoint to trace f2fs_remove_discard.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase on last codes of Jaegeuk's dev-test branch.
 fs/f2fs/segment.c           | 2 ++
 include/trace/events/f2fs.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ba433828c170..4a108321233d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -822,6 +822,8 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
+	trace_f2fs_remove_discard(dc->bdev, dc->start, dc->len);
+
 	f2fs_bug_on(sbi, dc->ref);
 
 	if (dc->error == -EOPNOTSUPP)
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 5d216f7fb05a..0e7a31694ff5 100644
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
