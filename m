Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F47CC6B2F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rAUNDEOYhmzikkGypY+0dpnv6l7L/8yTxqfV6T1Tk6I=; b=epiNjacsGP8eejJrJ+NALvOPqO
	UAjBwT8RHNFAgCpDL/IScpcL6//tLGYhQyvC3UID8R1BrV4HgVHCrNhTiUD+Ec9Os8NdO84270IaS
	O5xbCmQCbBvEOg6FHzwGbt4xtBafomAyEO90Guy4oKPLzQ16JFRvEu8LpL/Vr6P89Xro=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHGwO-0000j2-S4;
	Thu, 15 Oct 2026 08:35:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xHGwA-0000iR-78
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BGWNvW31UDgJBtWGlH9/IY5pNbnK5DE95i3+WnOMIF0=; b=QZzGcF8Ttvyqmko5ZCkOFhdg+W
 B8mBynmMzpCUukQt8nSyLqQeHJpEUNVpYOP6mv2p4wLLko12qi3Iz1sOHVHL6KUjK2+C3skccDVIr
 EO4g0EwylORFa8hvHhimgsXMASHpu4RipBkjDqkuEFKW/u1yh7gzcPpSawH+/9MoF5SM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BGWNvW31UDgJBtWGlH9/IY5pNbnK5DE95i3+WnOMIF0=; b=aLexO2aRf5oHB5RICrInxh7R3z
 SgRvgqglI3OkkCqjBmUpn8tPEM4NkS9n/Yonm1/9t5R4QXpOIJhzkGdPqd+vi7yTQVMb0/vSLfOzD
 i/wJQFgjkGz4Am3Navc+/wdNzuORWeqCf+lUR92adRCdVikfF2uaxQdfAbWRtrmORtGw=;
Received: from mail-dy1-f175.google.com ([74.125.82.175])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHGw6-0002JX-3V for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:35:39 +0000
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-35c76e9614aso3238803eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792053332; x=1792658132; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BGWNvW31UDgJBtWGlH9/IY5pNbnK5DE95i3+WnOMIF0=;
 b=OJftMl0euBuS1YnOt8hfLFu7L6VS8JoaLzvNMBQegz3ri6nZiOG4gGjuhfCBXkIJud
 RNDpNvn9yyVMOY4AZtv5e5P00Yh1ABysKwhXT2Sv2x/7XAAzjMIqdOjHMq+Hln7tvbRT
 PDknSyy9/q6UwgYgTQggcbKRJjljzV/hSQ8b7zfh9e/A60jGopIBnhHis+qfFynEmfzs
 I0TqPmVVqTfHuuATYSw0k1zX2l8Q+hN+HtMBUZoL9FiUMlgV3pB03P1XDXe3Udv4PgZj
 tn3NNEe1ptJSyuMJocfoWwIHKEjL7L5AabawyRWRPQgD1aMWAnNvxVazRQyqhBH6d7b6
 seYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053332; x=1792658132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BGWNvW31UDgJBtWGlH9/IY5pNbnK5DE95i3+WnOMIF0=;
 b=domPLRKL/jnbn+ZQ2PMHUfLxGet0SWtYl8a212AZqs3Wyu+jrkD0bG1dm17uJYqwmc
 Hw1W66Q1aNWVKySjyM7j2tC/FTCV692gz68yy9sVm01nCecRdE6gsCiwdFPtihNBGhPr
 6WHJ5T/zlCcGAvBE4A/d6BOAvOhPJNbO0xLyCK9F7GQIXMhKTllb8DeAyopans4Bq+bk
 2Q510E3xXActdg4C27/D0q+k3ulChIyDnqlG9zSYAu94RbeIdi4t+mFBOGjZAc7jvpmN
 FDuHUCIRj13sCTxNySFPgsuHxhems6b/py+vnG5NV7XQDVZ3KRzm4oPQxGEwDnsNRDpH
 iagw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7h9vvdrAtYLvErCH77c/4xZiETz5WYFuhA5yUsXXuNdiLeDzm/7ifQLE+2k+rOZ/QiOd+Z3qCCAdNg5q43iM9@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIxfVKPRkF+dNdBol6uXywPUr8Tj6FWIeE4+dZPQuoiRAck3quy
 Ghijj9znffwEWNeQfAVjIZDgLy6VzxvGV6esM10l/qJi+o5n64k+LZKV
X-Gm-Gg: AYBFou3VaNvwE87VaKwYrJiF0N2L9VPELoKwGkkfmXqI4aqfRAKxFY2V0RB4LsB4XLO
 Y966ZcGdoBHRNG/GlVZHWh7zgdtoCreHS/VdP/r5S1yyn/tAUyufk1dPzOmX3nyMbQ6HaRyOnPO
 4OXDI4TsELL/TxDAOcBvb5budEeZu+MPNNbFJhiO5X/+cXDlz330wqjb/qLPhhkHS45i/ABQPJ5
 EgGpHY+dj3ueA2GBPmfCn7uB/u9ayLAiaESkKJ4EL/FdYvY69L08yCx5qDKza/WdicRqmfOUsMY
 7VU5lwRPRjSJfeGglOumz6Fn+wx/R/uKkcFuvigVOVcgIRfCNZQ0djLhmpGTJpL1NNZGLsHyV8f
 hgyYLxHUJWO3adoFL9P5PdaNxUJAKwp7Vy6CXMGGWRV80Ju8rR4U5PCQARDp3Q4LKluhEKKpRBJ
 rFKhIuDvqIU0LNet2A6rdQl3Ha5Sw0KmacRi94Zdi4WRv7VyCBazNHuULIavZj+UpqNWgqKE1WH
 cloivfPmNGJ3G8jobXDioogU+yyCBNkCZbMARwKKJ28Hw==
