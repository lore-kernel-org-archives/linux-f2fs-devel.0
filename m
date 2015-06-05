From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: do not trim preallocated blocks when truncating after
 i_size
Date: Fri, 05 Jun 2015 18:34:02 +0800
Message-ID: <000101d09f7b$4a2559e0$de700da0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When we perform generic/092 in xfstests, output is like below:

     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     0: [0..10239]: data
     0: [0..10239]: data
    -1: [10240..20479]: unwritten
    +1: [10240..14335]: unwritten

This is because with this testcase, we redefine the regulation for
truncate in perallocated space past i_size as below:

"There was some confused about what the fs was supposed to do when you
truncate at i_size with preallocated space past i_size. We decided on the
following things.

1) truncate(i_size) will trim all blocks past i_size.
2) truncate(x) where x > i_size will not trim all blocks past i_size.
"

This method is used in xfs, and then ext4/btrfs will follow the rule.

This patch fixes to follow the new rule for f2fs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4d42d66..85f97af 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -651,16 +651,16 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 				f2fs_get_encryption_info(inode))
 			return -EACCES;
 
-		if (attr->ia_size != i_size_read(inode)) {
+		if (attr->ia_size <= i_size_read(inode)) {
 			truncate_setsize(inode, attr->ia_size);
 			f2fs_truncate(inode);
 			f2fs_balance_fs(F2FS_I_SB(inode));
 		} else {
 			/*
-			 * giving a chance to truncate blocks past EOF which
-			 * are fallocated with FALLOC_FL_KEEP_SIZE.
+			 * do not trim all blocks after i_size if target size is
+			 * larger than i_size.
 			 */
-			f2fs_truncate(inode);
+			truncate_setsize(inode, attr->ia_size);
 		}
 	}
 
-- 
2.4.2
