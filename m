Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C00C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zo8mBmgRwuc16HOERw/bnDuM4z9QrV5cgYMN4gtj6WM=; b=gtN3DTvEALg49RXDvdPnnzAwbr
	CZBL/dCOAnfh+HkhMMjVAxq0yvM4RNbeBBxTJaihpzg9EbUQTXmBcgXzbgkuafHvCo1Y/CAoDRvj8
	DvbCHn2r7tMv2ZLdYPvgCgiRcDD1gdE90bOlzZsUz1n6+3bDwbkzA3IfK/mA0vgD9CgI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2Gb9-0000lO-PT;
	Thu, 03 Sep 2026 23:11:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2Gb8-0000lC-DN
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:11:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kw+qmFr37Q7/LtQ8UqbmCTsqXbxzNguI36NDb1SL/60=; b=XrF1md6ATMN3/JUEe0NLkI9IDv
 RrErzI1EkGFuG1ip3PcYnaqEX1iB/mlksSCH47hw+6QXL5Cq1hSKF7xobjTVKmnOXNy4RZ2aOj2An
 Toj2d0cWyhrfbvYg1k5RAP6e6487z+b+XIVjDZf7/KlA018Y24T4ZBqBilpHUzd6ozD0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kw+qmFr37Q7/LtQ8UqbmCTsqXbxzNguI36NDb1SL/60=; b=HrEuSTxehCqLbiDxtGnYDcZu89
 7yS34YoP/aQQ/2FMDLgW4cSH4i4aQonNUD+pv5T4Ne4BXDJh5YN90AeLsnbq7kUbtsInvioyb0I9n
 mR3DQ/d9/2gWBPZnMt9n1I8JOIOlxjxOq3TNkoJUW2PsT5xf1Y6pr+ZtFWPVnVIzsgGY=;
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2Gb5-0001Yc-5u for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:11:55 +0000
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc149372c14so312679a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788477109; x=1789081909; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kw+qmFr37Q7/LtQ8UqbmCTsqXbxzNguI36NDb1SL/60=;
 b=E5f58BX895rZj0OtYQiHQjgG1rgTGMgWx6XzT4DE3BTcvgCuezrR3dj3yqDJcrWq7M
 kznzerBsrw8LN7chJ9TFiQmXLRT7Q/quBrdJV1LhZGDDRoa4nWl8q9sE0JojuelUJvz6
 vCH60IB5clgxBsNA1ssyjH1rUOjOb86WRRhE9TULakxbjkge2YW/Fydnw2hEZ9SlHAu4
 QtENykw0+jYbViRiCLLewA+URSgVJm4CrvkxhmGtgrfuu1aCFGPVAtGizBvP6rEVahap
 E3b0sB7RKJ7MbMeFzB6PbaZAyPgPKST+/O4L0j2u96VtYYGKg6svOxovvZacmy5kSbkz
 avOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788477109; x=1789081909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kw+qmFr37Q7/LtQ8UqbmCTsqXbxzNguI36NDb1SL/60=;
 b=bcRexLfg/9J+rUs2C63QbWzHJvpSiRDbzkGhWaixACCmdt2rH7R02ucTdRJ68QM1le
 wT4scUkCyTI8f6ZzeMVLloskT7//HaR5KQcPE+QjC/gp83JYX8UFaSO7rW3o8rLxnxzI
 sadeUg5K/Pk+o1OTR2smx1S8leXnvtUp6xmYlfe4w7OdYkdQaWtbW+PQaB8EfMYnWrbF
 gZHNZpL4QpitholByBDm7hoG6PWPrnXq2aCkr9IH4zOHVohnwu60YUEX4SNS7n1KWi4u
 c7h8rDOThDzbC8zFjdLNYRVj9lnrAGwkX7rpMXLnhKPOMbI6ls8OATVVLjY+cy0D4y63
 uAcA==
