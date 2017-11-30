From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/7] f2fs: inject fault to kzalloc
Date: Thu, 30 Nov 2017 19:28:17 +0800
Message-ID: <20171130112823.100494-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN1O-0005Wj-UI
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:50 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN1M-0000wB-EA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:50 +0000
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces f2fs_kzalloc based on f2fs_kmalloc in order to
support error injection for kzalloc().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/debug.c      |  2 +-
 fs/f2fs/f2fs.h       |  6 ++++++
 fs/f2fs/namei.c      |  2 +-
 fs/f2fs/node.c       |  7 ++++---
 fs/f2fs/segment.c    | 30 ++++++++++++++++--------------
 fs/f2fs/xattr.c      |  8 ++++----
 7 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a30024f2a567..d1f160ae4959 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -796,7 +796,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	block_t cp_blk_no;
 	int i;
 
-	sbi->ckpt = kzalloc(cp_blks * blk_size, GFP_KERNEL);
+	sbi->ckpt = f2fs_kzalloc(sbi, cp_blks * blk_size, GFP_KERNEL);
 	if (!sbi->ckpt)
 		return -ENOMEM;
 	/*
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 674f9bbe98d9..a66107b5cfff 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -439,7 +439,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_stat_info *si;
 
-	si = kzalloc(sizeof(struct f2fs_stat_info), GFP_KERNEL);
+	si = f2fs_kzalloc(sbi, sizeof(struct f2fs_stat_info), GFP_KERNEL);
 	if (!si)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b54b1c74f2e8..1b714d17d689 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2425,6 +2425,12 @@ static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
 	return kmalloc(size, flags);
 }
 
+static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
+					size_t size, gfp_t flags)
+{
+	return f2fs_kmalloc(sbi, size, flags | __GFP_ZERO);
+}
+
 static inline int get_extra_isize(struct inode *inode)
 {
 	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 28bdf8828e73..0c0abb17ed4b 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -544,7 +544,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 		struct qstr istr = QSTR_INIT(symname, len);
 		struct fscrypt_str ostr;
 
-		sd = kzalloc(disk_link.len, GFP_NOFS);
+		sd = f2fs_kzalloc(sbi, disk_link.len, GFP_NOFS);
 		if (!sd) {
 			err = -ENOMEM;
 			goto err_out;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4d85bd7c7296..2d6da4f26b83 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2600,8 +2600,8 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 
 	nm_i->nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) + 8 +
 						F2FS_BLKSIZE - 1);
-	nm_i->nat_bits = kzalloc(nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS,
-						GFP_KERNEL);
+	nm_i->nat_bits = f2fs_kzalloc(sbi,
+			nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS, GFP_KERNEL);
 	if (!nm_i->nat_bits)
 		return -ENOMEM;
 
@@ -2747,7 +2747,8 @@ int build_node_manager(struct f2fs_sb_info *sbi)
 {
 	int err;
 
-	sbi->nm_info = kzalloc(sizeof(struct f2fs_nm_info), GFP_KERNEL);
+	sbi->nm_info = f2fs_kzalloc(sbi, sizeof(struct f2fs_nm_info),
+							GFP_KERNEL);
 	if (!sbi->nm_info)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b4496a5d3cf3..e665a227b2c9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -657,7 +657,7 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 		goto init_thread;
 	}
 
-	fcc = kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
+	fcc = f2fs_kzalloc(sbi, sizeof(struct flush_cmd_control), GFP_KERNEL);
 	if (!fcc)
 		return -ENOMEM;
 	atomic_set(&fcc->issued_flush, 0);
@@ -1737,7 +1737,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 		goto init_thread;
 	}
 
-	dcc = kzalloc(sizeof(struct discard_cmd_control), GFP_KERNEL);
+	dcc = f2fs_kzalloc(sbi, sizeof(struct discard_cmd_control), GFP_KERNEL);
 	if (!dcc)
 		return -ENOMEM;
 
@@ -3379,7 +3379,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	unsigned int bitmap_size;
 
 	/* allocate memory for SIT information */
-	sit_i = kzalloc(sizeof(struct sit_info), GFP_KERNEL);
+	sit_i = f2fs_kzalloc(sbi, sizeof(struct sit_info), GFP_KERNEL);
 	if (!sit_i)
 		return -ENOMEM;
 
