From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/7] f2fs: avoid null pointer exception in dcc_info
Date: Tue, 29 Jan 2019 07:47:15 +0800
Message-ID: <20190128234717.77225-5-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If dcc_info is not set yet, we can get null pointer panic.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fe95abb05d40..8c928cd72b61 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2161,10 +2161,17 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
 		get_pages(sbi, F2FS_WB_CP_DATA) ||
 		get_pages(sbi, F2FS_DIO_READ) ||
-		get_pages(sbi, F2FS_DIO_WRITE) ||
-		atomic_read(&SM_I(sbi)->dcc_info->queued_discard) ||
-		atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
+		get_pages(sbi, F2FS_DIO_WRITE))
 		return false;
+
+	if (SM_I(sbi) && SM_I(sbi)->dcc_info &&
+			atomic_read(&SM_I(sbi)->dcc_info->queued_discard))
+		return false;
+
+	if (SM_I(sbi) && SM_I(sbi)->fcc_info &&
+			atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
+		return false;
+
 	return f2fs_time_over(sbi, type);
 }
 
-- 
2.19.0.605.g01d371f741-goog
