Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D90C77B7D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 May 2023 10:02:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pusH0-0004hD-VL;
	Fri, 05 May 2023 10:02:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pusH0-0004h6-09
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 10:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JSz0ergeSkpgDw7Ev22N++XeMyQBokvk/GSgEqqbk4Q=; b=kvfGxdgdDcl+DGdb+/GO60l03o
 tu0fz++W/AVlH7PoSb8aviQyoxDQqDCBjsIh/R3QZc0aTyGtOwISV5qr55CUggnT8/bFkxZVAFSRr
 ItNQTp8JGn8DxJtw48MQ5/mYbVAaE+rak3KVA+NvSRNQbn8+GCpfKXWgXbh2ESHnEeuA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JSz0ergeSkpgDw7Ev22N++XeMyQBokvk/GSgEqqbk4Q=; b=N2+eBFOrKNxg4XTkwgoi+gzlCJ
 v1dWdzkIT9zQ4rovRapIGKa7ikYBlLe36HQRDdnZkhtiyzkaP64PUrawW9jI08BXrif8nxmoHOmuO
 Z1uKIOSl+Z9SDczh3eH+NVlugihwNHJROxdlOwDh1eP6pGm/ssPs91A7kSJdBuUczrMA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pusGv-00F8Ld-3f for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 10:02:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 75E1963D0F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 May 2023 10:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACA8C433A0;
 Fri,  5 May 2023 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683280951;
 bh=StyTTh30oTEgsBuYTW1V09GLVjgm15bu8Xjh1oHn1gQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cMAnAwt05CXqTrQ7Gx8immCCabFe0KrqeWK+LUTfHxp9bW+/w8Igcckk+hvIZb1Zy
 ZU97j3VU4IDZRRLeIzWc2RvzrjoCONzbkWsBCBHMaDjgUnk/cFTxueS8YEaGwZ6lyD
 yY7SQnszibLtIY6QUN8NVfU7Gnpn8ucoDe4glZJ3EmvHqtPMaMm7P9misirfvEN8qU
 hUKBxAQxIWm3MQHSM2LmCUwCLA2yDxd5yD/W4RICytsR4/GCtQ17MGIXevRC5BI3Ge
 oAxugt037u88snL+eFDji85rQFVMbO8kdX2q1ITdZzzu395Yyj8f9ySjw3K0Ds4Tg9
 WgIXXzVOaC1fw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri,  5 May 2023 18:02:05 +0800
Message-Id: <20230505100205.1921708-6-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230505100205.1921708-1-chao@kernel.org>
References: <20230505100205.1921708-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pusGv-00F8Ld-3f
Subject: [f2fs-dev] [PATCH 6/6] f2fs-tools: use f2fs_init_inode() to clean
 up codes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/node.c        |   7 ++-
 include/f2fs_fs.h  |  36 +++++++++-----
 mkfs/f2fs_format.c | 118 ++++++++-------------------------------------
 3 files changed, 50 insertions(+), 111 deletions(-)

diff --git a/fsck/node.c b/fsck/node.c
index c3e383b..9ce8a72 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -57,7 +57,12 @@ int f2fs_rebuild_qf_inode(struct f2fs_sb_info *sbi, int qtype)
 		MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
 		return -ENOMEM;
 	}
-	f2fs_init_qf_inode(sb, raw_node, qtype, time(NULL));
+	f2fs_init_inode(sb, raw_node,
+			le32_to_cpu(sb->qf_ino[qtype]), time(NULL), 0x8180);
+
+	raw_node->i.i_size = cpu_to_le64(1024 * 6);
+	raw_node->i.i_blocks = cpu_to_le64(1);
+	raw_node->i.i_flags = FS_IMMUTABLE_FL;
 
 	if (is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
 		cp_ver |= (cur_cp_crc(ckpt) << 32);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 4accade..cab452d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1741,20 +1741,16 @@ static inline void show_version(const char *prog)
 #endif
 }
 
