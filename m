From: Chao Yu <chao@kernel.org>
Subject: [PATCH v3] f2fs: fix to be aware discard/preflush/dio command in is_idle()
Date: Mon, 12 Nov 2018 00:55:44 +0800
Message-ID: <20181111165544.14667-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds missing in-flight discard/preflush/dio command count
check in is_idle().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- add in-flight r/w dio count check as well.
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 97c35036bf49..b1d5031be2d5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2157,7 +2157,11 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
-		get_pages(sbi, F2FS_WB_CP_DATA))
+		get_pages(sbi, F2FS_WB_CP_DATA) ||
+		get_pages(sbi, F2FS_DIO_READ) ||
+		get_pages(sbi, F2FS_DIO_WRITE) ||
+		atomic_read(&SM_I(sbi)->dcc_info->issing_discard) ||
+		atomic_read(&SM_I(sbi)->fcc_info->issing_flush))
 		return false;
 	return f2fs_time_over(sbi, type);
 }
-- 
2.18.0
