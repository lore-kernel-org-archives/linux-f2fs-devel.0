From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to record dirty page count for symlink
Date: Mon, 29 Jun 2015 18:14:10 +0800
Message-ID: <00dd01d0b254$7082c640$518852c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Dirty page can be exist in mapping of newly created symlink, but previously
we did not maintain the counting of dirty page for symlink like we maintained
for regular/directory, so the counting we lookuped should be wrong.

This patch adds missed dirty page counting for symlink to fix this issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 3 ++-
 fs/f2fs/f2fs.h       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b70bbe1..de7a0d6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -704,7 +704,8 @@ void update_dirty_page(struct inode *inode, struct page *page)
 	struct inode_entry *new;
 	int ret = 0;
 
-	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode))
+	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
+			!S_ISLNK(inode->i_mode))
 		return;
 
 	if (!S_ISDIR(inode->i_mode)) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a8327ed..5162204 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1039,7 +1039,8 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
 
 static inline void inode_dec_dirty_pages(struct inode *inode)
 {
-	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode))
+	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
+			!S_ISLNK(inode->i_mode))
 		return;
 
 	atomic_dec(&F2FS_I(inode)->dirty_pages);
-- 
2.4.2
