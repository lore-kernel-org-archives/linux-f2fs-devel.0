Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47070C624D0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MAL2FUz0xG/qEOsExUC0c3erRsDWe3jTdSFw1qZqFAw=; b=jWXHY+NJ4TnOCMNUGZP30lUDrc
	Y3l6mxkAhXMxuAlG9G08fJbwHcmEdGpBrJT+4XqcdL8G+Z3pf2RZwKXJTkp9lhnkJGbsSkIbSnUgr
	fgTWQ4yXt+Qw85ENoCDzPXhfklH62vX/+7dTuHO4U6UqX14ENWAPwRLgybjRTNh0CTzI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15Ox-0004Zz-HZ;
	Mon, 31 Aug 2026 17:02:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15Os-0004Zk-7b
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J/1FY9WSB5RX6nf65O/jeitFs0+eIMznWlZ+J5l85Tg=; b=I+Bi9jXAF8F8rzV9+xXhQnk+lN
 gcme6Ft6MoxpsXxPYC2U2VKKBMwnC4ImKl1RXqoaW7wpgJf0/SRGzlKWanXDABLvNLUIJTyw0ehnc
 01PKxvJsElDlypaXjTnp0nK8H3vyYvkXSD70eUa657Vdmpzvfp2zdz/0rkzaVGx4m9FU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J/1FY9WSB5RX6nf65O/jeitFs0+eIMznWlZ+J5l85Tg=; b=i1YsTGdjGvxQ6+o6IUj1hI+/oY
 0n36/O58xo4+O/yqVbhtkIcGSg5COGUDi2JeujB/goX7s4ulKrHaQlhylWp2yRHQAnyFu714viW5S
 fJXnxsmfB+nQ+i1jmC/M0nGXrpC4OtWDLAGodwl50en83WAx8c8sUwlmTl9hg+m9QZ+g=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Oo-00014L-DT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:23 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so5942859a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195736; cv=none;
 d=google.com; s=arc-20260327;
 b=QN9ZftDgyE7rHFi8iZeXIT6FfI0QGHMlOPyQwDgg4OOinKRKhSZGr26uyt/L7tUytT
 ZcBOhNtHbxMewrDi0mzvb3dlSgV3Mc3HXJr6kYEjmxtWu2j/NgKe9kHtB37lmKY4qGtK
 qwFSRyxXUdvK5zAJ/XqwtipxCD+krBCpoCmjrwlW2NvXqsVQlgYNzF3QrUvipF6jBQ9n
 8frVbhtwG9S082DtlftjXewRNiWSbTx2LKkAPDVwHPa+sdU6Gh+TiVPFzTyEZuW4Bkke
 nuKrp/8SCxhswHb6ys2Gp6d4D/kXYTDntkV+G9Excco5DuKszhxYZvFy9Wy1/LSIgIZo
 m7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=J/1FY9WSB5RX6nf65O/jeitFs0+eIMznWlZ+J5l85Tg=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=lzJMh1MrPAMcE/ykIxf4zdY1uCu9EIk8jzf/bmf06md+KGnAclyx+d0PcPOLqhjkKg
 i04bFvvtIYePHu1KllvZQAA07xejMITzcmcpC2jhCwfbHJDG7DZVTXwTkv2+cFHBUPJL
 1BaGxa1i4nT70d28tayj6UgHuu+SKgPIHUPCDGd+vn12ivhYy6p6JGyEWgsJ7YzeT0HK
 tDnnq0ScFXQXWz8NpE0/GkTfFvmToP9PqMXtfhUQYiw50AJe8zvpZpfUTmfIaxAzRlEm
 Il1XpFqfxRUocPreUS9yXyerIiCpgXPEWYw/pZiKIt9VfmsB5UYy2b2nq4erZpVfEki1
 sf/w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195736; x=1788800536; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J/1FY9WSB5RX6nf65O/jeitFs0+eIMznWlZ+J5l85Tg=;
 b=pXwXjS0hc/1RFJ5ppD/bb9/bPU5KIXq0s6Mj2ybU2212K3gjz1rKnldcIsxQLdjUjG
 +qDfyiHSAocORGp+W9vaTgl+Jb/DjZmZHzX7g4pzqhf3ie24y7CtP6TtkXcjW2o4HGR5
 m/bSkdQMeFy8gS6sF/uzXgLzLqzvCZOR9WueVpmamVX2C92TEiLYXwQipDpXLrwJpWuC
 fyW/Rc1iV2kV1RsIKkyqbs3eQuZjbxCcSZ7zjQ0BKMCH0e5sxe8uF2A0fUQe1fVsHVB+
 R8Ca5ikCanrAE3126blBgn+feA8YVIMlq2bmzSzMRgor0VrbSpRoJ/1kIZdjUcm6Nzh7
 OXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195736; x=1788800536;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J/1FY9WSB5RX6nf65O/jeitFs0+eIMznWlZ+J5l85Tg=;
 b=QTZ3SzMuaouAuwBb5EFSs2neTgWpezDBa90ZswmJXqUDwE6oK5ZGvrTDWuq5JJ+xkf
 A0Opg+DCTK44o6QchEV8XcPon1vWw40pYey5Z84WUxaciI5HtRYzg9FcLLdXSw2SPjZD
 xTEiKF0PkLDkp7nUoin5gNk/jzGOF8Sh+OKPavwy9FFlF6m6TLUZ12KfTUifG3egk4EH
 EN/BqeTa7k8ZKFawVjH6Dr73iOVj88L3gTLq0fONYJ4WrF+Yo4AYvhPJ7kX0zUHj0XO9
 So0FhPZtfl9+ma5U1l7v05Z2F2GCSJIRylhxF0XaQHdz32xn8tbfoh5UH+I/O7AO6Y1E
 CnQg==
