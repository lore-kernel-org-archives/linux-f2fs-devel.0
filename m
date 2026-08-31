Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC8CC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KwjYaL/hZQM9e3+yzI2PyjbfEYMHt4L4ZLVbqHljuck=; b=Ge3+VwOnrBGypDHN+9PpaXsrag
	YHx7zPfbAP3Ji16Fb22lvlWIGxghacz2/QwDI3FQ/gsvZk70MKIuYB8Ghz8iEVXntTYNn7bejxHxT
	bekiZ+dVocHhIphKq2JxXANVVipBDFkFDIHYR8nwoa/Ax8JFDslsZkG2xnENEKfOTInQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0udr-0001l7-Jd;
	Mon, 31 Aug 2026 05:33:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0udq-0001l1-E9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=al32+VJq1jKIId9SnUJ76zOfT5qUXNEzgzuggBSWSDk=; b=RuqBZ0qe1bvBzSzVU5DRK0F5kV
 OVpQ8koZn4LiP8NPlzHlKIafJ1T2Ti/CgmuZhxFUjgrbkztARAbZvWzAxOxFLcaYvRPHDWmIg6wQ5
 KBjQcfLJss3FUUa7fnx8YsffkVxLP0jwLE3g/Xr+fhJqdbP+tfBwrnwOdyfoREtrIfGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=al32+VJq1jKIId9SnUJ76zOfT5qUXNEzgzuggBSWSDk=; b=Fj5Xm95m3WhlN5rrIamZ6XZmzw
 c+GCQpuoIX2HUs3mRAV/W1g3fQ//l6d4yiS8+os5f3j4eNyuZJyv4QJWJUT9sHpwUDmhJBczeRxcf
 Qc9NKLJorx8NfnoTRW//7vqZtMCHmR9nEXuBHikpE4rMwlslLUcm6rU0aNSTvvyR9Tls=;
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0udp-0006Xh-QJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:11 +0000
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a5e329c0f2so3578370a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 22:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788154383; cv=none;
 d=google.com; s=arc-20260327;
 b=qVHql+lUjTCBl/GjuoYchbJLonodNdMwKlDdI+GF9gDGcahehzqCdVghHKBKjzidiQ
 sXIF3oYU06xG7VyVsJcIsJaZ3BDo4lsKx3f5pb6i4tiOasnFL3udbjXORcSaGDx/dKnW
 Uxe3GigINWa16ez1IuptQptXUTev9GIIFIaGFpQLWqlyAaBRgoi6GyA2WIdl7+SMgN4N
 nxixularKSjvOTUzAV7xWIYCH8OlCBukAU1tbAtNK7eQ2X7wMJ5JIvDi3Sfoo1JlrjUE
 PEodSHNqsbrUybanLZst4Vq3QtGMDx7EzIKQw5t9QIOFVtN5tvFBIA1bseRoYsbuE1Au
 xHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=al32+VJq1jKIId9SnUJ76zOfT5qUXNEzgzuggBSWSDk=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=NO7LHxabIXiPo+esmJeu0Ye3ramSHMqS9LUnrFW52VmdojS9j+8sbQaeU9Obm1JJQT
 6PfS0nXBTA0qWxBP7hLNX+8zqYNVCxWdUEjMuNCeUYRbHQys5zu+H+t5Ober776qfAO8
 tZ8zJdCAB6Z+Qh1eW2SN05MjADC4DDwEB7/t1EREpaIxEiOrpjSl67RcHXseE8PBexhg
 D6AEVnNcLZZNzq81DpaKeERh4PrNlpBxO8g1R6EOv0iHuWq+zvvqInKIaYlgBm5fdpP1
 BjZZxMdpizmXuahyJpS3P9b5e2fRMQgcnB3KzjmHC2OwIItZSrqG/htjuuz43hJoPQow
 S0vw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788154383; x=1788759183; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=al32+VJq1jKIId9SnUJ76zOfT5qUXNEzgzuggBSWSDk=;
 b=BE+FgZZwJ0t2E4FCj81vYkzzhqWcw1H8nazIIYP99F317jVtcEHSgHZgKs30Vd+lV/
 6r4wxp8oOT2/IZPgAXnxILcGNFFTYyGB11UvngQcN1H4/mmV4gVu65U4YSol6Lf2jxk3
 DY5CLAf5mDHFbpyRqwQgm11qm0ZAdd28yapXoYiicMYTnwlkFRBpYCmwaEmhj9Axj21v
 Da7AaGqxJKXoY8hKGfp1Y6pZ6sGmXA76ZK8SA1IpKhZmKt2SnOAkjpBcUm9c4/wu7aKo
 aFSQjI9/cgEbAE6rzz4SGBlm6I6ty1XedFs/NJ4u9ewibOhpgUixACv1HKa/LQPoAREQ
 uakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788154383; x=1788759183;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=al32+VJq1jKIId9SnUJ76zOfT5qUXNEzgzuggBSWSDk=;
 b=a2KvkEsFLdzh0KEYui7s1NE7NCW9c4Y5VfHzrI+i7vnCFTCotELyCVGNyNaQpxnL1E
 qoMMhulIC7bVE9EiXEgzv7y8wgl2N6oqk4rA4EbGfJTPZY8Ow3NL67nhYBU9m7RmS02i
 tPpFZyaKzDZjRboeuIWH2kzYUytC5/DQDBbZAsa5W0xSp0V0NmQOhHdspfJrUg+bF2u4
 6cPny18Jf4d8xYsEvfu7eXwKbspZxevdRBA0pU7GCWyKH/kkQ340de6mPOLryYbz7AR7
 z7FfLSndDAHMCyH38y8Wp/a7z7OhL8ALJQo69KlSRnJ3Ps8/DlylDxZxiEGg569F5RJy
 mY+Q==
