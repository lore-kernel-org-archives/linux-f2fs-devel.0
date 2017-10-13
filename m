From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: relocate readahead codes in readdir()
Date: Fri, 13 Oct 2017 18:01:35 +0800
Message-ID: <20171013100136.35212-4-yuchao0@huawei.com>
References: <20171013100136.35212-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171013100136.35212-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, for large directory, we just do readahead only once in
readdir(), readdir()'s performance may drop when traversing latter
blocks. In order to avoid this, relocate readahead codes to covering
all traverse flow.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 1ebd206a4085..14646440b662 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -870,11 +870,6 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		goto out_free;
 	}
 
-	/* readahead for multi pages of dir */
-	if (npages - n > 1 && !ra_has_index(ra, n))
-		page_cache_sync_readahead(inode->i_mapping, ra, file, n,
-				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
-
 	for (; n < npages; n++) {
 
 		/* allow readdir() to be interrupted */
@@ -884,6 +879,11 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		}
 		cond_resched();
 
+		/* readahead for multi pages of dir */
+		if (npages - n > 1 && !ra_has_index(ra, n))
+			page_cache_sync_readahead(inode->i_mapping, ra, file, n,
+				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
+
 		dentry_page = get_lock_data_page(inode, n, false);
 		if (IS_ERR(dentry_page)) {
 			err = PTR_ERR(dentry_page);
-- 
2.13.1.388.g69e6b9b4f4a9
