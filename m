Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED527F53D89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Mar 2026 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5t7ruwGAJKlF7fw3iIuKrhnlbyR5TzHlQSc7LbvwA3A=; b=KOTfunPxCC7jxAoM0r67RSMXyo
	ulk4FY8Y/p1BbzTLKIkJnDe5dAE/jgBKZP0y+2MBPALQmAVeVjReOZ8VFQucXrLaw/ojkqDkRbCB6
	ZN80Spi6BJFnbgA2oSHvOTDhoQuPV+Xtezhuc4H+WAFpUMVKEH2UAEhCoDlVM9wmLZzk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2DAe-00048D-RS;
	Mon, 16 Mar 2026 19:00:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1w2DAe-000484-11
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Mar 2026 19:00:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nNIGcqXPfOweXoNb/mSBQcHnKJcZGl2TXjikUXsxC6U=; b=JwgfO/nLVfsi6II8ZAXGYdqO7V
 vdGiDz5VTx0lkbP+JWv8fgOkFv3ZTo0QbEe+m7gOdo9mv9Lx0zkZaNKk7rMM6vTKXWkp/zK4h0+ay
 QnQZiG3AwuySq8pV7gupWZl2lNe9hE4egNTv8PNHZ8JtLj6zFGAeZWKyZid1n6dCPjFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nNIGcqXPfOweXoNb/mSBQcHnKJcZGl2TXjikUXsxC6U=; b=k
 SGf8EQH9e5304FajINmlnOJWe16X13bfclyz9p1/ux/VRvyLcX8AeQkXZjtPuObWyhdRWpUFo4ZKR
 vht/lBGe+hxaEXBf5I52VZyE/WIeOvWIm2p2xaT9mbQ1H89CJW1frOMwEN2dM7reoUorcq68bFM4X
 CfaPR0qzDyC7fmqA=;
Received: from mail-dl1-f49.google.com ([74.125.82.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w2DAe-0007dU-Bw for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Mar 2026 19:00:08 +0000
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-127380532eeso7098246c88.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Mar 2026 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773687598; x=1774292398; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nNIGcqXPfOweXoNb/mSBQcHnKJcZGl2TXjikUXsxC6U=;
 b=UbhLcSecGcAx3ifgN4sP4qh/GnIKfHQtrM4BnvGIPUWMc840k+PSKGmZ29d068WMZh
 +lkansKp2dl+Q1QYKJ+xPtBXIhJMrRwgPsspBr8fPeYeVXQaTzqsFFzUnlyXhxLXidsG
 cJCPLq2xtWQvvTW0y2znpADHyAeAZBV1uK4UdiYuiAATQbCoo7hU66VPXx9whd10kGFL
 SlD5GYggWPiG5dBByFv7EzAxFlxMJUd7gZ68PnAs87Q9WxKsgRSwqyb6adGLeFgZVUD0
 1Uu9p8wX5r62q35ss50ADl6oceLOkFdZgULh/rptG/NTJAW6n6EYn9MO5p4vT4P6zd3K
 U5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773687598; x=1774292398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNIGcqXPfOweXoNb/mSBQcHnKJcZGl2TXjikUXsxC6U=;
 b=VIaYpwlztV0pwHcbqhezFwNCxKb0MoBe0SaOAGhVwfUOnq1AaFuUqaR1Re0uOgGS8s
 cff+uxfCGf1gt5Es63/Bu+Jid422IPf0NarJaCLMyptQko7uZ+v02Eb4EejWNobXcDLb
 WhdQG8uEThLT50504P+KFIPsRnE0mcVq47zBaL2SRGlvDWi7kHsH6CAipFPd0d1709in
 NSVS64NVlh0X7VXcuNqNSaBQJWDha2hRcLEjoKK/NGIszrhG0pLckSQQRmv53IGWkPf2
 QJWdmuQjTXIrWSB+676JbQKSc5XvIfpVh6QmPdrVnGRM3xROByzMcwuwrDyHIWlj74ND
 Pflg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo68AMQpGVpHMzd+ygwnt8OCF1fLvOdIPwJqp67xr6UTrAFn+l9LtvmRoSnXTy+T0e5IAGkZPXTb0tfLURDZpN@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxziw7AEPIqXdAG7jZ2XArkzd8xjmtRGNsOScr2lLkY8WfuNtSJ
 oZdpxDKJWJB4CaCVt224agyQViywaXuyFYg4vRY3nxMVj4m224eGPeJR
X-Gm-Gg: ATEYQzx5Mwli4Innb4/KH2NHi/TDjgrdWWA4zjUgSxnJU6U9BGd2SzAUgoQ7BxbtiaD
 cZoM8Qns5yqtg2UHFCO/TOz9RoqorTxtfYP844wpblvin7+SOPbq+PPs/nL3NULFFL+q9Mj6Nul
 c+es062mjLx8azbOWf/Fxu05Hbmm1CAxe51jG5Y37wN3XwTD0h5OiGM9LoI/zV7nzlFE/H2DrPT
 g+QZpkMcOjIa5F89V29Rri59/P3sTafZQb+FY6s32KltpEkTWXuehP16TcdUYcubNNSchdCoW3H
 9clLjxq+DJNABYBaqtL6E9aAM7HZeP6kfQ9mcWC8z065K48jWh2aeDMmNVvrE+GadySxVy1czhz
 i9QnuHiyXtHB09/5wdZw1ciO8XHL561D+QsEEHljEGqg/ucmeeBw/oCmsbw6t1iVBZL8oFzRTij
 E9lq4/RgvL9oN7omdTv21GQvCe0AvUReqV/+/TqSEatQt8sr3lyodbC3iHnjaofwj+5zF0LaVWi
 gIBwoBYKFDhbrPRX2+vDec51gD46rY8NBCkrRFaXllGOm22wfE=
X-Received: by 2002:a05:7022:48c:b0:128:ce44:be8f with SMTP id
 a92af1059eb24-128f3d1c017mr7639005c88.2.1773687597708; 
 Mon, 16 Mar 2026 11:59:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:de83:bdfe:287b:a163])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128f63b6a34sm15729412c88.14.2026.03.16.11.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:59:57 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 16 Mar 2026 11:59:54 -0700
