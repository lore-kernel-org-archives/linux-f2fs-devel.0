Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EC7EA3C5E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3BhPqu4JwKTA/nnLnQG8Jox4CMH0bQmWBM6ZQ9jfx3I=; b=gTxauf1w1Nz2TR3s7bWpygj7Ff
	0ymlhjYz07VLgUBmfa+lMRge9uazLPc7e8eWPv1YTJMYv5o76/LikbIIfu2QPlkS6AJSpGbR4UWZF
	XpFGVTeyQho/rR4YWdHhL4HESu0mNr2Z5azd5QyH5zfWduN9aEy0bCNj9oqX/i7NWoEg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wAphh-0007zV-LY;
	Thu, 09 Apr 2026 13:45:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wAphg-0007xo-QB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 13:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U/ohMaZjU2zHUDPmEgeNFfSl/zzaDiJnsoeluFVwqn4=; b=TkS4lIdcmVEyrSUQwz63S8saDz
 UhT9IQd4mrSjB6++YbPd5YzuQKY5WIEGOhJqjG5TahcwlfH2C2H9/wTNJBzdx9zZtiWrCE9euHpmq
 mAvhvC6BvyVYgEEFq0F0BRUVgMS48YkodvyVxxTsgz8IH88tc99AWPp5GUDoQGn16U2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U/ohMaZjU2zHUDPmEgeNFfSl/zzaDiJnsoeluFVwqn4=; b=j
 DAFOYS8Z0nY++kssMs8bXXA33LOufxlYR40zz1KvC3lZvo1o3JsPQPhdXYIPcjUlJmw/kKOIS2cRk
 GO5azwcpIa48yVG3TcLd04b5OgkJdJcJ4Jrkq57kvcJJx6mxMszOQ0nIYWEX2AaNC4E0LFZ3DBWwe
 2q9/+MzKpU7nKdOU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wAphg-0004rx-3T for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 13:45:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B07D44347F;
 Thu,  9 Apr 2026 13:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FA4C4CEF7;
 Thu,  9 Apr 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775742341;
 bh=DCFUYIxfYFbZ4AOYq4SmhJLjLGR+V0S2HKGiUDp8sNA=;
 h=From:To:Cc:Subject:Date:From;
 b=ffrDJRpcdcmc1AclWCdvXl0y8s/EPTjj9EB80ubytkPK7Z8VGX/HjBMYSZFjAX0f8
 0mSxH9jSCJJMfDNFEbPrfmvK6ww4KIsJ9ZGlM4LJ2O4HPkkgz+tGop93bhs/doTdx4
 Kc6eM1vNwrFHIl0eyvp129LnpEpFPVWuP09KVXmoZ3cRHHOXH3Tg213NqCZ6+hYXiv
 JzGQbLDRXBQSH+oS++WagZELwFNgZJpYuBbEJ5kEG6BM3X9gmOIvHR0HHkIsTkEF8A
 kpg+lYFgBPLgJU80pt0WIkBkmMmJG0y3MpnXypQJ91wUMCVcrJ5sL1Bv4awy8ekewQ
 Uvi28G7KOJ90A==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  9 Apr 2026 13:45:38 +0000
Message-ID: <20260409134538.3692605-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
MIME-Version: 1.0
X-Headers-End: 1wAphg-0004rx-3T
Subject: [f2fs-dev] [PATCH] f2fs: another way to set large folio by
 remembering inode number
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Akilesh Kailash <akailash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

enum {
       F2FS_XATTR_FADV_LARGEFOLIO,
};

unsigned int value = BIT(F2FS_XATTR_FADV_LARGEFOLIO);

1. setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
 -> register the inode number for large folio
2. chmod(0400, file)
 -> make Read-Only
3. open()
 -> f2fs_iget() with large folio
4. open(WRITE), mkwrite on mmap, chmod(WRITE)
 -> return error
5. iput() and open()
 -> goto #3
6. unlink
 -> deregister the inode number

Suggested-by: Akilesh Kailash <akailash@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       |  2 +-
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/file.c       | 11 +++++++++--
 fs/f2fs/inode.c      | 19 ++++++++++++++++---
 fs/f2fs/super.c      |  7 +++++++
 fs/f2fs/xattr.c      | 35 ++++++++++++++++++++++++++++++++++-
 fs/f2fs/xattr.h      |  6 ++++++
 8 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 01e1ba77263e..fdd62ddc3ed6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -778,7 +778,7 @@ void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 	__remove_ino_entry(sbi, ino, type);
 }
 
