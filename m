From: Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: no need to take page lock in readdir
Date: Thu, 21 Feb 2019 12:57:35 +0800
Message-ID: <20190221045735.45419-1-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

VFS will take inode_lock for readdir, therefore no need to
take page lock in readdir at all just as the majority of
other generic filesystems.

This patch improves concurrency since .iterate_shared
was introduced to VFS years ago.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

 personally tend to use read_mapping_page here, but it seems
 that f2fs has some remaining customized code since it was
 merged into Linux, use f2fs_find_data_page instead.

 fs/f2fs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ecc3a4e2be96..64602bc1e092 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -873,7 +873,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 			page_cache_sync_readahead(inode->i_mapping, ra, file, n,
 				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
 
-		dentry_page = f2fs_get_lock_data_page(inode, n, false);
+		dentry_page = f2fs_find_data_page(inode, n);
 		if (IS_ERR(dentry_page)) {
 			err = PTR_ERR(dentry_page);
 			if (err == -ENOENT) {
@@ -891,11 +891,11 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		err = f2fs_fill_dentries(ctx, &d,
 				n * NR_DENTRY_IN_BLOCK, &fstr);
 		if (err) {
-			f2fs_put_page(dentry_page, 1);
+			f2fs_put_page(dentry_page, 0);
 			break;
 		}
 
-		f2fs_put_page(dentry_page, 1);
+		f2fs_put_page(dentry_page, 0);
 	}
 out_free:
 	fscrypt_fname_free_buffer(&fstr);
-- 
2.14.4
