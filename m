From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: shrink sbi->sb_lock coverage in set_file_temperature()
Date: Thu,  4 Oct 2018 11:15:18 +0800
Message-ID: <20181004031520.4096-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

file_set_{cold,hot} doesn't need holding sbi->sb_lock, so moving them
out of the lock.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a14632744a6a..d5de8a99532d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -182,16 +182,19 @@ static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *
 	hot_count = sbi->raw_super->hot_ext_count;
 
 	for (i = 0; i < cold_count + hot_count; i++) {
-		if (!is_extension_exist(name, extlist[i]))
-			continue;
-		if (i < cold_count)
-			file_set_cold(inode);
-		else
-			file_set_hot(inode);
-		break;
+		if (is_extension_exist(name, extlist[i]))
+			break;
 	}
 
 	up_read(&sbi->sb_lock);
+
+	if (i == cold_count + hot_count)
+		return;
+
+	if (i < cold_count)
+		file_set_cold(inode);
+	else
+		file_set_hot(inode);
 }
 
 int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
-- 
2.18.0