X-Gm-Message-State: AFuF++kkv4jYbUQ4QfQ9NrBN2wpQQF6OG6vqQKKOyVEhDaYEdPIdsL9y
 O/Bq5q8ilHznrFU7MkZlAE8Y92TAHmWLLohzF6msFXc6mvj1B4Mrs0iaCU6BeYZ1NOFcfVaiDxZ
 PN55w/LXUhxbD0+mwcJlEGzmQhtLoOwUcBCainv8=
X-Gm-Gg: AYBFou1jv/pxBGUuqEEBoCfLENzMhzg5ZKjARa1/fwJnosnOvOb4jAAdA+uRB5Dvhf2
 V8CyVUyHkdFMT702It8h0Xi2WpkNHepIibaStCVA4G/Y+ew6gFahaKA+kcQg/LjR4LpCsbmKxEQ
 NruvWK9ljygjXoUr5Ls8VPAVhY7ijxiZ/TGFvRtoU9/QtjJ3TImBtebiwNzt7HPQ1ZDpL05qlYM
 hY2udZn4LOEiXWPFMieWEMPTLulVS7cBIKyAgkZg5QLnjorS8bYB/mv5fDEOGVRVUD5b9NDOOsK
 rWXEW9UWMNx+sAgJpWe2Vy/4dM5dfxPzImQrh33hvL8+XNyQj+VEI1+Ws7wlXfIYPEqegPOqGM8
 c1rgnR15IlBpN
X-Received: by 2002:a05:6402:278d:b0:6a6:8dd:c76b with SMTP id
 4fb4d7f45d1cf-6a663a269d3mr1670537a12.1.1788195735434; Mon, 31 Aug 2026
 10:02:15 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 12:02:14 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 12:02:14 -0500
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
References: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 12:02:14 -0500
X-Gm-Features: AcwNN1WSECiwVY763Ga0thxv79wadvKdrrnS0Ts8sE7WMy-ldPUACmEBL-gUqzU
Message-ID: <CAH=xXfGSVMXtisf7MEi_nepOvC2rJQZcjsv-FxWEGOeLQuhWUA@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15Oo-00014L-DT
Subject: [f2fs-dev] [PATCH v4 02/11] f2fs: describe SIT block layout
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

An SIT block consists of an on-disk array of struct f2fs_sit_entry elements
whose total capacity depends on the filesystem block size. The existing
fixed SIT_ENTRY_PER_BLOCK macro hardcodes a 4KB block size.

Convert the entries array in struct f2fs_sit_block into a C flexible array
member, and calculate sbi->sit_entries_per_block dynamically in
init_sb_info().

Parameterize SIT indexing helpers (SIT_ENTRY_PER_BLOCK, SIT_BLOCK_OFFSET,
SIT_BLK_CNT, and f2fs_start_segno) to take struct f2fs_sb_info *sbi, and
update all call sites across segment management, checkpointing, and mount.