-static inline void f2fs_init_qf_inode(struct f2fs_super_block *sb,
-		struct f2fs_node *raw_node, int qtype, time_t mtime)
+static inline void f2fs_init_inode(struct f2fs_super_block *sb,
+		struct f2fs_node *raw_node, nid_t ino, time_t mtime, mode_t mode)
 {
-	raw_node->footer.nid = sb->qf_ino[qtype];
-	raw_node->footer.ino = sb->qf_ino[qtype];
+	raw_node->footer.nid = cpu_to_le32(ino);
+	raw_node->footer.ino = cpu_to_le32(ino);
 	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->i.i_mode = cpu_to_le16(0x8180);
-	raw_node->i.i_links = cpu_to_le32(1);
+
 	raw_node->i.i_uid = cpu_to_le32(c.root_uid);
 	raw_node->i.i_gid = cpu_to_le32(c.root_gid);
 
-	raw_node->i.i_size = cpu_to_le64(1024 * 6); /* Hard coded */
-	raw_node->i.i_blocks = cpu_to_le64(1);
-
 	raw_node->i.i_atime = cpu_to_le32(mtime);
 	raw_node->i.i_atime_nsec = 0;
 	raw_node->i.i_ctime = cpu_to_le32(mtime);
@@ -1763,9 +1759,15 @@ static inline void f2fs_init_qf_inode(struct f2fs_super_block *sb,
 	raw_node->i.i_mtime_nsec = 0;
 	raw_node->i.i_generation = 0;
 	raw_node->i.i_xattr_nid = 0;
-	raw_node->i.i_flags = FS_IMMUTABLE_FL;
-	raw_node->i.i_current_depth = cpu_to_le32(0);
+	raw_node->i.i_flags = 0;
+	raw_node->i.i_current_depth = cpu_to_le32(S_ISDIR(mode) ? 1 : 0);
 	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
+	raw_node->i.i_mode = cpu_to_le16(mode);
+	raw_node->i.i_links = cpu_to_le32(S_ISDIR(mode) ? 2 : 1);
+
+	/* for dentry block in directory */
+	raw_node->i.i_size = cpu_to_le64(1 << get_sb(log_blocksize));
+	raw_node->i.i_blocks = cpu_to_le64(2);
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
@@ -1775,6 +1777,18 @@ static inline void f2fs_init_qf_inode(struct f2fs_super_block *sb,
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
 		raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
 
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
+		raw_node->i.i_crtime = cpu_to_le32(mtime);
+		raw_node->i.i_crtime_nsec = 0;
+	}
+
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_COMPRESSION)) {
+		raw_node->i.i_compr_blocks = 0;
+		raw_node->i.i_compress_algorithm = 0;
+		raw_node->i.i_log_cluster_size = 0;
+		raw_node->i.i_compress_flag = 0;
+	}
+
 	raw_node->i.i_ext.fofs = 0;
 	raw_node->i.i_ext.blk_addr = 0;
 	raw_node->i.i_ext.len = 0;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 666af45..6d02a57 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1233,7 +1233,7 @@ static int f2fs_discard_obsolete_dnode(void)
 static int f2fs_write_root_inode(void)
 {
 	struct f2fs_node *raw_node = NULL;
-	uint64_t blk_size_bytes, data_blk_nor;
+	uint64_t data_blk_nor;
 	uint64_t main_area_node_seg_blk_offset = 0;
 
 	raw_node = calloc(F2FS_BLKSIZE, 1);
@@ -1242,65 +1242,21 @@ static int f2fs_write_root_inode(void)
 		return -1;
 	}
 
-	raw_node->footer.nid = sb->root_ino;
-	raw_node->footer.ino = sb->root_ino;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->footer.next_blkaddr = cpu_to_le32(
-			get_sb(main_blkaddr) +
-			c.cur_seg[CURSEG_HOT_NODE] *
-			c.blks_per_seg + 1);
+	f2fs_init_inode(sb, raw_node, le32_to_cpu(sb->root_ino),
+						mkfs_time, 0x41ed);
 
-	raw_node->i.i_mode = cpu_to_le16(0x41ed);
 	if (c.lpf_ino)
 		raw_node->i.i_links = cpu_to_le32(3);
-	else
-		raw_node->i.i_links = cpu_to_le32(2);
-	raw_node->i.i_uid = cpu_to_le32(c.root_uid);
-	raw_node->i.i_gid = cpu_to_le32(c.root_gid);
-
-	blk_size_bytes = 1 << get_sb(log_blocksize);
-	raw_node->i.i_size = cpu_to_le64(1 * blk_size_bytes); /* dentry */
-	raw_node->i.i_blocks = cpu_to_le64(2);
-
-	raw_node->i.i_atime = cpu_to_le32(mkfs_time);
-	raw_node->i.i_atime_nsec = 0;
-	raw_node->i.i_ctime = cpu_to_le32(mkfs_time);
-	raw_node->i.i_ctime_nsec = 0;
-	raw_node->i.i_mtime = cpu_to_le32(mkfs_time);
-	raw_node->i.i_mtime_nsec = 0;
-	raw_node->i.i_generation = 0;
-	raw_node->i.i_xattr_nid = 0;
-	raw_node->i.i_flags = 0;
-	raw_node->i.i_current_depth = cpu_to_le32(1);
-	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
-
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
-		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
-		raw_node->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
-	}
-
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
-		raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
 
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
-		raw_node->i.i_crtime = cpu_to_le32(mkfs_time);
-		raw_node->i.i_crtime_nsec = 0;
-	}
-
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_COMPRESSION)) {
-		raw_node->i.i_compress_algorithm = 0;
-		raw_node->i.i_log_cluster_size = 0;
-		raw_node->i.i_compress_flag = 0;
-	}
+	raw_node->footer.next_blkaddr = cpu_to_le32(
+			get_sb(main_blkaddr) +
+			c.cur_seg[CURSEG_HOT_NODE] *
+			c.blks_per_seg + 1);
 
 	data_blk_nor = get_sb(main_blkaddr) +
 		c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg;
 	raw_node->i.i_addr[get_extra_isize(raw_node)] = cpu_to_le32(data_blk_nor);
 
