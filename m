From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/3] f2fs: remove costly dirty_dir_inode
	operations
Date: Tue, 15 Apr 2014 19:57:01 +0900
Message-ID: <1397559423-27411-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wa15A-0001g4-W3
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 10:59:17 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wa158-0001mu-R2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 10:59:16 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N420024GJUI6P60@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 19:59:06 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch removes list opeations in handling dirty dir inodes.
Previously, F2FS traverses whole the list of dirty dir inodes to check whether
there is an existing inode or not, resulting in heavy CPU overheads.

So this patch removes such the traverse operations by adding FI_DIRTY_DIR to
indicate the inode lies on the list or not.
Through this simple flag, we can remove redundant operations gracefully.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 52 +++++++++++++---------------------------------------
 fs/f2fs/f2fs.h       |  3 ++-
 fs/f2fs/recovery.c   | 18 ++++++++++--------
 3 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 890e23d..5133aec 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -555,14 +555,13 @@ fail_no_cp:
 static int __add_dirty_inode(struct inode *inode, struct dir_inode_entry *new)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-	struct list_head *head = &sbi->dir_inode_list;
-	struct dir_inode_entry *entry;
 
-	list_for_each_entry(entry, head, list)
-		if (unlikely(entry->inode == inode))
-			return -EEXIST;
+	if (is_inode_flag_set(F2FS_I(inode), FI_DIRTY_DIR))
+		return -EEXIST;
 
-	list_add_tail(&new->list, head);
+	set_inode_flag(F2FS_I(inode), FI_DIRTY_DIR);
+	F2FS_I(inode)->dirty_dir = new;
+	list_add_tail(&new->list, &sbi->dir_inode_list);
 	stat_inc_dirty_dir(sbi);
 	return 0;
 }
@@ -611,31 +610,26 @@ void add_dirty_dir_inode(struct inode *inode)
 void remove_dirty_dir_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-	struct list_head *head;
 	struct dir_inode_entry *entry;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
 	spin_lock(&sbi->dir_inode_lock);
-	if (get_dirty_dents(inode)) {
+	if (get_dirty_dents(inode) ||
+			!is_inode_flag_set(F2FS_I(inode), FI_DIRTY_DIR)) {
 		spin_unlock(&sbi->dir_inode_lock);
 		return;
 	}
 
-	head = &sbi->dir_inode_list;
-	list_for_each_entry(entry, head, list) {
-		if (entry->inode == inode) {
-			list_del(&entry->list);
-			stat_dec_dirty_dir(sbi);
-			spin_unlock(&sbi->dir_inode_lock);
-			kmem_cache_free(inode_entry_slab, entry);
-			goto done;
-		}
-	}
+	entry = F2FS_I(inode)->dirty_dir;
+	list_del(&entry->list);
+	F2FS_I(inode)->dirty_dir = NULL;
+	clear_inode_flag(F2FS_I(inode), FI_DIRTY_DIR);
+	stat_dec_dirty_dir(sbi);
 	spin_unlock(&sbi->dir_inode_lock);
+	kmem_cache_free(inode_entry_slab, entry);
 
-done:
 	/* Only from the recovery routine */
 	if (is_inode_flag_set(F2FS_I(inode), FI_DELAY_IPUT)) {
 		clear_inode_flag(F2FS_I(inode), FI_DELAY_IPUT);
@@ -643,26 +637,6 @@ done:
 	}
 }
 
-struct inode *check_dirty_dir_inode(struct f2fs_sb_info *sbi, nid_t ino)
-{
-
-	struct list_head *head;
-	struct inode *inode = NULL;
-	struct dir_inode_entry *entry;
-
-	spin_lock(&sbi->dir_inode_lock);
-
-	head = &sbi->dir_inode_list;
-	list_for_each_entry(entry, head, list) {
-		if (entry->inode->i_ino == ino) {
-			inode = entry->inode;
-			break;
-		}
-	}
-	spin_unlock(&sbi->dir_inode_lock);
-	return inode;
-}
-
 void sync_dirty_dir_inodes(struct f2fs_sb_info *sbi)
 {
 	struct list_head *head;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2c5a5da..d3180f8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -218,6 +218,7 @@ struct f2fs_inode_info {
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	unsigned long long xattr_ver;	/* cp version of xattr modification */
 	struct extent_info ext;		/* in-memory extent cache entry */
+	struct dir_inode_entry *dirty_dir;	/* the pointer of dirty dir */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -958,6 +959,7 @@ static inline int f2fs_clear_bit(unsigned int nr, char *addr)
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
 	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
+	FI_DIRTY_DIR,		/* indicate directory has dirty pages */
 	FI_INC_LINK,		/* need to increment i_nlink */
 	FI_ACL_MODE,		/* indicate acl mode */
 	FI_NO_ALLOC,		/* should not allocate any blocks */
@@ -1222,7 +1224,6 @@ int get_valid_checkpoint(struct f2fs_sb_info *);
 void set_dirty_dir_page(struct inode *, struct page *);
 void add_dirty_dir_inode(struct inode *);
 void remove_dirty_dir_inode(struct inode *);
-struct inode *check_dirty_dir_inode(struct f2fs_sb_info *, nid_t);
 void sync_dirty_dir_inodes(struct f2fs_sb_info *);
 void write_checkpoint(struct f2fs_sb_info *, bool);
 void init_orphan_info(struct f2fs_sb_info *);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b1ae89f..9eb6487 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -46,15 +46,17 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
 	struct inode *dir, *einode;
 	int err = 0;
 
-	dir = check_dirty_dir_inode(F2FS_SB(inode->i_sb), pino);
-	if (!dir) {
-		dir = f2fs_iget(inode->i_sb, pino);
-		if (IS_ERR(dir)) {
-			err = PTR_ERR(dir);
-			goto out;
-		}
-		set_inode_flag(F2FS_I(dir), FI_DELAY_IPUT);
+	dir = f2fs_iget(inode->i_sb, pino);
+	if (IS_ERR(dir)) {
+		err = PTR_ERR(dir);
+		goto out;
+	}
+
+	if (is_inode_flag_set(F2FS_I(dir), FI_DIRTY_DIR)) {
+		iput(dir);
+	} else {
 		add_dirty_dir_inode(dir);
+		set_inode_flag(F2FS_I(dir), FI_DELAY_IPUT);
 	}
 
 	name.len = le32_to_cpu(raw_inode->i_namelen);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
