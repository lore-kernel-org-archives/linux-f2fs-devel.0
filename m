From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: don't allocate new blocks on unclean
 shutdown
Date: Mon,  1 Oct 2018 19:02:23 -0700
Message-ID: <20181002020223.76087-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1g7A1D-00084z-OY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Oct 2018 02:02:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g7A19-00AbYT-75
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Oct 2018 02:02:35 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

We have to keep data for roll-forward recovery. Without this patch, we're
able to lose there-in data by quota overwrites.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c         | 14 ++++++++++++--
 fsck/fsck.h         |  4 ++--
 fsck/mkquota.c      |  3 ++-
 fsck/node.c         |  9 ++++++++-
 fsck/quotaio.c      |  3 ++-
 fsck/quotaio_tree.c | 26 ++++++++++++++++----------
 fsck/quotaio_tree.h |  2 +-
 fsck/quotaio_v2.c   |  2 +-
 fsck/segment.c      | 21 +++++++++++++++++----
 include/f2fs_fs.h   |  1 +
 10 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 63d49e4..85d9823 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1988,8 +1988,9 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	unsigned long long cp_blk_no;
-	u32 flags = CP_UMOUNT_FLAG;
+	u32 flags = c.alloc_failed ? CP_FSCK_FLAG: CP_UMOUNT_FLAG;
 	block_t orphan_blks = 0;
+	block_t cp_blocks;
 	u32 i;
 	int ret;
 	u_int32_t crc = 0;
@@ -2001,7 +2002,13 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
 		flags |= CP_DISABLED_FLAG;
 
-	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
+	if (flags & CP_UMOUNT_FLAG)
+		cp_blocks = 8;
+	else
+		cp_blocks = 5;
+
+	set_cp(cp_pack_total_block_count, cp_blocks +
+				orphan_blks + get_sb(cp_payload));
 
 	flags = update_nat_bits_flags(sb, cp, flags);
 	flags |= CP_NOCRC_RECOVERY_FLAG;
@@ -2033,6 +2040,9 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
 		struct curseg_info *curseg = CURSEG_I(sbi, i);
 
+		if (!(flags & CP_UMOUNT_FLAG) && IS_NODESEG(i))
+			continue;
+
 		ret = dev_write_block(curseg->sum_blk, cp_blk_no++);
 		ASSERT(ret >= 0);
 	}
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 1d3e438..b2227d2 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -235,7 +235,7 @@ int f2fs_sload(struct f2fs_sb_info *);
 /* segment.c */
 void reserve_new_block(struct f2fs_sb_info *, block_t *,
 					struct f2fs_summary *, int);
-void new_data_block(struct f2fs_sb_info *, void *,
+int new_data_block(struct f2fs_sb_info *, void *,
 					struct dnode_of_data *, int);
 int f2fs_build_file(struct f2fs_sb_info *, struct dentry *);
 void f2fs_alloc_nid(struct f2fs_sb_info *, nid_t *, int);
@@ -248,7 +248,7 @@ u64 f2fs_read(struct f2fs_sb_info *, nid_t, u8 *, u64, pgoff_t);
 u64 f2fs_write(struct f2fs_sb_info *, nid_t, u8 *, u64, pgoff_t);
 void f2fs_filesize_update(struct f2fs_sb_info *, nid_t, u64);
 
-void get_dnode_of_data(struct f2fs_sb_info *, struct dnode_of_data *,
+int get_dnode_of_data(struct f2fs_sb_info *, struct dnode_of_data *,
 					pgoff_t, int);
 void make_dentry_ptr(struct f2fs_dentry_ptr *, struct f2fs_node *, void *, int);
 int f2fs_create(struct f2fs_sb_info *, struct dentry *);
diff --git a/fsck/mkquota.c b/fsck/mkquota.c
index b54be08..c1abbc4 100644
--- a/fsck/mkquota.c
+++ b/fsck/mkquota.c
@@ -53,7 +53,8 @@ static void write_dquots(dict_t *dict, struct quota_handle *qh)
 			print_dquot("write", dq);
 			dq->dq_h = qh;
 			update_grace_times(dq);
-			qh->qh_ops->commit_dquot(dq);
+			if (qh->qh_ops->commit_dquot(dq))
+				break;
 		}
 	}
 }
diff --git a/fsck/node.c b/fsck/node.c
index 7f4a28b..18dd186 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -179,7 +179,7 @@ got:
 	return level;
 }
 
