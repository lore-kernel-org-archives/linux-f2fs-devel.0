From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to set sbi dirty correctly
Date: Thu, 10 Jan 2019 16:40:12 +0800
Message-ID: <20190110084012.115473-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In order to record direct IO count, we add two additional type in
enum count_type: F2FS_DIO_{WRITE,READ}, but those IO won't dirty
filesystem metadata, so we don't need to set filesystem dirty in
inc_page_count(), fix it.

Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 94315e8423a9..dc8498e3d03c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1793,13 +1793,12 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 {
 	atomic_inc(&sbi->nr_pages[count_type]);
 
-	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
-		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA ||
-		count_type == F2FS_RD_DATA || count_type == F2FS_RD_NODE ||
-		count_type == F2FS_RD_META)
-		return;
-
-	set_sbi_flag(sbi, SBI_IS_DIRTY);
+	if (count_type == F2FS_DIRTY_DENTS ||
+			count_type == F2FS_DIRTY_NODES ||
+			count_type == F2FS_DIRTY_META ||
+			count_type == F2FS_DIRTY_QDATA ||
+			count_type == F2FS_DIRTY_IMETA)
+		set_sbi_flag(sbi, SBI_IS_DIRTY);
 }
 
 static inline void inode_inc_dirty_pages(struct inode *inode)
-- 
2.18.0.rc1
