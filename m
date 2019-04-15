From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: fix to check total valid block count
 before block allocation
Date: Mon, 15 Apr 2019 17:14:38 +0800
Message-ID: <20190415091438.13559-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hFxha-0001cy-25
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 09:14:58 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFxhW-00635Z-N3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 09:14:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

Now, kernel can catch incorrect total valid block count which is exceed
max user block count of image.

Then, generic/051,476 of fstest reports below message:

Apr 15 11:08:03 szvp000201624 kernel: [ 2533.515813] F2FS-fs (zram1): Wrong valid_user_blocks: 469505, user_block_count: 469504
Apr 15 11:08:03 szvp000201624 kernel: [ 2533.519166] F2FS-fs (zram1): Failed to get valid F2FS checkpoint

The reason is that when fsck repairs corrupted quota sysfile, it didn't
check max user block count when allocating new block for quota sysfile,
so ckpt.valid_block_count can exceed max user block count, result in
mount failure later.

Adding upper boundary check of block count in reserve_new_block() to
fix this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dir.c     |  9 ++++++---
 fsck/fsck.h    |  2 +-
 fsck/node.c    |  7 ++++++-
 fsck/segment.c | 28 +++++++++++++++++++++++++---
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 98a0b7a..f1665c4 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -360,7 +360,8 @@ static void make_empty_dir(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
 	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
 
 	set_summary(&sum, ino, 0, ni.version);
-	reserve_new_block(sbi, &blkaddr, &sum, CURSEG_HOT_DATA);
+	ret = reserve_new_block(sbi, &blkaddr, &sum, CURSEG_HOT_DATA);
+	ASSERT(!ret);
 
 	ret = dev_write_block(dent_blk, blkaddr);
 	ASSERT(ret >= 0);
@@ -395,7 +396,8 @@ static void page_symlink(struct f2fs_sb_info *sbi, struct f2fs_node *inode,
 	memcpy(data_blk, symname, symlen);
 
 	set_summary(&sum, ino, 0, ni.version);
-	reserve_new_block(sbi, &blkaddr, &sum, CURSEG_WARM_DATA);
+	ret = reserve_new_block(sbi, &blkaddr, &sum, CURSEG_WARM_DATA);
+	ASSERT(!ret);
 
 	ret = dev_write_block(data_blk, blkaddr);
 	ASSERT(ret >= 0);
@@ -631,7 +633,8 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
 
 	/* write child */
 	set_summary(&sum, de->ino, 0, ni.version);
-	reserve_new_block(sbi, &blkaddr, &sum, CURSEG_HOT_NODE);
+	ret = reserve_new_block(sbi, &blkaddr, &sum, CURSEG_HOT_NODE);
+	ASSERT(!ret);
 
 	/* update nat info */
 	update_nat_blkaddr(sbi, de->ino, de->ino, blkaddr);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index cbd6e93..376ced7 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -234,7 +234,7 @@ int f2fs_resize(struct f2fs_sb_info *);
 int f2fs_sload(struct f2fs_sb_info *);
 
 /* segment.c */
-void reserve_new_block(struct f2fs_sb_info *, block_t *,
+int reserve_new_block(struct f2fs_sb_info *, block_t *,
 					struct f2fs_summary *, int);
 int new_data_block(struct f2fs_sb_info *, void *,
 					struct dnode_of_data *, int);
diff --git a/fsck/node.c b/fsck/node.c
index 18dd186..882f355 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -65,6 +65,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 	struct node_info ni;
 	block_t blkaddr = NULL_ADDR;
 	int type;
+	int ret;
 
 	f2fs_inode = dn->inode_blk;
 
@@ -86,7 +87,11 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, 0, ni.version);
-	reserve_new_block(sbi, &blkaddr, &sum, type);
+	ret = reserve_new_block(sbi, &blkaddr, &sum, type);
+	if (ret) {
+		free(node_blk);
+		return 0;
+	}
 
 	/* update nat info */
 	update_nat_blkaddr(sbi, le32_to_cpu(f2fs_inode->footer.ino),
diff --git a/fsck/segment.c b/fsck/segment.c
index 4ce623f..6dfea9b 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -24,7 +24,7 @@ static void write_inode(u64 blkaddr, struct f2fs_node *inode)
 	ASSERT(dev_write_block(inode, blkaddr) >= 0);
 }
 
-void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
+int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 			struct f2fs_summary *sum, int type)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -32,10 +32,25 @@ void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 	u64 blkaddr, offset;
 	u64 old_blkaddr = *to;
 
+	if (old_blkaddr == NULL_ADDR) {
+		if (c.func == FSCK) {
+			if (fsck->chk.valid_blk_cnt >= sbi->user_block_count) {
+				ERR_MSG("Not enough space");
+				return -ENOSPC;
+			}
+		} else {
+			if (sbi->total_valid_block_count >=
+						sbi->user_block_count) {
+				ERR_MSG("Not enough space");
+				return -ENOSPC;
+			}
+		}
+	}
+
 	blkaddr = SM_I(sbi)->main_blkaddr;
 
 	if (find_next_free_block(sbi, &blkaddr, 0, type)) {
-		ERR_MSG("Not enough space to allocate blocks");
+		ERR_MSG("Can't find free block");
 		ASSERT(0);
 	}
 
@@ -59,6 +74,8 @@ void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 	/* read/write SSA */
 	*to = (block_t)blkaddr;
 	update_sum_entry(sbi, *to, sum);
+
+	return 0;
 }
 
 int new_data_block(struct f2fs_sb_info *sbi, void *block,
@@ -68,6 +85,7 @@ int new_data_block(struct f2fs_sb_info *sbi, void *block,
 	struct node_info ni;
 	unsigned int blkaddr = datablock_addr(dn->node_blk, dn->ofs_in_node);
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	int ret;
 
 	if (!is_set_ckpt_flags(cp, CP_UMOUNT_FLAG)) {
 		c.alloc_failed = 1;
@@ -79,7 +97,11 @@ int new_data_block(struct f2fs_sb_info *sbi, void *block,
 
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
-	reserve_new_block(sbi, &dn->data_blkaddr, &sum, type);
+	ret = reserve_new_block(sbi, &dn->data_blkaddr, &sum, type);
+	if (ret) {
+		c.alloc_failed = 1;
+		return ret;
+	}
 
 	if (blkaddr == NULL_ADDR)
 		inc_inode_blocks(dn);
-- 
2.18.0.rc1
