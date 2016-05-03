From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/11] f2fs: introduce f2fs_kmalloc to wrap
	kmalloc
Date: Tue,  3 May 2016 11:21:40 -0700
Message-ID: <1462299708-67906-3-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexO-0008TN-GA
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexN-0007El-K4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:02 +0000
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds f2fs_kmalloc.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/acl.c    | 4 ++--
 fs/f2fs/dir.c    | 2 +-
 fs/f2fs/f2fs.h   | 5 +++++
 fs/f2fs/gc.c     | 2 +-
 fs/f2fs/inline.c | 2 +-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index c8f25f7..d757d79 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -115,7 +115,7 @@ static void *f2fs_acl_to_disk(const struct posix_acl *acl, size_t *size)
 	struct f2fs_acl_entry *entry;
 	int i;
 
-	f2fs_acl = kmalloc(sizeof(struct f2fs_acl_header) + acl->a_count *
+	f2fs_acl = f2fs_kmalloc(sizeof(struct f2fs_acl_header) + acl->a_count *
 			sizeof(struct f2fs_acl_entry), GFP_NOFS);
 	if (!f2fs_acl)
 		return ERR_PTR(-ENOMEM);
@@ -175,7 +175,7 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
 
 	retval = f2fs_getxattr(inode, name_index, "", NULL, 0, dpage);
 	if (retval > 0) {
-		value = kmalloc(retval, GFP_F2FS_ZERO);
+		value = f2fs_kmalloc(retval, GFP_F2FS_ZERO);
 		if (!value)
 			return ERR_PTR(-ENOMEM);
 		retval = f2fs_getxattr(inode, name_index, "", value,
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index dbfc1d1..6bd0595 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -805,7 +805,7 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int save_len = fstr->len;
 			int ret;
 
-			de_name.name = kmalloc(de_name.len, GFP_NOFS);
+			de_name.name = f2fs_kmalloc(de_name.len, GFP_NOFS);
 			if (!de_name.name)
 				return false;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 38aa75c..364d5fd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1643,6 +1643,11 @@ static inline bool f2fs_may_extent_tree(struct inode *inode)
 	return S_ISREG(inode->i_mode);
 }
 
+static inline void *f2fs_kmalloc(size_t size, gfp_t flags)
+{
+	return kmalloc(size, flags);
+}
+
 static inline void *f2fs_kvmalloc(size_t size, gfp_t flags)
 {
 	void *ret;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 19e9faf..38d56f6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -96,7 +96,7 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	int err = 0;
 
-	gc_th = kmalloc(sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
+	gc_th = f2fs_kmalloc(sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
 	if (!gc_th) {
 		err = -ENOMEM;
 		goto out;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e61084c..33830b2 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -465,7 +465,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	struct f2fs_inline_dentry *backup_dentry;
 	int err;
 
-	backup_dentry = kmalloc(sizeof(struct f2fs_inline_dentry),
+	backup_dentry = f2fs_kmalloc(sizeof(struct f2fs_inline_dentry),
 							GFP_F2FS_ZERO);
 	if (!backup_dentry)
 		return -ENOMEM;
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
