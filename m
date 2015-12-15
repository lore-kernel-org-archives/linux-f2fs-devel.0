From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add symbol to avoid any confusion with tools
Date: Mon, 14 Dec 2015 19:11:19 -0800
Message-ID: <1450149079-59118-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds MAX_VOLUME_NAME to sync with f2fs-tools.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/linux/f2fs_fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 25c6324..e59c3be 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -51,6 +51,7 @@
 #define MAX_ACTIVE_DATA_LOGS	8
 
 #define VERSION_LEN	256
+#define MAX_VOLUME_NAME		512
 
 /*
  * For superblock
@@ -84,7 +85,7 @@ struct f2fs_super_block {
 	__le32 node_ino;		/* node inode number */
 	__le32 meta_ino;		/* meta inode number */
 	__u8 uuid[16];			/* 128-bit uuid for volume */
-	__le16 volume_name[512];	/* volume name */
+	__le16 volume_name[MAX_VOLUME_NAME];	/* volume name */
 	__le32 extension_count;		/* # of extensions below */
 	__u8 extension_list[F2FS_MAX_EXTENSION][8];	/* extension array */
 	__le32 cp_payload;
-- 
2.5.4 (Apple Git-61)
