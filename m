From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to stop recovering dot dentries in a readonly fs
Date: Mon, 28 Dec 2015 18:12:45 +0800
Message-ID: <006f01d14158$63fa4a90$2beedfb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If filesystem is readonly, don't recover inline dot inode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5cc4128..b4a5836 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -269,7 +269,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	if (f2fs_has_inline_dots(inode)) {
+	if (f2fs_has_inline_dots(inode) && !f2fs_readonly(dir->i_sb)) {
 		err = __recover_dot_dentries(inode, dir->i_ino);
 		if (err)
 			goto err_out;
-- 
2.6.3
