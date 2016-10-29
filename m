From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: report error of f2fs_fill_dentries
Date: Sat, 29 Oct 2016 18:46:34 +0800
Message-ID: <20161029104634.8959-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c0RAc-0008BH-1U
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 29 Oct 2016 10:47:26 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c0RAW-0001or-Bk
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 29 Oct 2016 10:47:26 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Report error of f2fs_fill_dentries to ->iterate_shared, otherwise when
error ocurrs, user may just list part of dirents in target directory
without any hints.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c    | 21 ++++++++++++---------
 fs/f2fs/f2fs.h   |  2 +-
 fs/f2fs/inline.c |  6 ++++--
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f3a4fce..bdee449 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -785,7 +785,7 @@ bool f2fs_empty_dir(struct inode *dir)
 	return true;
 }
 
-bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
+int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr)
 {
 	unsigned char d_type = DT_UNKNOWN;
@@ -820,7 +820,7 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 						(u32)de->hash_code, 0,
 						&de_name, fstr);
 			if (err)
-				return true;
+				return err;
 
 			de_name = *fstr;
 			fstr->len = save_len;
@@ -828,12 +828,12 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 
 		if (!dir_emit(ctx, de_name.name, de_name.len,
 					le32_to_cpu(de->ino), d_type))
-			return true;
+			return 1;
 
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
 	}
-	return false;
+	return 0;
 }
 
 static int f2fs_readdir(struct file *file, struct dir_context *ctx)
@@ -872,17 +872,21 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		dentry_page = get_lock_data_page(inode, n, false);
 		if (IS_ERR(dentry_page)) {
 			err = PTR_ERR(dentry_page);
-			if (err == -ENOENT)
+			if (err == -ENOENT) {
+				err = 0;
 				continue;
-			else
+			} else {
 				goto out;
+			}
 		}
 
 		dentry_blk = kmap(dentry_page);
 
 		make_dentry_ptr(inode, &d, (void *)dentry_blk, 1);
 
-		if (f2fs_fill_dentries(ctx, &d, n * NR_DENTRY_IN_BLOCK, &fstr)) {
+		err = f2fs_fill_dentries(ctx, &d,
+				n * NR_DENTRY_IN_BLOCK, &fstr);
+		if (err) {
 			kunmap(dentry_page);
 			f2fs_put_page(dentry_page, 1);
 			break;
@@ -892,10 +896,9 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		kunmap(dentry_page);
 		f2fs_put_page(dentry_page, 1);
 	}
-	err = 0;
 out:
 	fscrypt_fname_free_buffer(&fstr);
-	return err;
+	return err < 0 ? err : 0;
 }
 
 static int f2fs_dir_open(struct inode *inode, struct file *filp)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a3d9db4..df0dbb3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2034,7 +2034,7 @@ void set_de_type(struct f2fs_dir_entry *, umode_t);
 unsigned char get_de_type(struct f2fs_dir_entry *);
 struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *,
 			f2fs_hash_t, int *, struct f2fs_dentry_ptr *);
-bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
+int f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
 			unsigned int, struct fscrypt_str *);
 void do_make_empty_dir(struct inode *, struct inode *,
 			struct f2fs_dentry_ptr *);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index def731a..71d4842 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -612,6 +612,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	struct f2fs_inline_dentry *inline_dentry = NULL;
 	struct page *ipage = NULL;
 	struct f2fs_dentry_ptr d;
+	int err;
 
 	if (ctx->pos == NR_INLINE_DENTRY)
 		return 0;
@@ -624,11 +625,12 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 
 	make_dentry_ptr(inode, &d, (void *)inline_dentry, 2);
 
-	if (!f2fs_fill_dentries(ctx, &d, 0, fstr))
+	err = f2fs_fill_dentries(ctx, &d, 0, fstr);
+	if (!err)
 		ctx->pos = NR_INLINE_DENTRY;
 
 	f2fs_put_page(ipage, 1);
-	return 0;
+	return err < 0 ? err : 0;
 }
 
 int f2fs_inline_data_fiemap(struct inode *inode,
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik
