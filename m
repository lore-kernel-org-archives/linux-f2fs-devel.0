Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2378FC5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNl346YyEkq7bRQFH05H71AtQTfbr2HWz6dfbpUvw5g=; b=MVrPT9qMXJlmjBGNbXTjqsaayp
	8zAfXA09AXsPN2XYF7sRpxiRtXvRHMgCJmzMJxswpRknb9Grmshl3F9szOEAbq1ZvUItxngRnpxxR
	l1KTeNSzI5j6/Rbq6XJ/fzRkStIVXK8834EmywdIMDmL0lhRY7tbZ2hsPoSeug5Ly0I0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzLLh-0003JB-50;
	Wed, 26 Aug 2026 21:39:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1wzLLg-0003J1-CQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LlsNfxWemhMviWnYnZ0KStlrqTocK5pZLQjuVsmOIfA=; b=Lnc+t/d/VzsSHy9SDMKQ8fXE7P
 V4OLkh7wEAu1o8DhjwHABluzLwwWa7pQfYaR8HpOMIo9zdt7byHmgrLIAgTxTdQ+nXRz5Pu0j45jo
 0U0eOm84gwcIKfjwzMflrsjBi5k9OHjQ6WcZpimcfspazYGGoO91TID90GcRHqvm2f54=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LlsNfxWemhMviWnYnZ0KStlrqTocK5pZLQjuVsmOIfA=; b=mkELJp4GZ16WsXApyIpMgE8fuU
 4LMmEHo1zOhn8HGkTcSQvJjI3L2vuamQUZvykIrzRngTdG/K2d9UF5dbknhD/VBdl/UI6i9se/Udj
 yUIG8Fi/ymYKqnO6DeRAxO1yNOY4ZxEZjarfJUqzGvh5YdYK3tPr2uVc3nY/6H0amRvQ=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzLLg-0002rf-Ek for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:39:57 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a5f1d0af69so1440713a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 14:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787780390; cv=none;
 d=google.com; s=arc-20260327;
 b=Mc1ONbdOfFqn2+HcM2HxoKhnZpaZjyEpIUkZsFbTjesFXAYzI6VjhHKZjoTjBfrzIJ
 A013H27Tw1EQ2O9W4+AHAGWQdGh7LEFYwZ0TpBZfIqUxn6Y68lt/9gYVGJnLjhR5JzzB
 +o4e/RZSdeVfarCiVRSWiWH8Iy/6rWhnLAi8bzO129dDV5jyH0+AQlqPc1cVdklPjS/R
 E9Kzs+TbhYvIscAUJnlbatEpztRopybNkIjcpwSl0z/iQmlIeFnrTutDckq+KBpetJBo
 oKpLanTW+Rmk/JpvYbIXDSaiYoxkhKcA0PFMtQ6IwCO9/EGKOeTro45ypmV+TBQdNCy6
 4hNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=LlsNfxWemhMviWnYnZ0KStlrqTocK5pZLQjuVsmOIfA=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=G5iflG2RI4RJDmlwuf5uryhp3fzmxl8DcoEIyAGAfRgZjjp4H42zNhEJIfTuNpsktC
 XaUbid043tYeqKcZvlbEGyrBlfWYDeP+aV7fLXvVs5dSVFjmKiigwbqUQivSBhapjHju
 cLSXUDSidX6CSCEbAt47a1uy48OroLv5r036AVZ6VM3bviHHnF4WtVXLZxb8I7zx0rZW
 uENb9J+sASyydu2Vn3iz96FAUJ7vn0QrHlTL6h6mJj4HeOhzefM2FLttmHaMIP9QknJf
 ZZQXzfqKJwEs9ZgGAIjp89lfvLfIc5MK3zuTsVgQXDgEUZfP/8n6MPdVTMj9t6+QIDs1
 aXLw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787780390; x=1788385190; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LlsNfxWemhMviWnYnZ0KStlrqTocK5pZLQjuVsmOIfA=;
 b=iYYxHEZdqqO2W4yN/do55zpGXRKk9qnPjp8YzeYxyiz0dEmEb4sr5WDxzBZpUEgEDs
 MBYy55Esqx4qa/TrHUta5ALjyuhwfjiUblll6zHhhJLmxo38um1vK+aVVa27g0G8woAM
 +8siBpCQvkbhdfd+iuXz4P21vnFq8e0imSyBl7d8PEvXmJiU2BQv9irBCU5SGZVl6C+c
 ICitni8Blyh/x3MyggzeqJ4bmwVv5I3cd61KcTUYgIXF010STApaOTXEooeFhuBxOF4t
 5KdruxFKVYXPgWfiUSnoFg9BXwrOKW/eZ1lywZo/Hka4016SFaihu2Lc+m+/HlMibp2V
 kqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780390; x=1788385190;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LlsNfxWemhMviWnYnZ0KStlrqTocK5pZLQjuVsmOIfA=;
 b=CxmbR024lyJz7XctqBLYD8luvyWK2oyC44DS4B7ZzY1DlCRClwCGfaMVU+oPW66uoq
 w4IqiAinY2TIpuVyjQ6gYHnKpk7ARIBjdRyqJApBRUxTJgJm1Dt2/0PCgy8jYbO8K2/e
 KdEZL2ilorhfZJCFFBH8EJn523rkRqmtzlF/85P2SbeJ2tOVBO79/BkLfhwgCkp4oLPJ
 wYLXGGub+3VCEyzpUmyrgWI33oJWI0xW1eY9Z6NKd5IuJDvGj6pHFTHjOrlLPf+ezJOe
 d5+z3cliKAb2ROB/kdWpAgZ+GTuWGaggmqVSNjR4VTxYYCigGx9KGgTwBZXaO2Q9AC6v
 vKGw==
