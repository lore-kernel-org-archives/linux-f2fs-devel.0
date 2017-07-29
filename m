From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add app/fs io stat
Date: Sat, 29 Jul 2017 18:41:12 +0800
Message-ID: <20170729104112.108302-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dbPBm-0006AZ-Ut
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Jul 2017 10:41:42 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dbPBj-0007FB-M4
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Jul 2017 10:41:42 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch enables inner app/fs io stats and introduces below virtual fs
nodes for exposing stats info:
/sys/fs/f2fs/<dev>/iostat_enable
/proc/fs/f2fs/<dev>/iostat_info

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 34 +++++++++++++++++++++---------
 fs/f2fs/data.c       | 35 +++++++++++++++++++++++--------
 fs/f2fs/f2fs.h       | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/file.c       |  7 ++++++-
 fs/f2fs/gc.c         |  3 +++
 fs/f2fs/inline.c     |  1 +
 fs/f2fs/node.c       | 15 ++++++++------
 fs/f2fs/segment.c    | 19 +++++++++++++++--
 fs/f2fs/super.c      |  4 ++++
 fs/f2fs/sysfs.c      | 35 +++++++++++++++++++++++++++++++
 10 files changed, 180 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3c84a2520796..da5b49183e09 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -230,8 +230,9 @@ void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
 		ra_meta_pages(sbi, index, BIO_MAX_PAGES, META_POR, true);
 }
 
-static int f2fs_write_meta_page(struct page *page,
-				struct writeback_control *wbc)
+static int __f2fs_write_meta_page(struct page *page,
+				struct writeback_control *wbc,
+				enum iostat_type io_type)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
@@ -244,7 +245,7 @@ static int f2fs_write_meta_page(struct page *page,
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto redirty_out;
 
-	write_meta_page(sbi, page);
+	write_meta_page(sbi, page, io_type);
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
 	if (wbc->for_reclaim)
@@ -263,6 +264,12 @@ static int f2fs_write_meta_page(struct page *page,
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
+static int f2fs_write_meta_page(struct page *page,
+				struct writeback_control *wbc)
+{
+	return __f2fs_write_meta_page(page, wbc, FS_META_IO);
+}
+
 static int f2fs_write_meta_pages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
@@ -283,7 +290,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 
 	trace_f2fs_writepages(mapping->host, wbc, META);
 	diff = nr_pages_to_write(sbi, META, wbc);
-	written = sync_meta_pages(sbi, META, wbc->nr_to_write);
+	written = sync_meta_pages(sbi, META, wbc->nr_to_write, FS_META_IO);
 	mutex_unlock(&sbi->cp_mutex);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - written - diff);
 	return 0;
@@ -295,7 +302,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 }
 
 long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
-						long nr_to_write)
+				long nr_to_write, enum iostat_type io_type)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
 	pgoff_t index = 0, end = ULONG_MAX, prev = ULONG_MAX;
