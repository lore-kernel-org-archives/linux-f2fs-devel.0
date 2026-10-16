Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476E9CC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EdO4muXAIWyYKSLAK5C5bJ+78ai2a42WmrZIsZLm4Qg=; b=TwOCQFwZgudQczw8Egc3urTgWm
	NMS1sl9jFazL/SjXw61wo6ys9qFFjq4qWhRTBhusb6VQaVcabGtnEE9VVmINkJFtytidcucivhZkb
	xHxEtbdtD4qbbvwZlQnN+P25yood0y0qp3JmGNNPfjoJOoC3yQoaT41zHE7NtzlOowOY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHak4-0004tH-DS;
	Fri, 16 Oct 2026 05:44:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xHak2-0004tA-EW
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kg0/Y5OQ+zT/2BaSWkG21iLF11f9YrlrZ+pWUx9askg=; b=mhCeQDenMTS2i3K6HH8lh+8OYP
 0BQcf2WEJkwMVI54NodOfSVG58hz2sPhOzbAgxePrfxj3sM0H9a7Y7ld8Djk/CmpWrTepQ5Hehd4J
 RUj0G/yeCZj+4XBOoT7O4ZA1CqG7EfRB6zFXXdcGHrq7RO+pE2NtQppKyTZcIH9CmFSs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Kg0/Y5OQ+zT/2BaSWkG21iLF11f9YrlrZ+pWUx9askg=; b=Hr8l8oR0lR1CvpkBcrAa+6e8b0
 vhOpKg2DO/7AshJTD5E5oNJMtjXNbLa2BePL6a8ErmhR2WMYY+fXu+rl31jFKV35A8/5abM9WCTZk
 QT8dugdz9Xi/xTCfRWjcuUXhDiLedcGDH8mEHdc7K5dTKXXV8dsIhMfNDZIytS3jCpg4=;
