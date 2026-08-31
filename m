Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05084C61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3cTRW1F1HyWukMR182Cv/5XmSjQ+Kt6PS8kHsP75G2A=; b=GDorOzSUFcUj8v8dh6GXJmzJVb
	+MJo+hQ8UrRSXkfxCrogeDkRwMAhjKlb1A/Hv7Xy8CVD/IKnDfojFc0Z35Umm8uTKvBQpfIpoKCqI
	SvxDeH+6R5xkAgR6TkUv7ARMuDPmqceI+E4lJbcapQKsEqTy5DNtMNa0RPzqJRVHYFws=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1AAx-0005JY-0y;
	Mon, 31 Aug 2026 22:08:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1AAv-0005JS-Iv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 22:08:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MxBPSiGREhAhPA4w8Ogt4vVXD6aoADqBeEuVZcqzI3Q=; b=CPc0FMY0OyEX0rH24XyjcrC0vq
 Zqj1v9ReqXADvuqkh56qTuzg9W8PFf9i7C8OkYRFBagqil33WRVHX8CEYnp0m5MsCqgD1s1IsLUb+
 owOs0q6snFzPQ4bOf5azvQhr4v0wPEVJA7szHtAZK1dKsDUwpfAseA+GHvrf3MdA0vpg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MxBPSiGREhAhPA4w8Ogt4vVXD6aoADqBeEuVZcqzI3Q=; b=bUxXgo5YWr+CyeNq7B+78H6ylw
 kmersyQF/JsYeITVZWOLN2CtTUjP/cK/DX3wFIQ8FG/vBfcWsp8aKNJO7sTjgOMzTtI/5c4S6MLBA
 c86tO7o04am+REfrBpw2uLw/gV7xGX0E9y1QzeaHEuVuHSpQwVKTZe6lYFZk71T1Ms2Q=;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1AAu-0004qF-Li for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 22:08:22 +0000
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc1c3d79b9bso3568434a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788214095; x=1788818895; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MxBPSiGREhAhPA4w8Ogt4vVXD6aoADqBeEuVZcqzI3Q=;
 b=WdxFl8HUD3oe6xk/NGoNvOeDRL8qfg0kaACrbnVJc1CXPlI0Qa/XN3gEmtaMUzzPAd
 yb99cKWDqY3XiBwyxsh06RZkNt54IWcDD1Ea78fjiErLa/CifXrMVi51FRDolm/e0150
 JKQVNnEZOMaa3XGDvaZfBgZZNpZ0htM5Lc/JwIPlhEvmiqunZc60cErI7JdLQ6LAMHdh
 l4+3FbhkpFrSn0QHSBtIFo2fExh4nM8fQmousI2ccRzwp1HqhNC+4qObGqOsxpzA0sfe
 HF5QbgNOLJnuiKErtoBeW2D/mfSxx8WhxKn4LS4gcMh+yV2nR8acuY+lWPrgaty+ebN+
 h+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788214095; x=1788818895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MxBPSiGREhAhPA4w8Ogt4vVXD6aoADqBeEuVZcqzI3Q=;
 b=LdYCI0aCIck0Y+fTBxFr1F7gev4rfahtNkvFaXvp0wjzKvj+xPr09BPBCMpL3cW4KA
 UAk0yJAW7P6Bmm4egiZckNXDqUm4LV9yuaJ1fw4guGbdwNl4xDiKqU0zMGJBz1UWD2kV
 3LymERr0Lnhd2rA39X8qjQW1kJsZCTC48z7pBQaiVB2BT+js2BEALFiVdvlyoplGphkV
 +K7Wq5ZEwKM1sg7Je/ECb+zEMqQcHTaf9ySywcnMf1K+R4dr0mbJUOxH765cboEsxVmo
 3YY2WFnzXXAHVGNzrN3cUuar0g9Hlpa2mwQ0mWl9a6xN8vdrvGr/CSKBDUV5zsLDdkQE
 Qg2w==
X-Gm-Message-State: AFuF++noD04xLkKRnuqQbCVJkXLnOdtOHWOYv67QBdmRW2w27CCsB28m
 Sn5PSjCcpxxZBQXAz2edU3IbExM3tXcxrVwQDMRx9LR0QflxqBOLLThILzNkqzXKRYk=
