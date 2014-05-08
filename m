From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: use inode_init_owner() to simplify codes
Date: Thu, 08 May 2014 17:09:30 +0800
Message-ID: <000201cf6a9d$5266c3f0$f7344bd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch uses exported inode_init_owner() to simplify codes in
f2fs_new_inode().

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a9409d1..9138c32 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -41,18 +41,9 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	}
 	f2fs_unlock_op(sbi);
 
-	inode->i_uid = current_fsuid();
-
-	if (dir->i_mode & S_ISGID) {
-		inode->i_gid = dir->i_gid;
-		if (S_ISDIR(mode))
-			mode |= S_ISGID;
-	} else {
-		inode->i_gid = current_fsgid();
-	}
+	inode_init_owner(inode, dir, mode);
 
 	inode->i_ino = ino;
-	inode->i_mode = mode;
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_generation = sbi->s_next_generation++;
-- 
1.7.9.5


