Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4ABC531D0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VGZmf3d5mLmKWhudHQx3a2x586g7zMC+/UGbdw2RZGg=; b=cm7NidiGVpcLb46WiwIeWC7776
	ED382su7e+GWVt7+a+byq3C0JK/r/ncNksykiLGIGA9YT3+X5EQwgOI/HaPiCDJTbRPM4Fb4S9N0C
	l9yt1MjiLvxYKL+z8/rF3LTD/KFXcK7qQUcgFRE0JJru6MlwJyEPc/E9cNflCvKmdTKM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmzD1-0007CH-UE;
	Thu, 23 Jul 2026 19:35:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wmzD0-0007C8-Ej
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 19:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mmxp41kA5FHa5x1u6tdJJJL0q36Az2Yj3WnRD1lYAZg=; b=m8sxls4MgFvqjhOOwzwOeXQJQU
 bqs3Xz8SCOG6SRKPIgezZTKIxrBGTFJbjpCRhcgMveeCGLPneDENZ4SEG75HuwCbOSVYSdLOw7BoI
 0nfpwmY33HuV/ho1AsegmJ57aRMUlzD5O8ty3BCXAQXLhvEy8hQRzmereR7bEioaqGdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mmxp41kA5FHa5x1u6tdJJJL0q36Az2Yj3WnRD1lYAZg=; b=F
 7saAiyid2XguwosaKx2nW+7hJTb2SopF+/xqQE0I3c46hPP8PtqJK825ccKZL9zhwI7hsekMLPm4c
 Xit/JB88Bi/JS4Y5oYNjo1pe4cCB/Gp3JeFqpihUi8lFU82PUf/d4Ta+ZUXOLhfnvx/0GvALtnZJ7
 dmY8FGl8r1v8Fhmc=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmzD4-0005wp-35 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 19:35:55 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso9515985ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784835349; x=1785440149; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mmxp41kA5FHa5x1u6tdJJJL0q36Az2Yj3WnRD1lYAZg=;
 b=sY6bCvVHAMBv3CVojsKA1ggqRQ14+JOiZU7FC+wFUI72l+hNVcJyP5mY7j4mqkJijP
 w9kbPzl9wg68iFFDhxrvOPu7kgAJVVMX8meTTU55cUSHREr0NMLRnIVwhA9GcdFcCsb0
 C1eEDUH8Rvy1/uPcjdaB24x5tLpETXmlVFr0hkjJ9EVLtols5zyDiB/mXSvi18VhrVuP
 XkbofWcSlg+d8mu+Y1KpDEgpR7EFZbu/U3CvUjuSksYZZMfIr3IIHbGNLV9bBARS89na
 cFiiMuzZkHU8pFM/ONHQjBaRFdhW9/bz9UI7rQixlB2mSMffLz+67yBCrhOtxunOEabU
 sBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784835349; x=1785440149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mmxp41kA5FHa5x1u6tdJJJL0q36Az2Yj3WnRD1lYAZg=;
 b=mx0eelkkN7Ug3/+csS17xXb7ytoHfCBzeOjj4DaoynMpRIgB367chKIfMlyZhkk2kf
 h74ZslQCMoiM3Dq5pNP6EzM2y/5GNcRBbLnwiATrslkqM5RBRxtm0PjOB1CaxgkvO/S8
 KN5FJgc/oQ5q9exigSG5KGYp0Q76qLop6wvm19QjbVDBRWX9LL9YM2r1wkY2USNGBTSR
 1t1xRtQyjCuy4bd9w02rsqjRw81UQWWHaLMRGG1gOAPzuYqazYH5o1CWntv0xLnEWc6t
 Ar1s64TVB/E3ZkEnbghsPdDf8DvKlpdLo8o2zrln7weNVqP1hLFss9Z2myq8QBP3i3f2
 Wozg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAfqEuxdX5t3Dd8L2hc+cHR/gevm5Yez5pkNhPG0+dl7cMbAX/R1qS0WE8jIDakvuKL7xcv8Y9VVe8V+k8Fe9r@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyzfksGX1QVfLilnw3JWc7rdrSbQcDiElkFD+gXFlwdqyE00tZq
 aWGPt2wePqfuvUo6V8AWtz3bGbDzvYSG+lJLvtJSs3j3GbzmIdEln14AH8cfVA==