X-Gm-Message-State: AFuF++m09TZoxajkx/sMUBke/COhvsr8TJ2jYmmSeDVAGDpVwMC79Act
 J93/XIq+LsH73grT93CPEVqpeNZnRhu227Mxc5qC3PX8ufmSRi9HCbXHwYV+wx7y
X-Gm-Gg: AYBFou3ab8X54kPQuOcTCimm5ZkXAqdjqVxXknmiXxI7EXD3eeVnhVbSPYU7qSbJMNM
 dXBtoClZ8h+nnfzfRCTwsyNFm/BRhc62oxLNwxDUb6zmQmZdoZu0PZdDVv67JRY4kSAedwyCk5+
 6iKunN39zFaCh4JG80haMj/R+RbPt5FMHdXosoO0uD+py9W5pnWoMIeXQNSnwghkpzZFe4HU7z9
 eYwydSD1ijLCNC7eTEC9Yj0KOz6EZM4MPJsSkNnwFnEZQ2HwSnuU4A2uh6s68j+L5e21/JrUmmU
 HVvdgFj/kL+VPB1+E0oTe3UnTHXLZHaAF6d9xxMMete75sgl7iGx4XgRMcbDgDHmGKGSHPVmlJC
 kwl33lo20JW7EkYEh5lbY5SJeNtGk5zy7YaCKVaulM2wE/gaW/X3y9zkefbj2OgzfGg48CILAY5
 +FhPtoTQZtCtpkSUFLJKdzZ7cFHzzd8g2Ur0c5/QiJq4AffxDXRA4yg2wsP1TCZKO3fw==
X-Received: by 2002:a17:90b:5826:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-39b261b07b6mr2831887a91.10.1788477109342; 
 Thu, 03 Sep 2026 16:11:49 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm1108512a91.11.2026.09.03.16.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:11:48 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:11:35 -0700
Message-ID: <7ddc7d42143ecbd6637c9470ba325119b340675b.1788476500.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788476500.git.zhangxp1998@gmail.com>
References: <cover.1788476500.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2Gb5-0001Yc-5u
Subject: [f2fs-dev] [PATCH v8 08/11] f2fs: parameterize sector conversion
 macros
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sector-to-block and block-to-sector conversion helpers previously
assumed a fixed sector count per block derived from 4KB pages.

Parameterize F2FS_LOG_SECTORS_PER_BLOCK, SECTOR_FROM_BLOCK, and
SECTOR_TO_BLOCK with struct f2fs_sb_info *sbi, using
sbi->log_sectors_per_block.

Update all call sites across metadata I/O, data mapping, discard
operations, and zoned block device reporting.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/data.c          |  2 +-
 fs/f2fs/f2fs.h          |  5 +++--
 fs/f2fs/file.c          |  4 ++--
 fs/f2fs/inode.c         | 11 +++++++----
 fs/f2fs/segment.c       | 14 +++++++-------
 fs/f2fs/segment.h       |  8 ++++----
 fs/f2fs/super.c         | 10 +++++-----
 include/linux/f2fs_fs.h |  2 +-
 8 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 632513b5453c..6a74af3fb396 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -466,7 +466,7 @@ struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 	}
 
 	if (sector)
-		*sector = SECTOR_FROM_BLOCK(blk_addr);
+		*sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
 	return bdev;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 84f2d0cabda4..e1006931f1af 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2610,7 +2610,8 @@ static inline int F2FS_HAS_BLOCKS(struct inode *inode)
 {
 	block_t xattr_block = F2FS_I(inode)->i_xattr_nid ? 1 : 0;
 
-	return (inode->i_blocks >> F2FS_LOG_SECTORS_PER_BLOCK) > xattr_block;
+	return (inode->i_blocks >>
+		F2FS_LOG_SECTORS_PER_BLOCK(F2FS_I_SB(inode))) > xattr_block;
 }
 
 static inline bool f2fs_has_xattr_block(unsigned int ofs)