Message-ID: <20260316185954.2185806-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
MIME-Version: 1.0
X-Headers-End: 1w2DAe-0007dU-Bw
Subject: [f2fs-dev] [PATCH v3] f2fs: fix to freeze GC and discard threads
 quickly
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

Suspend can fail if kernel threads do not freeze for a while.
f2fs_gc and f2fs_discard threads can perform long-running operations
that prevent them from reaching a freeze point in a timely manner.

This patch adds explicit freezing checks in the following locations:
1. f2fs_gc: Added a check at the 'retry' label to exit the loop quickly
   if freezing is requested, especially during heavy GC rounds.
2. __issue_discard_cmd: Added a 'suspended' flag to break both inner and
   outer loops during discard command issuance if freezing is detected
   after at least one command has been issued.
3. __issue_discard_cmd_orderly: Added a similar check for orderly discard
   to ensure responsiveness.

These checks ensure that the threads release locks safely and enter the
frozen state.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: removed unnecessary suspended check
v2: add freezing check in do_garbage_collect()
---
 fs/f2fs/gc.c      | 10 ++++++++++
 fs/f2fs/segment.c | 12 +++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 246496fbe5e5..2305f16cbabb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1889,12 +1889,18 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				sbi->next_victim_seg[gc_type] =
 					(cur_segno + 1 < sec_end_segno) ?
 					cur_segno + 1 : NULL_SEGNO;
+
+			if (unlikely(freezing(current))) {
+				folio_put_refs(sum_folio, 2);
+				goto stop;
+			}
 		}
 next_block:
 		folio_put_refs(sum_folio, 2);
 		segno = block_end_segno;
 	}
 
+stop:
 	if (submitted)
 		f2fs_submit_merged_write(sbi, data_type);
 
@@ -1968,6 +1974,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 retry:
+	if (unlikely(freezing(current))) {
+		ret = 0;
+		goto stop;
+	}
 	ret = __get_victim(sbi, &segno, gc_type, gc_control->one_time);
 	if (ret) {
 		/* allow to search victim from sections has pinned data */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e9b6d774b985..0c4fb4270185 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1606,6 +1606,9 @@ static void __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		if (dc->state != D_PREP)
 			goto next;
 
+		if (*issued > 0 && unlikely(freezing(current)))
+			break;
+
 		if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
 			io_interrupted = true;
 			break;
@@ -1645,6 +1648,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	struct blk_plug plug;
 	int i, issued;
 	bool io_interrupted = false;
+	bool suspended = false;
 
 	if (dpolicy->timeout)
 		f2fs_update_time(sbi, UMOUNT_DISCARD_TIMEOUT);
@@ -1675,6 +1679,11 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
+			if (issued > 0 && unlikely(freezing(current))) {
+				suspended = true;
+				break;
+			}
+
 			if (dpolicy->timeout &&
 				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
 				break;
@@ -1694,7 +1703,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 next:
 		mutex_unlock(&dcc->cmd_lock);
 
-		if (issued >= dpolicy->max_requests || io_interrupted)
+		if (issued >= dpolicy->max_requests || io_interrupted ||
+					suspended)
 			break;
 	}
 
-- 
2.53.0.851.ga537e3e6e9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