@@ -346,7 +353,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			if (mapping->a_ops->writepage(page, &wbc)) {
+			if (__f2fs_write_meta_page(page, &wbc, io_type)) {
 				unlock_page(page);
 				break;
 			}
@@ -904,7 +911,14 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	if (inode) {
 		unsigned long cur_ino = inode->i_ino;
 
+		if (is_dir)
+			F2FS_I(inode)->cp_task = current;
+
 		filemap_fdatawrite(inode->i_mapping);
+
+		if (is_dir)
+			F2FS_I(inode)->cp_task = NULL;
+
 		iput(inode);
 		/* We need to give cpu to another writers. */
 		if (ino == cur_ino) {
@@ -1017,7 +1031,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
-		err = sync_node_pages(sbi, &wbc, false);
+		err = sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
 		if (err) {
 			up_write(&sbi->node_change);
 			f2fs_unlock_all(sbi);
@@ -1115,7 +1129,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Flush all the NAT/SIT pages */
 	while (get_pages(sbi, F2FS_DIRTY_META)) {
-		sync_meta_pages(sbi, META, LONG_MAX);
+		sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 		if (unlikely(f2fs_cp_error(sbi)))
 			return -EIO;
 	}
@@ -1194,7 +1208,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 		/* Flush all the NAT BITS pages */
 		while (get_pages(sbi, F2FS_DIRTY_META)) {
-			sync_meta_pages(sbi, META, LONG_MAX);
+			sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 			if (unlikely(f2fs_cp_error(sbi)))
 				return -EIO;
 		}
@@ -1249,7 +1263,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
 	/* Here, we only have one bio having CP pack */
-	sync_meta_pages(sbi, META_FLUSH, LONG_MAX);
+	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
 
 	/* wait for previous submitted meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aefc2a5745d3..ee92f9d082b4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1475,7 +1475,8 @@ int do_write_data_page(struct f2fs_io_info *fio)
 }
 
 static int __write_data_page(struct page *page, bool *submitted,
-				struct writeback_control *wbc)
+				struct writeback_control *wbc,
+				enum iostat_type io_type)
 {
 	struct inode *inode = page->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1496,6 +1497,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		.encrypted_page = NULL,
 		.submitted = false,
 		.need_lock = LOCK_RETRY,
+		.io_type = io_type,
 	};
 
 	trace_f2fs_writepage(page, DATA);
@@ -1602,7 +1604,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 static int f2fs_write_data_page(struct page *page,
 					struct writeback_control *wbc)
 {
-	return __write_data_page(page, NULL, wbc);
+	return __write_data_page(page, NULL, wbc, FS_DATA_IO);
 }
 
 /*
@@ -1611,7 +1613,8 @@ static int f2fs_write_data_page(struct page *page,
  * warm/hot data page.
  */
 static int f2fs_write_cache_pages(struct address_space *mapping,
-					struct writeback_control *wbc)
+					struct writeback_control *wbc,
+					enum iostat_type io_type)
 {
 	int ret = 0;
 	int done = 0;
@@ -1701,7 +1704,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			ret = __write_data_page(page, &submitted, wbc);
+			ret = __write_data_page(page, &submitted, wbc, io_type);
 			if (unlikely(ret)) {
 				/*
 				 * keep nr_to_write, since vfs uses this to
@@ -1756,8 +1759,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
-static int f2fs_write_data_pages(struct address_space *mapping,
-			    struct writeback_control *wbc)
+int __f2fs_write_data_pages(struct address_space *mapping,
+						struct writeback_control *wbc,
+						enum iostat_type io_type)
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1794,7 +1798,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 		goto skip_write;
 
 	blk_start_plug(&plug);
-	ret = f2fs_write_cache_pages(mapping, wbc);
+	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
 	blk_finish_plug(&plug);
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
@@ -1813,6 +1817,16 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	return 0;
 }
 
+static int f2fs_write_data_pages(struct address_space *mapping,
+			    struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+
+	return __f2fs_write_data_pages(mapping, wbc,
+			F2FS_I(inode)->cp_task == current ?
+			FS_CP_DATA_IO : FS_DATA_IO);
+}
+
 static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 {
 	struct inode *inode = mapping->host;
@@ -2079,10 +2093,13 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	up_read(&F2FS_I(inode)->dio_rwsem[rw]);
 
 	if (rw == WRITE) {
-		if (err > 0)
+		if (err > 0) {
+			f2fs_record_iostat(F2FS_I_SB(inode), APP_DIRECT_IO,
+									err);
 			set_inode_flag(inode, FI_UPDATE_WRITE);
-		else if (err < 0)
+		} else if (err < 0) {
 			f2fs_write_failed(mapping, offset + count);
+		}
 	}
 
 	trace_f2fs_direct_IO_exit(inode, offset, count, rw, err);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 928028356fbc..385027897f4c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -562,6 +562,7 @@ struct f2fs_inode_info {
 	f2fs_hash_t chash;		/* hash value of given file name */
 	unsigned int clevel;		/* maximum level of given file name */
 	struct task_struct *task;	/* lookup and create consistency */
+	struct task_struct *cp_task;	/* separate cp/wb IO stats*/
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	loff_t	last_disk_size;		/* lastly written file size */
 
@@ -868,6 +869,22 @@ enum need_lock_type {
 	LOCK_RETRY,
 };
 
+enum iostat_type {
+	APP_DIRECT_IO,			/* app direct IOs */
+	APP_BUFFERED_IO,		/* app buffered IOs */
+	APP_WRITE_IO,			/* app write IOs */
+	APP_MAPPED_IO,			/* app mapped IOs */
+	FS_DATA_IO,			/* data IOs from kworker/fsync/reclaimer */
+	FS_NODE_IO,			/* node IOs from kworker/fsync/reclaimer */
+	FS_META_IO,			/* meta IOs from kworker/reclaimer */
+	FS_GC_DATA_IO,			/* data IOs from forground gc */
+	FS_GC_NODE_IO,			/* node IOs from forground gc */
+	FS_CP_DATA_IO,			/* data IOs from checkpoint */
+	FS_CP_NODE_IO,			/* node IOs from checkpoint */
+	FS_CP_META_IO,			/* meta IOs from checkpoint */
+	NR_IO_TYPE,
+};
+
 struct f2fs_io_info {
 	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
@@ -882,6 +899,7 @@ struct f2fs_io_info {
 	bool submitted;		/* indicate IO submission */
 	int need_lock;		/* indicate we need to lock cp_rwsem */
 	bool in_list;		/* indicate fio is in io_list */
+	enum iostat_type io_type;	/* io type */
 };
 
 #define is_read_io(rw) ((rw) == READ)
@@ -1073,6 +1091,11 @@ struct f2fs_sb_info {
 #endif
 	spinlock_t stat_lock;			/* lock for stat operations */
 
+	/* For app/fs IO statistics */
+	spinlock_t iostat_lock;
+	unsigned long long write_iostat[NR_IO_TYPE];
+	bool iostat_enable;
+
 	/* For sysfs suppport */
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
@@ -2302,6 +2325,31 @@ static inline int get_extra_isize(struct inode *inode)
 		sizeof((f2fs_inode)->field))			\
 		<= (F2FS_OLD_ATTRIBUTE_SIZE + extra_isize))	\
 
+static inline void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
+{
+	int i;
+
+	spin_lock(&sbi->iostat_lock);
+	for (i = 0; i < NR_IO_TYPE; i++)
+		sbi->write_iostat[i] = 0;
+	spin_unlock(&sbi->iostat_lock);
+}
+
+static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi,
+			enum iostat_type type, unsigned long long io_bytes)
+{
+	if (!sbi->iostat_enable)
+		return;
+	spin_lock(&sbi->iostat_lock);
+	sbi->write_iostat[type] += io_bytes;
+
+	if (type == APP_WRITE_IO || type == APP_DIRECT_IO)
+		sbi->write_iostat[APP_BUFFERED_IO] =
+			sbi->write_iostat[APP_WRITE_IO] -
+			sbi->write_iostat[APP_DIRECT_IO];
+	spin_unlock(&sbi->iostat_lock);
+}
+
 /*
  * file.c
  */
@@ -2428,7 +2476,7 @@ void move_node_page(struct page *node_page, int gc_type);
 int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic);
 int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
-			bool do_balance);
+			bool do_balance, enum iostat_type io_type);
 void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
 bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
 void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
@@ -2471,7 +2519,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno);
 void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr);
