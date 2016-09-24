From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs-tools: use shorter config variable name
Date: Sat, 24 Sep 2016 11:21:40 -0700
Message-ID: <20160924182140.25395-3-jaegeuk@kernel.org>
References: <20160924182140.25395-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bnraQ-0005gu-8F
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 18:22:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bnraL-0002QJ-5g
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 18:22:06 +0000
In-Reply-To: <20160924182140.25395-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch has no functional change.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c              |  12 +--
 fsck/fsck.c              |  88 +++++++++---------
 fsck/main.c              | 198 +++++++++++++++++++--------------------
 fsck/mount.c             |  50 +++++-----
 fsck/resize.c            |  30 +++---
 include/f2fs_fs.h        |  26 +++---
 lib/libf2fs.c            | 108 +++++++++++-----------
 lib/libf2fs_io.c         |  32 +++----
 lib/zbc.c                |  46 +++++-----
 mkfs/f2fs_format.c       | 235 +++++++++++++++++++++++++----------------------
 mkfs/f2fs_format_main.c  |  53 ++++++-----
 mkfs/f2fs_format_utils.h |   2 +-
 12 files changed, 446 insertions(+), 434 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 332ff7c..80b18d2 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -363,17 +363,17 @@ void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
 		name[le32_to_cpu(inode->i_namelen)] = 0;
 		sprintf(path, "./lost_found/%s", name);
 
-		config.dump_fd = open(path, O_TRUNC|O_CREAT|O_RDWR, 0666);
-		ASSERT(config.dump_fd >= 0);
+		c.dump_fd = open(path, O_TRUNC|O_CREAT|O_RDWR, 0666);
+		ASSERT(c.dump_fd >= 0);
 
 		/* dump file's data */
 		dump_inode_blk(sbi, ni->ino, node_blk);
 
 		/* adjust file size */
-		ret = ftruncate(config.dump_fd, le32_to_cpu(inode->i_size));
+		ret = ftruncate(c.dump_fd, le32_to_cpu(inode->i_size));
 		ASSERT(ret >= 0);
 
-		close(config.dump_fd);
+		close(c.dump_fd);
 	}
 }
 
@@ -420,7 +420,7 @@ static void dump_node_from_blkaddr(u32 blk_addr)
 	ret = dev_read_block(node_blk, blk_addr);
 	ASSERT(ret >= 0);
 
-	if (config.dbg_lv > 0)
+	if (c.dbg_lv > 0)
 		print_node_info(node_blk);
 	else
 		print_inode_info(&node_blk->i, 1);
@@ -546,7 +546,7 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	}
 
 	/* print inode */
