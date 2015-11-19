From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to report error in f2fs_readdir
Date: Thu, 19 Nov 2015 16:09:07 +0800
Message-ID: <00a201d122a1$a879f920$f96deb60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

get_lock_data_page in f2fs_readdir can fail due to a lot of reasons (i.e.
no memory or IO error...), it's better to report this kind of error to
user rather than ignoring it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c2b330f..f1de7ee 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -855,8 +855,13 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 
 	for (; n < npages; n++) {
 		dentry_page = get_lock_data_page(inode, n, false);
-		if (IS_ERR(dentry_page))
-			continue;
+		if (IS_ERR(dentry_page)) {
+			err = PTR_ERR(dentry_page);
+			if (err == -ENOENT)
+				continue;
+			else
+				goto out;
+		}
 
 		dentry_blk = kmap(dentry_page);
 
-- 
2.6.3
