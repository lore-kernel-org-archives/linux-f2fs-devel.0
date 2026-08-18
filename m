Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089B7C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KqQiCSaItJykV5u95qCsf9EyJaZeWAepIDBoNDAkRNo=; b=l7ck2sIKVvWAHSpkqVpLjflJD6
	JGP/xFDGtHYjgsUWht81FJqQiObE3m1oakml7VOr+xVJqo0nI+LViBzMuLH0K/hYpn/xIiNLDwGb3
	oBJnZnaNt7n30JxUwxjt5ImbrVUFmZLp7ksm9W6CSUsP9FcvUKpJpHL265MJyFK0HFDo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwNOU-0001qO-Mi;
	Tue, 18 Aug 2026 17:14:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wwNOT-0001qH-Ck
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 17:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6uxCYjzk6Sw3PcKM0MHXuF6QyCEyzVfr72+hK3fcU0U=; b=DFc1XvJFAKiSDVEWIrXCkyF2az
 5k+XdvVmgDkCV4jfaivAIR0q0sghQElonfI0p7ryQuiC8PgeXwiir7hyJaibMFndsG4str6hLfP2/
 XrwqTNc1dbQIPyRtOGj2WuK7V6ggIDO3qLiKNEMSGfCcPAXtSk+YoH1LFBetmsj+/hB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6uxCYjzk6Sw3PcKM0MHXuF6QyCEyzVfr72+hK3fcU0U=; b=Y
 bpxqY+Cr+Dj14MYxTVBwso/hiVRT71ZtjQm25DwuIvuuiOZHSOjEAaZEpSdzTF4nCPmBM/tBiWet0
 NfWF5yKpnMIsYQWZKlHUeLJaxzl8I0lIqgwEucQ26qP38WkiDB/uYe40sRKp7JUZUC9jK96wFtRsk
 W9M7F4/ersG+l11M=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwNOP-00074p-54 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 17:14:30 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so32638a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787073257; x=1787678057; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6uxCYjzk6Sw3PcKM0MHXuF6QyCEyzVfr72+hK3fcU0U=;
 b=NvZRcWl5VwGVOhnEJEaqeYWuIQyxkXBkdFQI6y+l7IaRAfuYH6iACv8+fL3dO/UV9P
 2b+9qwi9t+jbPeOxNdxKLAHtN+XZQS1YOeYJbHNY2RTP58JcE1wlfdpNMWPMsMZbrQ/c
 n0ySqKwwZBpYjWzbVbjeOkXHdySXFGDEjJr958yE6mF/geM1SKbSDnJkZ0ZD8FBRfM1Y
 tmXIg58IWrZ54kBREmPp9LT0k1qVgvvHK4pBjRB2Pkd26cZb2vlLQMGw00ogI85NzdDH
 tYnh74NrOih66KQBZjD1XgnaNHnbKWtGgMURfWXbjvvvPP2Vfxz0FtO9YvDI8Hy/PWTh
 iRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073257; x=1787678057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6uxCYjzk6Sw3PcKM0MHXuF6QyCEyzVfr72+hK3fcU0U=;
 b=r+0VNwNUYeFNrbZQsagUu92fiKPWwto3LwhLDxAjQQeIjhDk23YvKjtNHR3VVs6Jaf
 rScZhUytSG8D6BzAiSxr+5qBr4UOS/tmJ0XVih0saL8xeO+xJ7wVxDoZjSMyuJVZQcbS
 X2YVtU/+NuxO/vqImeVvfPdvbKNdSqTWL6CoBs316+GdJPDe43N1SqeAR+xXWrfS/P5O
 cBhJuykVS0obZ05zAvr3iHDlEo/628WLBLMuP9QcfaJoD2BN1PLvzm/HJACDwLtQXtFD
 YF9tuVwI+bChMSH5wYzFga+dQGCLphcyTRGYpVWVYxO36d4sGnucL/N1zx7AwySnimv2
 C2qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUkp3HEpoFDnmLqn0P82pl8PtT+X9Lk2Xjd414bHw8OwAjBchsdG4uZhAEukSO5PB0SsVkSyTuCxhyL+HRPbx4@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwAsLh3mbNfpM//ysGfZaBV6WYKEkUGiC8b+Nh8chnxpqp9DxvS
 LYNMeldQIMEt2tX/+ZqfTc/TTGKaSzmqaKWFgZb4/5qqLI095khoIVZM