X-Gm-Gg: AYBFou3s+8x4GXmqetHtR+/xr3HXAdMlGunxYv+lI/NMEekqbpD/fz42Xg9wAPRDD1h
 rrXFq641ScgWy7tVzYQCtjJnM6hChe9Vy5V7NotRC6kDYHqVnWb/xhdGfcDP7gGEQshglaRtRms
 ODpvgiQUSuZ+wIvQ5ldT+TIGbZ0YMhfhNTv2YjRDeWWeK9Dp1/oYTdhP+dx89jKfsvx6LUm1u7D
 O+CwsvzreewR0OmKmfCXStmulQA6nBHP02gGlk0GYvu3pvlZHYsxfERzp4tycTmZk9hhBdGM6GM
 zRPQufFivn5eDYmralPjOOcIF2rlo+LaC643mjfEcaGIltB5XNmeMpWqtDvIKIvULAPC6C73NNG
 rf4My/ptp6p50JpW/Z1AwwCNDRhBGL/km23CR225QY8itpx0edydEHewIHy8jtS6A6O5PwUtxwt
 LJ15NolaI0Xg4nARnfYuKu4ADjR1S+Wgy3ZRMOUF3hlXz7VwtcBhehIvjKsSzyuulOMQ==
X-Received: by 2002:a17:90b:48d1:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-39907b5fefamr5117407a91.10.1788214094753; 
 Mon, 31 Aug 2026 15:08:14 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:91a4:c2d8:1d54:21ad])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d76463csm1658592a91.9.2026.08.31.15.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 15:08:14 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 15:08:04 -0700
Message-ID: <d6a28ec269f24e0ea20f125671ae0e2802d384dc.1788213716.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788213716.git.zhangxp1998@gmail.com>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x1AAu-0004qF-Li
Subject: [f2fs-dev] [PATCH v7 03/11] f2fs: describe NAT block layout
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

A NAT block is a filesystem-block-sized array of struct f2fs_nat_entry
elements. The compile-time NAT_ENTRY_PER_BLOCK definition hardcodes the
NAT capacity to a 4KB block size.

Replace the fixed array in struct f2fs_nat_block with a C flexible
array member, and calculate sbi->nat_entries_per_block dynamically in
init_sb_info().

Parameterize NAT geometry helpers (NAT_ENTRY_PER_BLOCK,
NAT_BLOCK_OFFSET, f2fs_start_nid, NAT_BLK_CNT, and
f2fs_nat_bitmap_size) with sbi. Update call sites across node management,
checkpointing, GC, and sysfs.

This is a layout-only change without behavioral differences for 4KB
blocks.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    |  4 +--
 fs/f2fs/debug.c         |  2 +-
 fs/f2fs/f2fs.h          |  2 ++
 fs/f2fs/gc.c            |  4 +--
 fs/f2fs/node.c          | 77 +++++++++++++++++++++--------------------
 fs/f2fs/node.h          | 22 ++++++++----
 fs/f2fs/segment.c       |  4 +--
 fs/f2fs/shrinker.c      |  2 +-
 fs/f2fs/super.c         |  4 ++-
 include/linux/f2fs_fs.h |  5 ++-
 10 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 47c4a5c83a70..3ecced9b4d57 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -476,11 +476,11 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		switch (type) {
 		case META_NAT:
 			if (unlikely(blkno >=
-					NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid)))
+					NAT_BLOCK_OFFSET(sbi, NM_I(sbi)->max_nid)))
 				blkno = 0;
 			/* get nat block addr */
 			fio.new_blkaddr = current_nat_addr(sbi,
-					blkno * NAT_ENTRY_PER_BLOCK);
+					blkno * NAT_ENTRY_PER_BLOCK(sbi));
 			break;
 		case META_SIT:
 			if (unlikely(blkno >= TOTAL_SEGS(sbi)))
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ff379aff4472..5980b9d79afb 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -345,7 +345,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
 	si->base_mem += F2FS_BLK_TO_BYTES(NM_I(sbi)->nat_bits_blocks);
 	si->base_mem += NM_I(sbi)->nat_blocks *
