Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB3FCD37AC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 May 2026 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=waEb2TTk3vPmN98HUWMTA3LyKrZMcK/zJfaIK5vO+BY=; b=RO7r5FCq3n7ACyHKMpCxJsNQp6
	WeDCTSfA81LMX4iGlwSKWX2Id17folnGLerkRNoYdcf/l7puG8aFMocivyPcCRyitoADxtV1oU9YV
	HU0tfTvoCtykXaHsKExi4Fs66ph+Sd3dUX6VjD2TKQ2f7UtTJIM3iVRx0s22mvxAystg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNd5d-0000f2-LI;
	Thu, 14 May 2026 20:55:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wNd5c-0000ev-Oc
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 May 2026 20:55:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M+HrC3wUfomSuttyTiJ1cH0jqcmCnpaZOOcbBOvYx+Y=; b=Kj49IHBW74XKO5uuKxbKZ1kpl+
 7+ssDqbe4UXFfYv84gVCESKHi1Fx2pj4SD1RjujKq2weGx3LA1WjQjuGroN8ESvqkvJmInRzJ1f+G
 +TJscYeU/jjvXGrN9Gozi/eZH1u+S9cduJtN8v8iH5FYNCmlNmORN3b5neLlkWnLuBr8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M+HrC3wUfomSuttyTiJ1cH0jqcmCnpaZOOcbBOvYx+Y=; b=f
 k3Ij/wBbIwUDZxLPh03jpd2atfg7hxyQvM+Uy3ZQboQA9yd5hl8hqu0Gmj9n8hziUlHI0vDq5yOur
 3dqXV+xTJNlNLnrce1RW8ih9uJRgdBAnkqnm9HAes2JQs62CG0/bndQ0OjDBApFWLeTm5q+DGakCE
 PM4vxaYLlBZhO3cs=;
Received: from mail-dl1-f52.google.com ([74.125.82.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNd5b-0003R8-Rg for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 May 2026 20:55:28 +0000
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-132d1b2519eso3023078c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778792118; x=1779396918; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M+HrC3wUfomSuttyTiJ1cH0jqcmCnpaZOOcbBOvYx+Y=;
 b=J0q8jALnH8LyyaTYqyQShLcwRow4JHb03hYcmtkrz9a3yy3ExUNCC1caacTZf0vH7y
 AbzkQjtvBToJZZK8c9mmxiZ3rpUL5SiW6axYQvKBIEvTjobWGjygthEo/blYPbex6BMg
 1xOAvK5/jPd8PbDAMLhoeWVBddu4hUnuuvoFWs5yRnXWZ8dSIiEW+KhGwgS6PiF9BNUB
 vxR87WAf/3vaqBtvlAE/x/rkKLjgErSdXGcGpjtqxjYMDvFaiazREelPlVKTAR3apxau
 Ps/XAIUVxVhj4RIL5jK5QwoqSWhTqSlVPNVZk9ZSYbG7oHOezBuKJFMc96XfjB/0v1GC
 9iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778792118; x=1779396918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+HrC3wUfomSuttyTiJ1cH0jqcmCnpaZOOcbBOvYx+Y=;
 b=tLKt89bsNwh/6aL5S6xCDpZa/HJUDLCjgFJWgMkv5dXDXTUNZ2ZTjSWBZdprOtmIOY
 d53S96e2ewyn3E33vQPBPWTp0Ks25hhSdxQkbuXPg6zG7UC0EQEfoBUxPCsTaq1Imtc4
 +UjupFq0XLpeXaUFLbH2wIdeklXt2RyYixoI044obJ8+Xms4LSKOvK6VUmvytZmArLW1
 Ho2vfhRcNT3or5qm564kUgLva0BPKuZ9dv91DseFgSxvfIgdCwLoVIEUo6sPcIfQFVma
 W/QaGtUOnpZkyEWMctYcEYaxsfPWSCux/un1+yIrwq1Yn/UOPfBH2Lm+fj5Li6JC5Rhh
 i1ZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qyjLExOMxQ7EB/8VHT5ZlWpIwRaFtSGKIpK92i64jutcxCC+GuJv5eU/LBFMnLRAtMjV/i+cgzew4grky1MQx@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz66Aj+2UwMHQVGe+yq++Qg5E7eS5CVezyK6GRPvYOpmYtODr/q
 pqJhDmEUhJp/vYXFk0pYMkcKQsGaZdA6Vu3O3xYXbNcQgO69kMumMDfN
X-Gm-Gg: Acq92OFmHIu0udnCE059sXHQpoJ2iGvdPpELQd+jHv6ToiPCP5vZo2nI7o4eXlC+oEq
 u0jHD7H9hbkO1NSpbAVmCJkbXnIYWb0Lfp3uHqP/Km28jAoJ2dfDLAZpoMi0IB7tqftaZcIJbeH
 HhTclp2CuNFmWRFJWe7fDWM0V/0o3JFKqtbEf6N/+Gp4in5UkdZBy3wU2fJmvpdEd2eTPf4F1VU
 2B82hqxTcXjyNGHBKsmXfa4wjUCSv2a/o2w27OwKA/yaE+tM6fsI5fEwL/wToB0mQ2HjA1w4Bcv
 WOpDhPlTU9exLmgG9O4KJLJfSvTxYg1O+7ypwprThhXPKdG8Ix8otCYYvv5wsIP8qwJWNmjEjJK
 JQjNBcepqf2H+x2SKIfEHmty9u4fYv2QhVZyPFkPF4sXvodguo1MjS73J3XGdlBlesqvsTuj7DB
 iShz8pPLhbwjHqwHxsUpGOtDYORToBUmybYtKrLImqoMV+5d+19W/r/v10DKevx1i6cZJpd+2mS
 aPRNFVJJmNF2d7MPtl3kyoKNwwANMfwFUDyUwEbFTYyKVrX3Q==
X-Received: by 2002:a05:7300:e6c6:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-303982b11bbmr674972eec.11.1778792117654; 
 Thu, 14 May 2026 13:55:17 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:d674:986:3782:2b17])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm5355763eec.3.2026.05.14.13.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 13:55:17 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 14 May 2026 13:55:13 -0700