@@ -3397,29 +3397,30 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 
 	for (start = 0; start < MAIN_SEGS(sbi); start++) {
 		sit_i->sentries[start].cur_valid_map
-			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
+			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
 		sit_i->sentries[start].ckpt_valid_map
-			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
+			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
 		if (!sit_i->sentries[start].cur_valid_map ||
 				!sit_i->sentries[start].ckpt_valid_map)
 			return -ENOMEM;
 
 #ifdef CONFIG_F2FS_CHECK_FS
 		sit_i->sentries[start].cur_valid_map_mir
-			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
+			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
 		if (!sit_i->sentries[start].cur_valid_map_mir)
 			return -ENOMEM;
 #endif
 
 		if (f2fs_discard_en(sbi)) {
 			sit_i->sentries[start].discard_map
-				= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
+				= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
+								GFP_KERNEL);
 			if (!sit_i->sentries[start].discard_map)
 				return -ENOMEM;
 		}
 	}
 
-	sit_i->tmp_map = kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
+	sit_i->tmp_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
 	if (!sit_i->tmp_map)
 		return -ENOMEM;
 
@@ -3468,7 +3469,7 @@ static int build_free_segmap(struct f2fs_sb_info *sbi)
 	unsigned int bitmap_size, sec_bitmap_size;
 
 	/* allocate memory for free segmap information */
-	free_i = kzalloc(sizeof(struct free_segmap_info), GFP_KERNEL);
+	free_i = f2fs_kzalloc(sbi, sizeof(struct free_segmap_info), GFP_KERNEL);
 	if (!free_i)
 		return -ENOMEM;
 
@@ -3509,12 +3510,12 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
 		mutex_init(&array[i].curseg_mutex);
-		array[i].sum_blk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		array[i].sum_blk = f2fs_kzalloc(sbi, PAGE_SIZE, GFP_KERNEL);
 		if (!array[i].sum_blk)
 			return -ENOMEM;
 		init_rwsem(&array[i].journal_rwsem);
-		array[i].journal = kzalloc(sizeof(struct f2fs_journal),
-							GFP_KERNEL);
+		array[i].journal = f2fs_kzalloc(sbi,
+				sizeof(struct f2fs_journal), GFP_KERNEL);
 		if (!array[i].journal)
 			return -ENOMEM;
 		array[i].segno = NULL_SEGNO;
@@ -3672,7 +3673,8 @@ static int build_dirty_segmap(struct f2fs_sb_info *sbi)
 	unsigned int bitmap_size, i;
 
 	/* allocate memory for dirty segments list information */
-	dirty_i = kzalloc(sizeof(struct dirty_seglist_info), GFP_KERNEL);
+	dirty_i = f2fs_kzalloc(sbi, sizeof(struct dirty_seglist_info),
+								GFP_KERNEL);
 	if (!dirty_i)
 		return -ENOMEM;
 
@@ -3726,7 +3728,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	struct f2fs_sm_info *sm_info;
 	int err;
 
-	sm_info = kzalloc(sizeof(struct f2fs_sm_info), GFP_KERNEL);
+	sm_info = f2fs_kzalloc(sbi, sizeof(struct f2fs_sm_info), GFP_KERNEL);
 	if (!sm_info)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ec8961ef8cac..5e2b905cc0c4 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -298,8 +298,8 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	if (!size && !inline_size)
 		return -ENODATA;
 
-	txattr_addr = kzalloc(inline_size + size + XATTR_PADDING_SIZE,
-							GFP_F2FS_ZERO);
+	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode),
+			inline_size + size + XATTR_PADDING_SIZE, GFP_NOFS);
 	if (!txattr_addr)
 		return -ENOMEM;
 
@@ -351,8 +351,8 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 	void *txattr_addr;
 	int err;
 
-	txattr_addr = kzalloc(inline_size + size + XATTR_PADDING_SIZE,
-							GFP_F2FS_ZERO);
+	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode),
+			inline_size + size + XATTR_PADDING_SIZE, GFP_NOFS);
 	if (!txattr_addr)
 		return -ENOMEM;
 
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