X-Received: by 2002:a05:7301:e0cb:b0:351:1e3f:812d with SMTP id
 5a478bee46e88-3537e0caeb8mr23093066eec.36.1792053332422; 
 Thu, 15 Oct 2026 01:35:32 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d20dsm64539101eec.12.2026.10.15.01.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:35:31 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 16:35:10 +0800
Message-ID: <eaed01c69f5af16df36a6df9be3f6615e4818d29.1792050467.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792050467.git.qiwenjie@xiaomi.com>
References: <cover.1792050467.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xHGw6-0002JX-3V
Subject: [f2fs-dev] [PATCH v3 2/2] f2fs: refresh pinned allocation boundary
 after resize
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
Cc: Daeho Jeong <daehojeong@google.com>, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, Qiuyang Sun <sunqiuyang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Online shrink updates MAIN_SECS() but leaves resizable_tail_secno and
pinned_area_max_secno unchanged. The pinned allocation limit can exceed
the new main area when shrinking beyond the reserved tail.

Consume the reserved tail by the number of removed sections, clamping
it to zero, before refreshing the shared pinned allocation boundary.
This preserves the boundary while shrinking within the reservation and
limits it to the new main area otherwise, retaining the zoned limit.

Save the old tail count and restore it before rolling back the geometry
if the final checkpoint fails.

Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
Suggested-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v2:
- Consume the tail reservation instead of keeping its old size.
- Restore the saved tail before geometry and boundary rollback.
- Document the remaining-reservation semantics.

 Documentation/filesystems/f2fs.rst |  3 ++-
 fs/f2fs/gc.c                       |  6 +++++-
 fs/f2fs/segment.h                  | 11 +++++++++++
 fs/f2fs/super.c                    | 15 ++-------------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 771216f45207a..55798421f2c45 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -421,7 +421,8 @@ resizable_tail_secno=%u  Control the number of sections at the tail of the
 			 (MAIN_SECS - resizable_tail_secno) - 1. If set to 0
 			 (default), there is no tail restriction unless running
 			 on a zoned block device where conventional zones are
-			 used.
+			 used. Online shrink consumes this reservation, reducing
+			 the value by the number of removed sections, down to zero.
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 926e6976bc22a..540769ad58acc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2342,6 +2342,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
 	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
 	MAIN_SECS(sbi) += secs;
+	f2fs_adjust_pinned_area_boundary(sbi);
 	if (sbi->allocate_section_hint > MAIN_SECS(sbi))
 		sbi->allocate_section_hint = MAIN_SECS(sbi);
 	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
@@ -2373,7 +2374,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	struct f2fs_lock_context lc;
 	struct f2fs_lock_context glc;
 	struct f2fs_lock_context clc;
-	unsigned int secs;
+	unsigned int secs, old_tail;
 	int err = 0;
 	__u32 rem;
 
@@ -2482,6 +2483,8 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 		goto recover_out;
 	}
 
+	old_tail = F2FS_OPTION(sbi).resizable_tail_secno;
+	F2FS_OPTION(sbi).resizable_tail_secno -= min(old_tail, secs);
 	update_fs_metadata(sbi, -secs);
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
@@ -2489,6 +2492,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err) {
+		F2FS_OPTION(sbi).resizable_tail_secno = old_tail;
 		update_fs_metadata(sbi, secs);
 		update_sb_metadata(sbi, secs);
 		f2fs_commit_super(sbi, false);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 526764ba31ae5..918bc4452ad09 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -91,6 +91,17 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define GET_ZONE_FROM_SEG(sbi, segno)				\
 	GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
 
+static inline void f2fs_adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
+{
+	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
+	if (f2fs_sb_has_blkzoned(sbi) && sbi->first_seq_zone_segno != NULL_SEGNO)
+		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
+				GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno));
+	if (F2FS_OPTION(sbi).resizable_tail_secno)
+		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
+				MAIN_SECS(sbi) - F2FS_OPTION(sbi).resizable_tail_secno);
+}
+
 #define GET_SUM_BLOCK(sbi, segno)	\
 	(SM_I(sbi)->ssa_blkaddr + (segno / (sbi)->sums_per_block))
 #define GET_SUM_BLKOFF(sbi, segno) (segno % (sbi)->sums_per_block)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 773b12ea29c0c..f323d9705aebe 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -554,17 +554,6 @@ static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
 			F2FS_OPTION(sbi).unusable_cap_perc);
 }
 
-static inline void adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
-{
-	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
-	if (f2fs_sb_has_blkzoned(sbi) && sbi->first_seq_zone_segno != NULL_SEGNO)
-		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
-				GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno));
-	if (F2FS_OPTION(sbi).resizable_tail_secno)
-		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
-				MAIN_SECS(sbi) - F2FS_OPTION(sbi).resizable_tail_secno);
-}
-
 static void init_once(void *foo)
 {
 	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
@@ -3103,7 +3092,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	adjust_pinned_area_boundary(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 	limit_reserve_root(sbi);
 	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
@@ -5440,7 +5429,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* get segno of first zoned block device */
 	sbi->first_seq_zone_segno = get_first_seq_zone_segno(sbi);
 
-	adjust_pinned_area_boundary(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 
 	sbi->reserved_pin_section = f2fs_sb_has_blkzoned(sbi) ?
 			ZONED_PIN_SEC_REQUIRED_COUNT :
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