-				f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK);
+				f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK(sbi));
 	si->base_mem += NM_I(sbi)->nat_blocks / 8;
 	si->base_mem += NM_I(sbi)->nat_blocks * sizeof(unsigned short);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 035863d513ab..8e6000e7d766 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1863,6 +1863,7 @@ struct f2fs_sb_info {
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
 	unsigned int log_blocksize;		/* log2 block size */
 	unsigned int blocksize;			/* block size */
+	unsigned int nat_entries_per_block;	/* NAT entries in a block */
 	unsigned int sit_entries_per_block;	/* SIT entries in a block */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
@@ -2253,6 +2254,7 @@ static inline struct f2fs_sb_info *F2FS_F_SB(const struct folio *folio)
 }
 
 #define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
+#define NAT_ENTRY_PER_BLOCK(sbi)	((sbi)->nat_entries_per_block)
 
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a00180c21dc..c15c6ba91597 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1066,7 +1066,7 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 			continue;
 
 		if (phase == 0) {
-			f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
+			f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(sbi, nid), 1,
 							META_NAT, true);
 			continue;
 		}
@@ -1614,7 +1614,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			continue;
 
 		if (phase == 0) {
-			f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
+			f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(sbi, nid), 1,
 							META_NAT, true);
 			continue;
 		}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 86c2e67e43b6..960c6657d0d6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -169,7 +169,7 @@ static struct folio *get_next_nat_folio(struct f2fs_sb_info *sbi, nid_t nid)
 	folio_mark_dirty(dst_folio);
 	f2fs_folio_put(src_folio, true);
 
-	set_to_next_nat(nm_i, nid);
+	set_to_next_nat(sbi, nm_i, nid);
 
 	return dst_folio;
 }
@@ -254,10 +254,11 @@ static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *e)
 	__free_nat_entry(e);
 }
 
-static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
+static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_sb_info *sbi,
+							struct f2fs_nm_info *nm_i,
 							struct nat_entry *ne)
 {
-	nid_t set = NAT_BLOCK_OFFSET(ne->ni.nid);
+	nid_t set = NAT_BLOCK_OFFSET(sbi, ne->ni.nid);
 	struct nat_entry_set *head;
 
 	head = radix_tree_lookup(&nm_i->nat_set_root, set);
@@ -274,14 +275,15 @@ static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
 	return head;
 }
 
-static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
+static void __set_nat_cache_dirty(struct f2fs_sb_info *sbi,
+		struct f2fs_nm_info *nm_i,
 		struct nat_entry *ne, bool init_dirty)
 {
 	struct nat_entry_set *head;
 	bool new_ne = nat_get_blkaddr(ne) == NEW_ADDR;
 
 	if (!new_ne)
-		head = __grab_nat_entry_set(nm_i, ne);
+		head = __grab_nat_entry_set(sbi, nm_i, ne);
 
 	/*
 	 * update entry_cnt in below condition:
@@ -527,7 +529,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	nat_set_blkaddr(e, new_blkaddr);
 	if (!__is_valid_data_blkaddr(new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
-	__set_nat_cache_dirty(nm_i, e, init_dirty);
+	__set_nat_cache_dirty(sbi, nm_i, e, init_dirty);
 
 	/* update fsync_mark if its inode nat entry is still alive */
 	if (ni->nid != ni->ino)
@@ -578,7 +580,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
-	nid_t start_nid = START_NID(nid);
+	nid_t start_nid = f2fs_start_nid(sbi, nid);
 	struct f2fs_nat_block *nat_blk;
 	struct folio *folio = NULL;
 	struct f2fs_nat_entry ne;
@@ -2403,8 +2405,8 @@ static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
 							bool set, bool build)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
-	unsigned int nid_ofs = nid - START_NID(nid);
+	unsigned int nat_ofs = NAT_BLOCK_OFFSET(sbi, nid);
+	unsigned int nid_ofs = nid - f2fs_start_nid(sbi, nid);
 
 	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
 		return;
