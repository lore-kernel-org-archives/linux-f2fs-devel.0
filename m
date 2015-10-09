From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: add F2FS_GOING_DOWN_METAFLUSH to test power-failure
Date: Thu,  8 Oct 2015 17:29:25 -0700
Message-ID: <1444350566-37795-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces F2FS_GOING_DOWN_METAFLUSH which flushes meta pages like
SSA blocks and then blocks all the writes.
This can be used by power-failure tests.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/file.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aad4720..f05ae22 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -250,6 +250,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
 #define F2FS_GOING_DOWN_FULLSYNC	0x0	/* going down with full sync */
 #define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
 #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
+#define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b3985a6..6d3cfd5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1498,6 +1498,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	case F2FS_GOING_DOWN_NOSYNC:
 		f2fs_stop_checkpoint(sbi);
 		break;
+	case F2FS_GOING_DOWN_METAFLUSH:
+		sync_meta_pages(sbi, META, LONG_MAX);
+		f2fs_stop_checkpoint(sbi);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.1.1
