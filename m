Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECDFC61DC4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u80WVWkIHLum3pVMtw74b15Y+jY6GuYByEXLWhTiwjs=; b=DUYZiFmqPHGBHycQFRqxza55S+
	XYW7pVwYwatCuZCE94dGfqas/NGCb15RRLo5h6gEjC3n3GUuG81FU4tirQepABiizmZJNDgiuMu7I
	evV0zvzAr1I2bEKtOMXiERZSQN2fb4WNDj/zCteUmnPazRw+1VS08AS+vdJK+Iw0ULWw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzLLd-0001zh-8x;
	Wed, 26 Aug 2026 21:39:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1wzLLc-0001za-IB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:39:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hKvrCasOCKT/DyEhWxJp6Xu43dSEy3m9PcOA3nYVyys=; b=WvlUYnW7QSlmk81yv+OIvFbR9W
 vqTrrEZOsa0ZTxAQ5jRrcPGRkfAYxDP+GRliU7IIejfp6xHTFklG8CgbH2IgAeWmsad+eevB2Y2ES
 5RkVcEd+xqkVXLy98dbXD9tdjI1n7S7aA0kaaubFtSuMPLVI0vVUrVE1R/vZGU+xJMxM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hKvrCasOCKT/DyEhWxJp6Xu43dSEy3m9PcOA3nYVyys=; b=mZcEeYhM7WLE1UjqvvQXv/DS2D
 iBb6UOIE9BfrLHy0W4I7rQwCzRSubhPLSShgHbAF2pyQ5/Z+JhMibo0tDla8g5bFdlSuz1BCqHJHY
 EByozsy+K8vbxnLwA6qiaZ8f5ajQzsXzn3vuIuve6ftSa/HnlESTKvQ/BcTb0VMqttYc=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzLLb-000260-RU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:39:52 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso2464743a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 14:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787780385; cv=none;
 d=google.com; s=arc-20260327;
 b=SG05KCMMUZyjXGE7TgPGu3okABOGluZ7MDSsrUkCnKxWc1/sYfjEATHtngk7Ue2430
 KQVZ1n7+CyxGHakmkM90F3V3Byo9WNZE1gHm9m0PYjqY4SRwx+gKn+1UGu6bvjBDYieT
 AjanueJtTuo3HWZ1yH+BjKoggacKOnJ6aXHHWMZK7pHSJbDJef1gnfqaj80mQKm7LuY5
 1vRBnDbeR4DlQYHOMpPXJk27iyc22nNUO9hs2eayNEcvT8GnG9cmYln92OKfKSifOrNh
 xQ3Peq/2+DUuK6+ph1JinEgeI6mSyXqD2q+Wq4lVUS3v5iDgB4vJlGVuT91zq4JyDXkr
 bJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=hKvrCasOCKT/DyEhWxJp6Xu43dSEy3m9PcOA3nYVyys=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=klVwmqjsP2J2almus+ENpbR0FpjOPKwvZJzU/c8dDGID3zAML94DLpoBYrF3f64os0
 4JYDyQUnAteqEwI2TzeIBVnV36tsi2Px7CSiPgUw7ggrJIqJmgnzaZSQMHWBDxJ1dOY0
 lgo/c3T7+E4i9eUXxylGhw04gWTRNAAZiobkLHlaLgj5ZLJVljDkDujQKRftHfFqZpxg
 nSKieMHr80VKYEwgqxbZY0rZHxpxfbbOJwTFJPIy08ZJUJGd6ePz89UZSFSfq5H9PZr2
 LCYUUvSYQoCJsmw25sxRwKOK41JDuT2OywhJuCPXRhyW6X3dbBSo3erAgNOmEK4nYYwQ
 XzgQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787780385; x=1788385185; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hKvrCasOCKT/DyEhWxJp6Xu43dSEy3m9PcOA3nYVyys=;
 b=kjmL2oPPq85kLOGl/aVau1vgg58NV080xx90cdzigCUL42G5zViXVI53PhzUHXOO3d
 cbQLhh7moyEUBBNEiScC3W6IZAGyf3D1z9fqG+IiS/RJQft2l0RIFu6AiJlvVCcpENro
 +Cv8XglrPLVlI5R/QtEcfDT6ttbx4wTnW3nlIS8CfGemLJRelI7JyZ8oSeodqyKu3ve2
 WFHqAWxvchSg46MGQKDAm5Ntmb/9kGWTn0BVdOGlUtQ+RscMbxHrLWgR3Tjuq4dQ1bBA
 W8JJ4jGw1aA+Cnh5eELUpYcRSASO9aiSaB+655c/Qmg+yOKRhgqgzWljYrZPqn+Eeezr
 bMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780385; x=1788385185;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hKvrCasOCKT/DyEhWxJp6Xu43dSEy3m9PcOA3nYVyys=;
 b=bZkuJexgWUBqZAkRW2h94VHZYPLJ1eFLYMxOjAjBtDwy6X8ji51XinY+q824S2cRW4
 RY1c/hF46GHeijEOMGSFhiQzAmws7zrEBbJdFnudctPVd6SE5P8cbUa2fa8GjY1NReNf
 6XPkPpukFMB6uiCKch2v76Wh3jQGPzD4xFHF43scH+z7zzjvZ1X/1SrVNJuGDeyxMGBk
 3BKKMMJzEWCPPFLl/0K6HaVCNZIaYGPGtwR5cFZUutWXoD9VnocbN89SR7pDA/oepnwF
 rbMB6ocAhRJEuXNWeQY6mz8TfI6vstxnN34XGveQYDkaz47eHK0GlfnCRowHsvWTN5T5
 ZuQA==
