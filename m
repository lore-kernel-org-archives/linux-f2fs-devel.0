From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to be aware discard IO in is_idle()
Date: Wed, 24 Oct 2018 15:43:55 +0800
Message-ID: <20181024074355.113845-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds missing in-flight discard IO count check in is_idle().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6af2a105529d..c8005d271de0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2156,7 +2156,8 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
-		get_pages(sbi, F2FS_WB_CP_DATA))
+		get_pages(sbi, F2FS_WB_CP_DATA) ||
+		atomic_read(&SM_I(sbi)->dcc_info->issing_discard))
 		return false;
 	return f2fs_time_over(sbi, type);
 }
-- 
2.18.0.rc1
