From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: release new entry page correctly in error path of
 f2fs_rename
Date: Tue, 24 Jun 2014 14:13:13 +0800
Message-ID: <001601cf8f73$7f4e4280$7deac780$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch correct releasing code of new_page to avoid BUG_ON in error patch of
f2fs_rename.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 0d55517..f17e34c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -475,7 +475,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return 0;
 
 put_out_dir:
-	f2fs_put_page(new_page, 1);
+	kunmap(new_page);
+	f2fs_put_page(new_page, 0);
 out_dir:
 	if (old_dir_entry) {
 		kunmap(old_dir_page);
-- 
1.7.9.5