@@ -2816,7 +2817,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,
 						block_t count)
 {
-	blkcnt_t sectors = count << F2FS_LOG_SECTORS_PER_BLOCK;
+	blkcnt_t sectors = count << F2FS_LOG_SECTORS_PER_BLOCK(sbi);
 
 	spin_lock(&sbi->stat_lock);
 	if (unlikely(sbi->total_valid_block_count < count)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d440231b8cb9..2c72e028cec2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4510,8 +4510,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 		pgoff_t off, block_t block, block_t len, u32 flags)
 {
-	sector_t sector = SECTOR_FROM_BLOCK(block);
-	sector_t nr_sects = SECTOR_FROM_BLOCK(len);
+	sector_t sector = SECTOR_FROM_BLOCK(F2FS_I_SB(inode), block);
+	sector_t nr_sects = SECTOR_FROM_BLOCK(F2FS_I_SB(inode), len);
 	int ret = 0;
 
 	if (flags & F2FS_TRIM_FILE_DISCARD) {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 79c0a1301996..aa22e457d5b3 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -221,11 +221,11 @@ static bool sanity_check_compress_inode(struct inode *inode,
 		return false;
 	}
 	if (le64_to_cpu(ri->i_compr_blocks) >
-			SECTOR_TO_BLOCK(inode->i_blocks)) {
+			SECTOR_TO_BLOCK(sbi, inode->i_blocks)) {
 		f2fs_warn(sbi,
 			"%s: inode (ino=%llx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
 			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
-			SECTOR_TO_BLOCK(inode->i_blocks));
+			SECTOR_TO_BLOCK(sbi, inode->i_blocks));
 		return false;
 	}
 	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
@@ -447,7 +447,8 @@ static int do_read_inode(struct inode *inode)
 	i_gid_write(inode, le32_to_cpu(ri->i_gid));
 	set_nlink(inode, le32_to_cpu(ri->i_links));
 	inode->i_size = le64_to_cpu(ri->i_size);
-	inode->i_blocks = SECTOR_FROM_BLOCK(le64_to_cpu(ri->i_blocks) - 1);
+	inode->i_blocks = SECTOR_FROM_BLOCK(sbi,
+			le64_to_cpu(ri->i_blocks) - 1);
 
 	inode_set_atime(inode, le64_to_cpu(ri->i_atime),
 			le32_to_cpu(ri->i_atime_nsec));
@@ -696,6 +697,7 @@ struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
 
 void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_inode *ri;
 	struct extent_tree *et = fi->extent_tree[EX_READ];
@@ -712,7 +714,8 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 	ri->i_uid = cpu_to_le32(i_uid_read(inode));
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
-	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(READ_ONCE(inode->i_blocks)) + 1);
+	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(sbi,
+					   READ_ONCE(inode->i_blocks)) + 1);
 
 	if (!f2fs_is_atomic_file(inode) ||
 			is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b29df65ab5b7..f565b6873832 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1310,7 +1310,7 @@ static void __submit_zone_reset_cmd(struct f2fs_sb_info *sbi,
 	/* sanity check on discard range */
 	__check_sit_bitmap(sbi, dc->di.lstart, dc->di.lstart + dc->di.len);
 
-	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(dc->di.start);
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, dc->di.start);
 	bio->bi_private = dc;
 	bio->bi_end_io = f2fs_submit_discard_endio;
 	submit_bio(bio);
@@ -1327,7 +1327,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 {
 	struct block_device *bdev = dc->bdev;
 	unsigned int max_discard_blocks =
-			SECTOR_TO_BLOCK(bdev_max_discard_sectors(bdev));
+			SECTOR_TO_BLOCK(sbi, bdev_max_discard_sectors(bdev));
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
@@ -1389,8 +1389,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		dc->di.len += len;
 
-		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
-				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);
+		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(sbi, start),
+				SECTOR_FROM_BLOCK(sbi, len), GFP_NOFS, &bio);
 		f2fs_bug_on(sbi, !bio);
 
 		/*
@@ -1518,7 +1518,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 	struct discard_info di = {0};
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	unsigned int max_discard_blocks =
-			SECTOR_TO_BLOCK(bdev_max_discard_sectors(bdev));
+			SECTOR_TO_BLOCK(sbi, bdev_max_discard_sectors(bdev));
 	block_t end = lstart + len;
 
 	dc = __lookup_discard_cmd_ret(&dcc->root, lstart,
@@ -2041,8 +2041,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 
 	/* For sequential zones, reset the zone write pointer */
 	if (f2fs_blkz_is_seq(sbi, devi, blkstart)) {
-		sector = SECTOR_FROM_BLOCK(blkstart);
-		nr_sects = SECTOR_FROM_BLOCK(blklen);
+		sector = SECTOR_FROM_BLOCK(sbi, blkstart);
+		nr_sects = SECTOR_FROM_BLOCK(sbi, blklen);
 		div64_u64_rem(sector, bdev_zone_sectors(bdev), &remainder);
 
 		if (remainder || nr_sects != bdev_zone_sectors(bdev)) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 534e376cbc92..2275404e769c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -114,10 +114,10 @@ f2fs_start_segno(struct f2fs_sb_info *sbi, unsigned int segno)
 #define f2fs_bitmap_size(nr)			\
 	(BITS_TO_LONGS(nr) * sizeof(unsigned long))
 
-#define SECTOR_FROM_BLOCK(blk_addr)					\
-	(((sector_t)blk_addr) << F2FS_LOG_SECTORS_PER_BLOCK)
-#define SECTOR_TO_BLOCK(sectors)					\
-	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
+#define SECTOR_FROM_BLOCK(sbi, blk_addr)				\
+	(((sector_t)blk_addr) << F2FS_LOG_SECTORS_PER_BLOCK(sbi))
+#define SECTOR_TO_BLOCK(sbi, sectors)					\
+	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK(sbi))
 
 /*
  * In the victim_sel_policy->alloc_mode, there are three block allocation modes.
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index df5572084af0..5fd163e60296 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3944,7 +3944,7 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
 	bio = bio_alloc(sbi->sb->s_bdev, 1, opf, GFP_NOFS);
 
 	/* it doesn't need to set crypto context for superblock update */
