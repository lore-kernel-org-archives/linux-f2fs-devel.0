From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH v2] f2fs: avoid overflow when large directory
 feathure is enabled
Date: Wed, 28 May 2014 08:56:09 +0800
Message-ID: <012001cf7a0f$bec1e530$3c45af90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When large directory feathure is enable, We have one case which could cause
overflow in dir_buckets() as following:
special case: level + dir_level >= 32 and level < MAX_DIR_HASH_DEPTH / 2.

Here we define MAX_DIR_BUCKETS to limit the return value when the condition
could trigger potential overflow.

Changes from V1
 o modify description of calculation in f2fs.txt suggested by Changman Lee.

Suggested-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 Documentation/filesystems/f2fs.txt |    8 ++++----
 fs/f2fs/dir.c                      |    4 ++--
 include/linux/f2fs_fs.h            |    3 +++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 25311e11..51afba1 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -461,11 +461,11 @@ The number of blocks and buckets are determined by,
   # of blocks in level #n = |
                             `- 4, Otherwise
 
-                             ,- 2^ (n + dir_level),
-			     |            if n < MAX_DIR_HASH_DEPTH / 2,
+                             ,- 2^(n + dir_level),
+			     |        if n + dir_level < MAX_DIR_HASH_DEPTH / 2,
   # of buckets in level #n = |
-                             `- 2^((MAX_DIR_HASH_DEPTH / 2 + dir_level) - 1),
-			                  Otherwise
+                             `- 2^((MAX_DIR_HASH_DEPTH / 2) - 1),
+			              Otherwise
 
 When F2FS finds a file name in a directory, at first a hash value of the file
 name is calculated. Then, F2FS scans the hash table in level #0 to find the
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c3f1485..966acb0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -23,10 +23,10 @@ static unsigned long dir_blocks(struct inode *inode)
 
 static unsigned int dir_buckets(unsigned int level, int dir_level)
 {
-	if (level < MAX_DIR_HASH_DEPTH / 2)
+	if (level + dir_level < MAX_DIR_HASH_DEPTH / 2)
 		return 1 << (level + dir_level);
 	else
-		return 1 << ((MAX_DIR_HASH_DEPTH / 2 + dir_level) - 1);
+		return MAX_DIR_BUCKETS;
 }
 
 static unsigned int bucket_blocks(unsigned int level)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 8c03f71..ba6f312 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -394,6 +394,9 @@ typedef __le32	f2fs_hash_t;
 /* MAX level for dir lookup */
 #define MAX_DIR_HASH_DEPTH	63
 
+/* MAX buckets in one level of dir */
+#define MAX_DIR_BUCKETS		(1 << ((MAX_DIR_HASH_DEPTH / 2) - 1))
+
 #define SIZE_OF_DIR_ENTRY	11	/* by byte */
 #define SIZE_OF_DENTRY_BITMAP	((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
 					BITS_PER_BYTE)
-- 
1.7.9.5