@@ -2524,14 +2526,14 @@ static int scan_nat_page(struct f2fs_sb_info *sbi,
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	block_t blk_addr;
-	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
+	unsigned int nat_ofs = NAT_BLOCK_OFFSET(sbi, start_nid);
 	int i;
 
 	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
 
-	i = start_nid % NAT_ENTRY_PER_BLOCK;
+	i = start_nid % NAT_ENTRY_PER_BLOCK(sbi);
 
-	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
+	for (; i < NAT_ENTRY_PER_BLOCK(sbi); i++, start_nid++) {
 		if (unlikely(start_nid >= nm_i->max_nid))
 			break;
 
@@ -2587,16 +2589,16 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 			continue;
 		if (!nm_i->free_nid_count[i])
 			continue;
-		for (idx = 0; idx < NAT_ENTRY_PER_BLOCK; idx++) {
+		for (idx = 0; idx < NAT_ENTRY_PER_BLOCK(sbi); idx++) {
 			idx = find_next_bit_le(nm_i->free_nid_bitmap[i],
-						NAT_ENTRY_PER_BLOCK, idx);
-			if (idx >= NAT_ENTRY_PER_BLOCK)
+						NAT_ENTRY_PER_BLOCK(sbi), idx);
+			if (idx >= NAT_ENTRY_PER_BLOCK(sbi))
 				break;
 
-			nid = i * NAT_ENTRY_PER_BLOCK + idx;
+			nid = i * NAT_ENTRY_PER_BLOCK(sbi) + idx;
 			add_free_nid(sbi, nid, true, false);
 
-			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
+			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS(sbi))
 				goto out;
 		}
 	}
@@ -2617,11 +2619,11 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 	if (unlikely(nid >= nm_i->max_nid))
 		nid = 0;
 
-	if (unlikely(nid % NAT_ENTRY_PER_BLOCK))
-		nid = NAT_BLOCK_OFFSET(nid) * NAT_ENTRY_PER_BLOCK;
+	if (unlikely(nid % NAT_ENTRY_PER_BLOCK(sbi)))
+		nid = NAT_BLOCK_OFFSET(sbi, nid) * NAT_ENTRY_PER_BLOCK(sbi);
 
 	/* Enough entries */
-	if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
+	if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK(sbi))
 		return 0;
 
 	if (!sync && !f2fs_available_free_memory(sbi, FREE_NIDS))
@@ -2631,18 +2633,18 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 		/* try to find free nids in free_nid_bitmap */
 		scan_free_nid_bits(sbi);
 
-		if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
+		if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK(sbi))
 			return 0;
 	}
 
 	/* readahead nat pages to be scanned */
-	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
+	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(sbi, nid), FREE_NID_PAGES,
 							META_NAT, true);
 
 	f2fs_down_read_trace(&nm_i->nat_tree_lock, &lc);
 
 	while (1) {
-		if (!test_bit_le(NAT_BLOCK_OFFSET(nid),
+		if (!test_bit_le(NAT_BLOCK_OFFSET(sbi, nid),
 						nm_i->nat_block_bitmap)) {
 			struct folio *folio = get_current_nat_folio(sbi, nid);
 
@@ -2668,7 +2670,8 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 			}
 		}
 
-		nid += (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
+		nid += NAT_ENTRY_PER_BLOCK(sbi) -
+			(nid % NAT_ENTRY_PER_BLOCK(sbi));
 		if (unlikely(nid >= nm_i->max_nid))
 			nid = 0;
 
@@ -2684,7 +2687,7 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 
 	f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 
-	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
+	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(sbi, nm_i->next_scan_nid),
 					nm_i->ra_nid_pages, META_NAT, false);
 
 	return 0;
@@ -2811,20 +2814,20 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	int nr = nr_shrink;
 
-	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
+	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS(sbi))
 		return 0;
 
 	if (!mutex_trylock(&nm_i->build_lock))
 		return 0;
 
-	while (nr_shrink && nm_i->nid_cnt[FREE_NID] > MAX_FREE_NIDS) {
+	while (nr_shrink && nm_i->nid_cnt[FREE_NID] > MAX_FREE_NIDS(sbi)) {
 		struct free_nid *i, *next;
 		unsigned int batch = SHRINK_NID_BATCH_SIZE;
 
 		spin_lock(&nm_i->nid_list_lock);
 		list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
 			if (!nr_shrink || !batch ||
-				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
+				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS(sbi))
 				break;
 			__remove_free_nid(sbi, i, FREE_NID);
 			kmem_cache_free(free_nid_slab, i);
@@ -3074,7 +3077,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 			spin_unlock(&nm_i->nid_list_lock);
 		}
 
-		__set_nat_cache_dirty(nm_i, ne, init_dirty);
+		__set_nat_cache_dirty(sbi, nm_i, ne, init_dirty);
 	}
 	update_nats_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
@@ -3102,7 +3105,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		const struct f2fs_nat_block *nat_blk)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	unsigned int nat_index = start_nid / NAT_ENTRY_PER_BLOCK;
+	unsigned int nat_index = start_nid / NAT_ENTRY_PER_BLOCK(sbi);
 	int valid = 0;
 	int i = 0;
 
