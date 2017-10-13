From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/5] f2fs: trace f2fs_lookup
Date: Fri, 13 Oct 2017 18:01:32 +0800
Message-ID: <20171013100136.35212-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds trace for f2fs_lookup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c             | 42 ++++++++++++++++++++++------------
 include/trace/events/f2fs.h | 56 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b6455b7ca00f..3aaf273aa97d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -337,12 +337,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	struct f2fs_dir_entry *de;
 	struct page *page;
-	nid_t ino;
+	nid_t ino = -1;
 	int err = 0;
 	unsigned int root_ino = F2FS_ROOT_INO(F2FS_I_SB(dir));
 
+	trace_f2fs_lookup_start(dir, dentry, flags);
+
 	if (f2fs_encrypted_inode(dir)) {
-		int res = fscrypt_get_encryption_info(dir);
+		err = fscrypt_get_encryption_info(dir);
 
 		/*
 		 * DCACHE_ENCRYPTED_WITH_KEY is set if the dentry is
@@ -352,18 +354,22 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		if (fscrypt_has_encryption_key(dir))
 			fscrypt_set_encrypted_dentry(dentry);
 		fscrypt_set_d_op(dentry);
-		if (res && res != -ENOKEY)
-			return ERR_PTR(res);
+		if (err && err != -ENOKEY)
+			goto out;
 	}
 
-	if (dentry->d_name.len > F2FS_NAME_LEN)
-		return ERR_PTR(-ENAMETOOLONG);
+	if (dentry->d_name.len > F2FS_NAME_LEN) {
+		err = -ENAMETOOLONG;
+		goto out;
+	}
 
 	de = f2fs_find_entry(dir, &dentry->d_name, &page);
 	if (!de) {
-		if (IS_ERR(page))
-			return (struct dentry *)page;
-		return d_splice_alias(inode, dentry);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
+			goto out;
+		}
+		goto out_splice;
 	}
 
 	ino = le32_to_cpu(de->ino);
@@ -371,19 +377,21 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	f2fs_put_page(page, 0);
 
 	inode = f2fs_iget(dir->i_sb, ino);
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto out;
+	}
 
 	if ((dir->i_ino == root_ino) && f2fs_has_inline_dots(dir)) {
 		err = __recover_dot_dentries(dir, root_ino);
 		if (err)
-			goto err_out;
+			goto out_iput;
 	}
 
 	if (f2fs_has_inline_dots(inode)) {
 		err = __recover_dot_dentries(inode, dir->i_ino);
 		if (err)
-			goto err_out;
+			goto out_iput;
 	}
 	if (f2fs_encrypted_inode(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
@@ -392,12 +400,16 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 			 "Inconsistent encryption contexts: %lu/%lu",
 			 dir->i_ino, inode->i_ino);
 		err = -EPERM;
-		goto err_out;
+		goto out_iput;
 	}
+out_splice:
+	trace_f2fs_lookup_end(dir, dentry, ino, 0);
 	return d_splice_alias(inode, dentry);
 
-err_out:
+out_iput:
 	iput(inode);
+out:
+	trace_f2fs_lookup_end(dir, dentry, ino, err);
 	return ERR_PTR(err);
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 407713ef5981..df9dd1b62820 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -728,6 +728,62 @@ TRACE_EVENT(f2fs_get_victim,
 		__entry->free)
 );
 
+TRACE_EVENT(f2fs_lookup_start,
+
+	TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
+
+	TP_ARGS(dir, dentry, flags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(const char *,	name)
+		__field(unsigned int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= dir->i_sb->s_dev;
+		__entry->ino	= dir->i_ino;
+		__entry->name	= dentry->d_name.name;
+		__entry->flags	= flags;
+	),
+
+	TP_printk("dev = (%d,%d), pino = %lu, name:%s, flags:%u",
+		show_dev_ino(__entry),
+		__entry->name,
+		__entry->flags)
+);
+
+TRACE_EVENT(f2fs_lookup_end,
+
+	TP_PROTO(struct inode *dir, struct dentry *dentry, nid_t ino,
+		int err),
+
+	TP_ARGS(dir, dentry, ino, err),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(const char *,	name)
+		__field(ino_t,	cino)
+		__field(int,	err)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= dir->i_sb->s_dev;
+		__entry->ino	= dir->i_ino;
+		__entry->name	= dentry->d_name.name;
+		__entry->cino	= ino;
+		__entry->err	= err;
+	),
+
+	TP_printk("dev = (%d,%d), pino = %lu, name:%s, ino:%lu, err:%d",
+		show_dev_ino(__entry),
+		__entry->name,
+		__entry->cino,
+		__entry->err)
+);
+
 TRACE_EVENT(f2fs_fallocate,
 
 	TP_PROTO(struct inode *inode, int mode,
-- 
2.13.1.388.g69e6b9b4f4a9
