From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix fdatasync
Date: Wed, 16 Nov 2016 20:12:11 +0800
Message-ID: <20161116121211.11790-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c6z59-0002Ey-To
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 12:12:51 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c6z53-0005iP-Jt
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 12:12:51 +0000
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

For below two cases, we can't guarantee data consistence:

a)
1. xfs_io "pwrite 0 4195328" "fsync"
2. xfs_io "pwrite 4195328 1024" "fdatasync"
3. godown
4. umount & mount
--> isize we updated before fdatasync won't be recovered

b)
1. xfs_io "pwrite -S 0xcc 0 4202496" "fsync"
2. xfs_io "fpunch 4194304 4096" "fdatasync"
3. godown
4. umount & mount
--> dnode we punched before fdatasync won't be recovered

The reason is that normally fdatasync won't be aware of modification
of metadata in file, e.g. isize changing, dnode updating, so in ->fsync
we will skip flushing node pages for above cases, result in making
fdatasynced file being lost during recovery.

Introduce FDATASYNC_INO global ino cache for tracking node changing,
later fdatasync choose to flush nodes depend on ino cache state.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 13 ++++++++++++-
 fs/f2fs/f2fs.h       |  7 +++++++
 fs/f2fs/file.c       | 11 +++++++++--
 fs/f2fs/node.c       |  5 ++++-
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5039ed8..27d5679 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -464,12 +464,23 @@ bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
 	return e ? true : false;
 }
 
+bool need_flush_nodes(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	struct inode_management *im = &sbi->im[FDATASYNC_INO];
+	struct ino_entry *e;
+
+	spin_lock(&im->ino_lock);
+	e = radix_tree_lookup(&im->ino_root, ino);
+	spin_unlock(&im->ino_lock);
+	return e ? true : false;
+}
+
 void release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 {
 	struct ino_entry *e, *tmp;
 	int i;
 
-	for (i = all ? ORPHAN_INO: APPEND_INO; i <= UPDATE_INO; i++) {
+	for (i = all ? ORPHAN_INO: APPEND_INO; i < MAX_INO_ENTRY; i++) {
 		struct inode_management *im = &sbi->im[i];
 
 		spin_lock(&im->ino_lock);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cf74ec6..0978c58 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -161,6 +161,7 @@ enum {
 	ORPHAN_INO,		/* for orphan ino list */
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
+	FDATASYNC_INO,		/* need to flush nodes during fdatasync */
 	MAX_INO_ENTRY,		/* max. list */
 };
 
@@ -1695,6 +1696,7 @@ static inline void f2fs_i_links_write(struct inode *inode, bool inc)
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
+void add_ino_entry(struct f2fs_sb_info *, nid_t, int);
 static inline void f2fs_i_blocks_write(struct inode *inode,
 					blkcnt_t diff, bool add)
 {
@@ -1706,6 +1708,8 @@ static inline void f2fs_i_blocks_write(struct inode *inode,
 	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
+
+	add_ino_entry(F2FS_I_SB(inode), inode->i_ino, FDATASYNC_INO);
 }
 
 static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
@@ -1720,6 +1724,8 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
+
+	add_ino_entry(F2FS_I_SB(inode), inode->i_ino, FDATASYNC_INO);
 }
 
 static inline bool f2fs_skip_inode_update(struct inode *inode)
@@ -2150,6 +2156,7 @@ void add_ino_entry(struct f2fs_sb_info *, nid_t, int type);
 void remove_ino_entry(struct f2fs_sb_info *, nid_t, int type);
 void release_ino_entry(struct f2fs_sb_info *, bool);
 bool exist_written_data(struct f2fs_sb_info *, nid_t, int);
+bool need_flush_nodes(struct f2fs_sb_info *, nid_t);
 int f2fs_sync_inode_meta(struct f2fs_sb_info *);
 int acquire_orphan_inode(struct f2fs_sb_info *);
 void release_orphan_inode(struct f2fs_sb_info *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 47b7b13..75017c2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -209,8 +209,13 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		return ret;
 	}
 
-	/* if the inode is dirty, let's recover all the time */
-	if (!datasync && !f2fs_skip_inode_update(inode)) {
+	if (datasync) {
+		if (need_flush_nodes(sbi, ino)) {
+			f2fs_write_inode(inode, NULL);
+			goto go_write;
+		}
+	} else if (!f2fs_skip_inode_update(inode)) {
+		/* if the inode is dirty, let's recover all the time */
 		f2fs_write_inode(inode, NULL);
 		goto go_write;
 	}
@@ -276,6 +281,8 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	/* once recovery info is written, don't need to tack this */
 	remove_ino_entry(sbi, ino, APPEND_INO);
 	clear_inode_flag(inode, FI_APPEND_WRITE);
+
+	remove_ino_entry(sbi, ino, FDATASYNC_INO);
 flush_out:
 	remove_ino_entry(sbi, ino, UPDATE_INO);
 	clear_inode_flag(inode, FI_UPDATE_WRITE);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1b5b31a..0974d5b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -62,7 +62,7 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 	} else if (type == INO_ENTRIES) {
 		int i;
 
-		for (i = 0; i <= UPDATE_INO; i++)
+		for (i = 0; i < MAX_INO_ENTRY; i++)
 			mem_size += (sbi->im[i].ino_num *
 				sizeof(struct ino_entry)) >> PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
@@ -1670,6 +1670,9 @@ static int f2fs_set_node_page_dirty(struct page *page)
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 		SetPagePrivate(page);
 		f2fs_trace_pid(page);
+
+		add_ino_entry(F2FS_P_SB(page), ino_of_node(page),
+							FDATASYNC_INO);
 		return 1;
 	}
 	return 0;
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