X-Gm-Message-State: AFuF++lo22HfwWYLlbtR8vWrCKWtxh6p7bI1XYFLJGbOgOEJ+c+dqEL5
 jbupAIjpInE4VYQxotGAm3pmPqjAOQVfgdxCtX+3/wHHMri6inSWlLCxmcyvtFQaMhFOJ1sC2t1
 Uav535zifuFyRtJnQRBrM3mJrTpTN0qerQvM2R5E=
X-Gm-Gg: AR+sD100kAKwYTq30WB1PxWuWXBG0s4kSMA2FHWf5L6s3eCaOpqZmXB71yqpehC6QGM
 SPrOYW9xmdrNXINmnLZS9cuFmZXr4uCqrobjYhK3j2Sx0KYpntnatFw8pjmZCq3h/9GlLeMWWAR
 l9IZcdYETEJZQ0RKZboavUOLX2lo+rFq814egTnyjBe82CXJQFwCMb9E3LRlhBpjFp3xMNfBh7J
 mwuCf9dhXFCFkO8BvF2QXHI+Bcr8ZPNoRRag7s6pLPYd9JQTPOdCZ2dbGPOFj//FOARyf3U2DGu
 GzB+x8HPVwN7fiJZMPhmO72wM+yZoOCvwsZ/QgwJ16j8JBzcywXeF4ld4lUPS6QHjgvCc1YDASy
 E
X-Received: by 2002:a05:6402:50c9:b0:6a1:28d8:2306 with SMTP id
 4fb4d7f45d1cf-6a5df5c688emr10352413a12.1.1787780385063; Wed, 26 Aug 2026
 14:39:45 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:44 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:44 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
References: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
Date: Wed, 26 Aug 2026 16:39:44 -0500
X-Gm-Features: AcwNN1WOHCzWgi6oQVYrqIg5x5GznlecK5ewJ3ew4weWTdxYqZzK2fCfuj1zNVg
Message-ID: <CAH=xXfE94eYwRAF=X16fuyV=bXm=MFvOf0bTpLDOT-5rZTDWCQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wzLLb-000260-RU
Subject: [f2fs-dev] [PATCH 2/5] f2fs: describe SIT block layout dynamically
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

An SIT block is a filesystem-block-sized array of SIT entries. A
fixed-length array makes the C structure describe a particular block size
rather than the on-disk layout.

Use a C flexible array member to model that dynamic layout, retaining the
entry count as an explicit filesystem geometry calculation. Unlike a
zero-length GNU array, this lets bounds sanitizers retain the runtime
extent. This is a layout-only change.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    |  2 +-
 fs/f2fs/f2fs.h          |  3 +++
 fs/f2fs/segment.c       | 15 ++++++++-------
 fs/f2fs/segment.h       | 19 ++++++++++---------
 fs/f2fs/super.c         |  4 +++-
 include/linux/f2fs_fs.h |  9 ++++++---
 6 files changed, 31 insertions(+), 21 deletions(-)

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
index a1f5f375045a..4423f899b2b5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1862,6 +1862,7 @@ struct f2fs_sb_info {
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
 	unsigned int log_blocksize;		/* log2 block size */
 	unsigned int blocksize;			/* block size */
+	unsigned int sit_entries_per_block;	/* SIT entries in a block */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
 	unsigned int meta_ino_num;		/* meta inode number*/
@@ -2249,6 +2250,8 @@ static inline struct f2fs_sb_info
*F2FS_F_SB(const struct folio *folio)
 	return F2FS_M_SB(folio->mapping);
 }

