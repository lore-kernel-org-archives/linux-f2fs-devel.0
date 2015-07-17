From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: convert inline data before set atomic/volatile flag
Date: Fri, 17 Jul 2015 18:06:35 +0800
Message-ID: <01a501d0c078$5b78b430$126a1c90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_ioc_start_{atomic,volatile}_write, if we failed in converting
inline data, we will report error to user, but still remain atomic/volatile
flag in inode, it will impact further writes for this file. Fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1bb1d6e..ee17472 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1323,6 +1323,7 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 static int f2fs_ioc_start_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	int ret;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
@@ -1332,9 +1333,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (f2fs_is_atomic_file(inode))
 		return 0;
 
-	set_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		return ret;
 
-	return f2fs_convert_inline_inode(inode);
+	set_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+	return 0;
 }
 
 static int f2fs_ioc_commit_atomic_write(struct file *filp)
@@ -1364,6 +1368,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 static int f2fs_ioc_start_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	int ret;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
@@ -1371,9 +1376,12 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	if (f2fs_is_volatile_file(inode))
 		return 0;
 
-	set_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		return ret;
 
-	return f2fs_convert_inline_inode(inode);
+	set_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
+	return 0;
 }
 
 static int f2fs_ioc_release_volatile_write(struct file *filp)
-- 
2.4.2
