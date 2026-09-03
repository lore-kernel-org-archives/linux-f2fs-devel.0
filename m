Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7889C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Go+rgogybYpn46V8jTcZZA3tyPS05KKnjixxhPPaf0=; b=kzaLsGZg0iMwQ64cb8eeHXonbl
	CsR2qlMECCOZppbiaZuXw9omrtvHD0Z79dzwXvY+mbleiBg2iVAYPLcXn7XAX17+x0ntN3o8a0W9L
	eS90nOlIwgXQaUcaugd55OcpfWvNFR1hdkckP/4cYml1YWsI8BYYpjtT/W8Nl3xl4xHs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2Gb2-0002XM-Br;
	Thu, 03 Sep 2026 23:11:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2Gaz-0002XE-Tx
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LiO/HZyQ66ZVLjgkl46SE6ZbrPgYtx0eLhZ31mShgv0=; b=l2trvd4UP4LrAEXzWAtGexMXwq
 MQumvSBJs4MeGjWRGqKzXxKT3xpf22kVXgRUfzeGQwiBDGYa8JyPMtFmg2REeW6UzUl29NdRX2Aq1
 CI5V3D/ZjisZ5PAccJ1GhKnUojADDzZrg0UTPbsp62MeLf4Fx3A9UbHBZnu5r47bQ6ww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LiO/HZyQ66ZVLjgkl46SE6ZbrPgYtx0eLhZ31mShgv0=; b=CXR8krhyjolvbEqLBcVOXD+Ulg
 PLmtWNIG8iBV4ZdKIZs9Mu4CngJD2wRRBMLJaLRpjuGEdws0D8CUMroWCEoMaLoHP4IIt+ikQBpq9
 RG+n3jcOqLFnTiTy9ef6eOeHICGXLf/6rvnQXFW1TK4S4ew2bDvrEuCO4ZHe8NgXhwUg=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2Gaz-0001YH-2y for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:11:49 +0000
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc439bfb2d8so376642a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788477103; x=1789081903; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LiO/HZyQ66ZVLjgkl46SE6ZbrPgYtx0eLhZ31mShgv0=;
 b=YpqygaaarrjMBaVhVxSb4LVGBI58k+37OUAtcrHcbc9Fs+le6dnoDlMwiQLoE/LjzI
 IdxMmens7P8xtKBZhjip/pa8umIbCzZxlv4LGa9rq03LlxC/UjKm3AFJRzFPQu0fqYhP
 qK4T2Bz8mZj8+gbxbg654B4lsmxHqyanjlaMH4sWrBKJwtcZiM91HbYWU48976JjZG0s
 t9etv215LlSiK+gq3YBY2f5JDTiwH+2eoJL4L0goN11f5MBe668pG+1+ywpGp3tcct1W
 hYSqvvnCmsLZo4eoV9HSXoUGtZx6f1zgnCp5gdk1feVLr6lWbwTwB6h1ygNKMC+mL9Ji
 P+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788477103; x=1789081903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LiO/HZyQ66ZVLjgkl46SE6ZbrPgYtx0eLhZ31mShgv0=;
 b=RL1z1WybIqZ9Mdw6V+WjenBDp+FZOLaBNPuM7fhXs1DIsuJgWy23E4C8sOcbzBSe6c
 S+OZE/95Q0PFyrpphEtAd71sJGrcHJ4Lj6e/pGQrOH29FrHhev07uM8tHaHVMASK6BN2
 5pqrlf7r1tsL9Tm4fxwWWHhcYoO+Xp+f7AK/5pYBvY8NINGap+3Ww8zatNl0dFm0SZAb
 S5FFBEMwSqQ0wUF2BZELd46Jl6rvbL+CgpB0b99lVnHLhGsm4x+kXQbzjImOu8pMfD21
 L/JPvvEFYOVvTdQaQ4EcsY3bIzXMkhWFwQXtrHtvaffk3GzQW11LgxlI3jd+K0buNSs4
 55KA==
X-Gm-Message-State: AFuF++nDnYrkHwmJ4CY1fiur0MRrWLgj8PB8jFl9AypZvlMB2YIdiIvZ
 wtia+5CN5L7TDZ737MGEiRKFEJje2OEDQyhB9z1XvmlimsuCKWZpdFHFfCWImYgC
