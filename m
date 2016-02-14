From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 6/7] f2fs crypto: make sure the encryption info is initialized
 on opendir(2)
Date: Sun, 14 Feb 2016 18:56:55 +0800
Message-ID: <00ff01d16716$85cf93d0$916ebb70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, tytso@mit.edu
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch syncs f2fs with commit 6bc445e0ff44 ("ext4 crypto: make
sure the encryption info is initialized on opendir(2)") from ext4.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ca41b2a..8f09da0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -902,11 +902,19 @@ out:
 	return err;
 }
 
+static int f2fs_dir_open(struct inode *inode, struct file *filp)
+{
+	if (f2fs_encrypted_inode(inode))
+		return f2fs_get_encryption_info(inode) ? -EACCES : 0;
+	return 0;
+}
+
 const struct file_operations f2fs_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate	= f2fs_readdir,
 	.fsync		= f2fs_sync_file,
+	.open		= f2fs_dir_open,
 	.unlocked_ioctl	= f2fs_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = f2fs_compat_ioctl,
-- 
2.7.0.2.g1b0b6dd
