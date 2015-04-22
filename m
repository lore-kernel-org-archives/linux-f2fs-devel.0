From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: export more enums for tracepoint
Date: Wed, 22 Apr 2015 16:17:56 -0700
Message-ID: <1429744676-97126-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch exports newly added enums to userspace.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/trace/events/f2fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index f18c83a..04856a2 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -13,6 +13,10 @@ TRACE_DEFINE_ENUM(NODE);
 TRACE_DEFINE_ENUM(DATA);
 TRACE_DEFINE_ENUM(META);
 TRACE_DEFINE_ENUM(META_FLUSH);
+TRACE_DEFINE_ENUM(INMEM);
+TRACE_DEFINE_ENUM(INMEM_DROP);
+TRACE_DEFINE_ENUM(IPU);
+TRACE_DEFINE_ENUM(OPU);
 TRACE_DEFINE_ENUM(CURSEG_HOT_DATA);
 TRACE_DEFINE_ENUM(CURSEG_WARM_DATA);
 TRACE_DEFINE_ENUM(CURSEG_COLD_DATA);
@@ -37,6 +41,7 @@ TRACE_DEFINE_ENUM(__REQ_META);
 TRACE_DEFINE_ENUM(CP_UMOUNT);
 TRACE_DEFINE_ENUM(CP_FASTBOOT);
 TRACE_DEFINE_ENUM(CP_SYNC);
+TRACE_DEFINE_ENUM(CP_RECOVERY);
 TRACE_DEFINE_ENUM(CP_DISCARD);
 
 #define show_block_type(type)						\
-- 
2.1.1