X-Gm-Gg: AYBFou277jCioNBipiDdnTCQWWg7ch/rLbmYZtrx4fbdBS1Cz7lW+D2e2RaWlfhdD0R
 u8dFkQpb7HVr/Rn0DsZDrGV9TRnkkulTPclPuG6rjA4ErbqqdDVc8c6M2g3OYkwZYj+CfVKTspD
 PC5AL0rRCePaXTspdMJMhOzQ0+55YskwwNZPiPkARz8iy0GofpYzPxCgANnaSzUYKJ58S1oDVfv
 y4rr9gtqa3wZ1dCb+gGpi7LlcpttKxS0tf5NPkpGn8NSpVyM7CzVR4CpUX5QbkciOzwn6VZSXxS
 Tn+TawWlopJ2Ny07orPotI1J5ADV8UYW3T4DnEbQNGhlg2KRs0HT7xbd4Q5nEoedUcmsLgp0bry
 Xj3j3MQ9ZLtPWyX2zqfUzUALN2GuHZSPYd2vEBvgLUht4/jqgw1DGQjYXwC2NrNuTVJKu4tjTnQ
 SSRSPSDozkAAmlVvZ7tbblneMkBEDBzso8frkqGqNuN6Aw8IDGrXq4f7hpeFpVjUMu/Q==
X-Received: by 2002:a17:90b:2884:b0:398:e86b:ce14 with SMTP id
 98e67ed59e1d1-39b262ab44emr2824941a91.20.1788477103244; 
 Thu, 03 Sep 2026 16:11:43 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b260fdc1dsm1095550a91.7.2026.09.03.16.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:11:42 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:11:31 -0700
Message-ID: <14ec93f97f034507d19317f793c4bb4c1dc0f9ba.1788476500.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788476500.git.zhangxp1998@gmail.com>
References: <cover.1788476500.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2Gaz-0001YH-2y
Subject: [f2fs-dev] [PATCH v8 04/11] f2fs: describe orphan block layout
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
index 3ecced9b4d57..e615477307f9 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1042,6 +1042,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct folio *folio;
 		struct f2fs_orphan_block *orphan_blk;
+		struct f2fs_orphan_footer *footer;
 		unsigned int entry_count;
 
 		folio = f2fs_get_meta_folio(sbi, start_blk + i);
@@ -1051,8 +1052,9 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
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
@@ -1085,6 +1087,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 {
 	struct list_head *head;
 	struct f2fs_orphan_block *orphan_blk = NULL;
+	struct f2fs_orphan_footer *footer = NULL;
 	unsigned int nentries = 0;
 	unsigned short index = 1;
 	unsigned short orphan_blocks;
@@ -1092,7 +1095,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	struct ino_entry *orphan = NULL;
 	struct inode_management *im = &sbi->im[ORPHAN_INO];
 
-	orphan_blocks = GET_ORPHAN_BLOCKS(im->ino_num);
+	orphan_blocks = GET_ORPHAN_BLOCKS(sbi, im->ino_num);
 
 	/*
 	 * we don't need to do spin_lock(&im->ino_lock) here, since all the
@@ -1106,20 +1109,21 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
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
@@ -1129,9 +1133,9 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
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
@@ -1824,7 +1828,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		__clear_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
 	spin_unlock_irqrestore(&sbi->cp_lock, flags);
 
-	orphan_blocks = GET_ORPHAN_BLOCKS(orphan_num);
+	orphan_blocks = GET_ORPHAN_BLOCKS(sbi, orphan_num);
 	ckpt->cp_pack_start_sum = cpu_to_le32(1 + cp_payload_blks +
 			orphan_blocks);
 
@@ -2080,7 +2084,7 @@ void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi)
 
 	sbi->max_orphans = (BLKS_PER_SEG(sbi) - F2FS_CP_PACKS -
 			NR_CURSEG_PERSIST_TYPE - __cp_payload(sbi)) *
-			F2FS_ORPHANS_PER_BLOCK;
+			F2FS_ORPHANS_PER_BLOCK(sbi);
 }
 
 int __init f2fs_create_checkpoint_caches(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8e6000e7d766..2a4ba7d4ec0e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1865,6 +1865,7 @@ struct f2fs_sb_info {
 	unsigned int blocksize;			/* block size */
 	unsigned int nat_entries_per_block;	/* NAT entries in a block */
 	unsigned int sit_entries_per_block;	/* SIT entries in a block */
+	unsigned int orphans_per_block;	/* orphan inodes in a block */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
 	unsigned int meta_ino_num;		/* meta inode number*/
@@ -2255,6 +2256,17 @@ static inline struct f2fs_sb_info *F2FS_F_SB(const struct folio *folio)
 
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
index 32c050257d7d..5891dba76bce 100644
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
