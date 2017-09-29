From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: enhance multiple device flush
Date: Fri, 29 Sep 2017 13:59:38 +0800
Message-ID: <20170929055939.39937-4-yuchao0@huawei.com>
References: <20170929055939.39937-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929055939.39937-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When multiple device feature is enabled, during ->fsync we will issue
flush in all devices to make sure node/data of the file being persisted
into storage. But some flushes of device could be unneeded as file's
data may be not writebacked into those devices. So this patch adds and
manage bitmap per inode in global cache to indicate which device is
dirty and it needs to issue flush during ->fsync, hence, we could improve
performance of fsync in scenario of multiple device.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 36 +++++++++++++++++++++++++++++++-----
 fs/f2fs/data.c       |  1 +
 fs/f2fs/f2fs.h       | 14 +++++++++++---
 fs/f2fs/file.c       |  3 ++-
 fs/f2fs/gc.c         |  2 ++
 fs/f2fs/inline.c     |  1 +
 fs/f2fs/inode.c      |  1 +
 fs/f2fs/node.c       |  3 ++-
 fs/f2fs/segment.c    | 46 +++++++++++++++++++++++++++++++++++-----------
 9 files changed, 86 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 04fe1df052b2..571980793542 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -401,7 +401,8 @@ const struct address_space_operations f2fs_meta_aops = {
 #endif
 };
 
-static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
+static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
+						unsigned int devidx, int type)
 {
 	struct inode_management *im = &sbi->im[type];
 	struct ino_entry *e, *tmp;
@@ -426,6 +427,10 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 		if (type != ORPHAN_INO)
 			im->ino_num++;
 	}
+
+	if (type == FLUSH_INO)
+		f2fs_set_bit(devidx, (char *)&e->dirty_device);
+
 	spin_unlock(&im->ino_lock);
 	radix_tree_preload_end();
 
@@ -454,7 +459,7 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 void add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	/* add new dirty ino entry into list */
-	__add_ino_entry(sbi, ino, type);
+	__add_ino_entry(sbi, ino, 0, type);
 }
 
 void remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
@@ -480,7 +485,7 @@ void release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 	struct ino_entry *e, *tmp;
 	int i;
 
-	for (i = all ? ORPHAN_INO: APPEND_INO; i <= UPDATE_INO; i++) {
+	for (i = all ? ORPHAN_INO : APPEND_INO; i < MAX_INO_ENTRY; i++) {
 		struct inode_management *im = &sbi->im[i];
 
 		spin_lock(&im->ino_lock);
@@ -494,6 +499,27 @@ void release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 	}
 }
 
+void set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
+					unsigned int devidx, int type)
+{
+	__add_ino_entry(sbi, ino, devidx, type);
+}
+
+bool is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
+					unsigned int devidx, int type)
+{
+	struct inode_management *im = &sbi->im[type];
+	struct ino_entry *e;
+	bool is_dirty = false;
+
+	spin_lock(&im->ino_lock);
+	e = radix_tree_lookup(&im->ino_root, ino);
+	if (e && f2fs_test_bit(devidx, (char *)&e->dirty_device))
+		is_dirty = true;
+	spin_unlock(&im->ino_lock);
+	return is_dirty;
+}
+
 int acquire_orphan_inode(struct f2fs_sb_info *sbi)
 {
 	struct inode_management *im = &sbi->im[ORPHAN_INO];
@@ -530,7 +556,7 @@ void release_orphan_inode(struct f2fs_sb_info *sbi)
 void add_orphan_inode(struct inode *inode)
 {
 	/* add new orphan ino entry into list */
-	__add_ino_entry(F2FS_I_SB(inode), inode->i_ino, ORPHAN_INO);
+	__add_ino_entry(F2FS_I_SB(inode), inode->i_ino, 0, ORPHAN_INO);
 	update_inode_page(inode);
 }
 
@@ -554,7 +580,7 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 		return err;
 	}
 
-	__add_ino_entry(sbi, ino, ORPHAN_INO);
+	__add_ino_entry(sbi, ino, 0, ORPHAN_INO);
 
 	inode = f2fs_iget_retry(sbi->sb, ino);
 	if (IS_ERR(inode)) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 506281d9807d..861dd95f78b7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1494,6 +1494,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 	int err = 0;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