-	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(folio->index);
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, folio->index);
 
 	if (!bio_add_folio(bio, folio, folio_size(folio), 0))
 		f2fs_bug_on(sbi, 1);
@@ -4519,7 +4519,7 @@ static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx,
 {
 	struct f2fs_report_zones_args *rz_args = data;
 	block_t unusable_blocks = (zone->len - zone->capacity) >>
-					F2FS_LOG_SECTORS_PER_BLOCK;
+					F2FS_LOG_SECTORS_PER_BLOCK(rz_args->sbi);
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return 0;
@@ -4562,10 +4562,10 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
-				SECTOR_TO_BLOCK(zone_sectors))
+				SECTOR_TO_BLOCK(sbi, zone_sectors))
 		return -EINVAL;
-	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(zone_sectors);
-	FDEV(devi).nr_blkz = div_u64(SECTOR_TO_BLOCK(nr_sectors),
+	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(sbi, zone_sectors);
+	FDEV(devi).nr_blkz = div_u64(SECTOR_TO_BLOCK(sbi, nr_sectors),
 					sbi->blocks_per_blkz);
 	if (nr_sectors & (zone_sectors - 1))
 		FDEV(devi).nr_blkz++;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index e98bff846b23..33995cd3dd6d 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -14,7 +14,7 @@
 #define F2FS_SUPER_OFFSET		1024	/* byte-size offset */
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
 #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
-#define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for sector/blk */
+#define F2FS_LOG_SECTORS_PER_BLOCK(sbi)	((sbi)->log_blocksize - 9) /* log number for sector/blk */
 #define F2FS_MIN_LOG_BLOCKSIZE		12
 #define F2FS_MIN_BLKSIZE		4096UL
 #define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
