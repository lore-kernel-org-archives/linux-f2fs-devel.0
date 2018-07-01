From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] f2fs: Replace strncpy with memcpy
Date: Sun,  1 Jul 2018 13:57:06 -0700
Message-ID: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

gcc 8.1.0 complains:

fs/f2fs/namei.c: In function 'f2fs_update_extension_list':
fs/f2fs/namei.c:257:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length
fs/f2fs/namei.c:249:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/f2fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 231b7f3ea7d3..e75607544f7c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -246,7 +246,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 		return -EINVAL;
 
 	if (hot) {
-		strncpy(extlist[count], name, strlen(name));
+		memcpy(extlist[count], name, strlen(name));
 		sbi->raw_super->hot_ext_count = hot_count + 1;
 	} else {
 		char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
@@ -254,7 +254,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 		memcpy(buf, &extlist[cold_count],
 				F2FS_EXTENSION_LEN * hot_count);
 		memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
-		strncpy(extlist[cold_count], name, strlen(name));
+		memcpy(extlist[cold_count], name, strlen(name));
 		memcpy(&extlist[cold_count + 1], buf,
 				F2FS_EXTENSION_LEN * hot_count);
 		sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
-- 
2.7.4
