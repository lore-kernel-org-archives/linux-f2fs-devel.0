From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: reserve space for tmpfile
Date: Mon, 18 May 2015 13:55:53 +0800
Message-ID: <002f01d0912f$67182370$35486a50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add missed f2fs_balance_fs to reserve space for ->tmpfile.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bed0cb0..38a783e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -517,6 +517,9 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int err;
 
+	if (!whiteout)
+		f2fs_balance_fs(sbi);
+
 	inode = f2fs_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
-- 
2.3.3