+#define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
+
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 {
 	return (struct f2fs_super_block *)(sbi->raw_super);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 56decf9c691c..8b8fbd5072b6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4707,7 +4707,7 @@ static struct folio *get_next_sit_folio(struct
f2fs_sb_info *sbi,
 	seg_info_to_sit_folio(sbi, folio, start);

 	folio_mark_dirty(folio);
-	set_to_next_sit(sit_i, start);
+	set_to_next_sit(sbi, sit_i, start);

 	return folio;
 }
@@ -4746,10 +4746,11 @@ static void adjust_sit_entry_set(struct
sit_entry_set *ses,
 	list_move_tail(&ses->set_list, head);
 }

-static void add_sit_entry(unsigned int segno, struct list_head *head)
+static void add_sit_entry(struct f2fs_sb_info *sbi, unsigned int segno,
+		struct list_head *head)
 {
 	struct sit_entry_set *ses;
-	unsigned int start_segno = START_SEGNO(segno);
+	unsigned int start_segno = START_SEGNO(sbi, segno);

 	list_for_each_entry(ses, head, set_list) {
 		if (ses->start_segno == start_segno) {
@@ -4774,7 +4775,7 @@ static void add_sits_in_set(struct f2fs_sb_info *sbi)
 	unsigned int segno;

 	for_each_set_bit(segno, bitmap, MAIN_SEGS(sbi))
-		add_sit_entry(segno, set_list);
+		add_sit_entry(sbi, segno, set_list);
 }

 static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
@@ -4792,7 +4793,7 @@ static void remove_sits_in_journal(struct
f2fs_sb_info *sbi)
 		dirtied = __mark_sit_entry_dirty(sbi, segno);

 		if (!dirtied)
-			add_sit_entry(segno, &SM_I(sbi)->sit_entry_set);
+			add_sit_entry(sbi, segno, &SM_I(sbi)->sit_entry_set);
 	}
 	update_sits_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
@@ -4842,7 +4843,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info
*sbi, struct cp_control *cpc)
 		struct folio *folio = NULL;
 		struct f2fs_sit_block *raw_sit = NULL;
 		unsigned int start_segno = ses->start_segno;
-		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
+		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK(sbi),
 						(unsigned long)MAIN_SEGS(sbi));
 		unsigned int segno = start_segno;

@@ -5007,7 +5008,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	sit_i->written_valid_blocks = 0;
 	sit_i->bitmap_size = sit_bitmap_size;
 	sit_i->dirty_sentries = 0;
-	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
+	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK(sbi);
 	sit_i->elapsed_time = le64_to_cpu(sbi->ckpt->elapsed_time);
 	sit_i->mounted_time = ktime_get_boottime_seconds();
 	init_rwsem(&sit_i->sentry_lock);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index db1079169a23..4f90f3bc2a7f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -101,12 +101,12 @@ static inline void sanity_check_seg_type(struct
f2fs_sb_info *sbi,

 #define SIT_ENTRY_OFFSET(sit_i, segno)					\
 	((segno) % (sit_i)->sents_per_block)
-#define SIT_BLOCK_OFFSET(segno)					\
-	((segno) / SIT_ENTRY_PER_BLOCK)
-#define	START_SEGNO(segno)		\
-	(SIT_BLOCK_OFFSET(segno) * SIT_ENTRY_PER_BLOCK)
+#define SIT_BLOCK_OFFSET(sbi, segno)				\
+	((segno) / SIT_ENTRY_PER_BLOCK(sbi))
+#define	START_SEGNO(sbi, segno)		\
+	(SIT_BLOCK_OFFSET(sbi, segno) * SIT_ENTRY_PER_BLOCK(sbi))
 #define SIT_BLK_CNT(sbi)			\
-	DIV_ROUND_UP(MAIN_SEGS(sbi), SIT_ENTRY_PER_BLOCK)
+	DIV_ROUND_UP(MAIN_SEGS(sbi), SIT_ENTRY_PER_BLOCK(sbi))
 #define f2fs_bitmap_size(nr)			\
 	(BITS_TO_LONGS(nr) * sizeof(unsigned long))

@@ -423,7 +423,7 @@ static inline void seg_info_to_sit_folio(struct
f2fs_sb_info *sbi,
 	struct f2fs_sit_block *raw_sit;
 	struct seg_entry *se;
 	struct f2fs_sit_entry *rs;
-	unsigned int end = min(start + SIT_ENTRY_PER_BLOCK,
+	unsigned int end = min(start + SIT_ENTRY_PER_BLOCK(sbi),
 					(unsigned long)MAIN_SEGS(sbi));
 	int i;

@@ -868,7 +868,7 @@ static inline pgoff_t current_sit_addr(struct
f2fs_sb_info *sbi,
 						unsigned int start)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int offset = SIT_BLOCK_OFFSET(start);
+	unsigned int offset = SIT_BLOCK_OFFSET(sbi, start);
 	block_t blk_addr = sit_i->sit_base_addr + offset;

 	f2fs_bug_on(sbi, !valid_main_segno(sbi, start));
@@ -893,9 +893,10 @@ static inline pgoff_t next_sit_addr(struct
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
index 3bdb0f891c35..f71a2b63f8ab 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4295,7 +4295,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}

-	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK);
+	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK(sbi));
 	if (sit_bitmap_size * 8 < sit_blk_cnt) {
 		f2fs_err(sbi, "Wrong bitmap size: sit: %u, sit_blk_cnt:%u",
 			 sit_bitmap_size, sit_blk_cnt);
@@ -4348,6 +4348,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		le32_to_cpu(raw_super->log_sectors_per_block);
 	sbi->log_blocksize = le32_to_cpu(raw_super->log_blocksize);
 	sbi->blocksize = BIT(sbi->log_blocksize);
+	sbi->sit_entries_per_block = sbi->blocksize /
+		sizeof(struct f2fs_sit_entry);
 	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	sbi->blocks_per_seg = BIT(sbi->log_blocks_per_seg);
 	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index bb2b6cd5d507..324427cc29dc 100644
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
+	struct f2fs_sit_entry entries[];
 } __packed;

 /*
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