-void write_meta_page(struct f2fs_sb_info *sbi, struct page *page);
+void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
+						enum iostat_type io_type);
 void write_node_page(unsigned int nid, struct f2fs_io_info *fio);
 void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio);
 int rewrite_data_page(struct f2fs_io_info *fio);
@@ -2512,7 +2561,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
 void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
 long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
-			long nr_to_write);
+			long nr_to_write, enum iostat_type io_type);
 void add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
 void remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
 void release_ino_entry(struct f2fs_sb_info *sbi, bool all);
@@ -2565,6 +2614,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
 void f2fs_set_page_dirty_nobuffers(struct page *page);
+int __f2fs_write_data_pages(struct address_space *mapping,
+						struct writeback_control *wbc,
+						enum iostat_type io_type);
 void f2fs_invalidate_page(struct page *page, unsigned int offset,
 			unsigned int length);
 int f2fs_release_page(struct page *page, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 407518f42e45..d6cc12fea798 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -98,6 +98,8 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
+	f2fs_record_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
+
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 mapped:
 	/* fill the page */
@@ -1815,7 +1817,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		f2fs_stop_checkpoint(sbi, false);
 		break;
 	case F2FS_GOING_DOWN_METAFLUSH:
-		sync_meta_pages(sbi, META, LONG_MAX);
+		sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
 		f2fs_stop_checkpoint(sbi, false);
 		break;
 	default:
@@ -2694,6 +2696,9 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = __generic_file_write_iter(iocb, from);
 		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
+
+		if (ret > 0)
+			f2fs_record_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 	}
 	inode_unlock(inode);
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 1c0117f60083..a75d26632794 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -688,6 +688,8 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	fio.new_blkaddr = newaddr;
 	f2fs_submit_page_write(&fio);
 