@@ -3113,7 +3116,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		valid = 1;
 		i = 1;
 	}
-	for (; i < NAT_ENTRY_PER_BLOCK; i++) {
+	for (; i < NAT_ENTRY_PER_BLOCK(sbi); i++) {
 		if (le32_to_cpu(nat_blk->entries[i].block_addr) != NULL_ADDR)
 			valid++;
 	}
@@ -3124,7 +3127,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 	}
 
 	__clear_bit_le(nat_index, nm_i->empty_nat_bits);
-	if (valid == NAT_ENTRY_PER_BLOCK)
+	if (valid == NAT_ENTRY_PER_BLOCK(sbi))
 		__set_bit_le(nat_index, nm_i->full_nat_bits);
 	else
 		__clear_bit_le(nat_index, nm_i->full_nat_bits);
@@ -3135,7 +3138,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
-	nid_t start_nid = set->set * NAT_ENTRY_PER_BLOCK;
+	nid_t start_nid = set->set * NAT_ENTRY_PER_BLOCK(sbi);
 	bool to_journal = true;
 	struct f2fs_nat_block *nat_blk;
 	struct nat_entry *ne, *cur;
@@ -3342,8 +3345,8 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 
 		__set_bit_le(i, nm_i->nat_block_bitmap);
 
-		nid = i * NAT_ENTRY_PER_BLOCK;
-		last_nid = nid + NAT_ENTRY_PER_BLOCK;
+		nid = i * NAT_ENTRY_PER_BLOCK(sbi);
+		last_nid = nid + NAT_ENTRY_PER_BLOCK(sbi);
 
 		spin_lock(&NM_I(sbi)->nid_list_lock);
 		for (; nid < last_nid; nid++)
@@ -3373,7 +3376,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	/* segment_count_nat includes pair segment so divide to 2. */
 	nat_segs = le32_to_cpu(sb_raw->segment_count_nat) >> 1;
 	nm_i->nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
-	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nm_i->nat_blocks;
+	nm_i->max_nid = NAT_ENTRY_PER_BLOCK(sbi) * nm_i->nat_blocks;
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
@@ -3436,7 +3439,7 @@ static int init_free_nid_cache(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
 		nm_i->free_nid_bitmap[i] = f2fs_kvzalloc(sbi,
-			f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK), GFP_KERNEL);
+			f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK(sbi)), GFP_KERNEL);
 		if (!nm_i->free_nid_bitmap[i])
 			return -ENOMEM;
 	}
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 5e114f352099..0dce97aac5fc 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -6,14 +6,23 @@
  *             http://www.samsung.com/
  */
 /* start node id of a node block dedicated to the given node id */
-#define	START_NID(nid) (((nid) / NAT_ENTRY_PER_BLOCK) * NAT_ENTRY_PER_BLOCK)
+static inline nid_t f2fs_start_nid(struct f2fs_sb_info *sbi, nid_t nid)
+{
+	unsigned int entries = NAT_ENTRY_PER_BLOCK(sbi);
+
+	return (nid / entries) * entries;
+}
+
+#define	START_NID(sbi, nid) f2fs_start_nid(sbi, nid)
 
 /* node block offset on the NAT area dedicated to the given start node id */
-#define	NAT_BLOCK_OFFSET(start_nid) ((start_nid) / NAT_ENTRY_PER_BLOCK)
+#define	NAT_BLOCK_OFFSET(sbi, start_nid) \
+	((start_nid) / NAT_ENTRY_PER_BLOCK(sbi))
 
 /* # of pages to perform synchronous readahead before building free nids */
 #define FREE_NID_PAGES	8
