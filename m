From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] f2fs: fix typos in code comments
Date: Fri, 25 Jan 2019 15:35:01 +0800
Message-ID: <19c7195d323e7c6a4b03c1e584d070e60458b71f.1548401310.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Jiri Kosina <trivial@kernel.org>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

lengh -> length

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/linux/f2fs_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d7711048ef93..624b8a47d3c6 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -186,7 +186,7 @@ struct f2fs_orphan_block {
 struct f2fs_extent {
 	__le32 fofs;		/* start file offset of the extent */
 	__le32 blk;		/* start block address of the extent */
-	__le32 len;		/* lengh of the extent */
+	__le32 len;		/* length of the extent */
 } __packed;
 
 #define F2FS_NAME_LEN		255
@@ -511,7 +511,7 @@ typedef __le32	f2fs_hash_t;
 struct f2fs_dir_entry {
 	__le32 hash_code;	/* hash code of file name */
 	__le32 ino;		/* inode number */
-	__le16 name_len;	/* lengh of file name */
+	__le16 name_len;	/* length of file name */
 	__u8 file_type;		/* file type */
 } __packed;
 
-- 
2.17.1