+	f2fs_record_iostat(fio.sbi, FS_GC_DATA_IO, F2FS_BLKSIZE);
+
 	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (page->index == 0)
@@ -735,6 +737,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.page = page,
 			.encrypted_page = NULL,
 			.need_lock = LOCK_REQ,
+			.io_type = FS_GC_DATA_IO,
 		};
 		bool is_dirty = PageDirty(page);
 		int err;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index f38be791fdf9..e63ab0d1f614 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -117,6 +117,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 		.op_flags = REQ_SYNC | REQ_PRIO,
 		.page = page,
 		.encrypted_page = NULL,
+		.io_type = FS_DATA_IO,
 	};
 	int dirty, err;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5483a735847f..b08f0d9bd86f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1327,7 +1327,8 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 }
 
 static int __write_node_page(struct page *page, bool atomic, bool *submitted,
-				struct writeback_control *wbc, bool do_balance)
+				struct writeback_control *wbc, bool do_balance,
+				enum iostat_type io_type)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 	nid_t nid;
@@ -1340,6 +1341,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		.page = page,
 		.encrypted_page = NULL,
 		.submitted = false,
+		.io_type = io_type,
 	};
 
 	trace_f2fs_writepage(page, NODE);
@@ -1408,7 +1410,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 static int f2fs_write_node_page(struct page *page,
 				struct writeback_control *wbc)
 {
-	return __write_node_page(page, false, NULL, wbc, false);
+	return __write_node_page(page, false, NULL, wbc, false, FS_NODE_IO);
 }
 
 int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
@@ -1496,7 +1498,8 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			ret = __write_node_page(page, atomic &&
 						page == last_page,
-						&submitted, wbc, true);
+						&submitted, wbc, true,
+						FS_NODE_IO);
 			if (ret) {
 				unlock_page(page);
 				f2fs_put_page(last_page, 0);
@@ -1534,7 +1537,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 }
 
 int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
-							bool do_balance)
+				bool do_balance, enum iostat_type io_type)
 {
 	pgoff_t index, end;
 	struct pagevec pvec;
@@ -1613,7 +1616,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 			set_dentry_mark(page, 0);
 
 			ret = __write_node_page(page, false, &submitted,
-							wbc, do_balance);
+						wbc, do_balance, io_type);
 			if (ret)
 				unlock_page(page);
 			else if (submitted)
@@ -1702,7 +1705,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	diff = nr_pages_to_write(sbi, NODE, wbc);
 	wbc->sync_mode = WB_SYNC_NONE;
 	blk_start_plug(&plug);
-	sync_node_pages(sbi, wbc, true);
+	sync_node_pages(sbi, wbc, true, FS_NODE_IO);
 	blk_finish_plug(&plug);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 	return 0;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4a0bf3643e93..151968ecc694 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -292,6 +292,7 @@ static int __commit_inmem_pages(struct inode *inode,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
 		.op_flags = REQ_SYNC | REQ_PRIO,
+		.io_type = FS_DATA_IO,
 	};
 	pgoff_t last_idx = ULONG_MAX;
 	int err = 0;
@@ -2255,7 +2256,8 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	}
 }
 