-	raw_node->i.i_ext.fofs = 0;
-	raw_node->i.i_ext.blk_addr = 0;
-	raw_node->i.i_ext.len = 0;
-
 	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
 	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_HOT_NODE] *
 					c.blks_per_seg;
@@ -1403,13 +1359,17 @@ static int f2fs_write_qf_inode(int qtype, int offset)
 		MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
 		return -1;
 	}
-	f2fs_init_qf_inode(sb, raw_node, qtype, mkfs_time);
+	f2fs_init_inode(sb, raw_node,
+			le32_to_cpu(sb->qf_ino[qtype]), mkfs_time, 0x8180);
+
+	raw_node->i.i_size = cpu_to_le64(1024 * 6);
+	raw_node->i.i_blocks = cpu_to_le64(1 + QUOTA_DATA(qtype));
+	raw_node->i.i_flags = FS_IMMUTABLE_FL;
 
 	raw_node->footer.next_blkaddr = cpu_to_le32(
 			get_sb(main_blkaddr) +
 			c.cur_seg[CURSEG_HOT_NODE] *
 			c.blks_per_seg + 1 + qtype + 1);
-	raw_node->i.i_blocks = cpu_to_le64(1 + QUOTA_DATA(qtype));
 
 	data_blk_nor = get_sb(main_blkaddr) +
 		c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg + 1
@@ -1552,7 +1512,7 @@ static block_t f2fs_add_default_dentry_lpf(void)
 static int f2fs_write_lpf_inode(void)
 {
 	struct f2fs_node *raw_node;
-	uint64_t blk_size_bytes, main_area_node_seg_blk_offset;
+	uint64_t main_area_node_seg_blk_offset;
 	block_t data_blk_nor;
 	int err = 0;
 
@@ -1564,56 +1524,16 @@ static int f2fs_write_lpf_inode(void)
 		return -1;
 	}
 
-	raw_node->footer.nid = cpu_to_le32(c.lpf_ino);
-	raw_node->footer.ino = raw_node->footer.nid;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->footer.next_blkaddr = cpu_to_le32(
-			get_sb(main_blkaddr) +
-			c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
-			1 + c.quota_inum + 1);
-
-	raw_node->i.i_mode = cpu_to_le16(0x41c0); /* 0700 */
-	raw_node->i.i_links = cpu_to_le32(2);
-	raw_node->i.i_uid = cpu_to_le32(c.root_uid);
-	raw_node->i.i_gid = cpu_to_le32(c.root_gid);
+	f2fs_init_inode(sb, raw_node, c.lpf_ino, mkfs_time, 0x41c0);
 
-	blk_size_bytes = 1 << get_sb(log_blocksize);
-	raw_node->i.i_size = cpu_to_le64(1 * blk_size_bytes);
-	raw_node->i.i_blocks = cpu_to_le64(2);
-
-	raw_node->i.i_atime = cpu_to_le32(mkfs_time);
-	raw_node->i.i_atime_nsec = 0;
-	raw_node->i.i_ctime = cpu_to_le32(mkfs_time);
-	raw_node->i.i_ctime_nsec = 0;
-	raw_node->i.i_mtime = cpu_to_le32(mkfs_time);
-	raw_node->i.i_mtime_nsec = 0;
-	raw_node->i.i_generation = 0;
-	raw_node->i.i_xattr_nid = 0;
-	raw_node->i.i_flags = 0;
 	raw_node->i.i_pino = le32_to_cpu(sb->root_ino);
 	raw_node->i.i_namelen = le32_to_cpu(strlen(LPF));
 	memcpy(raw_node->i.i_name, LPF, strlen(LPF));
-	raw_node->i.i_current_depth = cpu_to_le32(1);
-	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
 
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
-		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
-		raw_node->i.i_extra_isize = cpu_to_le16(calc_extra_isize());
-	}
-
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
-		raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
-
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
-		raw_node->i.i_crtime = cpu_to_le32(mkfs_time);
-		raw_node->i.i_crtime_nsec = 0;
-	}
-
-	if (c.feature & cpu_to_le32(F2FS_FEATURE_COMPRESSION)) {
-		raw_node->i.i_compress_algorithm = 0;
-		raw_node->i.i_log_cluster_size = 0;
-		raw_node->i.i_compress_flag = 0;
-	}
+	raw_node->footer.next_blkaddr = cpu_to_le32(
+			get_sb(main_blkaddr) +
+			c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
+			1 + c.quota_inum + 1);
 
 	data_blk_nor = f2fs_add_default_dentry_lpf();
 	if (data_blk_nor == 0) {
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
