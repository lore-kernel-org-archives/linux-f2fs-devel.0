From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: clear FI_DATA_EXIST flag in
	truncate_inline_inode
Date: Fri, 10 Mar 2017 20:43:20 +0800
Message-ID: <334a8de3-5119-37b5-08ac-f7843d1fe4b2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cmJtP-0007oF-4v
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 12:43:35 +0000
Received: from mail-io0-f195.google.com ([209.85.223.195])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cmJtO-00085H-9l
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 12:43:35 +0000
Received: by mail-io0-f195.google.com with SMTP id n76so6794501ioe.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 10 Mar 2017 04:43:34 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Clear FI_DATA_EXIST flag atomically in truncate_inline_inode, and
the return value from truncate_inline_inode isn't used, remove it.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/f2fs.h   |  8 +-------
 fs/f2fs/file.c   |  4 +---
 fs/f2fs/inline.c | 21 +++++++++++----------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5dbc0c0..ee68144 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1872,12 +1872,6 @@ static inline int f2fs_has_inline_data(struct inode *inode)
 	return is_inode_flag_set(inode, FI_INLINE_DATA);
 }
 
-static inline void f2fs_clear_inline_inode(struct inode *inode)
-{
-	clear_inode_flag(inode, FI_INLINE_DATA);
-	clear_inode_flag(inode, FI_DATA_EXIST);
-}
-
 static inline int f2fs_exist_data(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_DATA_EXIST);
@@ -2504,7 +2498,7 @@ extern struct kmem_cache *inode_entry_slab;
 bool f2fs_may_inline_data(struct inode *inode);
 bool f2fs_may_inline_dentry(struct inode *inode);
 void read_inline_data(struct page *page, struct page *ipage);
-bool truncate_inline_inode(struct page *ipage, u64 from);
+void truncate_inline_inode(struct inode *inode, struct page *ipage, u64 from);
 int f2fs_read_inline_data(struct inode *inode, struct page *page);
 int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page);
 int f2fs_convert_inline_inode(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c407fa6..da6d33d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -561,9 +561,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	}
 
 	if (f2fs_has_inline_data(inode)) {
-		truncate_inline_inode(ipage, from);
-		if (from == 0)
-			clear_inode_flag(inode, FI_DATA_EXIST);
+		truncate_inline_inode(inode, ipage, from);
 		f2fs_put_page(ipage, 1);
 		truncate_page = true;
 		goto out;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 41fe27d..701bbd8 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -63,19 +63,21 @@ void read_inline_data(struct page *page, struct page *ipage)
 		SetPageUptodate(page);
 }
 
-bool truncate_inline_inode(struct page *ipage, u64 from)
+void truncate_inline_inode(struct inode *inode, struct page *ipage, u64 from)
 {
 	void *addr;
 
 	if (from >= MAX_INLINE_DATA)
-		return false;
+		return;
 
 	addr = inline_data_addr(ipage);
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memset(addr + from, 0, MAX_INLINE_DATA - from);
 	set_page_dirty(ipage);
-	return true;
+
+	if (from == 0)
+		clear_inode_flag(inode, FI_DATA_EXIST);
 }
 
 int f2fs_read_inline_data(struct inode *inode, struct page *page)
@@ -146,11 +148,11 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	set_inode_flag(dn->inode, FI_APPEND_WRITE);
 
 	/* clear inline data and flag after data writeback */
-	truncate_inline_inode(dn->inode_page, 0);
+	truncate_inline_inode(dn->inode, dn->inode_page, 0);
 	clear_inline_node(dn->inode_page);
 clear_out:
 	stat_dec_inline_inode(dn->inode);
-	f2fs_clear_inline_inode(dn->inode);
+	clear_inode_flag(dn->inode, FI_INLINE_DATA);
 	f2fs_put_dnode(dn);
 	return 0;
 }
@@ -267,9 +269,8 @@ bool recover_inline_data(struct inode *inode, struct page *npage)
 	if (f2fs_has_inline_data(inode)) {
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
-		if (!truncate_inline_inode(ipage, 0))
-			return false;
-		f2fs_clear_inline_inode(inode);
+		truncate_inline_inode(inode, ipage, 0);
+		clear_inode_flag(inode, FI_INLINE_DATA);
 		f2fs_put_page(ipage, 1);
 	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
 		if (truncate_blocks(inode, 0, false))
@@ -380,7 +381,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	set_page_dirty(page);
 
 	/* clear inline dir and flag after data writeback */
-	truncate_inline_inode(ipage, 0);
+	truncate_inline_inode(dir, ipage, 0);
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
@@ -455,7 +456,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	}
 
 	memcpy(backup_dentry, inline_dentry, MAX_INLINE_DATA);
-	truncate_inline_inode(ipage, 0);
+	truncate_inline_inode(dir, ipage, 0);
 
 	unlock_page(ipage);
 
-- 
2.9.3


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
