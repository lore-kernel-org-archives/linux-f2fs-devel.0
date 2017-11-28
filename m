From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH 2/2] f2fs: pass down write hints to block layer for direct write
Date: Tue, 28 Nov 2017 09:23:27 +0900
Message-ID: <1511828607-624-2-git-send-email-hyc.lee@gmail.com>
References: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Jens Axboe <axboe@kernel.dk>, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

This implements which hint is passed down to block layer
for direct write.

                     (allocated
file hint            segment type)   io hint
----------           ------------    --------
WRITE_LIFE_SHORT     HOT_DATA        WRITE_LIFE_MEDIUM
WRITE_LIFE_EXTREME   COLD_DATA       WRITE_LIFE_EXTREME
others               WARM_DATA       WRITE_LIFE_NONE

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 fs/f2fs/data.c    |  6 ++++++
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 12 ++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0919a43..eabd569 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2093,6 +2093,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t offset = iocb->ki_pos;
 	int rw = iov_iter_rw(iter);
 	int err;
+	enum rw_hint orig_hint;
 
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
@@ -2103,10 +2104,15 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
 
+	orig_hint = iocb->ki_hint;
+	iocb->ki_hint = file_rwhint_to_io_rwhint(iocb->ki_hint);
+
 	down_read(&F2FS_I(inode)->dio_rwsem[rw]);
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
 	up_read(&F2FS_I(inode)->dio_rwsem[rw]);
 
+	iocb->ki_hint = orig_hint;
+
 	if (rw == WRITE) {
 		if (err > 0) {
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_IO,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index be3cb0c..426625a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2676,6 +2676,7 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 void destroy_segment_manager_caches(void);
 int rw_hint_to_seg_type(enum rw_hint hint);
 enum rw_hint io_type_to_rw_hint(enum page_type page, enum temp_type temp);
+enum rw_hint file_rwhint_to_io_rwhint(enum rw_hint hint);
 
 /*
  * checkpoint.c
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0570db7..b4496a5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2475,6 +2475,18 @@ enum rw_hint io_type_to_rw_hint(enum page_type page, enum temp_type temp)
 	}
 }
 
+enum rw_hint file_rwhint_to_io_rwhint(enum rw_hint hint)
+{
+	switch(hint) {
+	case WRITE_LIFE_SHORT:
+		return WRITE_LIFE_MEDIUM;
+	case WRITE_LIFE_EXTREME:
+		return WRITE_LIFE_EXTREME;
+	default:
+		return WRITE_LIFE_NONE;
+	}
+}
+
 static int __get_segment_type_2(struct f2fs_io_info *fio)
 {
 	if (fio->type == DATA)
-- 
1.9.1