Message-ID: <20260514205513.1464863-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
MIME-Version: 1.0
X-Headers-End: 1wNd5b-0003R8-Rg
Subject: [f2fs-dev] [PATCH] f2fs: optimize representative type determination
 in GC
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

In large section mode, do_garbage_collect() previously determined the
section's representative type by looking only at the first segment of
the section. However, if data was fsynced into an area previously used
as a node section, and this area is recovered during roll-forward
recovery after sudden power off (SPO), GC would incorrectly assume the
section's type based on an empty or obsolete first segment. This caused
the recovered data segment to be misunderstood as being stuck inside a
node section, triggering false inconsistency panics (Inconsistent
segment type in SSA and SIT) and subsequent mount failures.

This patch optimizes do_garbage_collect() to determine the section's
representative type by identifying the first segment that actually
contains valid blocks (valid_blocks > 0) during the main GC loop. This
eliminates false alarms from empty/obsolete leading segments while
maintaining strict section-level type consistency checks for genuine
corruption.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 755df9b6bbaa..3464ca7d5fb1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1745,9 +1745,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
 	unsigned int sec_end_segno;
 	int seg_freed = 0, migrated = 0;
-	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
-						SUM_TYPE_DATA : SUM_TYPE_NODE;
-	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
+	unsigned char type;
+	unsigned char data_type;
 	int submitted = 0, sum_blk_cnt;
 
 	if (__is_large_section(sbi)) {
@@ -1846,6 +1845,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					migrated >= sbi->migration_granularity)
 				continue;
 
+			if (migrated == 0) {
+				type = IS_DATASEG(get_seg_entry(sbi, cur_segno)->type) ?
+							SUM_TYPE_DATA : SUM_TYPE_NODE;
+				data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
+			}
+
 			sum = SUM_BLK_PAGE_ADDR(sbi, sum_folio, cur_segno);
 			if (type != GET_SUM_TYPE(sum_footer(sbi, sum))) {
 				f2fs_err(sbi, "Inconsistent segment (%u) type "
-- 
2.54.0.563.g4f69b47b94-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
