Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488A0C624DE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JkRD8WTMCTKNPfE6xMzhNJle2JwT9s2YbB52ItHmIJ8=; b=NfOOTYCFZbIeWhnVjuC9AUoK3i
	gXDAjDaBbD+h4tuhwzX8vb8CkarobnbD8rQGs/TElp923kJT84exQ0arpHP4OXU8TGOb2FC77JY4T
	QIE/jj5jZ3Qe8GD1oVsF+LJHZkA3hXKp28GU38PK0rc82MAEdI3x6dViPKkexe3atJBk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2HIK-0003lY-V9;
	Thu, 03 Sep 2026 23:56:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2HII-0003lR-UQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:56:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m9wKI0Z0DpMpYM/1mHsDF/pZnszi7sqs9bFOkpAyOMY=; b=fnID8wcqdrZ8JmdrGwCHXxdOE7
 IdVqyAkRgQjoo96JDuRbf5aEvRA8/oKN0lubTi6SSxeMgEYOnGVkjT+W+lml1c3nhrS8JKRBZ5dez
 582qAR0tCPhmrsNd2T9iIAORH6HWTTgZS8brd9UFR0O9YSqzrcaczDSBpSs5UkGv7Kag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m9wKI0Z0DpMpYM/1mHsDF/pZnszi7sqs9bFOkpAyOMY=; b=Pw6qt/45o4UWP2MXpuSgaAetXK
 qusUPUAtAwnLWurPbexP6F9badW25oEkI+roF43rN34227g8xvO0sGWFRaD4lbK/i8GSLEoIAcRU7
 jC0475B4zswDSEkDRWor0UxvxlT8CYlc9E6d4yBD2wylwaovWqeWI8D8PBRJh8H6javs=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2HII-0002Vl-9E for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:56:34 +0000
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso510820a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788479788; x=1789084588; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m9wKI0Z0DpMpYM/1mHsDF/pZnszi7sqs9bFOkpAyOMY=;
 b=CC4im57IY/VJA5Z6awl3a+ar4dkHWtJdZGPbM9zmoWPjVIj2THtya8pwu6Vki5evuI
 iJJw9rGJsARHYqlYfRE2zolONvFJ/ZsDmS7gL+oDxLmuWFt8LrrUxaWNau/vgf5L11N5
 jUdH741K/sLt00GO1+2TiRrRBcZu25Vjo8GGmn1wMv5EGNHw/BLX4XjsAVzIa3wR8UU0
 aPG6mlrkXLG6NutX84NF6Vy94lDdtpHH+vQzIwBi5LpgVgmuu95LlaTU97CyEuK+RvyI
 a2lieYEo8gkaTVP0fnMxSszq40y/6hE+msDELAq8dImAwkthIBbtpfdZSN8VILdPod4i
 4jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788479788; x=1789084588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m9wKI0Z0DpMpYM/1mHsDF/pZnszi7sqs9bFOkpAyOMY=;
 b=oje+T0w6VhoAtgQ3q7JN7z6hGtBXmBl8w53wp6d0XTGFUO4VHBSaBUkZxpWyU791eZ
 jhaY1JEzn5MV4eoD1TQCiomx/HexwWxpLlESOx/jV5BdUbgKnrsKqQyR+7J3m/eVTEWu
 Z18QoCdNs55hCGq0ml2x4qvT4XcY5FeXZ4rhydXckotwded3jfIRrrzAqeVJbfOafTTD
 5lCOKRAsVsavU6qa+tOdceEKV80iiph1V8k4mQCwd6eG1o8QMls9Xn1r8YibLT5wT9yg
 X/uHQk4EiyqwHmzS7BWpiEWaHp68FZrgPCvSlsJkapeyAG/c0c2zlYdc2VCjpL844mSu
 HHwg==
X-Gm-Message-State: AFuF++l0WumStGUWI9c1QB3VAmCPr0bmDVVtq8uBHj/Iy6VNET+8V2b/
 qJkvLT8HJ5oFBj//0RwLsOw4IJ1lPu2ZyelTH2Q7VB4kUPhHyNLmx1cdx4IAD7bQ
X-Gm-Gg: AYBFou1JgapGpoaS7LoAMxk79dGjQO4/aKHHPwkU87X1qTJklDR4xewyZqxTymsERXT
 L2jqazvI/S04KjvDVJ33uyrbPlLpRIRhOYBWXqcTvL/DPGiRXMUWeSPeHEr2pkfLEI+IZ9zeZFM
 jtyR/J/JGBTM+vC+E5RufYprLAmwllAMcXPWrIUaJLlHOQyvA2aPRc2LV2YS69XUhnwNx4DFCUl
 eq2oyPockFFgnNhxVTD3QjBKXsZLUFhKYDDes268xSQBUAqKruGjuvLT85fGw5xTR9TnXYdtYH4
 IeHggF06GKjPJGGqgdhMgCiRdLZIRUqJZbNB8bbQnn5qcQhANX8cL59i61ah4ZQx8MbM6+MHkVY
 VKMGyf+vyN87diCAlFvsaS7U1DqzgKa9vGYFd+RzW9Uilycdxoy9bdXgUcyzS45kirdEAQxJkZZ
 RYYQwAVLDySrvv5UtOH8OJy8IrGsY//i148BnlQflAYl2wfdGL/mdgl73Yvff7OoHlYg==