X-Gm-Gg: AR+sD137qQbjtLIBVzgYkbhWjbpEGuRP/Y02BXkbs99hwDmBgAJb7OZFKmZ830A58iX
 phghXd7uZ3oV1ne8Mpv1suMCcoFb3xhq41slnspmaw77Vz+tsF4lC1XQFhwDsB4xANe2U2UqHit
 Ipw+eQaU9yRxc7wnMANbEAJ7eNHlLzEyj42GPJhGqaJJBb4x+1MZWg8reiYjYY2d3ZusL+ojEvv
 sSY7EPcSwCuWcbDXg4Wu0rYUubLt4mYQvn6PmW3aYzGWs5WEFbJPN7Lu3/Bzuvo39XG2HQbEyxN
 Ag22ft1s4XHx/BNesoRR/IxAPyesuj30ZTb+leUBMIL1OyZf+GMzxu3RwfHMl4NInan8pkPrJtc
 grUFA0HBPMzuFHGchWMHfjkroySLondmQ3H16jCti0Y+f+Lf3bAxfBKcnZ3ti+2aobDT0Ac++OR
 sP1IUS16NXAEIzLv9NowQm6aIYXwZTvZbSDwvvQuS+h0t0g/+68nxC6+qKyjNCSunjYO1JpLBdf
 cEsEicuilILuhbfJggZeHwSBEkDgg==
X-Received: by 2002:a17:90b:5103:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-38ec839714emr4436392a91.3.1784835348677; 
 Thu, 23 Jul 2026 12:35:48 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:8f80:8150:b723:2d96])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130cc5ebsm23940500c88.12.2026.07.23.12.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 12:35:47 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 23 Jul 2026 12:35:44 -0700
Message-ID: <20260723193544.2462174-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
MIME-Version: 1.0
X-Headers-End: 1wmzD4-0005wp-35
Subject: [f2fs-dev] [PATCH] fsck.f2fs: handle find_next_free_block failure
 gracefully
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

When find_next_free_block() fails to allocate a free block, callers like
move_one_curseg_info(), reserve_new_block(), and update_block() previously
crashed via ASSERT().

Replace these ASSERT() calls with proper error propagation to gracefully
abort FSCK execution instead of crashing.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c    | 22 +++++++++++++++-------
 fsck/fsck.h    |  8 ++++----
 fsck/main.c    |  4 +++-
 fsck/mount.c   | 28 ++++++++++++++++++----------
 fsck/segment.c |  8 ++++----
 5 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index db44f9d..b128617 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2972,13 +2972,15 @@ int check_curseg_offsets(struct f2fs_sb_info *sbi, bool check_wp)
 	return 0;
 }
 
-static void fix_curseg_info(struct f2fs_sb_info *sbi, bool check_wp)
+static int fix_curseg_info(struct f2fs_sb_info *sbi, bool check_wp)
 {
-	int i, need_update = 0;
+	int i, need_update = 0, ret;
 
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
 		if (check_curseg_offset(sbi, i, check_wp)) {
-			update_curseg_info(sbi, i);
+			ret = update_curseg_info(sbi, i);
+			if (ret)
+				return ret;
 			need_update = 1;
 		}
 	}
@@ -2987,6 +2989,7 @@ static void fix_curseg_info(struct f2fs_sb_info *sbi, bool check_wp)
 		write_curseg_info(sbi);
 		flush_curseg_sit_entries(sbi);
 	}
+	return 0;
 }
 
 int check_sit_types(struct f2fs_sb_info *sbi)
@@ -3595,23 +3598,28 @@ static void fix_wp_sit_alignment(struct f2fs_sb_info *UNUSED(sbi))
  * Check and fix consistency with write pointers at the beginning of
  * fsck so that following writes by fsck do not fail.
  */
-void fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *sbi)
+int fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	int ret = 0;
 
 	if (c.zoned_model != F2FS_ZONED_HM)
-		return;
+		return 0;
 
 	if (c.fix_on) {
 		flush_nat_journal_entries(sbi);
 		flush_sit_journal_entries(sbi);
 
-		if (check_curseg_offsets(sbi, true))
-			fix_curseg_info(sbi, true);
+		if (check_curseg_offsets(sbi, true)) {
+			ret = fix_curseg_info(sbi, true);
+			if (ret)
+				return ret;
+		}
 
 		fix_wp_sit_alignment(sbi);
 		fsck->chk.wp_fixed = 1;
 	}
+	return 0;
 }
 
 int fsck_chk_curseg_info(struct f2fs_sb_info *sbi)
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 05daa2d..ec37e08 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -190,7 +190,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 void fsck_chk_checkpoint(struct f2fs_sb_info *sbi);
 void fsck_update_sb_flags(struct f2fs_sb_info *sbi);
 int fsck_chk_meta(struct f2fs_sb_info *sbi);
-void fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *);
+int fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *sbi);
 int fsck_chk_curseg_info(struct f2fs_sb_info *);
 void pretty_print_filename(const u8 *raw_name, u32 len,
 			   char out[F2FS_PRINT_NAMELEN], int enc_name);
