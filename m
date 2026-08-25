Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC50C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 01:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uUA7gPCky4UdHTQrUZq2bsQn7fJIkbkgD/Lo/mtHCS4=; b=KhFT1w5YOL4Mo/O3M0UlkRQMeb
	6U14aNTIC4zQaLSO7GPblhzSF1HRFU6rlV9o3pveRwZl9pHKdmnPS3/2/5L3WxIQVmPcKZqUOiumg
	raIdjPy8BWbFjEuWAzT5KqciJA7pYma0EsYOOlNkq9Zl7Zxq5hDbj2JLA1BQNpOMh4d8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wygLp-0005t8-Jf;
	Tue, 25 Aug 2026 01:53:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wygLi-0005sy-UZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 01:53:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7ksJHKJAw5R8WRBPibc1ESESDe+ccf9OaKGAn1jN9/4=; b=YZpTw9Ie+xnuWuoM4vy/xhIA/b
 yvwRssCpoCf+lt2xnL2Opk/noR9zATK9E3nLYzEqY3WmBu4iQJE3Pyvni0bsoT3BUnT1ZTtP3jXY2
 RuaVBi3wfjv3JRQ9xi2BvhPxlcp7PriaUgw/R+yufxYqKAQKAYYG1z9GqJu21jFv5SoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7ksJHKJAw5R8WRBPibc1ESESDe+ccf9OaKGAn1jN9/4=; b=Q
 fJQUAUIXrWlPH8Sh1wDnXhlHKm8njvA5Q4uaU97Nih1MRx3MgWppGQxmU79E9ihj2PIQKXyV7eiwa
 i2myvO7nMoO93928Iq9aoCe8tUwjcB/isF4pS4/FZsRAOYMnlTOOiq+svMGP73a3CatYqGxFgrjKR
 93Cq6BqQQQZTu4U4=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wygLh-0005Yc-Ho for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 01:53:14 +0000
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cee9b74ee1so33543205ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787622788; x=1788227588; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7ksJHKJAw5R8WRBPibc1ESESDe+ccf9OaKGAn1jN9/4=;
 b=Po90mMyi/J5fHmWhCVllrJhzhgxfaIvBSgzPD6GGIuUGfzOpYX0W2EgsO/raB3tfZ+
 yRbOCeFmoTdlx/4JWSEMwbkGsIzb43oK4DtxqzORLxhJKOrL6wJUphyU7waYMHXrkGMS
 ba+5Ice9grTC//x54ziBUEwY6ENLvBLlZXzw7PZpw9dBoUT3+gYrByfm+JyPg6GO7YNi
 mf0ZTXj5HMpjn2esTNVAsUCaxiMOVCb3lZSD8+QBaPs0J5s93ThSjgbZixoOa6OfBfB/
 BuhFW0oievSUFB3E/3yX5vujcYG2Xd25sIPAHIDA+dAb9jWWHKQafSxyVbptjvt3z2HT
 L/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787622788; x=1788227588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7ksJHKJAw5R8WRBPibc1ESESDe+ccf9OaKGAn1jN9/4=;
 b=F/M4vEHN+1II14JCFMoBHYkcqT7eFWpwTDJ84CmQkZp/+g/OAw00kuIorRrnXf9/ot
 XYQUIFUmlEyFEjtU0cyFJlWOiD9aqyVejlmg99VUntzDXO85e2kxzYRElyRA0pLzt3iU
 hNf7W4hu7Hni3s2ymMOl7lLPouq27BaIoSXgRVnOcR3dcVS/OTrMydqEIEulB1pmAXye
 zYCpZjNsfJ2WFLq95uJD2fFhQnjWJXlkSBbfT2MEm724JbUcTNhpAGpIfo97fjh8sDC0
 354iA0JwmmsvGLq/EVKa5fN7Ug58/Rv28VHn9dSPzJTZASkokCsQ3fL9dfhmotRuiGir
 vCAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnUW53zZwFcxqhXUxnfdtNkDwY25G4aUiLfvGdohk7IRV3stbvvgClmvuWTSsycNURGXzI3UXtFPoWIIDjI5nK@lists.sourceforge.net
X-Gm-Message-State: AFuF++mIL/gyBDsMGCMnvxZsdPAZFdgCWPuzqhV9J6mjqhkruvmgmiVw
 sjR0H7KnrH2M6S8vzWm2wCay33j5p6wucEpS4sCsb6pEsedbY96XhOz5
X-Gm-Gg: AR+sD12p5nd1RUVIUwy/ckYzgRRLgekdn+t0rwjV6P6qp2RiZAFY8UIq911BV+ypX1y
 N8Oh8Em1zR4Sq1baVghIs16cQoSzngzrdDyr6Fod0OycakEIeYC704A1bAIL6nxx5L3T/CX4M+p
 6BBF4MVMOP43AW+0TRtDSXCinf/C9vHZC8RLO4xQgNto6APML30a9pQcvc02H0Gz1Ktl2BUZjud
 VEB6FGMWyFtex4WwKifM4UjuIzSfmMMs5BAbuLDz0vJIgY2jf1gTBaVQnwDZRIe2aYhYu3fYISZ
 W9eVAI6jUokjV7R0tn/fhAngRYb7rLy/ygn0kPo+rG9IclPxvwm+9ctWKb+9cTzn7MVs3M/zfLW
 2zhxv74pr3iY9NmwfDcTVJLfcCZPE71bKDuonI1n2SvAU4rOsLDX8o4yr4NM6aoAU/SlHi0/7t4
 jRRJy4k+4hBsKHYI1dt2YKDlbC7h/DzN3JWk0n06ieOti25ae3LTv3qALf/5SFoeLtCF1gQhdO9
 2FhtUC16ZT9QWTW7ViJjjz5Z5YTyuaDZO29JqeV5cjGw+WpcmZCg7xp+CqEqJJeutetrjEF7eSI
 H7Utzs+PKcY1
X-Received: by 2002:a17:90b:3911:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-395df2926d9mr39684897a91.12.1787622787801; 
 Mon, 24 Aug 2026 18:53:07 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:8d79:bdf4:eb94:2cab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9236166sm30514662eec.28.2026.08.24.18.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 18:53:06 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 24 Aug 2026 18:53:03 -0700
Message-ID: <20260825015303.2082221-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
MIME-Version: 1.0
X-Headers-End: 1wygLh-0005Yc-Ho
Subject: [f2fs-dev] [PATCH v2] f2fs: accurately adjust free_sections during
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

In free_segment_range(), MAIN_SECS(sbi) is temporarily reduced by `secs`
to restrict block allocation to the safe remaining main area while valid
blocks in the truncated range are evacuated by GC.

However, FREE_I(sbi)->free_sections tracks the total number of free
sections across the whole filesystem. If any sections within the
truncated range were already free upon entering free_segment_range(),
failing to deduct them from free_sections causes the filesystem to
overestimate available free sections in the active, reduced main area.
This leads to inconsistent free section accounting during GC data
migration and can trigger unexpected allocation failures or assertion
errors when space is tight.

Fix this by calculating the number of already-free sections in the
truncated range, deducting them from free_sections upon entering
free_segment_range(), and restoring them on exit.

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
v2: elaborate on the issue in the commit message.
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
2.55.0.860.g4b6b3295ed-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
