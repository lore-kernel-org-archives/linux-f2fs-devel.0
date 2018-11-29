From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add an ioctl() to explicitly trigger fsck later
Date: Wed, 28 Nov 2018 17:52:57 -0800
Message-ID: <20181129015257.95036-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This adds an option in ioctl(F2FS_IOC_SHUTDOWN) in order to trigger fsck by
setting a NEED_FSCK flag.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/file.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aa500239baf2..7cec897146a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -417,6 +417,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
 #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
 #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
+#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ff82350a2c55..ca9bdbb8651b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1966,6 +1966,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		f2fs_stop_checkpoint(sbi, false);
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
+	case F2FS_GOING_DOWN_NEED_FSCK:
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		/* do checkpoint only */
+		ret = f2fs_sync_fs(sb, 1);
+		if (ret)
+			goto out;
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
2.19.0.605.g01d371f741-goog