@@ -227,11 +227,11 @@ extern int f2fs_find_fsync_inode(struct f2fs_sb_info *, struct list_head *);
 extern void f2fs_destroy_fsync_dnodes(struct list_head *);
 
 extern void flush_journal_entries(struct f2fs_sb_info *);
-extern void update_curseg_info(struct f2fs_sb_info *, int);
+extern int update_curseg_info(struct f2fs_sb_info *sbi, int type);
 extern void zero_journal_entries(struct f2fs_sb_info *);
 extern void flush_sit_entries(struct f2fs_sb_info *);
-extern void move_curseg_info(struct f2fs_sb_info *, u64, int);
-extern void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
+extern int move_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left);
+extern int move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
 				 int i);
 extern void write_curseg_info(struct f2fs_sb_info *);
 extern void save_curseg_warm_node_info(struct f2fs_sb_info *);
diff --git a/fsck/main.c b/fsck/main.c
index 08d38d8..460e4db 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -985,7 +985,9 @@ static int do_fsck(struct f2fs_sb_info *sbi)
 	if (c.roll_forward && c.zoned_model == F2FS_ZONED_HM)
 		save_curseg_warm_node_info(sbi);
 
-	fsck_chk_and_fix_write_pointers(sbi);
+	ret = fsck_chk_and_fix_write_pointers(sbi);
+	if (ret)
+		return FSCK_OPERATIONAL_ERROR;
 
 	fsck_chk_curseg_info(sbi);
 
diff --git a/fsck/mount.c b/fsck/mount.c
index 6f640a0..85ed404 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -3159,7 +3159,7 @@ next_segment:
 	return -1;
 }
 
-void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
+int move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
 				 int i)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
@@ -3171,7 +3171,7 @@ void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
 
 	if ((get_sb(feature) & F2FS_FEATURE_RO)) {
 		if (i != CURSEG_HOT_DATA && i != CURSEG_HOT_NODE)
-			return;
+			return 0;
 
 		if (i == CURSEG_HOT_DATA) {
 			left = 0;
@@ -3191,7 +3191,10 @@ bypass_ssa:
 	to = from;
 	ret = find_next_free_block(sbi, &to, left, i,
 				   c.zoned_model == F2FS_ZONED_HM);
-	ASSERT(ret == 0);
+	if (ret) {
+		ERR_MSG("Failed to find next free block for curseg[%d]\n", i);
+		return ret;
+	}
 
 	old_segno = curseg->segno;
 	curseg->segno = GET_SEGNO(sbi, to);
@@ -3211,22 +3214,27 @@ bypass_ssa:
 
 	FIX_MSG("Move curseg[%d] %x -> %x after %"PRIx64"\n",
 		i, old_segno, curseg->segno, from);
+	return 0;
 }
 
-void move_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left)
+int move_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left)
 {
-	int i;
+	int i, ret;
 
 	/* update summary blocks having nullified journal entries */
-	for (i = 0; i < NO_CHECK_TYPE; i++)
-		move_one_curseg_info(sbi, from, left, i);
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		ret = move_one_curseg_info(sbi, from, left, i);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
-void update_curseg_info(struct f2fs_sb_info *sbi, int type)
+int update_curseg_info(struct f2fs_sb_info *sbi, int type)
 {
 	if (!relocate_curseg_offset(sbi, type))
-		return;
-	move_one_curseg_info(sbi, SM_I(sbi)->main_blkaddr, 0, type);
+		return 0;
+	return move_one_curseg_info(sbi, SM_I(sbi)->main_blkaddr, 0, type);
 }
 
 void zero_journal_entries(struct f2fs_sb_info *sbi)
diff --git a/fsck/segment.c b/fsck/segment.c
index 96de22a..46dc747 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -70,8 +70,8 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 	}
 
 	if (find_next_free_block(sbi, &blkaddr, left, type, false)) {
-		ERR_MSG("Can't find free block");
-		ASSERT(0);
+		ERR_MSG("Can't find free block\n");
+		return -ENOSPC;
 	}
 
 	se = get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
@@ -789,8 +789,8 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
 
 	new_blkaddr = SM_I(sbi)->main_blkaddr;
 	if (find_next_free_block(sbi, &new_blkaddr, 0, type, false)) {
-		ERR_MSG("Can't find free block for the update");
-		ASSERT(0);
+		ERR_MSG("Can't find free block for the update\n");
+		return -ENOSPC;
 	}
 
 	ret = dev_write_block(buf, new_blkaddr, f2fs_io_type_to_rw_hint(type));
-- 
2.55.0.229.g6434b31f56-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
