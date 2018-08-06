From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support discard submission error injection
Date: Mon, 6 Aug 2018 20:30:18 +0800
Message-ID: <20180806123018.14952-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds to support discard submission error injection for testing
error handling of __submit_discard_cmd().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/segment.c | 8 ++++++++
 fs/f2fs/super.c   | 1 +
 3 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae9dfad58046..1e07fcd7f580 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -56,6 +56,7 @@ enum {
 	FAULT_TRUNCATE,
 	FAULT_IO,
 	FAULT_CHECKPOINT,
+	FAULT_DISCARD,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ccad453bd2b7..db8a79ac5b3f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1045,10 +1045,18 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		dc->len += len;
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+		if (time_to_inject(sbi, FAULT_DISCARD)) {
+			f2fs_show_injection_info(FAULT_DISCARD);
+			err = -EIO;
+			goto submit;
+		}
+#endif
 		err = __blkdev_issue_discard(bdev,
 					SECTOR_FROM_BLOCK(start),
 					SECTOR_FROM_BLOCK(len),
 					GFP_NOFS, 0, &bio);
+submit:
 		if (!err && bio) {
 			/*
 			 * should keep before submission to avoid D_DONE
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ba2fd51580d2..254f74a6b481 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -55,6 +55,7 @@ char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_TRUNCATE]	= "truncate fail",
 	[FAULT_IO]		= "IO error",
 	[FAULT_CHECKPOINT]	= "checkpoint error",
+	[FAULT_DISCARD]		= "discard error",
 };
 
 void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate)
-- 
2.18.0.rc1