-/* mode should be APPEND_INO, UPDATE_INO or TRANS_DIR_INO */
+/* mode should be APPEND_INO, UPDATE_INO, LARGE_FOLIO_IO, or TRANS_DIR_INO */
 bool f2fs_exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
 {
 	struct inode_management *im = &sbi->im[mode];
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 965d4e6443c6..5e46230398d7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2494,7 +2494,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio;
 
-	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode)) {
 		if (folio)
 			folio_unlock(folio);
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e40b6b2784ee..02bc6eb96a59 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -381,6 +381,7 @@ enum {
 /* for the list of ino */
 enum {
 	ORPHAN_INO,		/* for orphan ino list */
+	LARGE_FOLIO_INO,	/* for large folio case */
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
 	TRANS_DIR_INO,		/* for transactions dir ino list */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c0220cd7b332..64ba900410fc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2068,9 +2068,16 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
-	if (atomic_dec_and_test(&F2FS_I(inode)->open_count))
+	if (atomic_dec_and_test(&F2FS_I(inode)->open_count)) {
 		f2fs_remove_donate_inode(inode);
-
+		/*
+		 * In order to get large folio as soon as possible, let's drop
+		 * inode cache asap. See also f2fs_drop_inode.
+		 */
+		if (f2fs_exist_written_data(F2FS_I_SB(inode),
+					    inode->i_ino, LARGE_FOLIO_INO))
+                       d_drop(filp->f_path.dentry);
+	}
 	/*
 	 * f2fs_release_file is called at every close calls. So we should
 	 * not drop any inmemory pages by close called by other process.
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 89240be8cc59..e100bc5a378c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -565,6 +565,20 @@ static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
 		ino == F2FS_COMPRESS_INO(sbi);
 }
 
+static void f2fs_mapping_set_large_folio(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (f2fs_compressed_file(inode))
+		return;
+	if (f2fs_quota_file(sbi, inode->i_ino))
+		return;
+	if (IS_IMMUTABLE(inode) ||
+	    (f2fs_exist_written_data(sbi, inode->i_ino, LARGE_FOLIO_INO) &&
+	     !(inode->i_mode & S_IWUGO)))
+	    mapping_set_folio_min_order(inode->i_mapping, 0);
+}
+
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -620,9 +634,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &f2fs_file_inode_operations;
 		inode->i_fop = &f2fs_file_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-		if (IS_IMMUTABLE(inode) && !f2fs_compressed_file(inode) &&
-		    !f2fs_quota_file(sbi, inode->i_ino))
-			mapping_set_folio_min_order(inode->i_mapping, 0);
+		f2fs_mapping_set_large_folio(inode);
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &f2fs_dir_inode_operations;
 		inode->i_fop = &f2fs_dir_operations;
@@ -895,6 +907,7 @@ void f2fs_evict_inode(struct inode *inode)
 	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
 	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
+	f2fs_remove_ino_entry(sbi, inode->i_ino, LARGE_FOLIO_INO);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING)) {
 		sb_start_intwrite(inode->i_sb);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ccf806b676f5..f12fb1ccc877 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1844,6 +1844,13 @@ static int f2fs_drop_inode(struct inode *inode)
 			return 1;
 		}
 	}
+	/*
+	 * In order to get large folio as soon as possible, let's drop
+	 * inode cache asap. See also f2fs_release_file.
+	 */
+	if (f2fs_exist_written_data(F2FS_I_SB(inode),
+				    inode->i_ino, LARGE_FOLIO_INO))
+		return 1;
 
 	/*
 	 * This is to avoid a deadlock condition like below.
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 941dc62a6d6f..0c0e44c2dcdd 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -44,6 +44,16 @@ static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
 		kfree(xattr_addr);
 }
 
+static int f2fs_xattr_fadvise_get(struct inode *inode, void *buffer)
+{
+	if (!buffer)
+		goto out;
+	if (mapping_large_folio_support(inode->i_mapping))
+		*((unsigned int *)buffer) |= BIT(F2FS_XATTR_FADV_LARGEFOLIO);
+out:
+	return sizeof(unsigned int);
+}
+
 static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 		struct dentry *unused, struct inode *inode,
 		const char *name, void *buffer, size_t size)
@@ -61,10 +71,29 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 	default:
 		return -EINVAL;
 	}
+	if (handler->flags == F2FS_XATTR_INDEX_USER &&
+	    !strcmp(name, "fadvise"))
+		return f2fs_xattr_fadvise_get(inode, buffer);
+
 	return f2fs_getxattr(inode, handler->flags, name,
 			     buffer, size, NULL);
 }
 
+static int f2fs_xattr_fadvise_set(struct inode *inode, const void *value)
+{
+	unsigned int new_fadvise;
+
+	new_fadvise = *(unsigned int *)value;
+
+	if (new_fadvise & BIT(F2FS_XATTR_FADV_LARGEFOLIO))
+		f2fs_add_ino_entry(F2FS_I_SB(inode),
+				inode->i_ino, LARGE_FOLIO_INO);
+	else
+		f2fs_remove_ino_entry(F2FS_I_SB(inode),
+				inode->i_ino, LARGE_FOLIO_INO);
+	return 0;
+}
+
 static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
 		struct mnt_idmap *idmap,
 		struct dentry *unused, struct inode *inode,
@@ -84,6 +113,10 @@ static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
 	default:
 		return -EINVAL;
 	}
+	if (handler->flags == F2FS_XATTR_INDEX_USER &&
+	    !strcmp(name, "fadvise"))
+		return f2fs_xattr_fadvise_set(inode, value);
+
 	return f2fs_setxattr(inode, handler->flags, name,
 					value, size, NULL, flags);
 }
@@ -842,4 +875,4 @@ int __init f2fs_init_xattr_cache(void)
 void f2fs_destroy_xattr_cache(void)
 {
 	kmem_cache_destroy(inline_xattr_slab);
-}
\ No newline at end of file
+}
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index bce3d93e4755..455f460d014e 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -24,6 +24,7 @@
 #define F2FS_XATTR_REFCOUNT_MAX         1024
 
 /* Name indexes */
+#define F2FS_USER_FADVISE_NAME			"user.fadvise"
 #define F2FS_SYSTEM_ADVISE_NAME			"system.advise"
 #define F2FS_XATTR_INDEX_USER			1
 #define F2FS_XATTR_INDEX_POSIX_ACL_ACCESS	2
@@ -39,6 +40,11 @@
 #define F2FS_XATTR_NAME_ENCRYPTION_CONTEXT	"c"
 #define F2FS_XATTR_NAME_VERITY			"v"
 
+/* used for F2FS_USER_FADVISE_NAME */
+enum {
+	F2FS_XATTR_FADV_LARGEFOLIO,
+};
+
 struct f2fs_xattr_header {
 	__le32  h_magic;        /* magic number for identification */
 	__le32  h_refcount;     /* reference count */
-- 
2.53.0.1213.gd9a14994de-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
