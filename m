From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: detect error of update_dent_inode in ->rename
Date: Wed, 17 Feb 2016 16:45:44 +0800
Message-ID: <016f01d1695f$af48abc0$0dda0340$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Should check and show correct return value of update_dent_inode in
->rename.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6f944e5..99ed009 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -654,8 +654,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (err)
 			goto put_out_dir;
 
-		if (update_dent_inode(old_inode, new_inode,
-						&new_dentry->d_name)) {
+		err = update_dent_inode(old_inode, new_inode,
+						&new_dentry->d_name);
+		if (err) {
 			release_orphan_inode(sbi);
 			goto put_out_dir;
 		}
-- 
2.7.0
