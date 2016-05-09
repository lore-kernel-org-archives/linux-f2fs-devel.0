From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/6] f2fs: support in batch fzero in dnode page
Date: Mon, 9 May 2016 19:56:31 +0800
Message-ID: <20160509115635.123946-2-yuchao0@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509115635.123946-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch tries to speedup fzero_range by making space preallocation and
address removal of blocks in one dnode page as in batch operation.

In virtual machine, with zram driver:

dd if=/dev/zero of=/mnt/f2fs/file bs=1M count=4096
time xfs_io -f /mnt/f2fs/file -c "fzero 0 4096M"

Before:
real	0m3.276s
user	0m0.008s
sys	0m3.260s

After:
real	0m1.568s
user	0m0.000s
sys	0m1.564s

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/file.c | 61 +++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 75b0084..f75cd65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1963,8 +1963,10 @@ void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *, struct inode *,
 void f2fs_flush_merged_bios(struct f2fs_sb_info *);
 int f2fs_submit_page_bio(struct f2fs_io_info *);
 void f2fs_submit_page_mbio(struct f2fs_io_info *);
+void __set_data_blkaddr(struct dnode_of_data *);
 void set_data_blkaddr(struct dnode_of_data *);
 void f2fs_update_data_blkaddr(struct dnode_of_data *, block_t);
+int reserve_new_blocks(struct dnode_of_data *, unsigned int, unsigned int);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_get_block(struct dnode_of_data *, pgoff_t);
 ssize_t f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5ead254..d5910bc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1035,6 +1035,38 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	return ret;
 }
 
+static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
+								pgoff_t end)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	pgoff_t index = start;
+	unsigned int ofs_in_node = dn->ofs_in_node, count = 0;
+	int ret;
+
+	for (; index < end; index++, ofs_in_node++) {
+		if (datablock_addr(dn->node_page, ofs_in_node) == NULL_ADDR)
+			count++;
+	}
+
+	ret = reserve_new_blocks(dn, dn->ofs_in_node, count);
+	if (ret)
+		return ret;
+
+	for (index = start; index < end; index++, dn->ofs_in_node++) {
+		dn->data_blkaddr =
+				datablock_addr(dn->node_page, dn->ofs_in_node);
+		if (dn->data_blkaddr != NEW_ADDR) {
+			invalidate_blocks(sbi, dn->data_blkaddr);
+			dn->data_blkaddr = NEW_ADDR;
+			__set_data_blkaddr(dn);
+		}
+	}
+
+	f2fs_update_extent_cache_range(dn, start, 0, end - start);
+
+	return 0;
+}
+
 static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 								int mode)
 {
@@ -1085,35 +1117,32 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 					(loff_t)pg_start << PAGE_SHIFT);
 		}
 
-		for (index = pg_start; index < pg_end; index++) {
+		for (index = pg_start; index < pg_end;) {
 			struct dnode_of_data dn;
-			struct page *ipage;
+			unsigned int end_offset;
+			pgoff_t end;
 
 			f2fs_lock_op(sbi);
 
-			ipage = get_node_page(sbi, inode->i_ino);
-			if (IS_ERR(ipage)) {
-				ret = PTR_ERR(ipage);
-				f2fs_unlock_op(sbi);
-				goto out;
-			}
-
-			set_new_dnode(&dn, inode, ipage, NULL, 0);
-			ret = f2fs_reserve_block(&dn, index);
+			set_new_dnode(&dn, inode, NULL, NULL, 0);
+			ret = get_dnode_of_data(&dn, index, ALLOC_NODE);
 			if (ret) {
 				f2fs_unlock_op(sbi);
 				goto out;
 			}
 
-			if (dn.data_blkaddr != NEW_ADDR) {
-				invalidate_blocks(sbi, dn.data_blkaddr);
-				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
-			}
+			end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
+			end = min(pg_end, end_offset - dn.ofs_in_node + index);
+
+			ret = f2fs_do_zero_range(&dn, index, end);
 			f2fs_put_dnode(&dn);
 			f2fs_unlock_op(sbi);
+			if (ret)
+				goto out;
 
+			index = end;
 			new_size = max_t(loff_t, new_size,
-				(loff_t)(index + 1) << PAGE_SHIFT);
+					(loff_t)index << PAGE_SHIFT);
 		}
 
 		if (off_end) {
-- 
2.8.2.311.gee88674