+		.ino = inode->i_ino,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
 		.op_flags = wbc_to_write_flags(wbc),
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3440551289d2..ce63e778136a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -179,12 +179,14 @@ enum {
 	ORPHAN_INO,		/* for orphan ino list */
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
+	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
 
 struct ino_entry {
-	struct list_head list;	/* list head */
-	nid_t ino;		/* inode number */
+	struct list_head list;		/* list head */
+	nid_t ino;			/* inode number */
+	unsigned int dirty_device;	/* dirty device bitmap */
 };
 
 /* for the list of inodes to be GCed */
@@ -796,6 +798,7 @@ enum {
 struct flush_cmd {
 	struct completion wait;
 	struct llist_node llnode;
+	nid_t ino;
 	int ret;
 };
 
@@ -923,6 +926,7 @@ enum iostat_type {
 
 struct f2fs_io_info {
 	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
+	nid_t ino;		/* inode number */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
 	enum temp_type temp;	/* contains HOT/WARM/COLD */
 	int op;			/* contains REQ_OP_ */
@@ -2549,7 +2553,7 @@ void drop_inmem_page(struct inode *inode, struct page *page);
 int commit_inmem_pages(struct inode *inode);
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi);
-int f2fs_issue_flush(struct f2fs_sb_info *sbi);
+int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
 int create_flush_cmd_control(struct f2fs_sb_info *sbi);
 void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
@@ -2613,6 +2617,10 @@ void add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
 void remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
 void release_ino_entry(struct f2fs_sb_info *sbi, bool all);
 bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode);
+void set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
+					unsigned int devidx, int type);
+bool is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
+					unsigned int devidx, int type);
 int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi);
 int acquire_orphan_inode(struct f2fs_sb_info *sbi);
 void release_orphan_inode(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 18ca8b305699..80d375060a2f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -295,10 +295,11 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	clear_inode_flag(inode, FI_APPEND_WRITE);
 flush_out:
 	if (!atomic)
-		ret = f2fs_issue_flush(sbi);
+		ret = f2fs_issue_flush(sbi, inode->i_ino);
 	if (!ret) {
 		remove_ino_entry(sbi, ino, UPDATE_INO);
 		clear_inode_flag(inode, FI_UPDATE_WRITE);
+		remove_ino_entry(sbi, ino, FLUSH_INO);
 	}
 	f2fs_update_time(sbi, REQ_TIME);
 out:
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bfe6a8ccc3a0..4e9f5c3017ac 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -608,6 +608,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 {
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
+		.ino = inode->i_ino,
 		.type = DATA,
 		.temp = COLD,
 		.op = REQ_OP_READ,
@@ -738,6 +739,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	} else {
 		struct f2fs_io_info fio = {
 			.sbi = F2FS_I_SB(inode),
+			.ino = inode->i_ino,
 			.type = DATA,
 			.temp = COLD,
 			.op = REQ_OP_WRITE,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8322e4e7bb3f..90e38d8ea688 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -112,6 +112,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 {
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(dn->inode),
+		.ino = dn->inode->i_ino,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
 		.op_flags = REQ_SYNC | REQ_PRIO,
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 42a8594d6361..f1698527cb6e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -492,6 +492,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
 	remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+	remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
 
 	sb_start_intwrite(inode->i_sb);
 	set_inode_flag(inode, FI_NO_ALLOC);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d087b45b3f72..b95b2784e7d8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -63,7 +63,7 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 	} else if (type == INO_ENTRIES) {
 		int i;
 
-		for (i = 0; i <= UPDATE_INO; i++)
+		for (i = 0; i < MAX_INO_ENTRY; i++)
 			mem_size += sbi->im[i].ino_num *
 						sizeof(struct ino_entry);
 		mem_size >>= PAGE_SHIFT;
@@ -1340,6 +1340,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	struct node_info ni;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
+		.ino = ino_of_node(page),
 		.type = NODE,
 		.op = REQ_OP_WRITE,
 		.op_flags = wbc_to_write_flags(wbc),
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8c9040960b29..9d096f0014dc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -313,6 +313,7 @@ static int __commit_inmem_pages(struct inode *inode,
 	struct inmem_pages *cur, *tmp;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
+		.ino = inode->i_ino,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
 		.op_flags = REQ_SYNC | REQ_PRIO,
@@ -485,15 +486,17 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 	return ret;
 }
 
-static int submit_flush_wait(struct f2fs_sb_info *sbi)
+static int submit_flush_wait(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	int ret = __submit_flush_wait(sbi, sbi->sb->s_bdev);
+	int ret = 0;
 	int i;
 
-	if (!sbi->s_ndevs || ret)
-		return ret;
+	if (!sbi->s_ndevs)
+		return __submit_flush_wait(sbi, sbi->sb->s_bdev);
 
-	for (i = 1; i < sbi->s_ndevs; i++) {
+	for (i = 0; i < sbi->s_ndevs; i++) {
+		if (!is_dirty_device(sbi, ino, i, FLUSH_INO))
+			continue;
 		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
 		if (ret)
 			break;
@@ -519,7 +522,9 @@ static int issue_flush_thread(void *data)
 		fcc->dispatch_list = llist_del_all(&fcc->issue_list);
 		fcc->dispatch_list = llist_reverse_order(fcc->dispatch_list);
 
-		ret = submit_flush_wait(sbi);
+		cmd = llist_entry(fcc->dispatch_list, struct flush_cmd, llnode);
+
+		ret = submit_flush_wait(sbi, cmd->ino);
 		atomic_inc(&fcc->issued_flush);
 
 		llist_for_each_entry_safe(cmd, next,
@@ -537,7 +542,7 @@ static int issue_flush_thread(void *data)
 	goto repeat;
 }
 
-int f2fs_issue_flush(struct f2fs_sb_info *sbi)
+int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct flush_cmd_control *fcc = SM_I(sbi)->fcc_info;
 	struct flush_cmd cmd;
@@ -547,19 +552,20 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 		return 0;
 
 	if (!test_opt(sbi, FLUSH_MERGE)) {
-		ret = submit_flush_wait(sbi);
+		ret = submit_flush_wait(sbi, ino);
 		atomic_inc(&fcc->issued_flush);
 		return ret;
 	}
 
-	if (atomic_inc_return(&fcc->issing_flush) == 1) {
-		ret = submit_flush_wait(sbi);
+	if (atomic_inc_return(&fcc->issing_flush) == 1 || sbi->s_ndevs > 1) {
+		ret = submit_flush_wait(sbi, ino);
 		atomic_dec(&fcc->issing_flush);
 
 		atomic_inc(&fcc->issued_flush);
 		return ret;
 	}
 
+	cmd.ino = ino;
 	init_completion(&cmd.wait);
 
 	llist_add(&cmd.llnode, &fcc->issue_list);
@@ -583,7 +589,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 		} else {
 			struct flush_cmd *tmp, *next;
 
-			ret = submit_flush_wait(sbi);
+			ret = submit_flush_wait(sbi, ino);
 
 			llist_for_each_entry_safe(tmp, next, list, llnode) {
 				if (tmp == &cmd) {
@@ -2497,6 +2503,20 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	mutex_unlock(&curseg->curseg_mutex);
 }
 
+static void update_device_state(struct f2fs_io_info *fio)
+{
+	struct f2fs_sb_info *sbi = fio->sbi;
+	unsigned int devidx;
+
+	if (!sbi->s_ndevs)
+		return;
+
+	devidx = f2fs_target_device_index(sbi, fio->new_blkaddr);
+
+	/* update device state for fsync */
+	set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
+}
+
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
 	int type = __get_segment_type(fio);
@@ -2511,6 +2531,8 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	if (err == -EAGAIN) {
 		fio->old_blkaddr = fio->new_blkaddr;
 		goto reallocate;
+	} else if (!err) {
+		update_device_state(fio);
 	}
 }
 
@@ -2571,6 +2593,8 @@ int rewrite_data_page(struct f2fs_io_info *fio)
 	stat_inc_inplace_blocks(fio->sbi);
 
 	err = f2fs_submit_page_bio(fio);
+	if (!err)
+		update_device_state(fio);
 
 	f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
 
-- 
2.13.1.388.g69e6b9b4f4a9