-void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
+void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
+					enum iostat_type io_type)
 {
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
@@ -2274,6 +2276,8 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 
 	set_page_writeback(page);
 	f2fs_submit_page_write(&fio);
+
+	f2fs_record_iostat(sbi, io_type, F2FS_BLKSIZE);
 }
 
 void write_node_page(unsigned int nid, struct f2fs_io_info *fio)
@@ -2282,6 +2286,8 @@ void write_node_page(unsigned int nid, struct f2fs_io_info *fio)
 
 	set_summary(&sum, nid, 0, 0);
 	do_write_page(&sum, fio);
+
+	f2fs_record_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
 }
 
 void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
@@ -2295,13 +2301,22 @@ void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	do_write_page(&sum, fio);
 	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
+
+	f2fs_record_iostat(sbi, fio->io_type, F2FS_BLKSIZE);
 }
 
 int rewrite_data_page(struct f2fs_io_info *fio)
 {
+	int err;
+
 	fio->new_blkaddr = fio->old_blkaddr;
 	stat_inc_inplace_blocks(fio->sbi);
-	return f2fs_submit_page_bio(fio);
+
+	err = f2fs_submit_page_bio(fio);
+
+	f2fs_record_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
+
+	return err;
 }
 
 void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7a7cce908b80..166b97608f52 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2332,6 +2332,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	set_sbi_flag(sbi, SBI_POR_DOING);
 	spin_lock_init(&sbi->stat_lock);
 
+	/* init iostat info */
+	spin_lock_init(&sbi->iostat_lock);
+	sbi->iostat_enable = false;
+
 	for (i = 0; i < NR_PAGE_TYPE; i++) {
 		int n = (i == META) ? 1: NR_TEMP_TYPE;
 		int j;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 1bc2cfb0b9df..29fd12200330 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -153,6 +153,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 	*ui = t;
+
+	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
+		f2fs_reset_iostat(sbi);
+
 	return count;
 }
 
@@ -251,6 +255,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
 F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
@@ -290,6 +295,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(dirty_nats_ratio),
 	ATTR_LIST(cp_interval),
 	ATTR_LIST(idle_interval),
+	ATTR_LIST(iostat_enable),
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	ATTR_LIST(inject_rate),
 	ATTR_LIST(inject_type),
@@ -393,6 +399,31 @@ static int segment_bits_seq_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+static int iostat_info_seq_show(struct seq_file *seq, void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	time64_t now = ktime_get_real_seconds();
+	int i;
+
+	if (!sbi->iostat_enable)
+		return 0;
+
+	seq_puts(seq, "time(sec)	app direct	app buffered	"
+		"app write	app mapped	"
+		"fs data		fs node		fs meta		"
+		"fs gc data	fs gc node	"
+		"fs cp data	fs cp node	fs cp meta\n");
+
+	seq_printf(seq, "%-16llu", now);
+
+	for (i = 0; i < NR_IO_TYPE; i++)
+		seq_printf(seq, "%-16llu", sbi->write_iostat[i]);
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
 #define F2FS_PROC_FILE_DEF(_name)					\
 static int _name##_open_fs(struct inode *inode, struct file *file)	\
 {									\
@@ -408,6 +439,7 @@ static const struct file_operations f2fs_seq_##_name##_fops = {		\
 
 F2FS_PROC_FILE_DEF(segment_info);
 F2FS_PROC_FILE_DEF(segment_bits);
+F2FS_PROC_FILE_DEF(iostat_info);
 
 int __init f2fs_init_sysfs(void)
 {
@@ -456,6 +488,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				 &f2fs_seq_segment_info_fops, sb);
 		proc_create_data("segment_bits", S_IRUGO, sbi->s_proc,
 				 &f2fs_seq_segment_bits_fops, sb);
+		proc_create_data("iostat_info", S_IRUGO, sbi->s_proc,
+				&f2fs_seq_iostat_info_fops, sb);
 	}
 	return 0;
 }
@@ -463,6 +497,7 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 {
 	if (sbi->s_proc) {
+		remove_proc_entry("iostat_info", sbi->s_proc);
 		remove_proc_entry("segment_info", sbi->s_proc);
 		remove_proc_entry("segment_bits", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
