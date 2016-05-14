From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix incorrect error path handling in f2fs_move_rehashed_dirents
Date: Sat, 14 May 2016 19:03:53 +0800
Message-ID: <20160514110353.31981-2-yuchao0@huawei.com>
References: <20160514110353.31981-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160514110353.31981-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fix two bugs in error path of f2fs_move_rehashed_dirents:
 - release dir's inode page if fail to call kmalloc
 - recover i_current_depth if fail to converting

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inline.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 60ba7ac..a4bb155 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -464,12 +464,15 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 				struct f2fs_inline_dentry *inline_dentry)
 {
 	struct f2fs_inline_dentry *backup_dentry;
+	struct f2fs_inode_info *fi = F2FS_I(dir);
 	int err;
 
 	backup_dentry = f2fs_kmalloc(sizeof(struct f2fs_inline_dentry),
 							GFP_F2FS_ZERO);
-	if (!backup_dentry)
+	if (!backup_dentry) {
+		f2fs_put_page(ipage, 1);
 		return -ENOMEM;
+	}
 
 	memcpy(backup_dentry, inline_dentry, MAX_INLINE_DATA);
 	truncate_inline_inode(ipage, 0);
@@ -483,13 +486,14 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	lock_page(ipage);
 
 	stat_dec_inline_dir(dir);
-	clear_inode_flag(F2FS_I(dir), FI_INLINE_DENTRY);
+	clear_inode_flag(fi, FI_INLINE_DENTRY);
 	update_inode(dir, ipage);
 	kfree(backup_dentry);
 	return 0;
 recover:
 	lock_page(ipage);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA);
+	fi->i_current_depth = 0;
 	i_size_write(dir, MAX_INLINE_DATA);
 	update_inode(dir, ipage);
 	f2fs_put_page(ipage, 1);
-- 
2.8.2.311.gee88674
