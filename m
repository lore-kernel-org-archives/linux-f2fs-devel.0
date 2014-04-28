From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 2/2] f2fs: readahead multi pages of directory for
 performance
Date: Mon, 28 Apr 2014 17:59:43 +0800
Message-ID: <000601cf62c8$ae9a4200$0bcec600$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We have no so such readahead mechanism in ->iterate() path as the one in
->read() path, it cause low performance when we read large directory.
This patch add readahead in f2fs_readdir() for better performance.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c  |    6 ++++++
 fs/f2fs/f2fs.h |    2 ++
 2 files changed, 8 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 972fd0e..3581c2b 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -637,11 +637,17 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	struct f2fs_dentry_block *dentry_blk = NULL;
 	struct f2fs_dir_entry *de = NULL;
 	struct page *dentry_page = NULL;
+	struct file_ra_state *ra = &file->f_ra;
 	unsigned int n = ((unsigned long)ctx->pos / NR_DENTRY_IN_BLOCK);
 	unsigned char d_type = DT_UNKNOWN;
 
 	bit_pos = ((unsigned long)ctx->pos % NR_DENTRY_IN_BLOCK);
 
+	/* readahead for multi pages of dir */
+	if (npages - n > 1 && !ra_has_index(ra, n))
+		page_cache_sync_readahead(inode->i_mapping, ra, file, n,
+				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
+
 	for (; n < npages; n++) {
 		dentry_page = get_lock_data_page(inode, n);
 		if (IS_ERR(dentry_page))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e77be7c..2b67679 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -182,6 +182,8 @@ enum {
 
 #define F2FS_LINK_MAX		32000	/* maximum link count per file */
 
+#define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
+
 /* for in-memory extent cache entry */
 #define F2FS_MIN_EXTENT_LEN	16	/* minimum extent length */
 
-- 
1.7.9.5