X-Received: by 2002:a17:90b:5845:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-39b2620547amr3221584a91.16.1788479788557; 
 Thu, 03 Sep 2026 16:56:28 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b6036fcsm2268682eec.20.2026.09.03.16.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:56:28 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:56:16 -0700
Message-ID: <99c37e861d74328fa6203c58284dc33505d326ad.1788479509.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788479509.git.zhangxp1998@gmail.com>
References: <cover.1788479509.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2HII-0002Vl-9E
Subject: [f2fs-dev] [PATCH v9 04/11] f2fs: describe orphan block layout
 dynamically
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

An on-disk orphan block contains a variable-length array of 32-bit
inode numbers followed by a fixed footer at the end of the block. A
compile-time whole-block structure cannot represent the footer position
when the block size varies at runtime.

Remove struct f2fs_orphan_block, introduce
struct f2fs_orphan_block_footer, and compute sbi->orphans_per_block
dynamically in init_sb_info(). Add helpers to access the inode entry array
and footer from a block buffer.

Update orphan inode recovery, checkpointing, and mount paths to use the
parameterized helpers. This preserves the on-disk format while decoupling
orphan handling from compile-time constants.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    | 32 ++++++++++++++++++--------------
 fs/f2fs/f2fs.h          | 12 ++++++++++++
 fs/f2fs/super.c         |  2 ++
 include/linux/f2fs_fs.h | 20 ++++++++++++++------
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 05366ba2675d..c7183d4b6765 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1034,6 +1034,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct folio *folio;
 		struct f2fs_orphan_block *orphan_blk;
+		struct f2fs_orphan_footer *footer;
 		unsigned int entry_count;
 
 		folio = f2fs_get_meta_folio(sbi, start_blk + i);
@@ -1043,8 +1044,9 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 
 		orphan_blk = folio_address(folio);
