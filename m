From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: clean up error path in f2fs_readdir
Date: Tue, 01 Dec 2015 11:41:50 +0800
Message-ID: <000101d12bea$4ea0d5c0$ebe28140$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

No logic changes, just clean up the error path.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9de898d..6554fd5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -867,18 +867,15 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 
 		make_dentry_ptr(inode, &d, (void *)dentry_blk, 1);
 
-		if (f2fs_fill_dentries(ctx, &d, n * NR_DENTRY_IN_BLOCK, &fstr))
-			goto stop;
+		if (f2fs_fill_dentries(ctx, &d, n * NR_DENTRY_IN_BLOCK, &fstr)) {
+			kunmap(dentry_page);
+			f2fs_put_page(dentry_page, 1);
+			break;
+		}
 
 		ctx->pos = (n + 1) * NR_DENTRY_IN_BLOCK;
 		kunmap(dentry_page);
 		f2fs_put_page(dentry_page, 1);
-		dentry_page = NULL;
-	}
-stop:
-	if (dentry_page && !IS_ERR(dentry_page)) {
-		kunmap(dentry_page);
-		f2fs_put_page(dentry_page, 1);
 	}
 out:
 	f2fs_fname_crypto_free_buffer(&fstr);
-- 
2.6.3