X-Gm-Message-State: AFuF++nbJZ7rmQglc9dVsO8BG3qTs5F2K+fByiiY/N/cgtuQwZd6LveL
 BqzAcx3f62qln8pKowRvuo+Jq9jvmkgSegZ6mLqBxVbVa6ckXy3shLDpys0rCkvJmtLwevL1KQc
 08+qTCtmCRxCgMzhj4IxlGtDZT6QwTZFs/6tYDjQ=
X-Gm-Gg: AYBFou1vsNwGOOLDzNGg8mmu4/F/Hhq/No22kcfPgU37WzFdYPP9NkdEJi9x+yu/8Ww
 B9WvsNjysGSfaRKW1Nf6etWtWp4qUW5R9B4JUSn6L4XfYbgEhspeMG9wR3hB6JBItwVKIQw2+Lc
 vmYfazJI/qsKhIA8NUIYpi9aOXyyEb1j887goyqelgaqSjiogYVw6Kk7dwq5i759njCFNTcdasg
 n/1P7CUNAiL7jxWHe8Z8m2eWlVA6elF+O3JQABIh7utCIpiicNUm7yop5FuEwxhhWviRmIYsf32
 XnU6ehysi+H0UntBdntct8HVDz1MPd9sVGerQoBEZyQv5u+7YmlX3VHK7+R74cwQ+1XrQCOazut
 XJw==
X-Received: by 2002:a05:6402:2088:b0:6a5:fbc6:cad1 with SMTP id
 4fb4d7f45d1cf-6a60d334d1cmr12440801a12.7.1788154383070; Sun, 30 Aug 2026
 22:33:03 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 00:33:02 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 00:33:02 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
References: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
Date: Mon, 31 Aug 2026 00:33:02 -0500
X-Gm-Features: AcwNN1WXdLhwaTvKo5Ws--zHjKmKCbHB-j7jN9AheKAa8cz7hqKNhAN9Lr7tL8A
Message-ID: <CAH=xXfFd7YskcSBXauAYKLVuC0HP4dej4w5Rtf7HCfdFDCSRGQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0udp-0006Xh-QJ
Subject: [f2fs-dev] [PATCH v3 04/11] f2fs: describe orphan block layout
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
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
 fs/f2fs/checkpoint.c    | 44 ++++++++++++++++++++++-------------------
 fs/f2fs/f2fs.h          | 12 +++++++++++
 fs/f2fs/super.c         |  2 ++
 include/linux/f2fs_fs.h | 18 ++++++++++-------
 4 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3ecced9b4d57..37a72b693545 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1041,7 +1041,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)

 	for (i = 0; i < orphan_blocks; i++) {
 		struct folio *folio;
-		struct f2fs_orphan_block *orphan_blk;
+		__le32 *orphan_inos;
+		struct f2fs_orphan_footer *footer;
 		unsigned int entry_count;

 		folio = f2fs_get_meta_folio(sbi, start_blk + i);
@@ -1050,9 +1051,10 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 			goto out;
 		}