-		entry_count = le32_to_cpu(orphan_blk->entry_count);
-		if (entry_count > F2FS_ORPHANS_PER_BLOCK) {
+		footer = f2fs_orphan_footer(orphan_blk, sbi);
+		entry_count = le32_to_cpu(footer->entry_count);
+		if (entry_count > F2FS_ORPHANS_PER_BLOCK(sbi)) {
 			f2fs_err(sbi, "invalid orphan inode entry count %u",
 				 entry_count);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -1077,6 +1079,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 {
 	struct list_head *head;
 	struct f2fs_orphan_block *orphan_blk = NULL;
+	struct f2fs_orphan_footer *footer = NULL;
 	unsigned int nentries = 0;
 	unsigned short index = 1;
 	unsigned short orphan_blocks;
@@ -1084,7 +1087,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	struct ino_entry *orphan = NULL;
 	struct inode_management *im = &sbi->im[ORPHAN_INO];
 
-	orphan_blocks = GET_ORPHAN_BLOCKS(im->ino_num);
+	orphan_blocks = GET_ORPHAN_BLOCKS(sbi, im->ino_num);
 
 	/*
 	 * we don't need to do spin_lock(&im->ino_lock) here, since all the
@@ -1098,20 +1101,21 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 		if (!folio) {
 			folio = f2fs_grab_meta_folio(sbi, start_blk++);
 			orphan_blk = folio_address(folio);
-			memset(orphan_blk, 0, sizeof(*orphan_blk));
+			footer = f2fs_orphan_footer(orphan_blk, sbi);
+			memset(orphan_blk, 0, sbi->blocksize);
 		}
 
 		orphan_blk->ino[nentries++] = cpu_to_le32(orphan->ino);
 
-		if (nentries == F2FS_ORPHANS_PER_BLOCK) {
+		if (nentries == F2FS_ORPHANS_PER_BLOCK(sbi)) {
 			/*
-			 * an orphan block is full of 1020 entries,
+			 * an orphan block is full,
 			 * then we need to flush current orphan blocks
 			 * and bring another one in memory
 			 */
-			orphan_blk->blk_addr = cpu_to_le16(index);
-			orphan_blk->blk_count = cpu_to_le16(orphan_blocks);
-			orphan_blk->entry_count = cpu_to_le32(nentries);
+			footer->blk_addr = cpu_to_le16(index);
+			footer->blk_count = cpu_to_le16(orphan_blocks);
+			footer->entry_count = cpu_to_le32(nentries);
 			folio_mark_dirty(folio);
 			f2fs_folio_put(folio, true);
 			index++;
@@ -1121,9 +1125,9 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	}
 
 	if (folio) {
-		orphan_blk->blk_addr = cpu_to_le16(index);
-		orphan_blk->blk_count = cpu_to_le16(orphan_blocks);
-		orphan_blk->entry_count = cpu_to_le32(nentries);
+		footer->blk_addr = cpu_to_le16(index);
+		footer->blk_count = cpu_to_le16(orphan_blocks);
+		footer->entry_count = cpu_to_le32(nentries);
 		folio_mark_dirty(folio);
 		f2fs_folio_put(folio, true);
 	}
@@ -1816,7 +1820,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		__clear_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
 	spin_unlock_irqrestore(&sbi->cp_lock, flags);
 
-	orphan_blocks = GET_ORPHAN_BLOCKS(orphan_num);
+	orphan_blocks = GET_ORPHAN_BLOCKS(sbi, orphan_num);
 	ckpt->cp_pack_start_sum = cpu_to_le32(1 + cp_payload_blks +
 			orphan_blocks);
 
@@ -2072,7 +2076,7 @@ void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi)
 
 	sbi->max_orphans = (BLKS_PER_SEG(sbi) - F2FS_CP_PACKS -
 			NR_CURSEG_PERSIST_TYPE - __cp_payload(sbi)) *
-			F2FS_ORPHANS_PER_BLOCK;
+			F2FS_ORPHANS_PER_BLOCK(sbi);
 }
 
 int __init f2fs_create_checkpoint_caches(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d3ca0bc2a76..69a558fe46c7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1864,6 +1864,7 @@ struct f2fs_sb_info {
 	unsigned int blocksize;			/* block size */
 	unsigned int nat_entries_per_block;	/* NAT entries in a block */
 	unsigned int sit_entries_per_block;	/* SIT entries in a block */
+	unsigned int orphans_per_block;	/* orphan inodes in a block */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
 	unsigned int meta_ino_num;		/* meta inode number*/
@@ -2254,6 +2255,17 @@ static inline struct f2fs_sb_info *F2FS_F_SB(const struct folio *folio)
 
 #define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
 #define NAT_ENTRY_PER_BLOCK(sbi)	((sbi)->nat_entries_per_block)
+#define F2FS_ORPHANS_PER_BLOCK(sbi)	((sbi)->orphans_per_block)
+#define GET_ORPHAN_BLOCKS(sbi, n)	DIV_ROUND_UP((n), \
+					F2FS_ORPHANS_PER_BLOCK(sbi))
+
+static inline struct f2fs_orphan_footer *
+f2fs_orphan_footer(void *orphan_block, struct f2fs_sb_info *sbi)
+{
+	return (struct f2fs_orphan_footer *)
+		((char *)orphan_block + sbi->blocksize -
+		 sizeof(struct f2fs_orphan_footer));
+}
 
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 534f6678e4ae..5f630ee748d0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4386,6 +4386,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		sizeof(struct f2fs_nat_entry);
 	sbi->sit_entries_per_block = sbi->blocksize /
 		sizeof(struct f2fs_sit_entry);
+	sbi->orphans_per_block = (sbi->blocksize -
+		sizeof(struct f2fs_orphan_footer)) / sizeof(__le32);
 	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	sbi->blocks_per_seg = BIT(sbi->log_blocks_per_seg);
 	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 061f906a7b94..bdb8c63ac0c6 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -220,14 +220,22 @@ struct f2fs_checkpoint {
 
 /*
  * For orphan inode management
+ *
+ * The number of inode entries in an orphan block depends on the filesystem
+ * block size. Its exact on-disk layout is:
+ *
+ * 0                           blocksize - 16             blocksize
+ * +--------------------------+--------------------------+
+ * | ino[0] ... ino[n - 1]    | struct f2fs_orphan_footer |
+ * +--------------------------+--------------------------+
+ *
+ * n = (blocksize - sizeof(struct f2fs_orphan_footer)) / sizeof(__le32)
  */
-#define F2FS_ORPHANS_PER_BLOCK	((F2FS_BLKSIZE - 4 * sizeof(__le32)) / sizeof(__le32))
-
-#define GET_ORPHAN_BLOCKS(n)	(((n) + F2FS_ORPHANS_PER_BLOCK - 1) / \
-					F2FS_ORPHANS_PER_BLOCK)
-
 struct f2fs_orphan_block {
-	__le32 ino[F2FS_ORPHANS_PER_BLOCK];	/* inode numbers */
+	DECLARE_FLEX_ARRAY(__le32, ino);
+} __packed;
+
+struct f2fs_orphan_footer {
 	__le32 reserved;	/* reserved */
 	__le16 blk_addr;	/* block index in current CP */
 	__le16 blk_count;	/* Number of orphan inode blocks in CP */
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
