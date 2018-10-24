From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to be aware discard/preflush command in is_idle()
Date: Wed, 24 Oct 2018 17:29:36 +0800
Message-ID: <20181024092936.129587-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds missing in-flight discard/preflush command count check
in is_idle().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- add in-flight preflush count check as well.
 fs/f2fs/f2fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6af2a105529d..70009709d50c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2156,7 +2156,9 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
-		get_pages(sbi, F2FS_WB_CP_DATA))
+		get_pages(sbi, F2FS_WB_CP_DATA) ||
+		atomic_read(&SM_I(sbi)->dcc_info->issing_discard) ||
+		atomic_read(&SM_I(sbi)->fcc_info->issing_flush))
 		return false;
 	return f2fs_time_over(sbi, type);
 }
-- 
2.18.0.rc1