-void get_dnode_of_data(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
+int get_dnode_of_data(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 						pgoff_t index, int mode)
 {
 	int offset[4];
@@ -205,6 +205,12 @@ void get_dnode_of_data(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 
 	for (i = 1; i <= level; i++) {
 		if (!nids[i] && mode == ALLOC_NODE) {
+			struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+
+			if (!is_set_ckpt_flags(cp, CP_UMOUNT_FLAG)) {
+				c.alloc_failed = 1;
+				return -EINVAL;
+			}
 			f2fs_alloc_nid(sbi, &nids[i], 0);
 
 			dn->nid = nids[i];
@@ -247,4 +253,5 @@ void get_dnode_of_data(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 	dn->ofs_in_node = offset[level];
 	dn->data_blkaddr = datablock_addr(dn->node_blk, dn->ofs_in_node);
 	dn->node_blkaddr = nblk[level];
+	return 0;
 }
diff --git a/fsck/quotaio.c b/fsck/quotaio.c
index 26f8a71..cc517bd 100644
--- a/fsck/quotaio.c
+++ b/fsck/quotaio.c
@@ -80,7 +80,8 @@ static unsigned int quota_write_nomount(struct quota_file *qf,
 	written = f2fs_write(qf->sbi, qf->ino, buf, size, offset);
 	if (qf->filesize < offset + written)
 		qf->filesize = offset + written;
-
+	if (written != size)
+		return -EIO;
 	return written;
 }
 
diff --git a/fsck/quotaio_tree.c b/fsck/quotaio_tree.c
index 5aef228..ebee862 100644
--- a/fsck/quotaio_tree.c
+++ b/fsck/quotaio_tree.c
@@ -291,7 +291,9 @@ static int do_insert_tree(struct quota_handle *h, struct dquot *dquot,
 	if (newson && ret >= 0) {
 		ref[get_index(dquot->dq_id, depth)] =
 			cpu_to_le32(newblk);
-		write_blk(h, *treeblk, buf);
+		ret = write_blk(h, *treeblk, buf);
+		if (ret)
+			goto out_buf;
 	} else if (newact && ret < 0) {
 		put_free_dqblk(h, buf, *treeblk);
 	}
@@ -302,17 +304,20 @@ out_buf:
 }
 
 /* Wrapper for inserting quota structure into tree */
-static void dq_insert_tree(struct quota_handle *h, struct dquot *dquot)
+static int dq_insert_tree(struct quota_handle *h, struct dquot *dquot)
 {
 	unsigned int tmp = QT_TREEOFF;
+	int err;
 
-	if (do_insert_tree(h, dquot, &tmp, 0) < 0)
+	err = do_insert_tree(h, dquot, &tmp, 0);
+	if (err < 0)
 		log_err("Cannot write quota (id %u): %s",
 			(unsigned int) dquot->dq_id, strerror(errno));
+	return err;
 }
 
 /* Write dquot to file */
-void qtree_write_dquot(struct dquot *dquot)
+int qtree_write_dquot(struct dquot *dquot)
 {
 	errcode_t retval;
 	unsigned int ret;
@@ -321,21 +326,22 @@ void qtree_write_dquot(struct dquot *dquot)
 	struct qtree_mem_dqinfo *info =
 			&dquot->dq_h->qh_info.u.v2_mdqi.dqi_qtree;
 
-
 	log_debug("writing ddquot 1: off=%llu, info->dqi_entry_size=%u",
 			dquot->dq_dqb.u.v2_mdqb.dqb_off,
 			info->dqi_entry_size);
 	retval = quota_get_mem(info->dqi_entry_size, &ddquot);
 	if (retval) {
-		errno = ENOMEM;
 		log_err("Quota write failed (id %u): %s",
 			(unsigned int)dquot->dq_id, strerror(errno));
-		return;
+		return -ENOMEM;
 	}
 	memset(ddquot, 0, info->dqi_entry_size);
 
 	if (!dquot->dq_dqb.u.v2_mdqb.dqb_off) {
-		dq_insert_tree(dquot->dq_h, dquot);
+		if (dq_insert_tree(dquot->dq_h, dquot)) {
+			quota_free_mem(&ddquot);
+			return -EIO;
+		}
 	}
 	info->dqi_ops->mem2disk_dqblk(ddquot, dquot);
 	log_debug("writing ddquot 2: off=%llu, info->dqi_entry_size=%u",
@@ -345,12 +351,12 @@ void qtree_write_dquot(struct dquot *dquot)
 			info->dqi_entry_size);
 
 	if (ret != info->dqi_entry_size) {
-		if (ret > 0)
-			errno = ENOSPC;
 		log_err("Quota write failed (id %u): %s",
 			(unsigned int)dquot->dq_id, strerror(errno));
+		return ret;
 	}
 	quota_free_mem(&ddquot);
+	return 0;
 }
 
 /* Free dquot entry in data block */
diff --git a/fsck/quotaio_tree.h b/fsck/quotaio_tree.h
index aed93a8..8f4dae0 100644
--- a/fsck/quotaio_tree.h
+++ b/fsck/quotaio_tree.h
@@ -58,7 +58,7 @@ struct qtree_mem_dqinfo {
 						 * manipulation */
 };
 
-void qtree_write_dquot(struct dquot *dquot);
+int qtree_write_dquot(struct dquot *dquot);
 struct dquot *qtree_read_dquot(struct quota_handle *h, qid_t id);
 void qtree_delete_dquot(struct dquot *dquot);
 int qtree_entry_unused(struct qtree_mem_dqinfo *info, char *disk);
diff --git a/fsck/quotaio_v2.c b/fsck/quotaio_v2.c
index 478cd17..1404332 100644
--- a/fsck/quotaio_v2.c
+++ b/fsck/quotaio_v2.c
@@ -261,7 +261,7 @@ static int v2_commit_dquot(struct dquot *dquot)
 	{
 		qtree_delete_dquot(dquot);
 	} else {
-		qtree_write_dquot(dquot);
+		return qtree_write_dquot(dquot);
 	}
 	return 0;
 }
diff --git a/fsck/segment.c b/fsck/segment.c
index 4f8bdb4..4ce623f 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -61,12 +61,18 @@ void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 	update_sum_entry(sbi, *to, sum);
 }
 
-void new_data_block(struct f2fs_sb_info *sbi, void *block,
+int new_data_block(struct f2fs_sb_info *sbi, void *block,
 				struct dnode_of_data *dn, int type)
 {
 	struct f2fs_summary sum;
 	struct node_info ni;
 	unsigned int blkaddr = datablock_addr(dn->node_blk, dn->ofs_in_node);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+
+	if (!is_set_ckpt_flags(cp, CP_UMOUNT_FLAG)) {
+		c.alloc_failed = 1;
+		return -EINVAL;
+	}
 
 	ASSERT(dn->node_blk);
 	memset(block, 0, BLOCK_SZ);
@@ -80,6 +86,7 @@ void new_data_block(struct f2fs_sb_info *sbi, void *block,
 	else if (blkaddr == NEW_ADDR)
 		dn->idirty = 1;
 	set_data_blkaddr(dn);
+	return 0;
 }
 
 u64 f2fs_read(struct f2fs_sb_info *sbi, nid_t ino, u8 *buffer,
@@ -179,6 +186,7 @@ u64 f2fs_write(struct f2fs_sb_info *sbi, nid_t ino, u8 *buffer,
 	block_t blkaddr;
 	void* index_node = NULL;
 	int idirty = 0;
+	int err;
 
 	/* Memory allocation for block buffer and inode. */
 	blk_buffer = calloc(BLOCK_SZ, 2);
@@ -196,8 +204,10 @@ u64 f2fs_write(struct f2fs_sb_info *sbi, nid_t ino, u8 *buffer,
 	while (count > 0) {
 		if (remained_blkentries == 0) {
 			set_new_dnode(&dn, inode, NULL, ino);
-			get_dnode_of_data(sbi, &dn, F2FS_BYTES_TO_BLK(offset),
-					ALLOC_NODE);
+			err = get_dnode_of_data(sbi, &dn,
+					F2FS_BYTES_TO_BLK(offset), ALLOC_NODE);
+			if (err)
+				break;
 			idirty |= dn.idirty;
 			if (index_node)
 				free(index_node);
@@ -209,7 +219,10 @@ u64 f2fs_write(struct f2fs_sb_info *sbi, nid_t ino, u8 *buffer,
 
 		blkaddr = datablock_addr(dn.node_blk, dn.ofs_in_node);
 		if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR) {
-			new_data_block(sbi, blk_buffer, &dn, CURSEG_WARM_DATA);
+			err = new_data_block(sbi, blk_buffer,
+						&dn, CURSEG_WARM_DATA);
+			if (err)
+				break;
 			blkaddr = dn.data_blkaddr;
 		}
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index e86eac1..cdf54e5 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -371,6 +371,7 @@ struct f2fs_configuration {
 	int fix_on;
 	int defset;
 	int bug_on;
+	int alloc_failed;
 	int auto_fix;
 	int quota_fix;
 	int preen_mode;
-- 
2.19.0.605.g01d371f741-goog