This is a layout-only change; valid 4KB filesystems retain identical
runtime geometry and behavior.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    |  2 +-
 fs/f2fs/f2fs.h          |  3 +++
 fs/f2fs/segment.c       | 15 ++++++++-------
 fs/f2fs/segment.h       | 22 +++++++++++++---------
 fs/f2fs/super.c         |  4 +++-
 include/linux/f2fs_fs.h |  9 ++++++---
 6 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4b59f30ef45d..47c4a5c83a70 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -487,7 +487,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi,
block_t start, int nrpages,
 				goto out;
 			/* get sit block addr */
 			fio.new_blkaddr = current_sit_addr(sbi,
-					blkno * SIT_ENTRY_PER_BLOCK);
+					blkno * SIT_ENTRY_PER_BLOCK(sbi));
 			break;
 		case META_SSA:
 		case META_CP:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 16720f1f0a9c..035863d513ab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1863,6 +1863,7 @@ struct f2fs_sb_info {
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
 	unsigned int log_blocksize;		/* log2 block size */
 	unsigned int blocksize;			/* block size */
+	unsigned int sit_entries_per_block;	/* SIT entries in a block */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
 	unsigned int meta_ino_num;		/* meta inode number*/
@@ -2251,6 +2252,8 @@ static inline struct f2fs_sb_info
*F2FS_F_SB(const struct folio *folio)
 	return F2FS_M_SB(folio->mapping);
 }

+#define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
+
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 {
 	return (struct f2fs_super_block *)(sbi->raw_super);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e7e745be71d..b3bf1b62cdad 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4708,7 +4708,7 @@ static struct folio *get_next_sit_folio(struct
f2fs_sb_info *sbi,
 	seg_info_to_sit_folio(sbi, folio, start);

 	folio_mark_dirty(folio);
-	set_to_next_sit(sit_i, start);
+	set_to_next_sit(sbi, sit_i, start);

 	return folio;
 }
@@ -4747,10 +4747,11 @@ static void adjust_sit_entry_set(struct
sit_entry_set *ses,
 	list_move_tail(&ses->set_list, head);
 }

-static void add_sit_entry(unsigned int segno, struct list_head *head)
+static void add_sit_entry(struct f2fs_sb_info *sbi, unsigned int segno,
+		struct list_head *head)
 {
 	struct sit_entry_set *ses;
-	unsigned int start_segno = START_SEGNO(segno);
+	unsigned int start_segno = f2fs_start_segno(sbi, segno);

 	list_for_each_entry(ses, head, set_list) {
 		if (ses->start_segno == start_segno) {
@@ -4775,7 +4776,7 @@ static void add_sits_in_set(struct f2fs_sb_info *sbi)
 	unsigned int segno;

 	for_each_set_bit(segno, bitmap, MAIN_SEGS(sbi))
-		add_sit_entry(segno, set_list);
+		add_sit_entry(sbi, segno, set_list);
 }

 static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
@@ -4793,7 +4794,7 @@ static void remove_sits_in_journal(struct
f2fs_sb_info *sbi)
 		dirtied = __mark_sit_entry_dirty(sbi, segno);

 		if (!dirtied)
-			add_sit_entry(segno, &SM_I(sbi)->sit_entry_set);
+			add_sit_entry(sbi, segno, &SM_I(sbi)->sit_entry_set);
 	}
 	update_sits_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
@@ -4843,7 +4844,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info
*sbi, struct cp_control *cpc)
 		struct folio *folio = NULL;
 		struct f2fs_sit_block *raw_sit = NULL;
 		unsigned int start_segno = ses->start_segno;
-		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
+		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK(sbi),
 						(unsigned long)MAIN_SEGS(sbi));
 		unsigned int segno = start_segno;

@@ -5008,7 +5009,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	sit_i->written_valid_blocks = 0;
 	sit_i->bitmap_size = sit_bitmap_size;
 	sit_i->dirty_sentries = 0;