X-Gm-Message-State: AFuF++nKYaylMRxYAU7VYxS407EuZ8s6YEnnxv9AqIOJ6sejDVFRHbcb
 5IJRvRIgv1PR48PWCmKeCsiXbxqlyE/G8aFGOMDdLNE18K2+v6vfRM8882mngYMDh35/XxLIrB0
 D/EaEP+24V+CMwTJyZKIfVDU6aXqA0WKBUl8bxGI=
X-Gm-Gg: AR+sD10iE9juyGfesYarSrT7hpnNQjp6dgs3BxHfe7LzuIq6g9kCyq5vcZmdqshC5+U
 Or80w6EsN6OgajiXx9B0nvuI7OYFTHXyXyenFHEosPuGy1s9oVpdbHF34YBY6nDODIuK0yLWZ8v
 7VyULutAjb/C0TnC+qxxbbo233ITv07DKTrf5vWjTyrA+SoDU0EQlNXVMVI5FHUK27yfTu2A6WZ
 8XUJ+6+ifm85QIbfQ9HorV7fO6/Jjhx5fCgh9AzuojIw01JhrWT7rNl35qE0sR1YYz3Ogq5KsBq
 sE32IoyGow0AuDHClX+pd4sxpJ5m0OrB/tvMH94Ut+YjqD0+Y9nc93yYaLPNznJ/K/fKk4pjNEX
 i
X-Received: by 2002:a05:6402:24d2:b0:6a5:f4e6:ec14 with SMTP id
 4fb4d7f45d1cf-6a5f4e6edf0mr2052653a12.4.1787780388907; Wed, 26 Aug 2026
 14:39:48 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:47 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:47 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
References: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
Date: Wed, 26 Aug 2026 16:39:47 -0500
X-Gm-Features: AcwNN1XBh0dMCwkSFjy6ji5U2z__GZwMCCh_YD8MPyP62QjLX52Ik_B5vqVb1AU
Message-ID: <CAH=xXfEUmup0TNrZPG9HdhjvOCXcV1EX5sJ3CpooaFsBxh7gMA@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wzLLg-0002rf-Ek
Subject: [f2fs-dev] [PATCH 3/5] f2fs: describe orphan block layout
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

An on-disk orphan block consists of a variable-length array of inode
numbers followed by a fixed footer. The compile time definition of
orphan block struct cannot describe a runtime block length layout.

Remove the whole-block structure, document the exact layout, and add
helpers that derive the inode capacity and footer address from a supplied
block size. Access the inode array and footer separately.

The caller still supplies the existing fixed F2FS block size, so valid
filesystems retain the same on-disk format and behavior. This is a
layout-only refactoring to accommodate a runtime block length.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    | 44 ++++++++++++++++++++++-------------------
 fs/f2fs/f2fs.h          | 12 +++++++++++
 fs/f2fs/super.c         |  2 ++
 include/linux/f2fs_fs.h | 18 ++++++++++-------
 4 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 47c4a5c83a70..51ef4f421937 100644
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
index 4423f899b2b5..d1235ba80331 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1863,6 +1863,7 @@ struct f2fs_sb_info {
 	unsigned int log_blocksize;		/* log2 block size */
 	unsigned int blocksize;			/* block size */
 	unsigned int sit_entries_per_block;	/* SIT entries in a block */
+	unsigned int orphans_per_block;	/* orphan inodes in a block */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
 	unsigned int meta_ino_num;		/* meta inode number*/
@@ -2251,6 +2252,17 @@ static inline struct f2fs_sb_info
*F2FS_F_SB(const struct folio *folio)
 }

 #define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
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
index f71a2b63f8ab..f324e9cf4264 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4350,6 +4350,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->blocksize = BIT(sbi->log_blocksize);
 	sbi->sit_entries_per_block = sbi->blocksize /
 		sizeof(struct f2fs_sit_entry);
+	sbi->orphans_per_block = (sbi->blocksize -
+		sizeof(struct f2fs_orphan_footer)) / sizeof(__le32);
 	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	sbi->blocks_per_seg = BIT(sbi->log_blocks_per_seg);
 	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 324427cc29dc..a5111556d923 100644
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
