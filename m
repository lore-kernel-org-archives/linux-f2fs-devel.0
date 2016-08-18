From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: set dirty state for filesystem only when updating meta data
Date: Thu, 18 Aug 2016 17:46:14 +0800
Message-ID: <20160818094614.62957-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We don't guarantee integrity of user data after checkpoint, since we only
guarantee meta data integrity for data consistency of filesystem.

Due to above reason, we only need to set fs as dirty when meta data is
updated, so that we can skip writing checkpoint in some case of non-meta
data is updated.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a10bce..0ec6c36 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1220,6 +1220,10 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 {
 	percpu_counter_inc(&sbi->nr_pages[count_type]);
+
+	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES)
+		return;
+
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 }
 
-- 
2.8.2.311.gee88674