-	if (config.dbg_lv > 0)
+	if (c.dbg_lv > 0)
 		dump_node_from_blkaddr(ino_ni.blk_addr);
 
 	if (type == SEG_TYPE_CUR_DATA || type == SEG_TYPE_DATA) {
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 3c28f2a..9df9118 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -141,7 +141,7 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
 
 	if (type != SEG_TYPE_NODE && type != SEG_TYPE_CUR_NODE) {
 		/* can't fix current summary, then drop the block */
-		if (!config.fix_on || type < 0) {
+		if (!c.fix_on || type < 0) {
 			ASSERT_MSG("Summary footer is not for node segment");
 			ret = -EINVAL;
 			goto out;
@@ -161,7 +161,7 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
 	sum_entry = &(sum_blk->entries[offset]);
 
 	if (le32_to_cpu(sum_entry->nid) != nid) {
-		if (!config.fix_on || type < 0) {
+		if (!c.fix_on || type < 0) {
 			DBG(0, "nid                       [0x%x]\n", nid);
 			DBG(0, "target blk_addr           [0x%x]\n", blk_addr);
 			DBG(0, "summary blk_addr          [0x%x]\n",
@@ -182,7 +182,7 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
 			need_fix = 1;
 		}
 	}
-	if (need_fix && !config.ro) {
+	if (need_fix && !c.ro) {
 		u64 ssa_blk;
 		int ret2;
 
@@ -255,7 +255,7 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 	if (type != SEG_TYPE_DATA && type != SEG_TYPE_CUR_DATA) {
 		/* can't fix current summary, then drop the block */
-		if (!config.fix_on || type < 0) {
+		if (!c.fix_on || type < 0) {
 			ASSERT_MSG("Summary footer is not for data segment");
 			ret = -EINVAL;
 			goto out;
@@ -277,7 +277,7 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	if (le32_to_cpu(sum_entry->nid) != parent_nid ||
 			sum_entry->version != version ||
 			le16_to_cpu(sum_entry->ofs_in_node) != idx_in_node) {
-		if (!config.fix_on || type < 0) {
+		if (!c.fix_on || type < 0) {
 			DBG(0, "summary_entry.nid         [0x%x]\n",
 					le32_to_cpu(sum_entry->nid));
 			DBG(0, "summary_entry.version     [0x%x]\n",
@@ -305,7 +305,7 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			need_fix = 1;
 		}
 	}
-	if (need_fix && !config.ro) {
+	if (need_fix && !c.ro) {
 		u64 ssa_blk;
 		int ret2;
 
@@ -633,7 +633,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			if (find_and_dec_hard_link_list(sbi, nid)) {
 				ASSERT_MSG("[0x%x] needs more i_links=0x%x",
 						nid, i_links);
-				if (config.fix_on) {
+				if (c.fix_on) {
 					node_blk->i.i_links =
 						cpu_to_le32(i_links + 1);
 					need_fix = 1;
@@ -650,7 +650,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 
 	if (fsck_chk_xattr_blk(sbi, nid,
 			le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt) &&
-			config.fix_on) {
+			c.fix_on) {
 		node_blk->i.i_xattr_nid = 0;
 		need_fix = 1;
 		FIX_MSG("Remove xattr block: 0x%x, x_nid = 0x%x",
@@ -727,7 +727,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					file_is_encrypt(node_blk->i.i_advise));
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
-			} else if (config.fix_on) {
+			} else if (c.fix_on) {
 				node_blk->i.i_addr[idx] = 0;
 				need_fix = 1;
 				FIX_MSG("[0x%x] i_addr[%d] = 0", nid, idx);
@@ -756,7 +756,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
 		} else if (ret == -EINVAL) {
-			if (config.fix_on) {
+			if (c.fix_on) {
 				node_blk->i.i_nid[idx] = 0;
 				need_fix = 1;
 				FIX_MSG("[0x%x] i_nid[%d] = 0", nid, idx);
@@ -779,7 +779,7 @@ skip:
 	if (child.state & FSCK_UNMATCHED_EXTENT) {
 		ASSERT_MSG("ino: 0x%x has wrong ext: [pgofs:%u, blk:%u, len:%u]",
 				nid, child.ei.fofs, child.ei.blk, child.ei.len);
-		if (config.fix_on)
+		if (c.fix_on)
 			need_fix = 1;
 	}
 check:
@@ -787,7 +787,7 @@ check:
 		ASSERT_MSG("ino: 0x%x has i_blocks: %08"PRIx64", "
 				"but has %u blocks",
 				nid, i_blocks, *blk_cnt);
-		if (config.fix_on) {
+		if (c.fix_on) {
 			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
 			need_fix = 1;
 			FIX_MSG("[0x%x] i_blocks=0x%08"PRIx64" -> 0x%x",
@@ -811,7 +811,7 @@ skip_blkcnt_fix:
 		if (i_links != child.links) {
 			ASSERT_MSG("ino: 0x%x i_links: %u, real links: %u",
 					nid, i_links, child.links);
-			if (config.fix_on) {
+			if (c.fix_on) {
 				node_blk->i.i_links = cpu_to_le32(child.links);
 				need_fix = 1;
 				FIX_MSG("Dir: 0x%x i_links= 0x%x -> 0x%x",
@@ -822,7 +822,7 @@ skip_blkcnt_fix:
 				!(node_blk->i.i_inline & F2FS_INLINE_DOTS)) {
 			ASSERT_MSG("ino: 0x%x dots: %u",
 					nid, child.dots);
-			if (config.fix_on) {
+			if (c.fix_on) {
 				node_blk->i.i_inline |= F2FS_INLINE_DOTS;
 				need_fix = 1;
 				FIX_MSG("Dir: 0x%x set inline_dots", nid);
@@ -832,7 +832,7 @@ skip_blkcnt_fix:
 	if (ftype == F2FS_FT_SYMLINK && i_blocks && i_size == 0) {
 		DBG(1, "ino: 0x%x i_blocks: %lu with zero i_size",
 							nid, i_blocks);
-		if (config.fix_on) {
+		if (c.fix_on) {
 			u64 i_size = i_blocks * F2FS_BLKSIZE;
 
 			node_blk->i.i_size = cpu_to_le64(i_size);
@@ -845,14 +845,14 @@ skip_blkcnt_fix:
 	if (ftype == F2FS_FT_ORPHAN && i_links) {
 		MSG(0, "ino: 0x%x is orphan inode, but has i_links: %u",
 				nid, i_links);
-		if (config.fix_on) {
+		if (c.fix_on) {
 			node_blk->i.i_links = 0;
 			need_fix = 1;
 			FIX_MSG("ino: 0x%x orphan_inode, i_links= 0x%x -> 0",
 					nid, i_links);
 		}
 	}
-	if (need_fix && !config.ro) {
+	if (need_fix && !c.ro) {
 		/* drop extent information to avoid potential wrong access */
 		node_blk->i.i_ext.len = 0;
 		ret = dev_write_block(node_blk, ni->blk_addr);
@@ -883,13 +883,13 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			file_is_encrypt(inode->i_advise));
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
-		} else if (config.fix_on) {
+		} else if (c.fix_on) {
 			node_blk->dn.addr[idx] = 0;
 			need_fix = 1;
 			FIX_MSG("[0x%x] dn.addr[%d] = 0", nid, idx);
 		}
 	}
-	if (need_fix && !config.ro) {
+	if (need_fix && !c.ro) {
 		ret = dev_write_block(node_blk, ni->blk_addr);
 		ASSERT(ret >= 0);
 	}
@@ -912,7 +912,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL) {
-			if (!config.fix_on)
+			if (!c.fix_on)
 				printf("should delete in.nid[i] = 0;\n");
 			else {
 				node_blk->in.nid[i] = 0;
@@ -924,7 +924,7 @@ skip:
 		}
 	}
 
-	if (need_fix && !config.ro) {
+	if (need_fix && !c.ro) {
 		struct node_info ni;
 		nid_t nid = le32_to_cpu(node_blk->footer.nid);
 
@@ -952,7 +952,7 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL) {
-			if (!config.fix_on)
+			if (!c.fix_on)
 				printf("should delete in.nid[i] = 0;\n");
 			else {
 				node_blk->in.nid[i] = 0;
@@ -964,7 +964,7 @@ skip:
 		}
 	}
 
-	if (need_fix && !config.ro) {
+	if (need_fix && !c.ro) {
 		struct node_info ni;
 		nid_t nid = le32_to_cpu(node_blk->footer.nid);
 
@@ -1030,7 +1030,7 @@ static void print_dentry(__u32 depth, __u8 *name,
 	int bit_offset;
 	unsigned char new[F2FS_NAME_LEN + 1];
 
-	if (config.dbg_lv != -1)
+	if (c.dbg_lv != -1)
 		return;
 
 	name_len = le16_to_cpu(dentry[idx].name_len);
@@ -1252,7 +1252,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 		if (!IS_VALID_NID(sbi, le32_to_cpu(dentry[i].ino))) {
 			ASSERT_MSG("Bad dentry 0x%x with invalid NID/ino 0x%x",
 				    i, le32_to_cpu(dentry[i].ino));
-			if (config.fix_on) {
+			if (c.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x with bad ino 0x%x",
 					i, le32_to_cpu(dentry[i].ino));
 				test_and_clear_bit_le(i, bitmap);
@@ -1266,7 +1266,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 		if ((ftype <= F2FS_FT_UNKNOWN || ftype > F2FS_FT_LAST_FILE_TYPE)) {
 			ASSERT_MSG("Bad dentry 0x%x with unexpected ftype 0x%x",
 						le32_to_cpu(dentry[i].ino), ftype);
-			if (config.fix_on) {
+			if (c.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x with bad ftype 0x%x",
 					i, ftype);
 				test_and_clear_bit_le(i, bitmap);
@@ -1280,7 +1280,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 
 		if (name_len == 0) {
 			ASSERT_MSG("Bad dentry 0x%x with zero name_len", i);
-			if (config.fix_on) {
+			if (c.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x", i);
 				test_and_clear_bit_le(i, bitmap);
 				fixed = 1;
@@ -1342,7 +1342,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 				NULL, le32_to_cpu(dentry[i].ino), name,
 				ftype, TYPE_INODE, &blk_cnt, NULL);
 
-		if (ret && config.fix_on) {
+		if (ret && c.fix_on) {
 			int j;
 
 			for (j = 0; j < slots; j++)
@@ -1413,7 +1413,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			de_blk->dentry, de_blk->filename,
 			NR_DENTRY_IN_BLOCK, last_blk, encrypted);
 
-	if (dentries < 0 && !config.ro) {
+	if (dentries < 0 && !c.ro) {
 		ret = dev_write_block(de_blk, blk_addr);
 		ASSERT(ret >= 0);
 		DBG(1, "[%3d] Dentry Block [0x%x] Fixed hash_codes\n\n",
@@ -1510,12 +1510,12 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			if (!ret)
 				new_blk->ino[new_entry_count++] =
 							orphan_blk->ino[j];
-			else if (ret && config.fix_on)
+			else if (ret && c.fix_on)
 				FIX_MSG("[0x%x] remove from orphan list", ino);
 			else if (ret)
 				ASSERT_MSG("[0x%x] wrong orphan inode", ino);
 		}
-		if (!config.ro && config.fix_on &&
+		if (!c.ro && c.fix_on &&
 				entry_count != new_entry_count) {
 			new_blk->entry_count = cpu_to_le32(new_entry_count);
 			ret = dev_write_block(new_blk, start_blk + i);
@@ -1838,7 +1838,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 					node->nid, node->links);
 			node = node->next;
 		}
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] Unreachable nat entries                       ");
@@ -1847,7 +1847,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", nr_unref_nid);
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] SIT valid block bitmap checking                ");
@@ -1857,7 +1857,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf("[Fail]\n");
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] Hard link checking for regular file           ");
@@ -1866,7 +1866,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.multi_hard_link_files);
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] valid_block_count matching with CP            ");
@@ -1875,7 +1875,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", (u32)fsck->chk.valid_blk_cnt);
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] valid_node_count matcing with CP (de lookup)  ");
@@ -1884,7 +1884,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_node_cnt);
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] valid_node_count matcing with CP (nat lookup) ");
@@ -1893,7 +1893,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_nat_entry_cnt);
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] valid_inode_count matched with CP             ");
@@ -1902,7 +1902,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_inode_cnt);
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] free segment_count matched with CP            ");
@@ -1912,7 +1912,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.sit_free_segs);
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] next block offset is free                     ");
@@ -1921,7 +1921,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail]\n");
 		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
+		c.bug_on = 1;
 	}
 
 	printf("[FSCK] fixing SIT types\n");
@@ -1929,7 +1929,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		force = 1;
 
 	printf("[FSCK] other corrupted bugs                          ");
-	if (config.bug_on == 0) {
+	if (c.bug_on == 0) {
 		printf(" [Ok..]\n");
 	} else {
 		printf(" [Fail]\n");
@@ -1937,10 +1937,10 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	}
 
 	/* fix global metadata */
-	if (force || (config.fix_on && !config.ro)) {
+	if (force || (c.fix_on && !c.ro)) {
 		struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 
-		if (force || config.bug_on) {
+		if (force || c.bug_on) {
 			fix_hard_links(sbi);
 			fix_nat_entries(sbi);
 			move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
diff --git a/fsck/main.c b/fsck/main.c
index 464c62b..f1b065f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -85,11 +85,11 @@ void f2fs_parse_options(int argc, char *argv[])
 	if (!strcmp("fsck.f2fs", prog)) {
 		const char *option_string = "ad:fp:t";
 
-		config.func = FSCK;
+		c.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
 			case 'a':
-				config.auto_fix = 1;
+				c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption.\n");
 				break;
 			case 'p':
@@ -97,27 +97,27 @@ void f2fs_parse_options(int argc, char *argv[])
 				 *  0: default level, the same as -a
 				 *  1: check meta
 				 */
-				config.preen_mode = atoi(optarg);
-				if (config.preen_mode < 0)
-					config.preen_mode = PREEN_MODE_0;
-				else if (config.preen_mode >= PREEN_MODE_MAX)
-					config.preen_mode = PREEN_MODE_MAX - 1;
-				if (config.preen_mode == PREEN_MODE_0)
-					config.auto_fix = 1;
+				c.preen_mode = atoi(optarg);
+				if (c.preen_mode < 0)
+					c.preen_mode = PREEN_MODE_0;
+				else if (c.preen_mode >= PREEN_MODE_MAX)
+					c.preen_mode = PREEN_MODE_MAX - 1;
+				if (c.preen_mode == PREEN_MODE_0)
+					c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption in "
-					"preen mode %d\n", config.preen_mode);
+					"preen mode %d\n", c.preen_mode);
 				break;
 			case 'd':
-				config.dbg_lv = atoi(optarg);
+				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
-							config.dbg_lv);
+							c.dbg_lv);
 				break;
 			case 'f':
-				config.fix_on = 1;
+				c.fix_on = 1;
 				MSG(0, "Info: Force to fix corruption\n");
 				break;
 			case 't':
-				config.dbg_lv = -1;
+				c.dbg_lv = -1;
 				break;
 			default:
 				MSG(0, "\tError: Unknown option %c\n", option);
@@ -138,15 +138,15 @@ void f2fs_parse_options(int argc, char *argv[])
 			.blk_addr = -1,
 		};
 
-		config.func = DUMP;
+		c.func = DUMP;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			int ret = 0;
 
 			switch (option) {
 			case 'd':
-				config.dbg_lv = atoi(optarg);
+				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
-							config.dbg_lv);
+							c.dbg_lv);
 				break;
 			case 'i':
 				if (strncmp(optarg, "0x", 2))
@@ -187,46 +187,46 @@ void f2fs_parse_options(int argc, char *argv[])
 			ASSERT(ret >= 0);
 		}
 
-		config.private = &dump_opt;
+		c.private = &dump_opt;
 	} else if (!strcmp("defrag.f2fs", prog)) {
 		const char *option_string = "d:s:l:t:i";
 
-		config.func = DEFRAG;
+		c.func = DEFRAG;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			int ret = 0;
 
 			switch (option) {
 			case 'd':
-				config.dbg_lv = atoi(optarg);
+				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
-							config.dbg_lv);
+							c.dbg_lv);
 				break;
 			case 's':
 				if (strncmp(optarg, "0x", 2))
 					ret = sscanf(optarg, "%"PRIu64"",
-							&config.defrag_start);
+							&c.defrag_start);
 				else
 					ret = sscanf(optarg, "%"PRIx64"",
-							&config.defrag_start);
+							&c.defrag_start);
 				break;
 			case 'l':
 				if (strncmp(optarg, "0x", 2))
 					ret = sscanf(optarg, "%"PRIu64"",
-							&config.defrag_len);
+							&c.defrag_len);
 				else
 					ret = sscanf(optarg, "%"PRIx64"",
-							&config.defrag_len);
+							&c.defrag_len);
 				break;
 			case 't':
 				if (strncmp(optarg, "0x", 2))
 					ret = sscanf(optarg, "%"PRIu64"",
-							&config.defrag_target);
+							&c.defrag_target);
 				else
 					ret = sscanf(optarg, "%"PRIx64"",
-							&config.defrag_target);
+							&c.defrag_target);
 				break;
 			case 'i':
-				config.defrag_shrink = 1;
+				c.defrag_shrink = 1;
 				break;
 			default:
 				MSG(0, "\tError: Unknown option %c\n", option);
@@ -238,23 +238,23 @@ void f2fs_parse_options(int argc, char *argv[])
 	} else if (!strcmp("resize.f2fs", prog)) {
 		const char *option_string = "d:t:";
 
-		config.func = RESIZE;
+		c.func = RESIZE;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			int ret = 0;
 
 			switch (option) {
 			case 'd':
-				config.dbg_lv = atoi(optarg);
+				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
-							config.dbg_lv);
+							c.dbg_lv);
 				break;
 			case 't':
 				if (strncmp(optarg, "0x", 2))
 					ret = sscanf(optarg, "%"PRIu64"",
-							&config.target_sectors);
+							&c.target_sectors);
 				else
 					ret = sscanf(optarg, "%"PRIx64"",
-							&config.target_sectors);
+							&c.target_sectors);
 				break;
 			default:
 				MSG(0, "\tError: Unknown option %c\n", option);
@@ -266,19 +266,19 @@ void f2fs_parse_options(int argc, char *argv[])
 	} else if (!strcmp("sload.f2fs", prog)) {
 		const char *option_string = "d:f:t:";
 
-		config.func = SLOAD;
+		c.func = SLOAD;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
 			case 'd':
-				config.dbg_lv = atoi(optarg);
+				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
-						config.dbg_lv);
+						c.dbg_lv);
 				break;
 			case 'f':
-				config.from_dir = (char *)optarg;
+				c.from_dir = (char *)optarg;
 				break;
 			case 't':
-				config.mount_point = (char *)optarg;
+				c.mount_point = (char *)optarg;
 				break;
 			default:
 				MSG(0, "\tError: Unknown option %c\n", option);
@@ -290,18 +290,18 @@ void f2fs_parse_options(int argc, char *argv[])
 
 	if ((optind + 1) != argc) {
 		MSG(0, "\tError: Device not specified\n");
-		if (config.func == FSCK)
+		if (c.func == FSCK)
 			fsck_usage();
-		else if (config.func == DUMP)
+		else if (c.func == DUMP)
 			dump_usage();
-		else if (config.func == DEFRAG)
+		else if (c.func == DEFRAG)
 			defrag_usage();
-		else if (config.func == RESIZE)
+		else if (c.func == RESIZE)
 			resize_usage();
-		else if (config.func == SLOAD)
+		else if (c.func == SLOAD)
 			sload_usage();
 	}
-	config.device_name = argv[optind];
+	c.device_name = argv[optind];
 }
 
 static void do_fsck(struct f2fs_sb_info *sbi)
@@ -314,8 +314,8 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 
 	print_cp_state(flag);
 
-	if (!config.fix_on && !config.bug_on) {
-		switch (config.preen_mode) {
+	if (!c.fix_on && !c.bug_on) {
+		switch (c.preen_mode) {
 		case PREEN_MODE_1:
 			if (fsck_chk_meta(sbi)) {
 				MSG(0, "[FSCK] F2FS metadata   [Fail]");
@@ -327,8 +327,8 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 				return;
 			}
 
-			if (!config.ro)
-				config.fix_on = 1;
+			if (!c.ro)
+				c.fix_on = 1;
 			break;
 		}
 	} else {
@@ -342,7 +342,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 		 *     we set fix_on = 1 here, so that fsck can fix errors
 		 *     automatically
 		*/
-		config.fix_on = 1;
+		c.fix_on = 1;
 	}
 
 	fsck_chk_orphan_node(sbi);
@@ -357,7 +357,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 
 static void do_dump(struct f2fs_sb_info *sbi)
 {
-	struct dump_option *opt = (struct dump_option *)config.private;
+	struct dump_option *opt = (struct dump_option *)c.private;
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	u32 flag = le32_to_cpu(ckpt->ckpt_flags);
 
@@ -386,48 +386,48 @@ static int do_defrag(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 
-	if (config.defrag_start > get_sb(block_count))
+	if (c.defrag_start > get_sb(block_count))
 		goto out_range;
-	if (config.defrag_start < SM_I(sbi)->main_blkaddr)
-		config.defrag_start = SM_I(sbi)->main_blkaddr;
+	if (c.defrag_start < SM_I(sbi)->main_blkaddr)
+		c.defrag_start = SM_I(sbi)->main_blkaddr;
 
-	if (config.defrag_len == 0)
-		config.defrag_len = sbi->blocks_per_seg;
+	if (c.defrag_len == 0)
+		c.defrag_len = sbi->blocks_per_seg;
 
-	if (config.defrag_start + config.defrag_len > get_sb(block_count))
-		config.defrag_len = get_sb(block_count) - config.defrag_start;
+	if (c.defrag_start + c.defrag_len > get_sb(block_count))
+		c.defrag_len = get_sb(block_count) - c.defrag_start;
 
-	if (config.defrag_target == 0) {
-		config.defrag_target = config.defrag_start - 1;
-		if (!config.defrag_shrink)
-			config.defrag_target += config.defrag_len + 1;
+	if (c.defrag_target == 0) {
+		c.defrag_target = c.defrag_start - 1;
+		if (!c.defrag_shrink)
+			c.defrag_target += c.defrag_len + 1;
 	}
 
-	if (config.defrag_target < SM_I(sbi)->main_blkaddr ||
-			config.defrag_target > get_sb(block_count))
+	if (c.defrag_target < SM_I(sbi)->main_blkaddr ||
+			c.defrag_target > get_sb(block_count))
 		goto out_range;
-	if (config.defrag_target >= config.defrag_start &&
-		config.defrag_target < config.defrag_start + config.defrag_len)
+	if (c.defrag_target >= c.defrag_start &&
+		c.defrag_target < c.defrag_start + c.defrag_len)
 		goto out_range;
 
-	if (config.defrag_start > config.defrag_target)
+	if (c.defrag_start > c.defrag_target)
 		MSG(0, "Info: Move 0x%"PRIx64" <- [0x%"PRIx64"-0x%"PRIx64"]\n",
-				config.defrag_target,
-				config.defrag_start,
-				config.defrag_start + config.defrag_len - 1);
+				c.defrag_target,
+				c.defrag_start,
+				c.defrag_start + c.defrag_len - 1);
 	else
 		MSG(0, "Info: Move [0x%"PRIx64"-0x%"PRIx64"] -> 0x%"PRIx64"\n",
-				config.defrag_start,
-				config.defrag_start + config.defrag_len - 1,
-				config.defrag_target);
+				c.defrag_start,
+				c.defrag_start + c.defrag_len - 1,
+				c.defrag_target);
 
-	return f2fs_defragment(sbi, config.defrag_start, config.defrag_len,
-			config.defrag_target, config.defrag_shrink);
+	return f2fs_defragment(sbi, c.defrag_start, c.defrag_len,
+			c.defrag_target, c.defrag_shrink);
 out_range:
 	ASSERT_MSG("Out-of-range [0x%"PRIx64" ~ 0x%"PRIx64"] to 0x%"PRIx64"",
-				config.defrag_start,
-				config.defrag_start + config.defrag_len - 1,
-				config.defrag_target);
+				c.defrag_start,
+				c.defrag_start + c.defrag_len - 1,
+				c.defrag_target);
 	return -1;
 }
 
@@ -435,16 +435,16 @@ static int do_resize(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 
-	if (!config.target_sectors)
-		config.target_sectors = config.total_sectors;
+	if (!c.target_sectors)
+		c.target_sectors = c.total_sectors;
 
-	if (config.target_sectors > config.total_sectors) {
+	if (c.target_sectors > c.total_sectors) {
 		ASSERT_MSG("Out-of-range Target=0x%"PRIx64" / 0x%"PRIx64"",
-				config.target_sectors, config.total_sectors);
+				c.target_sectors, c.total_sectors);
 		return -1;
 	}
 
-	if (config.target_sectors ==
+	if (c.target_sectors ==
 			(get_sb(block_count) << get_sb(log_sectors_per_block))) {
 		ASSERT_MSG("Nothing to resize; it's same");
 		return -1;
@@ -454,15 +454,15 @@ static int do_resize(struct f2fs_sb_info *sbi)
 
 static int do_sload(struct f2fs_sb_info *sbi)
 {
-	if (!config.from_dir) {
+	if (!c.from_dir) {
 		MSG(0, "\tError: Need source directory\n");
 		sload_usage();
 		return -1;
 	}
-	if (!config.mount_point)
-		config.mount_point = "/";
+	if (!c.mount_point)
+		c.mount_point = "/";
 
-	return f2fs_sload(sbi, config.from_dir, config.mount_point, NULL, NULL);
+	return f2fs_sload(sbi, c.from_dir, c.mount_point, NULL, NULL);
 }
 
 int main(int argc, char **argv)
@@ -470,24 +470,24 @@ int main(int argc, char **argv)
 	struct f2fs_sb_info *sbi;
 	int ret = 0;
 
-	f2fs_init_configuration(&config);
+	f2fs_init_configuration();
 
 	f2fs_parse_options(argc, argv);
 
-	if (f2fs_dev_is_umounted(&config) < 0) {
-		if (!config.ro || config.func == DEFRAG) {
+	if (f2fs_dev_is_umounted() < 0) {
+		if (!c.ro || c.func == DEFRAG) {
 			MSG(0, "\tError: Not available on mounted device!\n");
 			return -1;
 		}
 
 		/* allow ro-mounted partition */
 		MSG(0, "Info: Check FS only due to RO\n");
-		config.fix_on = 0;
-		config.auto_fix = 0;
+		c.fix_on = 0;
+		c.auto_fix = 0;
 	}
 
 	/* Get device */
-	if (f2fs_get_device_info(&config) < 0)
+	if (f2fs_get_device_info() < 0)
 		return -1;
 fsck_again:
 	memset(&gfsck, 0, sizeof(gfsck));
@@ -503,7 +503,7 @@ fsck_again:
 		goto out_err;
 	}
 
-	switch (config.func) {
+	switch (c.func) {
 	case FSCK:
 		do_fsck(sbi);
 		break;
@@ -526,25 +526,25 @@ fsck_again:
 
 	f2fs_do_umount(sbi);
 
-	if (config.func == FSCK && config.bug_on) {
-		if (!config.ro && config.fix_on == 0 && config.auto_fix == 0) {
+	if (c.func == FSCK && c.bug_on) {
+		if (!c.ro && c.fix_on == 0 && c.auto_fix == 0) {
 			char ans[255] = {0};
 retry:
 			printf("Do you want to fix this partition? [Y/N] ");
 			ret = scanf("%s", ans);
 			ASSERT(ret >= 0);
 			if (!strcasecmp(ans, "y"))
-				config.fix_on = 1;
+				c.fix_on = 1;
 			else if (!strcasecmp(ans, "n"))
-				config.fix_on = 0;
+				c.fix_on = 0;
 			else
 				goto retry;
 
-			if (config.fix_on)
+			if (c.fix_on)
 				goto fsck_again;
 		}
 	}
-	f2fs_finalize_device(&config);
+	f2fs_finalize_device();
 
 	printf("\nDone.\n");
 	return 0;
diff --git a/fsck/mount.c b/fsck/mount.c
index 3be60bb..798825b 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -134,7 +134,7 @@ static void DISP_label(u_int16_t *name)
 
 void print_raw_sb_info(struct f2fs_super_block *sb)
 {
-	if (!config.dbg_lv)
+	if (!c.dbg_lv)
 		return;
 
 	printf("\n");
@@ -186,7 +186,7 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 
-	if (!config.dbg_lv)
+	if (!c.dbg_lv)
 		return;
 
 	printf("\n");
@@ -415,33 +415,33 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
 
 	if (!sanity_check_raw_super(sbi->raw_super, offset)) {
 		/* get kernel version */
-		if (config.kd >= 0) {
-			dev_read_version(config.version, 0, VERSION_LEN);
-			get_kernel_version(config.version);
+		if (c.kd >= 0) {
+			dev_read_version(c.version, 0, VERSION_LEN);
+			get_kernel_version(c.version);
 		} else {
-			memset(config.version, 0, VERSION_LEN);
+			memset(c.version, 0, VERSION_LEN);
 		}
 
 		/* build sb version */
-		memcpy(config.sb_version, sbi->raw_super->version, VERSION_LEN);
-		get_kernel_version(config.sb_version);
-		memcpy(config.init_version, sbi->raw_super->init_version, VERSION_LEN);
-		get_kernel_version(config.init_version);
+		memcpy(c.sb_version, sbi->raw_super->version, VERSION_LEN);
+		get_kernel_version(c.sb_version);
+		memcpy(c.init_version, sbi->raw_super->init_version, VERSION_LEN);
+		get_kernel_version(c.init_version);
 
-		MSG(0, "Info: MKFS version\n  \"%s\"\n", config.init_version);
+		MSG(0, "Info: MKFS version\n  \"%s\"\n", c.init_version);
 		MSG(0, "Info: FSCK version\n  from \"%s\"\n    to \"%s\"\n",
-					config.sb_version, config.version);
-		if (memcmp(config.sb_version, config.version, VERSION_LEN)) {
+					c.sb_version, c.version);
+		if (memcmp(c.sb_version, c.version, VERSION_LEN)) {
 			int ret;
 
 			memcpy(sbi->raw_super->version,
-						config.version, VERSION_LEN);
+						c.version, VERSION_LEN);
 			ret = dev_write(sbi->raw_super, offset,
 					sizeof(struct f2fs_super_block));
 			ASSERT(ret >= 0);
 
-			config.auto_fix = 0;
-			config.fix_on = 1;
+			c.auto_fix = 0;
+			c.fix_on = 1;
 		}
 		print_sb_state(sbi->raw_super);
 		return 0;
@@ -666,7 +666,7 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 	nid_t nid;
 	int i;
 
-	if (!(config.func == SLOAD))
+	if (!(c.func == SLOAD))
 		return 0;
 
 	nm_i->nid_bitmap = (char *)calloc(nid_bitmap_size, 1);
@@ -1867,7 +1867,7 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 					ASSERT_MSG("Invalid nat entry[0]: "
 						"blk_addr[0x%x]\n",
 						ni.blk_addr);
-					config.fix_on = 1;
+					c.fix_on = 1;
 					fsck->chk.valid_nat_entry_cnt--;
 				}
 
@@ -1895,8 +1895,8 @@ static int check_sector_size(struct f2fs_super_block *sb)
 
 	zero_buff = calloc(F2FS_BLKSIZE, 1);
 
-	log_sectorsize = log_base_2(config.sector_size);
-	log_sectors_per_block = log_base_2(config.sectors_per_blk);
+	log_sectorsize = log_base_2(c.sector_size);
+	log_sectors_per_block = log_base_2(c.sectors_per_blk);
 
 	if (log_sectorsize != get_sb(log_sectorsize))
 		set_sb(log_sectorsize, log_sectorsize);
@@ -1954,16 +1954,16 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 
 	print_ckpt_info(sbi);
 
-	if (config.auto_fix || config.preen_mode) {
+	if (c.auto_fix || c.preen_mode) {
 		u32 flag = get_cp(ckpt_flags);
 
 		if (flag & CP_FSCK_FLAG)
-			config.fix_on = 1;
-		else if (!config.preen_mode)
+			c.fix_on = 1;
+		else if (!c.preen_mode)
 			return 1;
 	}
 
-	config.bug_on = 0;
+	c.bug_on = 0;
 
 	sbi->total_valid_node_count = get_cp(valid_node_count);
 	sbi->total_valid_inode_count = get_cp(valid_inode_count);
@@ -1993,7 +1993,7 @@ void f2fs_do_umount(struct f2fs_sb_info *sbi)
 	unsigned int i;
 
 	/* free nm_info */
-	if (config.func == SLOAD)
+	if (c.func == SLOAD)
 		free(nm_i->nid_bitmap);
 	free(nm_i->nat_bitmap);
 	free(sbi->nm_info);
diff --git a/fsck/resize.c b/fsck/resize.c
index b53a6fa..565555c 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -22,19 +22,19 @@ static int get_new_sb(struct f2fs_sb_info *sbi, struct f2fs_super_block *sb)
 	u_int32_t blks_per_seg = 1 << get_sb(log_blocks_per_seg);
 	u_int32_t segs_per_zone = get_sb(segs_per_sec) * get_sb(secs_per_zone);
 
-	set_sb(block_count, config.target_sectors >>
+	set_sb(block_count, c.target_sectors >>
 				get_sb(log_sectors_per_block));
 
 	zone_size_bytes = segment_size_bytes * segs_per_zone;
 	zone_align_start_offset =
-		(config.start_sector * config.sector_size +
+		(c.start_sector * c.sector_size +
 		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
 		zone_size_bytes * zone_size_bytes -
-		config.start_sector * config.sector_size;
+		c.start_sector * c.sector_size;
 
-	set_sb(segment_count, (config.target_sectors * config.sector_size -
+	set_sb(segment_count, (c.target_sectors * c.sector_size -
 				zone_align_start_offset) / segment_size_bytes /
-				config.segs_per_sec * config.segs_per_sec);
+				c.segs_per_sec * c.segs_per_sec);
 
 	blocks_for_sit = ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
 	sit_segments = SEG_ALIGN(blocks_for_sit);
@@ -115,17 +115,17 @@ static int get_new_sb(struct f2fs_sb_info *sbi, struct f2fs_super_block *sb)
 						get_sb(segs_per_sec));
 
 	/* Let's determine the best reserved and overprovisioned space */
-	config.new_overprovision = get_best_overprovision(sb);
-	config.new_reserved_segments =
-		(2 * (100 / config.new_overprovision + 1) + 6) *
+	c.new_overprovision = get_best_overprovision(sb);
+	c.new_reserved_segments =
+		(2 * (100 / c.new_overprovision + 1) + 6) *
 						get_sb(segs_per_sec);
 
-	if ((get_sb(segment_count_main) - 2) < config.new_reserved_segments ||
+	if ((get_sb(segment_count_main) - 2) < c.new_reserved_segments ||
 		get_sb(segment_count_main) * blks_per_seg >
 						get_sb(block_count)) {
 		MSG(0, "\tError: Device size is not sufficient for F2FS volume, "
 			"more segment needed =%u",
-			config.new_reserved_segments -
+			c.new_reserved_segments -
 			(get_sb(segment_count_main) - 2));
 		return -1;
 	}
@@ -406,10 +406,10 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	ASSERT(buf);
 
 	/* ovp / free segments */
-	set_cp(rsvd_segment_count, config.new_reserved_segments);
+	set_cp(rsvd_segment_count, c.new_reserved_segments);
 	set_cp(overprov_segment_count, (get_newsb(segment_count_main) -
 			get_cp(rsvd_segment_count)) *
-			config.new_overprovision / 100);
+			c.new_overprovision / 100);
 	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
 						get_cp(rsvd_segment_count));
 
@@ -419,7 +419,7 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 
 	set_cp(free_segment_count, free_segment_count + new_segment_count);
 	set_cp(user_block_count, ((get_newsb(segment_count_main) -
-			get_cp(overprov_segment_count)) * config.blks_per_seg));
+			get_cp(overprov_segment_count)) * c.blks_per_seg));
 
 	if (is_set_ckpt_flags(cp, CP_ORPHAN_PRESENT_FLAG))
 		orphan_blks = __start_sum_addr(sbi) - 1;
@@ -545,10 +545,10 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
 		}
 	}
 
-	config.dbg_lv = 1;
+	c.dbg_lv = 1;
 	print_raw_sb_info(sb);
 	print_raw_sb_info(new_sb);
-	config.dbg_lv = 0;
+	c.dbg_lv = 0;
 
 	old_main_blkaddr = get_sb(main_blkaddr);
 	new_main_blkaddr = get_newsb(main_blkaddr);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index d44e10e..19ce250 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -125,7 +125,7 @@ static inline uint64_t bswap_64(uint64_t val)
 	do {								\
 		printf("[ASSERT] (%s:%4d) ", __func__, __LINE__);	\
 		printf(" --> "fmt"\n", ##__VA_ARGS__);			\
-		config.bug_on = 1;					\
+		c.bug_on = 1;						\
 	} while (0)
 
 #define ASSERT(exp)							\
@@ -144,14 +144,14 @@ static inline uint64_t bswap_64(uint64_t val)
 
 #define MSG(n, fmt, ...)						\
 	do {								\
-		if (config.dbg_lv >= n) {				\
+		if (c.dbg_lv >= n) {					\
 			printf(fmt, ##__VA_ARGS__);			\
 		}							\
 	} while (0)
 
 #define DBG(n, fmt, ...)						\
 	do {								\
-		if (config.dbg_lv >= n) {				\
+		if (c.dbg_lv >= n) {					\
 			printf("[%s:%4d] " fmt,				\
 				__func__, __LINE__, ##__VA_ARGS__);	\
 		}							\
@@ -708,7 +708,7 @@ struct f2fs_nat_block {
 #define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
 #define MAX_SIT_BITMAP_SIZE    (SEG_ALIGN(ALIGN(F2FS_MAX_SEGMENT, \
 						SIT_ENTRY_PER_BLOCK)) * \
-						config.blks_per_seg / 8)
+						c.blks_per_seg / 8)
 
 /*
  * Note that f2fs_sit_entry->vblocks has the following bit-field information.
@@ -953,10 +953,10 @@ extern u64 find_next_zero_bit_le(const u8 *, u64, u64);
 extern u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
 extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
 
-extern void f2fs_init_configuration(struct f2fs_configuration *);
-extern int f2fs_dev_is_umounted(struct f2fs_configuration *);
-extern int f2fs_get_device_info(struct f2fs_configuration *);
-extern void f2fs_finalize_device(struct f2fs_configuration *);
+extern void f2fs_init_configuration(void);
+extern int f2fs_dev_is_umounted(void);
+extern int f2fs_get_device_info(void);
+extern void f2fs_finalize_device(void);
 
 extern int dev_read(void *, __u64, size_t);
 extern int dev_write(void *, __u64, size_t);
@@ -973,14 +973,14 @@ extern int dev_read_version(void *, __u64, size_t);
 extern void get_kernel_version(__u8 *);
 f2fs_hash_t f2fs_dentry_hash(const unsigned char *, int);
 
-extern int zbc_scsi_report_zones(struct f2fs_configuration *);
+extern int zbc_scsi_report_zones(void);
 
-extern struct f2fs_configuration config;
+extern struct f2fs_configuration c;
 
 #define ALIGN(val, size)	((val) + (size) - 1) / (size)
-#define SEG_ALIGN(blks)		ALIGN(blks, config.blks_per_seg)
-#define ZONE_ALIGN(blks)	ALIGN(blks, config.blks_per_seg * \
-					config.segs_per_zone)
+#define SEG_ALIGN(blks)		ALIGN(blks, c.blks_per_seg)
+#define ZONE_ALIGN(blks)	ALIGN(blks, c.blks_per_seg * \
+					c.segs_per_zone)
 
 static inline double get_best_overprovision(struct f2fs_super_block *sb)
 {
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 706cc34..2284a78 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -487,24 +487,24 @@ int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len)
 /*
  * device information
  */
-void f2fs_init_configuration(struct f2fs_configuration *c)
+void f2fs_init_configuration(void)
 {
-	c->total_sectors = 0;
-	c->sector_size = DEFAULT_SECTOR_SIZE;
-	c->sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
-	c->blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
+	c.total_sectors = 0;
+	c.sector_size = DEFAULT_SECTOR_SIZE;
+	c.sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
+	c.blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
 
 	/* calculated by overprovision ratio */
-	c->reserved_segments = 0;
-	c->overprovision = 0;
-	c->segs_per_sec = 1;
-	c->secs_per_zone = 1;
-	c->segs_per_zone = 1;
-	c->heap = 1;
-	c->vol_label = "";
-	c->device_name = NULL;
-	c->trim = 1;
-	c->ro = 0;
+	c.reserved_segments = 0;
+	c.overprovision = 0;
+	c.segs_per_sec = 1;
+	c.secs_per_zone = 1;
+	c.segs_per_zone = 1;
+	c.heap = 1;
+	c.vol_label = "";
+	c.device_name = NULL;
+	c.trim = 1;
+	c.ro = 0;
 }
 
 static int is_mounted(const char *mpt, const char *device)
@@ -520,7 +520,7 @@ static int is_mounted(const char *mpt, const char *device)
 		if (!strcmp(device, mnt->mnt_fsname)) {
 #ifdef MNTOPT_RO
 			if (hasmntopt(mnt, MNTOPT_RO))
-				config.ro = 1;
+				c.ro = 1;
 #endif
 			break;
 		}
@@ -529,7 +529,7 @@ static int is_mounted(const char *mpt, const char *device)
 	return mnt ? 1 : 0;
 }
 
-int f2fs_dev_is_umounted(struct f2fs_configuration *c)
+int f2fs_dev_is_umounted(void)
 {
 	struct stat st_buf;
 	int ret = 0;
@@ -538,13 +538,13 @@ int f2fs_dev_is_umounted(struct f2fs_configuration *c)
 	 * try with /proc/mounts fist to detect RDONLY.
 	 * f2fs_stop_checkpoint makes RO in /proc/mounts while RW in /etc/mtab.
 	 */
-	ret = is_mounted("/proc/mounts", c->device_name);
+	ret = is_mounted("/proc/mounts", c.device_name);
 	if (ret) {
 		MSG(0, "Info: Mounted device!\n");
 		return -1;
 	}
 
-	ret = is_mounted(MOUNTED, c->device_name);
+	ret = is_mounted(MOUNTED, c.device_name);
 	if (ret) {
 		MSG(0, "Info: Mounted device!\n");
 		return -1;
@@ -554,8 +554,8 @@ int f2fs_dev_is_umounted(struct f2fs_configuration *c)
 	 * If f2fs is umounted with -l, the process can still use
 	 * the file system. In this case, we should not format.
 	 */
-	if (stat(c->device_name, &st_buf) == 0 && S_ISBLK(st_buf.st_mode)) {
-		int fd = open(c->device_name, O_RDONLY | O_EXCL);
+	if (stat(c.device_name, &st_buf) == 0 && S_ISBLK(st_buf.st_mode)) {
+		int fd = open(c.device_name, O_RDONLY | O_EXCL);
 
 		if (fd >= 0) {
 			close(fd);
@@ -577,7 +577,7 @@ void get_kernel_version(__u8 *version)
 	memset(version + i, 0, VERSION_LEN + 1 - i);
 }
 
-int f2fs_get_device_info(struct f2fs_configuration *c)
+int f2fs_get_device_info(void)
 {
 	int32_t fd = 0;
 	uint32_t sector_size;
@@ -589,17 +589,17 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 	sg_io_hdr_t io_hdr;
 	unsigned char reply_buffer[96];
 	unsigned char model_inq[6] = {MODELINQUIRY};
-	u_int64_t wanted_total_sectors = c->total_sectors;
+	u_int64_t wanted_total_sectors = c.total_sectors;
 
-	fd = open(c->device_name, O_RDWR);
+	fd = open(c.device_name, O_RDWR);
 	if (fd < 0) {
 		MSG(0, "\tError: Failed to open the device!\n");
 		return -1;
 	}
-	c->fd = fd;
+	c.fd = fd;
 
-	c->kd = open("/proc/version", O_RDONLY);
-	if (c->kd < 0)
+	c.kd = open("/proc/version", O_RDONLY);
+	if (c.kd < 0)
 		MSG(0, "\tInfo: No support kernel version!\n");
 
 	if (fstat(fd, &stat_buf) < 0 ) {
@@ -608,35 +608,35 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 	}
 
 	if (S_ISREG(stat_buf.st_mode)) {
-		c->total_sectors = stat_buf.st_size / c->sector_size;
+		c.total_sectors = stat_buf.st_size / c.sector_size;
 	} else if (S_ISBLK(stat_buf.st_mode)) {
 		if (ioctl(fd, BLKSSZGET, &sector_size) < 0) {
 			MSG(0, "\tError: Using the default sector size\n");
 		} else {
-			if (c->sector_size < sector_size) {
-				c->sector_size = sector_size;
-				c->sectors_per_blk = PAGE_SIZE / sector_size;
+			if (c.sector_size < sector_size) {
+				c.sector_size = sector_size;
+				c.sectors_per_blk = PAGE_SIZE / sector_size;
 			}
 		}
 
 #ifdef BLKGETSIZE64
-		if (ioctl(fd, BLKGETSIZE64, &c->total_sectors) < 0) {
+		if (ioctl(fd, BLKGETSIZE64, &c.total_sectors) < 0) {
 			MSG(0, "\tError: Cannot get the device size\n");
 			return -1;
 		}
-		c->total_sectors /= c->sector_size;
+		c.total_sectors /= c.sector_size;
 #else
 		if (ioctl(fd, BLKGETSIZE, &total_sectors) < 0) {
 			MSG(0, "\tError: Cannot get the device size\n");
 			return -1;
 		}
-		total_sectors /= c->sector_size;
-		c->total_sectors = total_sectors;
+		total_sectors /= c.sector_size;
+		c.total_sectors = total_sectors;
 #endif
 		if (ioctl(fd, HDIO_GETGEO, &geom) < 0)
-			c->start_sector = 0;
+			c.start_sector = 0;
 		else
-			c->start_sector = geom.start;
+			c.start_sector = geom.start;
 
 		/* Send INQUIRY command */
 		memset(&io_hdr, 0, sizeof(sg_io_hdr_t));
@@ -660,37 +660,37 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 		MSG(0, "\tError: Volume type is not supported!!!\n");
 		return -1;
 	}
-	if (wanted_total_sectors && wanted_total_sectors < c->total_sectors) {
+	if (wanted_total_sectors && wanted_total_sectors < c.total_sectors) {
 		MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
-					c->total_sectors, c->sector_size);
-		c->total_sectors = wanted_total_sectors;
+					c.total_sectors, c.sector_size);
+		c.total_sectors = wanted_total_sectors;
 	}
-	if (c->total_sectors * c->sector_size >
+	if (c.total_sectors * c.sector_size >
 		(u_int64_t)F2FS_MAX_SEGMENT * 2 * 1024 * 1024) {
 		MSG(0, "\tError: F2FS can support 16TB at most!!!\n");
 		return -1;
 	}
 
-	if (config.smr_mode) {
-		if (zbc_scsi_report_zones(c)) {
+	if (c.smr_mode) {
+		if (zbc_scsi_report_zones()) {
 			MSG(0, "\tError: Not proper SMR drive\n");
 			return -1;
 		}
 		MSG(0, "Info: SMR - ZONES = %u, CONV = %u, ZONE_SECTS = %lu\n",
-				c->nr_zones, c->nr_conventional,
-				c->zone_sectors);
-		if (c->segs_per_sec == 1)
-			c->segs_per_sec = c->zone_sectors /
-				c->sectors_per_blk / DEFAULT_BLOCKS_PER_SEGMENT;
+				c.nr_zones, c.nr_conventional,
+				c.zone_sectors);
+		if (c.segs_per_sec == 1)
+			c.segs_per_sec = c.zone_sectors /
+				c.sectors_per_blk / DEFAULT_BLOCKS_PER_SEGMENT;
 	}
-	c->segs_per_zone = c->segs_per_sec * c->secs_per_zone;
+	c.segs_per_zone = c.segs_per_sec * c.secs_per_zone;
 
-	MSG(0, "Info: Segments per section = %d\n", config.segs_per_sec);
-	MSG(0, "Info: Sections per zone = %d\n", config.secs_per_zone);
-	MSG(0, "Info: sector size = %u\n", c->sector_size);
+	MSG(0, "Info: Segments per section = %d\n", c.segs_per_sec);
+	MSG(0, "Info: Sections per zone = %d\n", c.secs_per_zone);
+	MSG(0, "Info: sector size = %u\n", c.sector_size);
 	MSG(0, "Info: total sectors = %"PRIu64" (%"PRIu64" MB)\n",
-				c->total_sectors, (c->total_sectors *
-					(c->sector_size >> 9)) >> 11);
+				c.total_sectors, (c.total_sectors *
+					(c.sector_size >> 9)) >> 11);
 	return 0;
 }
 
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index d2a04b2..1817c15 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -23,25 +23,25 @@
 
 #include <f2fs_fs.h>
 
-struct f2fs_configuration config;
+struct f2fs_configuration c;
 
 /*
  * IO interfaces
  */
 int dev_read_version(void *buf, __u64 offset, size_t len)
 {
-	if (lseek64(config.kd, (off64_t)offset, SEEK_SET) < 0)
+	if (lseek64(c.kd, (off64_t)offset, SEEK_SET) < 0)
 		return -1;
-	if (read(config.kd, buf, len) < 0)
+	if (read(c.kd, buf, len) < 0)
 		return -1;
 	return 0;
 }
 
 int dev_read(void *buf, __u64 offset, size_t len)
 {
-	if (lseek64(config.fd, (off64_t)offset, SEEK_SET) < 0)
+	if (lseek64(c.fd, (off64_t)offset, SEEK_SET) < 0)
 		return -1;
-	if (read(config.fd, buf, len) < 0)
+	if (read(c.fd, buf, len) < 0)
 		return -1;
 	return 0;
 }
@@ -49,7 +49,7 @@ int dev_read(void *buf, __u64 offset, size_t len)
 int dev_readahead(__u64 offset, size_t len)
 {
 #ifdef POSIX_FADV_WILLNEED
-	return posix_fadvise(config.fd, offset, len, POSIX_FADV_WILLNEED);
+	return posix_fadvise(c.fd, offset, len, POSIX_FADV_WILLNEED);
 #else
 	return 0;
 #endif
@@ -57,9 +57,9 @@ int dev_readahead(__u64 offset, size_t len)
 
 int dev_write(void *buf, __u64 offset, size_t len)
 {
-	if (lseek64(config.fd, (off64_t)offset, SEEK_SET) < 0)
+	if (lseek64(c.fd, (off64_t)offset, SEEK_SET) < 0)
 		return -1;
-	if (write(config.fd, buf, len) < 0)
+	if (write(c.fd, buf, len) < 0)
 		return -1;
 	return 0;
 }
@@ -71,9 +71,9 @@ int dev_write_block(void *buf, __u64 blk_addr)
 
 int dev_write_dump(void *buf, __u64 offset, size_t len)
 {
-	if (lseek64(config.dump_fd, (off64_t)offset, SEEK_SET) < 0)
+	if (lseek64(c.dump_fd, (off64_t)offset, SEEK_SET) < 0)
 		return -1;
-	if (write(config.dump_fd, buf, len) < 0)
+	if (write(c.dump_fd, buf, len) < 0)
 		return -1;
 	return 0;
 }
@@ -83,9 +83,9 @@ int dev_fill(void *buf, __u64 offset, size_t len)
 	/* Only allow fill to zero */
 	if (*((__u8*)buf))
 		return -1;
-	if (lseek64(config.fd, (off64_t)offset, SEEK_SET) < 0)
+	if (lseek64(c.fd, (off64_t)offset, SEEK_SET) < 0)
 		return -1;
-	if (write(config.fd, buf, len) < 0)
+	if (write(c.fd, buf, len) < 0)
 		return -1;
 	return 0;
 }
@@ -105,17 +105,17 @@ int dev_reada_block(__u64 blk_addr)
 	return dev_readahead(blk_addr << F2FS_BLKSIZE_BITS, F2FS_BLKSIZE);
 }
 
-void f2fs_finalize_device(struct f2fs_configuration *c)
+void f2fs_finalize_device(void)
 {
 	/*
 	 * We should call fsync() to flush out all the dirty pages
 	 * in the block device page cache.
 	 */
-	if (fsync(c->fd) < 0)
+	if (fsync(c.fd) < 0)
 		MSG(0, "\tError: Could not conduct fsync!!!\n");
 
-	if (close(c->fd) < 0)
+	if (close(c.fd) < 0)
 		MSG(0, "\tError: Failed to close device file!!!\n");
 
-	close(c->kd);
+	close(c.kd);
 }
diff --git a/lib/zbc.c b/lib/zbc.c
index 6ec2fc7..1783bd5 100644
--- a/lib/zbc.c
+++ b/lib/zbc.c
@@ -324,42 +324,42 @@ static char *zbc_sg_cmd_name(zbc_sg_cmd_t *cmd)
 	return name;
 }
 
-static void zbc_sg_set_sense(struct f2fs_configuration *c, uint8_t *sense_buf)
+static void zbc_sg_set_sense(uint8_t *sense_buf)
 {
 	if (sense_buf == NULL) {
-		c->zbd_errno.sk       = 0x00;
-		c->zbd_errno.asc_ascq = 0x0000;
+		c.zbd_errno.sk       = 0x00;
+		c.zbd_errno.asc_ascq = 0x0000;
 	} else {
 		if ((sense_buf[0] & 0x7F) == 0x72
 				|| (sense_buf[0] & 0x7F) == 0x73) {
 			/* store sense key, ASC/ASCQ */
-			c->zbd_errno.sk       = sense_buf[1] & 0x0F;
-			c->zbd_errno.asc_ascq = ((int)sense_buf[2] << 8) |
+			c.zbd_errno.sk       = sense_buf[1] & 0x0F;
+			c.zbd_errno.asc_ascq = ((int)sense_buf[2] << 8) |
 							(int)sense_buf[3];
 		} else if ((sense_buf[0] & 0x7F) == 0x70
 				|| (sense_buf[0] & 0x7F) == 0x71) {
 			/* store sense key, ASC/ASCQ */
-			c->zbd_errno.sk       = sense_buf[2] & 0x0F;
-			c->zbd_errno.asc_ascq = ((int)sense_buf[12] << 8) |
+			c.zbd_errno.sk       = sense_buf[2] & 0x0F;
+			c.zbd_errno.asc_ascq = ((int)sense_buf[12] << 8) |
 							(int)sense_buf[13];
 		}
 	}
 	return;
 }
 
-static int zbc_sg_cmd_exec(struct f2fs_configuration *c, zbc_sg_cmd_t *cmd)
+static int zbc_sg_cmd_exec(zbc_sg_cmd_t *cmd)
 {
 	int ret;
 
 	/* Send the SG_IO command */
-	ret = ioctl(c->fd, SG_IO, &cmd->io_hdr);
+	ret = ioctl(c.fd, SG_IO, &cmd->io_hdr);
 	if (ret) {
 		ERR_MSG("SG_IO ioctl failed (%s)\n", strerror(errno));
 		goto out;
 	}
 
 	/* Reset errno */
-	zbc_sg_set_sense(c, NULL);
+	zbc_sg_set_sense(NULL);
 
 	DBG(1, "Command %s done: status 0x%02x (0x%02x), host status 0x%04x, driver status 0x%04x (flags 0x%04x)\n",
 			zbc_sg_cmd_name(cmd),
@@ -375,7 +375,7 @@ static int zbc_sg_cmd_exec(struct f2fs_configuration *c, zbc_sg_cmd_t *cmd)
 
 		/* ATA command status */
 		if (cmd->io_hdr.status != ZBC_SG_CHECK_CONDITION) {
-			zbc_sg_set_sense(c, cmd->sense_buf);
+			zbc_sg_set_sense(cmd->sense_buf);
 			ret = -EIO;
 			goto out;
 		}
@@ -383,7 +383,7 @@ static int zbc_sg_cmd_exec(struct f2fs_configuration *c, zbc_sg_cmd_t *cmd)
 		if ((zbc_sg_cmd_driver_status(cmd) == ZBC_SG_DRIVER_SENSE)
 				&& (cmd->io_hdr.sb_len_wr > 21)
 				&& (cmd->sense_buf[21] != 0x50) ) {
-			zbc_sg_set_sense(c, cmd->sense_buf);
+			zbc_sg_set_sense(cmd->sense_buf);
 			ret = -EIO;
 			goto out;
 		}
@@ -402,7 +402,7 @@ static int zbc_sg_cmd_exec(struct f2fs_configuration *c, zbc_sg_cmd_t *cmd)
 				(unsigned int)cmd->io_hdr.host_status,
 				(unsigned int)zbc_sg_cmd_driver_status(cmd),
 				(unsigned int)zbc_sg_cmd_driver_flags(cmd));
-		zbc_sg_set_sense(c, cmd->sense_buf);
+		zbc_sg_set_sense(cmd->sense_buf);
 		ret = -EIO;
 		goto out;
 	}
@@ -418,7 +418,7 @@ out:
 
 #define ZBC_SCSI_REPORT_ZONES_BUFSZ     524288
 
-int zbc_scsi_report_zones(struct f2fs_configuration *c)
+int zbc_scsi_report_zones(void)
 {
 	zbc_sg_cmd_t cmd;
 	uint8_t *buf;
@@ -431,10 +431,10 @@ int zbc_scsi_report_zones(struct f2fs_configuration *c)
 next:
 	bufsz = ZBC_ZONE_DESCRIPTOR_OFFSET;
 	if (phase) {
-		if (c->nr_zones - idx == 0)
+		if (c.nr_zones - idx == 0)
 			return 0;
 
-		bufsz += (size_t)(c->nr_zones - idx) *
+		bufsz += (size_t)(c.nr_zones - idx) *
 					ZBC_ZONE_DESCRIPTOR_LENGTH;
 		if (bufsz > ZBC_SCSI_REPORT_ZONES_BUFSZ)
 			bufsz = ZBC_SCSI_REPORT_ZONES_BUFSZ;
@@ -479,7 +479,7 @@ next:
 	cmd.cdb[14] = 0;
 
 	/* Send the SG_IO command */
-	ret = zbc_sg_cmd_exec(c, &cmd);
+	ret = zbc_sg_cmd_exec(&cmd);
 	if (ret != 0)
 		goto out;
 
@@ -536,15 +536,15 @@ next:
 
 	/* read # of zones and then get all the zone info */
 	if (phase == 0) {
-		c->nr_zones = nr_zones;
-		c->nr_conventional = 0;
+		c.nr_zones = nr_zones;
+		c.nr_conventional = 0;
 		zbc_sg_cmd_destroy(&cmd);
 		phase++;
 		goto next;
 	}
 
-	if (nr_zones > c->nr_zones - idx)
-		nr_zones = c->nr_zones - idx;
+	if (nr_zones > c.nr_zones - idx)
+		nr_zones = c.nr_zones - idx;
 
 	buf_nz = (cmd.out_bufsz - ZBC_ZONE_DESCRIPTOR_OFFSET) /
 						ZBC_ZONE_DESCRIPTOR_LENGTH;
@@ -610,7 +610,7 @@ next:
 	for (i = 0; i < nr_zones; i++) {
 		z = &zones[i];
 		if ( zbc_zone_conventional(z) ) {
-			c->nr_conventional++;
+			c.nr_conventional++;
 			DBG(1, "Zone %05d: type 0x%x (%s), cond 0x%x (%s), LBA %llu, %llu sectors, wp N/A\n",
 				i + idx,
 				zbc_zone_type(z),
@@ -636,7 +636,7 @@ next:
 
 	idx += nr_zones;
 	next_lba = zones[nr_zones - 1].zbz_start + zones[nr_zones - 1].zbz_length;
-	c->zone_sectors = zones[nr_zones - 1].zbz_length;
+	c.zone_sectors = zones[nr_zones - 1].zbz_length;
 	phase++;
 	zbc_sg_cmd_destroy(&cmd);
 	free(zones);
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9dd30db..659c73c 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -21,16 +21,16 @@
 #include "f2fs_fs.h"
 #include "f2fs_format_utils.h"
 
-extern struct f2fs_configuration config;
+extern struct f2fs_configuration c;
 struct f2fs_super_block raw_sb;
 struct f2fs_super_block *sb = &raw_sb;
 struct f2fs_checkpoint *cp;
 
 /* Return first segment number of each area */
-#define prev_zone(cur)		(config.cur_seg[cur] - config.segs_per_zone)
-#define next_zone(cur)		(config.cur_seg[cur] + config.segs_per_zone)
-#define last_zone(cur)		((cur - 1) * config.segs_per_zone)
-#define last_section(cur)	(cur + (config.secs_per_zone - 1) * config.segs_per_sec)
+#define prev_zone(cur)		(c.cur_seg[cur] - c.segs_per_zone)
+#define next_zone(cur)		(c.cur_seg[cur] + c.segs_per_zone)
+#define last_zone(cur)		((cur - 1) * c.segs_per_zone)
+#define last_section(cur)	(cur + (c.secs_per_zone - 1) * c.segs_per_sec)
 
 const char *media_ext_lists[] = {
 	"jpg",
@@ -75,10 +75,10 @@ static bool is_extension_exist(const char *name)
 	return 0;
 }
 
-static void configure_extension_list(void)
+static void cure_extension_list(void)
 {
 	const char **extlist = media_ext_lists;
-	char *ext_str = config.extension_list;
+	char *ext_str = c.extension_list;
 	char *ue;
 	int name_len;
 	int i = 0;
@@ -114,7 +114,7 @@ next:
 
 	set_sb(extension_count, i);
 
-	free(config.extension_list);
+	free(c.extension_list);
 }
 
 static int f2fs_prepare_super_block(void)
@@ -136,10 +136,10 @@ static int f2fs_prepare_super_block(void)
 	set_sb(major_ver, F2FS_MAJOR_VERSION);
 	set_sb(minor_ver, F2FS_MINOR_VERSION);
 
-	log_sectorsize = log_base_2(config.sector_size);
-	log_sectors_per_block = log_base_2(config.sectors_per_blk);
+	log_sectorsize = log_base_2(c.sector_size);
+	log_sectors_per_block = log_base_2(c.sectors_per_blk);
 	log_blocksize = log_sectorsize + log_sectors_per_block;
-	log_blks_per_seg = log_base_2(config.blks_per_seg);
+	log_blks_per_seg = log_base_2(c.blks_per_seg);
 
 	set_sb(log_sectorsize, log_sectorsize);
 	set_sb(log_sectors_per_block, log_sectors_per_block);
@@ -147,46 +147,47 @@ static int f2fs_prepare_super_block(void)
 	set_sb(log_blocksize, log_blocksize);
 	set_sb(log_blocks_per_seg, log_blks_per_seg);
 
-	set_sb(segs_per_sec, config.segs_per_sec);
-	set_sb(secs_per_zone, config.secs_per_zone);
+	set_sb(segs_per_sec, c.segs_per_sec);
+	set_sb(secs_per_zone, c.secs_per_zone);
 
 	blk_size_bytes = 1 << log_blocksize;
-	segment_size_bytes = blk_size_bytes * config.blks_per_seg;
+	segment_size_bytes = blk_size_bytes * c.blks_per_seg;
 	zone_size_bytes =
-		blk_size_bytes * config.secs_per_zone *
-		config.segs_per_sec * config.blks_per_seg;
+		blk_size_bytes * c.secs_per_zone *
+		c.segs_per_sec * c.blks_per_seg;
 
 	set_sb(checksum_offset, 0);
 
-	set_sb(block_count, config.total_sectors >> log_sectors_per_block);
+	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
 
 	zone_align_start_offset =
-		(config.start_sector * config.sector_size +
+		(c.start_sector * c.sector_size +
 		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
 		zone_size_bytes * zone_size_bytes -
-		config.start_sector * config.sector_size;
+		c.start_sector * c.sector_size;
 
-	if (config.start_sector % config.sectors_per_blk) {
+	if (c.start_sector % c.sectors_per_blk) {
 		MSG(1, "\tWARN: Align start sector number to the page unit\n");
 		MSG(1, "\ti.e., start sector: %d, ofs:%d (sects/page: %d)\n",
-				config.start_sector,
-				config.start_sector % config.sectors_per_blk,
-				config.sectors_per_blk);
+				c.start_sector,
+				c.start_sector % c.sectors_per_blk,
+				c.sectors_per_blk);
 	}
 
-	set_sb(segment_count, (config.total_sectors * config.sector_size -
+	set_sb(segment_count, (c.total_sectors * c.sector_size -
 				zone_align_start_offset) / segment_size_bytes /
-				config.segs_per_zone * config.segs_per_zone);
+				c.segs_per_zone * c.segs_per_zone);
 
 	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
 	sb->cp_blkaddr = sb->segment0_blkaddr;
 
-	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n", get_sb(segment0_blkaddr));
+	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n",
+					get_sb(segment0_blkaddr));
 
 	set_sb(segment_count_ckpt, F2FS_NUMBER_OF_CHECKPOINT_PACK);
 
-	set_sb(sit_blkaddr, get_sb(segment0_blkaddr) + get_sb(segment_count_ckpt) *
-			config.blks_per_seg);
+	set_sb(sit_blkaddr, get_sb(segment0_blkaddr) +
+			get_sb(segment_count_ckpt) * c.blks_per_seg);
 
 	blocks_for_sit = ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
 
@@ -195,13 +196,14 @@ static int f2fs_prepare_super_block(void)
 	set_sb(segment_count_sit, sit_segments * 2);
 
 	set_sb(nat_blkaddr, get_sb(sit_blkaddr) + get_sb(segment_count_sit) *
-			config.blks_per_seg);
+			c.blks_per_seg);
 
 	total_valid_blks_available = (get_sb(segment_count) -
-			(get_sb(segment_count_ckpt) + get_sb(segment_count_sit))) *
-			config.blks_per_seg;
+			(get_sb(segment_count_ckpt) +
+			get_sb(segment_count_sit))) * c.blks_per_seg;
 
-	blocks_for_nat = ALIGN(total_valid_blks_available, NAT_ENTRY_PER_BLOCK);
+	blocks_for_nat = ALIGN(total_valid_blks_available,
+			NAT_ENTRY_PER_BLOCK);
 
 	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
 	/*
@@ -219,14 +221,18 @@ static int f2fs_prepare_super_block(void)
 
 	/*
 	 * It should be reserved minimum 1 segment for nat.
-	 * When sit is too large, we should expand cp area. It requires more pages for cp.
+	 * When sit is too large, we should expand cp area. It requires more
+	 * pages for cp.
 	 */
 	if (max_sit_bitmap_size >
-			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)) {
-		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
+			(CHECKSUM_OFFSET -
+				sizeof(struct f2fs_checkpoint) + 1 - 64)) {
+		max_nat_bitmap_size = CHECKSUM_OFFSET -
+				sizeof(struct f2fs_checkpoint) + 1;
 		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	} else {
-		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
+		max_nat_bitmap_size =
+			CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
 			- max_sit_bitmap_size;
 		set_sb(cp_payload, 0);
 	}
@@ -239,16 +245,16 @@ static int f2fs_prepare_super_block(void)
 	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
 
 	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) + get_sb(segment_count_nat) *
-			config.blks_per_seg);
+			c.blks_per_seg);
 
 	total_valid_blks_available = (get_sb(segment_count) -
 			(get_sb(segment_count_ckpt) +
 			get_sb(segment_count_sit) +
 			get_sb(segment_count_nat))) *
-			config.blks_per_seg;
+			c.blks_per_seg;
 
 	blocks_for_ssa = total_valid_blks_available /
-				config.blks_per_seg + 1;
+				c.blks_per_seg + 1;
 
 	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
 
@@ -256,45 +262,45 @@ static int f2fs_prepare_super_block(void)
 		get_sb(segment_count_sit) +
 		get_sb(segment_count_nat) +
 		get_sb(segment_count_ssa);
-	diff = total_meta_segments % (config.segs_per_zone);
+	diff = total_meta_segments % (c.segs_per_zone);
 	if (diff)
 		set_sb(segment_count_ssa, get_sb(segment_count_ssa) +
-			(config.segs_per_zone - diff));
+			(c.segs_per_zone - diff));
 
 	total_meta_zones = ZONE_ALIGN(total_meta_segments *
-						config.blks_per_seg);
+						c.blks_per_seg);
 
 	set_sb(main_blkaddr, get_sb(segment0_blkaddr) + total_meta_zones *
-				config.segs_per_zone * config.blks_per_seg);
+				c.segs_per_zone * c.blks_per_seg);
 
-	total_zones = get_sb(segment_count) / (config.segs_per_zone) -
+	total_zones = get_sb(segment_count) / (c.segs_per_zone) -
 							total_meta_zones;
 
-	set_sb(section_count, total_zones * config.secs_per_zone);
+	set_sb(section_count, total_zones * c.secs_per_zone);
 
-	set_sb(segment_count_main, get_sb(section_count) * config.segs_per_sec);
+	set_sb(segment_count_main, get_sb(section_count) * c.segs_per_sec);
 
 	/* Let's determine the best reserved and overprovisioned space */
-	if (config.overprovision == 0)
-		config.overprovision = get_best_overprovision(sb);
+	if (c.overprovision == 0)
+		c.overprovision = get_best_overprovision(sb);
 
-	config.reserved_segments =
-			(2 * (100 / config.overprovision + 1) + 6)
-			* config.segs_per_sec;
+	c.reserved_segments =
+			(2 * (100 / c.overprovision + 1) + 6)
+			* c.segs_per_sec;
 
 	if ((get_sb(segment_count_main) - 2) <
-					config.reserved_segments) {
+					c.reserved_segments) {
 		MSG(1, "\tError: Device size is not sufficient for F2FS volume, "
 			"more segment needed =%u",
-			config.reserved_segments -
+			c.reserved_segments -
 			(get_sb(segment_count_main) - 2));
 		return -1;
 	}
 
 	uuid_generate(sb->uuid);
 
-	utf8_to_utf16(sb->volume_name, (const char *)config.vol_label,
-				MAX_VOLUME_NAME, strlen(config.vol_label));
+	utf8_to_utf16(sb->volume_name, (const char *)c.vol_label,
+				MAX_VOLUME_NAME, strlen(c.vol_label));
 	set_sb(node_ino, 1);
 	set_sb(meta_ino, 2);
 	set_sb(root_ino, 3);
@@ -305,37 +311,38 @@ static int f2fs_prepare_super_block(void)
 		return -1;
 	}
 
-	if (config.heap) {
-		config.cur_seg[CURSEG_HOT_NODE] = last_section(last_zone(total_zones));
-		config.cur_seg[CURSEG_WARM_NODE] = prev_zone(CURSEG_HOT_NODE);
-		config.cur_seg[CURSEG_COLD_NODE] = prev_zone(CURSEG_WARM_NODE);
-		config.cur_seg[CURSEG_HOT_DATA] = prev_zone(CURSEG_COLD_NODE);
-		config.cur_seg[CURSEG_COLD_DATA] = 0;
-		config.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
+	if (c.heap) {
+		c.cur_seg[CURSEG_HOT_NODE] =
+				last_section(last_zone(total_zones));
+		c.cur_seg[CURSEG_WARM_NODE] = prev_zone(CURSEG_HOT_NODE);
+		c.cur_seg[CURSEG_COLD_NODE] = prev_zone(CURSEG_WARM_NODE);
+		c.cur_seg[CURSEG_HOT_DATA] = prev_zone(CURSEG_COLD_NODE);
+		c.cur_seg[CURSEG_COLD_DATA] = 0;
+		c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
 	} else {
-		config.cur_seg[CURSEG_HOT_NODE] = 0;
-		config.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
-		config.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
-		config.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
-		config.cur_seg[CURSEG_COLD_DATA] = next_zone(CURSEG_HOT_DATA);
-		config.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
+		c.cur_seg[CURSEG_HOT_NODE] = 0;
+		c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
+		c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
+		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
+		c.cur_seg[CURSEG_COLD_DATA] = next_zone(CURSEG_HOT_DATA);
+		c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
 	}
 
-	configure_extension_list();
+	cure_extension_list();
 
 	/* get kernel version */
-	if (config.kd >= 0) {
-		dev_read_version(config.version, 0, VERSION_LEN);
-		get_kernel_version(config.version);
-		MSG(0, "Info: format version with\n  \"%s\"\n", config.version);
+	if (c.kd >= 0) {
+		dev_read_version(c.version, 0, VERSION_LEN);
+		get_kernel_version(c.version);
+		MSG(0, "Info: format version with\n  \"%s\"\n", c.version);
 	} else {
-		memset(config.version, 0, VERSION_LEN);
+		memset(c.version, 0, VERSION_LEN);
 	}
 
-	memcpy(sb->version, config.version, VERSION_LEN);
-	memcpy(sb->init_version, config.version, VERSION_LEN);
+	memcpy(sb->version, c.version, VERSION_LEN);
+	memcpy(sb->init_version, c.version, VERSION_LEN);
 
-	sb->feature = config.feature;
+	sb->feature = c.feature;
 
 	return 0;
 }
@@ -448,12 +455,12 @@ static int f2fs_write_check_point_pack(void)
 
 	/* 1. cp page 1 of checkpoint pack 1 */
 	set_cp(checkpoint_ver, 1);
-	set_cp(cur_node_segno[0], config.cur_seg[CURSEG_HOT_NODE]);
-	set_cp(cur_node_segno[1], config.cur_seg[CURSEG_WARM_NODE]);
-	set_cp(cur_node_segno[2], config.cur_seg[CURSEG_COLD_NODE]);
-	set_cp(cur_data_segno[0], config.cur_seg[CURSEG_HOT_DATA]);
-	set_cp(cur_data_segno[1], config.cur_seg[CURSEG_WARM_DATA]);
-	set_cp(cur_data_segno[2], config.cur_seg[CURSEG_COLD_DATA]);
+	set_cp(cur_node_segno[0], c.cur_seg[CURSEG_HOT_NODE]);
+	set_cp(cur_node_segno[1], c.cur_seg[CURSEG_WARM_NODE]);
+	set_cp(cur_node_segno[2], c.cur_seg[CURSEG_COLD_NODE]);
+	set_cp(cur_data_segno[0], c.cur_seg[CURSEG_HOT_DATA]);
+	set_cp(cur_data_segno[1], c.cur_seg[CURSEG_WARM_DATA]);
+	set_cp(cur_data_segno[2], c.cur_seg[CURSEG_COLD_DATA]);
 	for (i = 3; i < MAX_ACTIVE_NODE_LOGS; i++) {
 		set_cp(cur_node_segno[i], 0xffffffff);
 		set_cp(cur_data_segno[i], 0xffffffff);
@@ -462,22 +469,22 @@ static int f2fs_write_check_point_pack(void)
 	set_cp(cur_node_blkoff[0], 1);
 	set_cp(cur_data_blkoff[0], 1);
 	set_cp(valid_block_count, 2);
-	set_cp(rsvd_segment_count, config.reserved_segments);
+	set_cp(rsvd_segment_count, c.reserved_segments);
 	set_cp(overprov_segment_count, (get_sb(segment_count_main) -
 			get_cp(rsvd_segment_count)) *
-			config.overprovision / 100);
+			c.overprovision / 100);
 	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
 			get_cp(rsvd_segment_count));
 
-	MSG(0, "Info: Overprovision ratio = %.3lf%%\n", config.overprovision);
+	MSG(0, "Info: Overprovision ratio = %.3lf%%\n", c.overprovision);
 	MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
 					get_cp(overprov_segment_count),
-					config.reserved_segments);
+					c.reserved_segments);
 
 	/* main segments - reserved segments - (node + data segments) */
 	set_cp(free_segment_count, get_sb(segment_count_main) - 6);
 	set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
-			get_cp(overprov_segment_count)) * config.blks_per_seg));
+			get_cp(overprov_segment_count)) * c.blks_per_seg));
 	/* cp page (2), data summaries (1), node summaries (3) */
 	set_cp(cp_pack_total_block_count, 6 + get_sb(cp_payload));
 	set_cp(ckpt_flags, CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG);
@@ -548,7 +555,7 @@ static int f2fs_write_check_point_pack(void)
 	journal->nat_j.entries[0].ne.ino = sb->root_ino;
 	journal->nat_j.entries[0].ne.block_addr = cpu_to_le32(
 			get_sb(main_blkaddr) +
-			get_cp(cur_node_segno[0]) * config.blks_per_seg);
+			get_cp(cur_node_segno[0]) * c.blks_per_seg);
 
 	memcpy(sum_compact_p, &journal->n_nats, SUM_JOURNAL_SIZE);
 	sum_compact_p += SUM_JOURNAL_SIZE;
@@ -557,21 +564,27 @@ static int f2fs_write_check_point_pack(void)
 	/* inode sit for root */
 	journal->n_sits = cpu_to_le16(6);
 	journal->sit_j.entries[0].segno = cp->cur_node_segno[0];
-	journal->sit_j.entries[0].se.vblocks = cpu_to_le16((CURSEG_HOT_NODE << 10) | 1);
+	journal->sit_j.entries[0].se.vblocks =
+				cpu_to_le16((CURSEG_HOT_NODE << 10) | 1);
 	f2fs_set_bit(0, (char *)journal->sit_j.entries[0].se.valid_map);
 	journal->sit_j.entries[1].segno = cp->cur_node_segno[1];
-	journal->sit_j.entries[1].se.vblocks = cpu_to_le16((CURSEG_WARM_NODE << 10));
+	journal->sit_j.entries[1].se.vblocks =
+				cpu_to_le16((CURSEG_WARM_NODE << 10));
 	journal->sit_j.entries[2].segno = cp->cur_node_segno[2];
-	journal->sit_j.entries[2].se.vblocks = cpu_to_le16((CURSEG_COLD_NODE << 10));
+	journal->sit_j.entries[2].se.vblocks =
+				cpu_to_le16((CURSEG_COLD_NODE << 10));
 
 	/* data sit for root */
 	journal->sit_j.entries[3].segno = cp->cur_data_segno[0];
-	journal->sit_j.entries[3].se.vblocks = cpu_to_le16((CURSEG_HOT_DATA << 10) | 1);
+	journal->sit_j.entries[3].se.vblocks =
+				cpu_to_le16((CURSEG_HOT_DATA << 10) | 1);
 	f2fs_set_bit(0, (char *)journal->sit_j.entries[3].se.valid_map);
 	journal->sit_j.entries[4].segno = cp->cur_data_segno[1];
-	journal->sit_j.entries[4].se.vblocks = cpu_to_le16((CURSEG_WARM_DATA << 10));
+	journal->sit_j.entries[4].se.vblocks =
+				cpu_to_le16((CURSEG_WARM_DATA << 10));
 	journal->sit_j.entries[5].segno = cp->cur_data_segno[2];
-	journal->sit_j.entries[5].se.vblocks = cpu_to_le16((CURSEG_COLD_DATA << 10));
+	journal->sit_j.entries[5].se.vblocks =
+				cpu_to_le16((CURSEG_COLD_DATA << 10));
 
 	memcpy(sum_compact_p, &journal->n_sits, SUM_JOURNAL_SIZE);
 	sum_compact_p += SUM_JOURNAL_SIZE;
@@ -645,7 +658,7 @@ static int f2fs_write_check_point_pack(void)
 	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
 	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) =
 							cpu_to_le32(crc);
-	cp_seg_blk = get_sb(segment0_blkaddr) + config.blks_per_seg;
+	cp_seg_blk = get_sb(segment0_blkaddr) + c.blks_per_seg;
 	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
 				cp_seg_blk);
 	if (dev_write_block(cp, cp_seg_blk)) {
@@ -710,7 +723,7 @@ static int f2fs_write_super_block(void)
 #ifndef WITH_ANDROID
 static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 {
-	if (config.smr_mode)
+	if (c.smr_mode)
 		return 0;
 	do {
 		if (offset < get_sb(main_blkaddr) ||
@@ -753,8 +766,8 @@ static int f2fs_write_root_inode(void)
 	raw_node->footer.cp_ver = cpu_to_le64(1);
 	raw_node->footer.next_blkaddr = cpu_to_le32(
 			get_sb(main_blkaddr) +
-			config.cur_seg[CURSEG_HOT_NODE] *
-			config.blks_per_seg + 1);
+			c.cur_seg[CURSEG_HOT_NODE] *
+			c.blks_per_seg + 1);
 
 	raw_node->i.i_mode = cpu_to_le16(0x41ed);
 	raw_node->i.i_links = cpu_to_le32(2);
@@ -778,7 +791,7 @@ static int f2fs_write_root_inode(void)
 	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
 
 	data_blk_nor = get_sb(main_blkaddr) +
-		config.cur_seg[CURSEG_HOT_DATA] * config.blks_per_seg;
+		c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg;
 	raw_node->i.i_addr[0] = cpu_to_le32(data_blk_nor);
 
 	raw_node->i.i_ext.fofs = 0;
@@ -786,13 +799,13 @@ static int f2fs_write_root_inode(void)
 	raw_node->i.i_ext.len = 0;
 
 	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
-	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_HOT_NODE] *
-					config.blks_per_seg;
+	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_HOT_NODE] *
+					c.blks_per_seg;
 
 	DBG(1, "\tWriting root inode (hot node), %x %x %x at offset 0x%08"PRIu64"\n",
 			get_sb(main_blkaddr),
-			config.cur_seg[CURSEG_HOT_NODE],
-			config.blks_per_seg, main_area_node_seg_blk_offset);
+			c.cur_seg[CURSEG_HOT_NODE],
+			c.blks_per_seg, main_area_node_seg_blk_offset);
 	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
 		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
 		free(raw_node);
@@ -801,8 +814,8 @@ static int f2fs_write_root_inode(void)
 
 	/* avoid power-off-recovery based on roll-forward policy */
 	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
-	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_WARM_NODE] *
-					config.blks_per_seg;
+	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_WARM_NODE] *
+					c.blks_per_seg;
 
 #ifndef WITH_ANDROID
 	if (discard_obsolete_dnode(raw_node, main_area_node_seg_blk_offset)) {
@@ -829,7 +842,7 @@ static int f2fs_update_nat_root(void)
 	/* update root */
 	nat_blk->entries[get_sb(root_ino)].block_addr = cpu_to_le32(
 		get_sb(main_blkaddr) +
-		config.cur_seg[CURSEG_HOT_NODE] * config.blks_per_seg);
+		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg);
 	nat_blk->entries[get_sb(root_ino)].ino = sb->root_ino;
 
 	/* update node nat */
@@ -881,8 +894,8 @@ static int f2fs_add_default_dentry_root(void)
 	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
 	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
 	data_blk_offset = get_sb(main_blkaddr);
-	data_blk_offset += config.cur_seg[CURSEG_HOT_DATA] *
-				config.blks_per_seg;
+	data_blk_offset += c.cur_seg[CURSEG_HOT_DATA] *
+				c.blks_per_seg;
 
 	DBG(1, "\tWriting default dentry root, at offset 0x%08"PRIx64"\n",
 				data_blk_offset);
@@ -934,8 +947,8 @@ int f2fs_format_device(void)
 		goto exit;
 	}
 
-	if (config.trim) {
-		err = f2fs_trim_device(config.fd);
+	if (c.trim) {
+		err = f2fs_trim_device(c.fd);
 		if (err < 0) {
 			MSG(0, "\tError: Failed to trim whole device!!!\n");
 			goto exit;
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 40ccdc7..37967ac 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -16,13 +16,12 @@
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include <time.h>
-//#include <linux/fs.h>
 #include <uuid/uuid.h>
 
 #include "f2fs_fs.h"
 #include "f2fs_format_utils.h"
 
-extern struct f2fs_configuration config;
+extern struct f2fs_configuration c;
 
 static void mkfs_usage()
 {
@@ -48,22 +47,22 @@ static void f2fs_show_info()
 	MSG(0, "\n\tF2FS-tools: mkfs.f2fs Ver: %s (%s)\n\n",
 				F2FS_TOOLS_VERSION,
 				F2FS_TOOLS_DATE);
-	if (config.heap == 0)
+	if (c.heap == 0)
 		MSG(0, "Info: Disable heap-based policy\n");
 
-	MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
-	if (config.extension_list)
+	MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
+	if (c.extension_list)
 		MSG(0, "Info: Add new extension list\n");
 
-	if (config.vol_label)
-		MSG(0, "Info: Label = %s\n", config.vol_label);
-	MSG(0, "Info: Trim is %s\n", config.trim ? "enabled": "disabled");
+	if (c.vol_label)
+		MSG(0, "Info: Label = %s\n", c.vol_label);
+	MSG(0, "Info: Trim is %s\n", c.trim ? "enabled": "disabled");
 }
 
 static void parse_feature(const char *features)
 {
 	if (!strcmp(features, "encrypt")) {
-		config.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
+		c.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
 	} else {
 		MSG(0, "Error: Wrong features\n");
 		mkfs_usage();
@@ -78,16 +77,16 @@ static void f2fs_parse_options(int argc, char *argv[])
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
 		switch (option) {
 		case 'q':
-			config.dbg_lv = -1;
+			c.dbg_lv = -1;
 			break;
 		case 'a':
-			config.heap = atoi(optarg);
+			c.heap = atoi(optarg);
 			break;
 		case 'd':
-			config.dbg_lv = atoi(optarg);
+			c.dbg_lv = atoi(optarg);
 			break;
 		case 'e':
-			config.extension_list = strdup(optarg);
+			c.extension_list = strdup(optarg);
 			break;
 		case 'l':		/*v: volume label */
 			if (strlen(optarg) > 512) {
@@ -95,25 +94,25 @@ static void f2fs_parse_options(int argc, char *argv[])
 						"512 characters\n");
 				mkfs_usage();
 			}
-			config.vol_label = optarg;
+			c.vol_label = optarg;
 			break;
 		case 'm':
-			config.smr_mode = 1;
+			c.smr_mode = 1;
 			break;
 		case 'o':
-			config.overprovision = atof(optarg);
+			c.overprovision = atof(optarg);
 			break;
 		case 'O':
 			parse_feature(optarg);
 			break;
 		case 's':
-			config.segs_per_sec = atoi(optarg);
+			c.segs_per_sec = atoi(optarg);
 			break;
 		case 'z':
-			config.secs_per_zone = atoi(optarg);
+			c.secs_per_zone = atoi(optarg);
 			break;
 		case 't':
-			config.trim = atoi(optarg);
+			c.trim = atoi(optarg);
 			break;
 		default:
 			MSG(0, "\tError: Unknown option %c\n",option);
@@ -126,35 +125,35 @@ static void f2fs_parse_options(int argc, char *argv[])
 		MSG(0, "\tError: Device not specified\n");
 		mkfs_usage();
 	}
-	config.device_name = argv[optind];
+	c.device_name = argv[optind];
 
 	if ((optind + 1) < argc)
-		config.total_sectors = atoll(argv[optind+1]);
+		c.total_sectors = atoll(argv[optind+1]);
 
-	if (config.smr_mode)
-		config.feature |= cpu_to_le32(F2FS_FEATURE_HMSMR);
+	if (c.smr_mode)
+		c.feature |= cpu_to_le32(F2FS_FEATURE_HMSMR);
 }
 
 int main(int argc, char *argv[])
 {
-	f2fs_init_configuration(&config);
+	f2fs_init_configuration();
 
 	f2fs_parse_options(argc, argv);
 
 	f2fs_show_info();
 
-	if (f2fs_dev_is_umounted(&config) < 0) {
+	if (f2fs_dev_is_umounted() < 0) {
 		MSG(0, "\tError: Not available on mounted device!\n");
 		return -1;
 	}
 
-	if (f2fs_get_device_info(&config) < 0)
+	if (f2fs_get_device_info() < 0)
 		return -1;
 
 	if (f2fs_format_device() < 0)
 		return -1;
 
-	f2fs_finalize_device(&config);
+	f2fs_finalize_device();
 
 	MSG(0, "Info: format successful\n");
 
diff --git a/mkfs/f2fs_format_utils.h b/mkfs/f2fs_format_utils.h
index 8bf598e..bc91aa3 100644
--- a/mkfs/f2fs_format_utils.h
+++ b/mkfs/f2fs_format_utils.h
@@ -10,7 +10,7 @@
 
 #include "f2fs_fs.h"
 
-extern struct f2fs_configuration config;
+extern struct f2fs_configuration c;
 
 int f2fs_trim_device(int);
 int f2fs_format_device(void);
-- 
2.8.3


------------------------------------------------------------------------------
