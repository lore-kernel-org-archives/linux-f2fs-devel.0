From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/12] f2fs: introduce f2fs_i_size_write with
	mark_inode_dirty_sync
Date: Tue, 24 May 2016 17:03:28 -0700
Message-ID: <1464134619-37015-2-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIl-0005ez-3h
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:03:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIk-00006Z-1v
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:03:55 +0000
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
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

This patch introduces f2fs_i_size_write() to call mark_inode_dirty_sync() with
i_size_write().

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c     | 10 ++++------
 fs/f2fs/dir.c      |  2 +-
 fs/f2fs/f2fs.h     |  6 ++++++
 fs/f2fs/file.c     | 10 ++++------
 fs/f2fs/inline.c   |  6 +++---
 fs/f2fs/recovery.c |  2 +-
 fs/f2fs/super.c    |  2 +-
 7 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dd46ca8..0dd42b6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -564,7 +564,7 @@ struct page *get_new_data_page(struct inode *inode,
 got_it:
 	if (new_i_size && i_size_read(inode) <
 				((loff_t)(index + 1) << PAGE_SHIFT)) {
-		i_size_write(inode, ((loff_t)(index + 1) << PAGE_SHIFT));
+		f2fs_i_size_write(inode, ((loff_t)(index + 1) << PAGE_SHIFT));
 		/* Only the directory inode sets new_i_size */
 		set_inode_flag(inode, FI_UPDATE_DIR);
 	}
@@ -605,7 +605,7 @@ alloc:
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
 							dn->ofs_in_node;
 	if (i_size_read(dn->inode) < ((loff_t)(fofs + 1) << PAGE_SHIFT))
-		i_size_write(dn->inode,
+		f2fs_i_size_write(dn->inode,
 				((loff_t)(fofs + 1) << PAGE_SHIFT));
 	return 0;
 }
@@ -1711,10 +1711,8 @@ static int f2fs_write_end(struct file *file,
 
 	set_page_dirty(page);
 
-	if (pos + copied > i_size_read(inode)) {
-		i_size_write(inode, pos + copied);
-		mark_inode_dirty(inode);
-	}
+	if (pos + copied > i_size_read(inode))
+		f2fs_i_size_write(inode, pos + copied);
 
 	f2fs_put_page(page, 1);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9fa8d3e..dc4beae 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -686,7 +686,7 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode, struct page *page)
 	drop_nlink(inode);
 	if (S_ISDIR(inode->i_mode)) {
 		drop_nlink(inode);
-		i_size_write(inode, 0);
+		f2fs_i_size_write(inode, 0);
 	}
 	up_write(&F2FS_I(inode)->i_sem);
 	update_inode_page(inode);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9371063..6a5f38b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1556,6 +1556,12 @@ static inline void set_acl_inode(struct inode *inode, umode_t mode)
 	set_inode_flag(inode, FI_ACL_MODE);
 }
 
+static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
+{
+	i_size_write(inode, i_size);
+	mark_inode_dirty_sync(inode);
+}
+
 static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 {
 	if (ri->i_inline & F2FS_INLINE_XATTR)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e68e5ad..d0f4258 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -988,7 +988,7 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 
 	ret = truncate_blocks(inode, new_size, true);
 	if (!ret)
-		i_size_write(inode, new_size);
+		f2fs_i_size_write(inode, new_size);
 
 	return ret;
 }
@@ -1125,8 +1125,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 
 out:
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size) {
-		i_size_write(inode, new_size);
-		mark_inode_dirty(inode);
+		f2fs_i_size_write(inode, new_size);
 		update_inode_page(inode);
 	}
 
@@ -1186,7 +1185,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	truncate_pagecache(inode, offset);
 
 	if (!ret)
-		i_size_write(inode, new_size);
+		f2fs_i_size_write(inode, new_size);
 	return ret;
 }
 
@@ -1235,8 +1234,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size) {
-		i_size_write(inode, new_size);
-		mark_inode_dirty(inode);
+		f2fs_i_size_write(inode, new_size);
 		update_inode_page(inode);
 	}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index c50dee9..7a9bc44 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -340,7 +340,7 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 
 	/* update i_size to MAX_INLINE_DATA */
 	if (i_size_read(inode) < MAX_INLINE_DATA) {
-		i_size_write(inode, MAX_INLINE_DATA);
+		f2fs_i_size_write(inode, MAX_INLINE_DATA);
 		set_inode_flag(inode, FI_UPDATE_DIR);
 	}
 	return 0;
@@ -402,7 +402,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 
 	F2FS_I(dir)->i_current_depth = 1;
 	if (i_size_read(dir) < PAGE_SIZE) {
-		i_size_write(dir, PAGE_SIZE);
+		f2fs_i_size_write(dir, PAGE_SIZE);
 		set_inode_flag(dir, FI_UPDATE_DIR);
 	}
 
@@ -493,7 +493,7 @@ recover:
 	lock_page(ipage);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA);
 	F2FS_I(dir)->i_current_depth = 0;
-	i_size_write(dir, MAX_INLINE_DATA);
+	f2fs_i_size_write(dir, MAX_INLINE_DATA);
 	update_inode(dir, ipage);
 	f2fs_put_page(ipage, 1);
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 3d7216d..2500b6a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -175,7 +175,7 @@ static void recover_inode(struct inode *inode, struct page *page)
 	char *name;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
-	i_size_write(inode, le64_to_cpu(raw->i_size));
+	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
 	inode->i_atime.tv_sec = le64_to_cpu(raw->i_mtime);
 	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
 	inode->i_mtime.tv_sec = le64_to_cpu(raw->i_mtime);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 160b15b..d832bf4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -568,7 +568,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			f2fs_destroy_extent_node(inode);
 
 			sb_start_intwrite(inode->i_sb);
-			i_size_write(inode, 0);
+			f2fs_i_size_write(inode, 0);
 
 			if (F2FS_HAS_BLOCKS(inode))
 				f2fs_truncate(inode, true);
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
