From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: fix to remove directory inode from dirty list
Date: Tue, 10 Nov 2015 18:45:07 +0800
Message-ID: <01b901d11ba4$f56a5cb0$e03f1610$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If last dirty dentry page was writebacked in reclaim path, we should
remove its directory inode from global dirty list to avoid unnecessary
flush for this inode when doing checkpoint.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c3e1ffa..6c689e9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1182,8 +1182,10 @@ out:
 	unlock_page(page);
 	if (need_balance_fs)
 		f2fs_balance_fs(sbi);
-	if (wbc->for_reclaim)
+	if (wbc->for_reclaim) {
 		f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		remove_dirty_dir_inode(inode);
+	}
 	return 0;
 
 redirty_out:
-- 
2.6.1