-		orphan_blk = folio_address(folio);
-		entry_count = le32_to_cpu(orphan_blk->entry_count);
-		if (entry_count > F2FS_ORPHANS_PER_BLOCK) {
+		orphan_inos = folio_address(folio);
+		footer = f2fs_orphan_footer(orphan_inos, sbi);
+		entry_count = le32_to_cpu(footer->entry_count);
+		if (entry_count > F2FS_ORPHANS_PER_BLOCK(sbi)) {
 			f2fs_err(sbi, "invalid orphan inode entry count %u",
 				 entry_count);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -1063,7 +1065,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}

 		for (j = 0; j < entry_count; j++) {
-			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
+			nid_t ino = le32_to_cpu(orphan_inos[j]);

 			err = recover_orphan_inode(sbi, ino);
 			if (err) {
@@ -1084,7 +1086,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 {
 	struct list_head *head;
-	struct f2fs_orphan_block *orphan_blk = NULL;
+	__le32 *orphan_inos = NULL;
+	struct f2fs_orphan_footer *footer = NULL;
 	unsigned int nentries = 0;
 	unsigned short index = 1;
 	unsigned short orphan_blocks;
@@ -1092,7 +1095,7 @@ static void write_orphan_inodes(struct
f2fs_sb_info *sbi, block_t start_blk)
 	struct ino_entry *orphan = NULL;
 	struct inode_management *im = &sbi->im[ORPHAN_INO];

-	orphan_blocks = GET_ORPHAN_BLOCKS(im->ino_num);
+	orphan_blocks = GET_ORPHAN_BLOCKS(sbi, im->ino_num);

 	/*
 	 * we don't need to do spin_lock(&im->ino_lock) here, since all the
@@ -1105,21 +1108,22 @@ static void write_orphan_inodes(struct
f2fs_sb_info *sbi, block_t start_blk)
 	list_for_each_entry(orphan, head, list) {
 		if (!folio) {
 			folio = f2fs_grab_meta_folio(sbi, start_blk++);
-			orphan_blk = folio_address(folio);
-			memset(orphan_blk, 0, sizeof(*orphan_blk));
+			orphan_inos = folio_address(folio);
+			footer = f2fs_orphan_footer(orphan_inos, sbi);
+			memset(orphan_inos, 0, sbi->blocksize);
 		}

-		orphan_blk->ino[nentries++] = cpu_to_le32(orphan->ino);
+		orphan_inos[nentries++] = cpu_to_le32(orphan->ino);

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
@@ -1129,9 +1133,9 @@ static void write_orphan_inodes(struct
f2fs_sb_info *sbi, block_t start_blk)
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
@@ -1824,7 +1828,7 @@ static int do_checkpoint(struct f2fs_sb_info
*sbi, struct cp_control *cpc)
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
@@ -2255,6 +2256,17 @@ static inline struct f2fs_sb_info
*F2FS_F_SB(const struct folio *folio)

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
index fdc2b0c51c06..f9811d571ae5 100644
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
index 061f906a7b94..7d2cbceb42d5 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -220,14 +220,18 @@ struct f2fs_checkpoint {

 /*
  * For orphan inode management
+ *
+ * An orphan block has no fixed-size C structure because the number of inode
+ * entries depends on the filesystem block size.  Its exact on-disk layout is:
+ *
+ * 0                           blocksize - 16             blocksize
+ * +--------------------------+--------------------------+
+ * | ino[0] ... ino[n - 1]    | struct f2fs_orphan_footer |
+ * +--------------------------+--------------------------+
+ *
+ * n = (blocksize - sizeof(struct f2fs_orphan_footer)) / sizeof(__le32)
  */
-#define F2FS_ORPHANS_PER_BLOCK	((F2FS_BLKSIZE - 4 * sizeof(__le32)) /
sizeof(__le32))
-
-#define GET_ORPHAN_BLOCKS(n)	(((n) + F2FS_ORPHANS_PER_BLOCK - 1) / \
-					F2FS_ORPHANS_PER_BLOCK)
-
-struct f2fs_orphan_block {
-	__le32 ino[F2FS_ORPHANS_PER_BLOCK];	/* inode numbers */
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
