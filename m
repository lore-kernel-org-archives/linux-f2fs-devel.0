From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: support FALLOC_FL_COLLAPSE_RANGE
Date: Sat, 18 Apr 2015 18:00:36 +0800
Message-ID: <007901d079be$9cfb81e0$d6f285a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Now, FALLOC_FL_COLLAPSE_RANGE flag in ->fallocate is supported in ext4/xfs.

In commit, the semantics of this flag is descripted as following:
"1) It collapses the range lying between offset and length by removing any data
   blocks which are present in this range and than updates all the logical
   offsets of extents beyond "offset + len" to nullify the hole created by
   removing blocks. In short, it does not leave a hole.
2) It should be used exclusively. No other fallocate flag in combination.
3) Offset and length supplied to fallocate should be fs block size aligned
   in case of xfs and ext4.
4) Collaspe range does not work beyond i_size."

This patch implements fallocate's FALLOC_FL_COLLAPSE_RANGE for f2fs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h    |   2 +
 fs/f2fs/file.c    | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/segment.c |  50 +++++++++++++++++++++
 3 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c06a25e..9d6368a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1560,6 +1560,8 @@ void write_node_page(struct f2fs_sb_info *, struct page *,
 void write_data_page(struct page *, struct dnode_of_data *,
 			struct f2fs_io_info *);
 void rewrite_data_page(struct page *, struct f2fs_io_info *);
+void replace_block(struct f2fs_sb_info *, struct f2fs_summary *, block_t,
+								block_t);
 void recover_data_page(struct f2fs_sb_info *, struct page *,
 				struct f2fs_summary *, block_t, block_t);
 void allocate_data_block(struct f2fs_sb_info *, struct page *,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index da13929..86bcc9c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -765,6 +765,131 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	return ret;
 }
 
+static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct dnode_of_data dn;
+	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
+	int ret = 0;
+
+	f2fs_lock_op(sbi);
+
+	for (; end < nrpages; start++, end++) {
+		block_t new_addr, old_addr;
+
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		ret = get_dnode_of_data(&dn, end, LOOKUP_NODE_RA);
+		if (ret && ret != -ENOENT) {
+			goto out;
+		} else if (ret == -ENOENT) {
+			new_addr = NULL_ADDR;
+		} else {
+			new_addr = dn.data_blkaddr;
+			truncate_data_blocks_range(&dn, 1);
+			f2fs_put_dnode(&dn);
+		}
+
+		if (new_addr == NULL_ADDR) {
+			set_new_dnode(&dn, inode, NULL, NULL, 0);
+			ret = get_dnode_of_data(&dn, start, LOOKUP_NODE_RA);
+			if (ret && ret != -ENOENT)
+				goto out;
+			else if (ret == -ENOENT)
+				continue;
+
+			if (dn.data_blkaddr == NULL_ADDR) {
+				f2fs_put_dnode(&dn);
+				continue;
+			} else {
+				truncate_data_blocks_range(&dn, 1);
+			}
+
+			f2fs_put_dnode(&dn);
+		} else {
+			struct page *ipage;
+
+			ipage = get_node_page(sbi, inode->i_ino);
+			if (IS_ERR(ipage)) {
+				ret = PTR_ERR(ipage);
+				goto out;
+			}
+
+			set_new_dnode(&dn, inode, ipage, NULL, 0);
+			ret = f2fs_reserve_block(&dn, start);
+			if (ret)
+				goto out;
+
+			old_addr = dn.data_blkaddr;
+			if (old_addr != NEW_ADDR && new_addr == NEW_ADDR) {
+				dn.data_blkaddr = NULL_ADDR;
+				f2fs_update_extent_cache(&dn);
+				invalidate_blocks(sbi, old_addr);
+
+				dn.data_blkaddr = new_addr;
+				set_data_blkaddr(&dn);
+			} else if (new_addr != NEW_ADDR) {
+				struct node_info ni;
+				struct f2fs_summary sum;
+
+				get_node_info(sbi, dn.nid, &ni);
+				set_summary(&sum, dn.nid, dn.ofs_in_node,
+								ni.version);
+
+				replace_block(sbi, &sum, old_addr, new_addr);
+
+				dn.data_blkaddr = new_addr;
+				set_data_blkaddr(&dn);
+				f2fs_update_extent_cache(&dn);
+			}
+
+			f2fs_put_dnode(&dn);
+		}
+	}
+	ret = 0;
+out:
+	f2fs_unlock_op(sbi);
+	return ret;
+}
+
+static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
+{
+	pgoff_t pg_start, pg_end;
+	loff_t new_size;
+	int ret;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if (offset + len >= i_size_read(inode))
+		return -EINVAL;
+
+	/* collapse range should be aligned to block size of f2fs. */
+	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
+		return -EINVAL;
+
+	pg_start = offset >> PAGE_CACHE_SHIFT;
+	pg_end = (offset + len) >> PAGE_CACHE_SHIFT;
+
+	/* write out all dirty pages from offset */
+	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	if (ret)
+		return ret;
+
+	truncate_pagecache(inode, offset);
+
+	ret = f2fs_do_collapse(inode, pg_start, pg_end);
+	if (ret)
+		return ret;
+
+	new_size = i_size_read(inode) - len;
+
+	ret = truncate_blocks(inode, new_size, true);
+	if (!ret)
+		i_size_write(inode, new_size);
+
+	return ret;
+}
+
 static int expand_inode_data(struct inode *inode, loff_t offset,
 					loff_t len, int mode)
 {
@@ -832,13 +957,16 @@ static long f2fs_fallocate(struct file *file, int mode,
 	struct inode *inode = file_inode(file);
 	long ret;
 
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+			FALLOC_FL_COLLAPSE_RANGE))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&inode->i_mutex);
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = punch_hole(inode, offset, len);
+	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
+		ret = f2fs_collapse_range(inode, offset, len);
 	else
 		ret = expand_inode_data(inode, offset, len, mode);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f939660..4701c13 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1258,6 +1258,56 @@ void rewrite_data_page(struct page *page, struct f2fs_io_info *fio)
 	f2fs_submit_page_mbio(F2FS_P_SB(page), page, fio);
 }
 