Received: from mail-dl1-f54.google.com ([74.125.82.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHajy-0003VY-Er for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:44:27 +0000
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-15168a20b47so4084166c88.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 22:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792129461; x=1792734261; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kg0/Y5OQ+zT/2BaSWkG21iLF11f9YrlrZ+pWUx9askg=;
 b=PXNtWxy9CXUJV35Hy5PGrfYAfSbcHRIHrC8xTmCib90waB+hopLNztwz4Wr4UpvV28
 7EL10Hz2hTEFmZ+v5DZmxRJAbo00RoAtaxEcE+h9LjmuB/XzL16uS5Bt/1gs9aX7yduA
 F2Q7p90xAHnGVBfLXLRpDsYvbEqsptBzPIw+8cLdM7awJv2dDcvs+BMbMMHJlvIolkM7
 /pM8b5xmn+VYH4Y10xioki2dAPWqT/swpie3hG4GUATCaeL+KubBjiMWjpyTJAvBKqZg
 5iWHccqgiBExslUlXCcqQrqi2OBZ6UVHmKAz4a8nn14IUZvfYEnTWMR5bU/W7/86lzhQ
 nblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792129461; x=1792734261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kg0/Y5OQ+zT/2BaSWkG21iLF11f9YrlrZ+pWUx9askg=;
 b=YosInAhQDV0a2uTUKNhifSHOZMTMeuAfgn/pCzyiO8IxOd/yeTy97SDT4ZrdFWp1hJ
 g/W6Z0ZGIadXEbn9OaNFwdStTMLXmx8OU+neR+tI3sEVUdaCf4X9RJWLV2iol/WhgfwU
 0W1oPzSQsyf8TuEwpf8h6dIJO0SeperHdfU+xR2TDe81q/rIhDFrw9FhTt5SQjaWqjT/
 nGV9XreQiSJJ3NbR9vk6wFqTdlVsu23V4mxyzFdqJUzkOXmuYtWLz1KSJIIR524ntku8
 /Z2ukHPqn5biTKPo9zWBwVtIAC02Nv+ucEiPMiMVLYdF7xqrcmcMeHvkGblVuaitr0Zg
 P5nw==
X-Forwarded-Encrypted: i=1;
 AKwUvByzOa3qNPTenC6wEU3Mp+iBIRlguSt6nEAlWwzAaDyEKek5KgXoIfu7mb/K1EJqomy5z0xfOjp2oQ40UqkVBxFj@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLSpFE4cRCv2AgspwLt7aTJ9LdDxb9EealVHCsARcdJqwwtna9O
 XiA+ov7NRd5XzikZjXf1oPkMZoAmUJE50PAvhxuMi3aKN5bvJ29sm346
X-Gm-Gg: AYBFou1UeRa0NHJxeKGwtZDn5pfZkfgJGvlLpa/ZjjBIuUv4SMZh/4nGAgDqU8pFOsz
 JxFih9b73OkNOootgsbZ5/W4gsa2z9XYilFpDN3bWOMaYSsREN76ROvCtOp7Lg5fra8yxHEOJki
 WVIyn5XM5U2LU3xoZRIfUeirTr/HyyoQfBM66a+thrKACLckgYVnvygeFdo3hKBhDKUUrXK4PLD
 8AEvSWq8MipI0LzittvurnoE9LSPFmfQ3qP372AF8CUW5Y7UtYCvweQ1Y2RpnFoIWJMvhz+Rs+n
 ClENnwSqrVXGVKfnBtF/mHZk7Oxx6Dz1BqHKeYqmFur/VbmN8Cn/fNUfMSZvA5VYY7fa1IVsvSE
 KxxKeipVGTtc3yKWvJWVi0tdyn5NFOrEa8sLmgyUAdjEW5J7YzhS3Vflr6DULVl/kO+pH8suM6B
 lFt0VCRv0z20Drx19lpcD8qSPGqjqXLJKvsC7BDx3a58cDf3Q2qUdm3BiWKExRB3oPg7+fRDdMA
 RRcuHsVN/YtRTSRSZC2LqkofccUIahkz9g=
X-Received: by 2002:a05:7022:1713:b0:14d:3c0c:79ec with SMTP id
 a92af1059eb24-16a5dbfddf2mr22186487c88.9.1792129460570; 
 Thu, 15 Oct 2026 22:44:20 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831919fdfesm2642428c88.7.2026.10.15.22.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 22:44:20 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 16 Oct 2026 13:44:06 +0800
Message-ID: <226abf7d629d7345f450753a42e924b436c99ec0.1792116883.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792116883.git.qiwenjie@xiaomi.com>
References: <cover.1792116883.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xHajy-0003VY-Er
Subject: [f2fs-dev] [PATCH v4 2/2] f2fs: refresh pinned allocation boundary
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 sunqiuyang@huawei.com
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

Also bound pinned section allocation by the current MAIN_SECS(). Range
evacuation temporarily reduces it before moving cursegs, while the
cached pinned boundary still describes the old geometry. Otherwise, a
pinned curseg can be reallocated into the range being removed.

Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
Suggested-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes in v4 (since v3):
- Bound pinned section allocation by the current MAIN_SECS().

Changes in v3 (since v2):
- Consume the tail reservation instead of keeping its old size.
- Restore the saved tail before geometry and boundary rollback.
- Document the remaining-reservation semantics.

Changes in v2 (since v1):
- Simplify tail validation and improve rejection diagnostics.
- Validate before taking the mount write reference and recheck
  after freeze for concurrent remounts.

v1:
- Refresh the pinned boundary on geometry changes and rollback.
- Check the tail against the requested shrink geometry.

 Documentation/filesystems/f2fs.rst |  3 ++-
 fs/f2fs/gc.c                       |  6 +++++-
 fs/f2fs/segment.c                  |  2 +-
 fs/f2fs/segment.h                  | 11 +++++++++++
 fs/f2fs/super.c                    | 15 ++-------------
 5 files changed, 21 insertions(+), 16 deletions(-)

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
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bf8d07fcce331..f6e1cb1c0b71d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2983,7 +2983,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		alloc_hint = MAIN_SECS(sbi);
 
 	if (pinning) {
-		max_secno = sbi->pinned_area_max_secno;
+		max_secno = min(sbi->pinned_area_max_secno, MAIN_SECS(sbi));
 		hint = 0;
 	} else if (alloc_policy == ALLOCATE_FORWARD_FROM_HINT &&
 		hint < alloc_hint) {
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
