From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: skip writing in ->writepages when no dirty pages
 exist
Date: Fri, 17 Jul 2015 18:02:39 +0800
Message-ID: <01a301d0c077$d111a4a0$7334ede0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When flushing comes from background, if there is no dirty page in the
mapping of inode, we'd better to skip seeking dirty page from mapping
for writebacking.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b621c08..5370a74 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1284,6 +1284,10 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	if (!mapping->a_ops->writepage)
 		return 0;
 
+	/* skip writing if there is no dirty page in this inode */
+	if (!get_dirty_pages(inode) && wbc->sync_mode == WB_SYNC_NONE)
+		return 0;
+
 	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
 			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
 			available_free_memory(sbi, DIRTY_DENTS))
-- 
2.4.2