-	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
+	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK(sbi);
 	sit_i->elapsed_time = le64_to_cpu(sbi->ckpt->elapsed_time);
 	sit_i->mounted_time = ktime_get_boottime_seconds();
 	init_rwsem(&sit_i->sentry_lock);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5949aa5200ac..534e376cbc92 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -102,12 +102,15 @@ static inline void sanity_check_seg_type(struct
f2fs_sb_info *sbi,

 #define SIT_ENTRY_OFFSET(sit_i, segno)					\
 	((segno) % (sit_i)->sents_per_block)
-#define SIT_BLOCK_OFFSET(segno)					\
-	((segno) / SIT_ENTRY_PER_BLOCK)
-#define	START_SEGNO(segno)		\
-	(SIT_BLOCK_OFFSET(segno) * SIT_ENTRY_PER_BLOCK)
+#define SIT_BLOCK_OFFSET(sbi, segno)				\
+	((segno) / SIT_ENTRY_PER_BLOCK(sbi))
+static inline unsigned int
+f2fs_start_segno(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	return SIT_BLOCK_OFFSET(sbi, segno) * SIT_ENTRY_PER_BLOCK(sbi);
+}
 #define SIT_BLK_CNT(sbi)			\
-	DIV_ROUND_UP(MAIN_SEGS(sbi), SIT_ENTRY_PER_BLOCK)
+	DIV_ROUND_UP(MAIN_SEGS(sbi), SIT_ENTRY_PER_BLOCK(sbi))
 #define f2fs_bitmap_size(nr)			\
 	(BITS_TO_LONGS(nr) * sizeof(unsigned long))

@@ -424,7 +427,7 @@ static inline void seg_info_to_sit_folio(struct
f2fs_sb_info *sbi,
 	struct f2fs_sit_block *raw_sit;
 	struct seg_entry *se;
 	struct f2fs_sit_entry *rs;
-	unsigned int end = min(start + SIT_ENTRY_PER_BLOCK,
+	unsigned int end = min(start + SIT_ENTRY_PER_BLOCK(sbi),
 					(unsigned long)MAIN_SEGS(sbi));
 	int i;

@@ -869,7 +872,7 @@ static inline pgoff_t current_sit_addr(struct
f2fs_sb_info *sbi,
 						unsigned int start)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int offset = SIT_BLOCK_OFFSET(start);
+	unsigned int offset = SIT_BLOCK_OFFSET(sbi, start);
 	block_t blk_addr = sit_i->sit_base_addr + offset;

 	f2fs_bug_on(sbi, !valid_main_segno(sbi, start));
@@ -894,9 +897,10 @@ static inline pgoff_t next_sit_addr(struct
f2fs_sb_info *sbi,
 	return block_addr + sit_i->sit_base_addr;
 }

-static inline void set_to_next_sit(struct sit_info *sit_i, unsigned int start)
+static inline void set_to_next_sit(struct f2fs_sb_info *sbi,
+				   struct sit_info *sit_i, unsigned int start)
 {
-	unsigned int block_off = SIT_BLOCK_OFFSET(start);
+	unsigned int block_off = SIT_BLOCK_OFFSET(sbi, start);

 	f2fs_change_bit(block_off, sit_i->sit_bitmap);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2d9f5b77f815..4bd1c9fb1f7f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4329,7 +4329,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}

-	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK);
+	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK(sbi));
 	if (sit_bitmap_size * 8 < sit_blk_cnt) {
 		f2fs_err(sbi, "Wrong bitmap size: sit: %u, sit_blk_cnt:%u",
 			 sit_bitmap_size, sit_blk_cnt);
@@ -4382,6 +4382,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		le32_to_cpu(raw_super->log_sectors_per_block);
 	sbi->log_blocksize = le32_to_cpu(raw_super->log_blocksize);
 	sbi->blocksize = BIT(sbi->log_blocksize);
+	sbi->sit_entries_per_block = sbi->blocksize /
+		sizeof(struct f2fs_sit_entry);
 	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	sbi->blocks_per_seg = BIT(sbi->log_blocks_per_seg);
 	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index bb2b6cd5d507..ecd6694af572 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -396,8 +396,6 @@ struct f2fs_nat_block {
  * Not allow to change this.
  */
 #define SIT_VBLOCK_MAP_SIZE 64
-#define SIT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / sizeof(struct f2fs_sit_entry))
-
 /*
  * F2FS uses 4 bytes to represent block address. As a result, supported size of
  * disk is 16 TB for a 4K page size and 64 TB for a 16K page size and it equals
@@ -424,8 +422,13 @@ struct f2fs_sit_entry {
 	__le64 mtime;				/* segment age for cleaning */
 } __packed;

+/*
+ * The on-disk SIT block is a filesystem-block-sized array of SIT entries.
+ * Its entry count depends on the filesystem block size, so it must be
+ * calculated by the caller rather than implied by this C structure.
+ */
 struct f2fs_sit_block {
-	struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
+	DECLARE_FLEX_ARRAY(struct f2fs_sit_entry, entries);
 } __packed;

 /*
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
