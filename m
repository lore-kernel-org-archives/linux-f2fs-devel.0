From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: use inode mutex to keep atomicity of
 f2fs_falloc
Date: Tue, 28 Jan 2014 10:29:26 +0800
Message-ID: <000101cf1bd0$d1f6be70$75e43b50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously without protection of inode mutex, f2fs_falloc and other data
correlated operations will interfere with each other.
So let's use inode mutex to keep atomicity of f2fs_falloc.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 85e91ca..ece380f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -559,6 +559,8 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&inode->i_mutex);
+
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = punch_hole(inode, offset, len);
 	else
@@ -568,6 +570,9 @@ static long f2fs_fallocate(struct file *file, int mode,
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		mark_inode_dirty(inode);
 	}
+
+	mutex_unlock(&inode->i_mutex);
+
 	trace_f2fs_fallocate(inode, mode, offset, len, ret);
 	return ret;
 }
-- 
1.7.9.5
