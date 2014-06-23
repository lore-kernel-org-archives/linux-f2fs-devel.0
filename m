From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: clean up an unused parameter and
	assignment
Date: Mon, 23 Jun 2014 10:12:56 +0900
Message-ID: <1403485976-29398-2-git-send-email-jaegeuk@kernel.org>
References: <1403485976-29398-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Wysot-0005zL-BA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jun 2014 01:13:15 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wysos-0000Tt-HJ for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jun 2014 01:13:15 +0000
In-Reply-To: <1403485976-29398-1-git-send-email-jaegeuk@kernel.org>
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

This patch cleans up simple unnecessary codes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c   |  2 +-
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/namei.c | 26 +++++++++-----------------
 fs/f2fs/node.c  |  2 +-
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index fe6aaca..1983c99 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -338,7 +338,7 @@ static struct page *init_inode_metadata(struct inode *inode,
 	int err;
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
-		page = new_inode_page(inode, name);
+		page = new_inode_page(inode);
 		if (IS_ERR(page))
 			return page;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ca421a8..3f0291b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1174,7 +1174,7 @@ int truncate_inode_blocks(struct inode *, pgoff_t);
 int truncate_xattr_node(struct inode *, struct page *);
 int wait_on_node_pages_writeback(struct f2fs_sb_info *, nid_t);
 void remove_inode_page(struct inode *);
-struct page *new_inode_page(struct inode *, const struct qstr *);
+struct page *new_inode_page(struct inode *);
 struct page *new_node_page(struct dnode_of_data *, unsigned int, struct page *);
 void ra_node_page(struct f2fs_sb_info *, nid_t);
 struct page *get_node_page(struct f2fs_sb_info *, pgoff_t);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 9de4ab3..d1f7c20 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -23,14 +23,13 @@
 
 static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	nid_t ino;
 	struct inode *inode;
 	bool nid_free = false;
 	int err;
 
-	inode = new_inode(sb);
+	inode = new_inode(dir->i_sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
@@ -103,8 +102,7 @@ static inline void set_cold_files(struct f2fs_sb_info *sbi, struct inode *inode,
 static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 						bool excl)
 {
-	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct inode *inode;
 	nid_t ino = 0;
 	int err;
@@ -147,8 +145,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 		struct dentry *dentry)
 {
 	struct inode *inode = old_dentry->d_inode;
-	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	int err;
 
 	f2fs_balance_fs(sbi);
@@ -208,8 +205,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 
 static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct inode *inode = dentry->d_inode;
 	struct f2fs_dir_entry *de;
 	struct page *page;
@@ -243,8 +239,7 @@ fail:
 static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 					const char *symname)
 {
-	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct inode *inode;
 	size_t symlen = strlen(symname) + 1;
 	int err;
@@ -331,8 +326,7 @@ static int f2fs_rmdir(struct inode *dir, struct dentry *dentry)
 static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 				umode_t mode, dev_t rdev)
 {
-	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct inode *inode;
 	int err = 0;
 
@@ -370,8 +364,7 @@ out:
 static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct super_block *sb = old_dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(old_dir->i_sb);
 	struct inode *old_inode = old_dentry->d_inode;
 	struct inode *new_inode = new_dentry->d_inode;
 	struct page *old_dir_page;
@@ -491,8 +484,7 @@ out:
 
 static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct inode *inode;
 	int err;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9dfb9a0..771a8ac 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -843,7 +843,7 @@ void remove_inode_page(struct inode *inode)
 	truncate_node(&dn);
 }
 
-struct page *new_inode_page(struct inode *inode, const struct qstr *name)
+struct page *new_inode_page(struct inode *inode)
 {
 	struct dnode_of_data dn;
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