X-Gm-Gg: AR+sD12G6AHYue5mTmCiiBi0MAPy/EmXQMPw0tELJKlkHNxG4fprO5CBNgF0UImqkdj
 edzXDn1izWy18HwW4zfkI3CSzbPqCHX9Z9smvW8ebapoenS7y9r6j3SWvf8lH0m4f7fv8BBn70U
 jevmOPEPMrjYs8SOxcraRmBGnTzxVmxfyDzemwhd4iwcSk1l9WhPbi7VaaU5FanYb0tRUJUCrXz
 lHURNiixhzbXj6XV6oMx1bRn4Xm1afKC7dOGNHeRw9YxnjSftEU/NjGfy79OS0AkE8TlylRbmeZ
 cIh4GucjeTUia2VUWCpWHS/TKGGqUJlUbO+WlUjRJOUqUcOnXnSlgCQDpbO+yqV3lwDSR7PdbMo
 PWXmtUS82jexpHm6wGxoNMJBkph2sBt2gNFly/p2pYzZOIUdm7zy5gDpHVjKWmL+99v0CAEcFJq
 Jr5D27hwyjK6jKRMN8d521lSwLLMVmRy1lAOJr7u1IuGbZnOpFe1/o2v2a21eLqXVk2wtWCamHq
 aYDOvLOrfa5TmCVUrxPjXGarcI7txo0o6Ir6gRUBnnCwybZPTsbPhvYvnDsdpWvuBlPxROxxG40
 OWejOoztjSfoOg==
X-Received: by 2002:a05:6a21:3a48:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3ccdac00616mr17004571637.18.1787073256979; 
 Tue, 18 Aug 2026 10:14:16 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:50d9:e296:7754:dc83])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21135719eec.11.2026.08.18.10.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:14:16 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 18 Aug 2026 10:14:12 -0700
Message-ID: <20260818171412.3201082-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wwNOP-00074p-54
Subject: [f2fs-dev] [PATCH] f2fs: accurately adjust free_sections during
 free_segment_range
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

In free_segment_range(), MAIN_SECS(sbi) is temporarily reduced by `secs`
while valid blocks in the truncated range are evacuated by GC.

However, if any sections within the truncated range were already free,
failing to deduct them from FREE_I(sbi)->free_sections leads to an
over-estimation of available space in the reduced main area, causing
inconsistent free section accounting.

Fix this by calculating the number of already-free sections in the
truncated range under segmap_lock, deducting them from free_sections upon
entering free_segment_range(), and restoring them under segmap_lock on exit.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/gc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 787133ee2eb2..f3a6fc6d08ae 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2200,8 +2200,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 static int free_segment_range(struct f2fs_sb_info *sbi,
 				unsigned int secs, bool dry_run)
 {
-	unsigned int next_inuse, start, end;
+	unsigned int secno, next_inuse, start, end, end_secno;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
+	unsigned int freed_secs = 0;
 	int gc_mode, gc_type;
 	int err = 0;
 	int type;
@@ -2210,6 +2211,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	MAIN_SECS(sbi) -= secs;
 	start = MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
 	end = MAIN_SEGS(sbi) - 1;
+	end_secno = GET_SEC_FROM_SEG(sbi, end);
 
 	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
 	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
@@ -2221,6 +2223,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
+	spin_lock(&FREE_I(sbi)->segmap_lock);
+	for (secno = MAIN_SECS(sbi); secno <= end_secno; secno++) {
+		if (!test_bit(secno, FREE_I(sbi)->free_secmap))
+			freed_secs++;
+	}
+	FREE_I(sbi)->free_sections -= freed_secs;
+	spin_unlock(&FREE_I(sbi)->segmap_lock);
+
 	/* Move out cursegs from the target range */
 	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
@@ -2245,6 +2255,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, 1);
 	}
 out:
+	spin_lock(&FREE_I(sbi)->segmap_lock);
+	FREE_I(sbi)->free_sections += freed_secs;
+	spin_unlock(&FREE_I(sbi)->segmap_lock);
 	MAIN_SECS(sbi) += secs;
 	return err;
 }
-- 
2.55.0.691.gc56d675ccc-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
