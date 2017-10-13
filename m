From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: trace f2fs_readdir
Date: Fri, 13 Oct 2017 18:01:33 +0800
Message-ID: <20171013100136.35212-2-yuchao0@huawei.com>
References: <20171013100136.35212-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e2wnC-00028j-2d
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 10:02:10 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e2wn6-0004oh-4r
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 10:02:10 +0000
In-Reply-To: <20171013100136.35212-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds trace for f2fs_readdir.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c               | 14 +++++++++-----
 include/trace/events/f2fs.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c0c933ad43c8..148927f5bc93 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -14,6 +14,7 @@
 #include "node.h"
 #include "acl.h"
 #include "xattr.h"
+#include <trace/events/f2fs.h>
 
 static unsigned long dir_blocks(struct inode *inode)
 {
@@ -847,6 +848,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	struct f2fs_dentry_block *dentry_blk = NULL;
 	struct page *dentry_page = NULL;
 	struct file_ra_state *ra = &file->f_ra;
+	loff_t start_pos = ctx->pos;
 	unsigned int n = ((unsigned long)ctx->pos / NR_DENTRY_IN_BLOCK);
 	struct f2fs_dentry_ptr d;
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
@@ -855,16 +857,16 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	if (f2fs_encrypted_inode(inode)) {
 		err = fscrypt_get_encryption_info(inode);
 		if (err && err != -ENOKEY)
-			return err;
+			goto out;
 
 		err = fscrypt_fname_alloc_buffer(inode, F2FS_NAME_LEN, &fstr);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
 	if (f2fs_has_inline_dentry(inode)) {
 		err = f2fs_read_inline_dir(file, ctx, &fstr);
-		goto out;
+		goto out_free;
 	}
 
 	/* readahead for multi pages of dir */
@@ -880,7 +882,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 				err = 0;
 				continue;
 			} else {
-				goto out;
+				goto out_free;
 			}
 		}
 
@@ -900,8 +902,10 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		kunmap(dentry_page);
 		f2fs_put_page(dentry_page, 1);
 	}
-out:
+out_free:
 	fscrypt_fname_free_buffer(&fstr);
+out:
+	trace_f2fs_readdir(inode, start_pos, ctx->pos, err);
 	return err < 0 ? err : 0;
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index df9dd1b62820..6c4dbcc2ee3d 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -784,6 +784,35 @@ TRACE_EVENT(f2fs_lookup_end,
 		__entry->err)
 );
 
+TRACE_EVENT(f2fs_readdir,
+
+	TP_PROTO(struct inode *dir, loff_t start_pos, loff_t end_pos, int err),
+
+	TP_ARGS(dir, start_pos, end_pos, err),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t,	start)
+		__field(loff_t,	end)
+		__field(int,	err)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= dir->i_sb->s_dev;
+		__entry->ino	= dir->i_ino;
+		__entry->start	= start_pos;
+		__entry->end	= end_pos;
+		__entry->err	= err;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, start_pos:%llu, end_pos:%llu, err:%d",
+		show_dev_ino(__entry),
+		__entry->start,
+		__entry->end,
+		__entry->err)
+);
+
 TRACE_EVENT(f2fs_fallocate,
 
 	TP_PROTO(struct inode *inode, int mode,
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