+void replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+				block_t old_blkaddr, block_t new_blkaddr)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	struct curseg_info *curseg;
+	unsigned int segno, old_cursegno;
+	struct seg_entry *se;
+	int type;
+	unsigned short old_blkoff;
+	bool recover_curseg = false;
+
+	segno = GET_SEGNO(sbi, new_blkaddr);
+	se = get_seg_entry(sbi, segno);
+	type = se->type;
+
+	if (!IS_CURSEG(sbi, segno))
+		type = CURSEG_WARM_DATA;
+	curseg = CURSEG_I(sbi, type);
+
+	mutex_lock(&curseg->curseg_mutex);
+	mutex_lock(&sit_i->sentry_lock);
+
+	old_cursegno = curseg->segno;
+
+	/* change the current segment */
+	if (segno != curseg->segno) {
+		curseg->next_segno = segno;
+		change_curseg(sbi, type, true);
+		recover_curseg = true;
+	} else {
+		old_blkoff = curseg->next_blkoff;
+	}
+
+	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
+	__add_sum_entry(sbi, type, sum);
+
+	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
+	locate_dirty_segment(sbi, old_cursegno);
+
+	if (recover_curseg) {
+		curseg->next_segno = old_cursegno;
+		change_curseg(sbi, type, true);
+	} else {
+		curseg->next_blkoff = old_blkoff;
+	}
+
+	mutex_unlock(&sit_i->sentry_lock);
+	mutex_unlock(&curseg->curseg_mutex);
+}
+
 void recover_data_page(struct f2fs_sb_info *sbi,
 			struct page *page, struct f2fs_summary *sum,
 			block_t old_blkaddr, block_t new_blkaddr)
-- 
2.3.3