-#define MAX_FREE_NIDS	(NAT_ENTRY_PER_BLOCK * FREE_NID_PAGES)
+#define MAX_FREE_NIDS(sbi)	((unsigned long)NAT_ENTRY_PER_BLOCK(sbi) * \
+				 FREE_NID_PAGES)
 
 /* size of free nid batch when shrinking */
 #define SHRINK_NID_BATCH_SIZE	8
@@ -208,7 +217,7 @@ static inline pgoff_t current_nat_addr(struct f2fs_sb_info *sbi, nid_t start)
 	 * OLD = (segment_off * 512) * 2 + off_in_segment
 	 * NEW = 2 * (segment_off * 512 + off_in_segment) - off_in_segment
 	 */
-	block_off = NAT_BLOCK_OFFSET(start);
+	block_off = NAT_BLOCK_OFFSET(sbi, start);
 
 	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
 		(block_off << 1) -
@@ -230,9 +239,10 @@ static inline pgoff_t next_nat_addr(struct f2fs_sb_info *sbi,
 	return block_addr + nm_i->nat_blkaddr;
 }
 
-static inline void set_to_next_nat(struct f2fs_nm_info *nm_i, nid_t start_nid)
+static inline void set_to_next_nat(struct f2fs_sb_info *sbi,
+				   struct f2fs_nm_info *nm_i, nid_t start_nid)
 {
-	unsigned int block_off = NAT_BLOCK_OFFSET(start_nid);
+	unsigned int block_off = NAT_BLOCK_OFFSET(sbi, start_nid);
 
 	f2fs_change_bit(block_off, nm_i->nat_bitmap);
 #ifdef CONFIG_F2FS_CHECK_FS
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b3bf1b62cdad..b29df65ab5b7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -512,10 +512,10 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 
 	/* check the # of cached NAT entries */
 	if (!f2fs_available_free_memory(sbi, NAT_ENTRIES))
-		f2fs_try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK);
+		f2fs_try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK(sbi));
 
 	if (!f2fs_available_free_memory(sbi, FREE_NIDS))
-		f2fs_try_to_free_nids(sbi, MAX_FREE_NIDS);
+		f2fs_try_to_free_nids(sbi, MAX_FREE_NIDS(sbi));
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 4f6bf5926de4..e3e0a7e89406 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -23,7 +23,7 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 
 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
-	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS;
+	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS(sbi);
 
 	return count > 0 ? count : 0;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4bd1c9fb1f7f..fdc2b0c51c06 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4382,6 +4382,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		le32_to_cpu(raw_super->log_sectors_per_block);
 	sbi->log_blocksize = le32_to_cpu(raw_super->log_blocksize);
 	sbi->blocksize = BIT(sbi->log_blocksize);
+	sbi->nat_entries_per_block = sbi->blocksize /
+		sizeof(struct f2fs_nat_entry);
 	sbi->sit_entries_per_block = sbi->blocksize /
 		sizeof(struct f2fs_sit_entry);
 	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
@@ -4391,7 +4393,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->total_sections = le32_to_cpu(raw_super->section_count);
 	sbi->total_node_count = SEGS_TO_BLKS(sbi,
 			((le32_to_cpu(raw_super->segment_count_nat) / 2) *
-			NAT_ENTRY_PER_BLOCK));
+			NAT_ENTRY_PER_BLOCK(sbi)));
 	sbi->allocate_section_hint = le32_to_cpu(raw_super->section_count);
 	sbi->allocate_section_policy = ALLOCATE_FORWARD_NOHINT;
 	F2FS_ROOT_INO(sbi) = le32_to_cpu(raw_super->root_ino);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index ecd6694af572..061f906a7b94 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -375,8 +375,6 @@ struct f2fs_node {
 /*
  * For NAT entries
  */
-#define NAT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / sizeof(struct f2fs_nat_entry))
-
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
 	__le32 ino;		/* inode number */
@@ -384,7 +382,8 @@ struct f2fs_nat_entry {
 } __packed;
 
 struct f2fs_nat_block {
-	struct f2fs_nat_entry entries[NAT_ENTRY_PER_BLOCK];
+	/* The entry count depends on the filesystem block size. */
+	DECLARE_FLEX_ARRAY(struct f2fs_nat_entry, entries);
 } __packed;
 
 /*
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
