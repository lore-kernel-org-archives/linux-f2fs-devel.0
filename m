Return-Path: <SRS0=qUHl=ER=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F97C4742C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2020 09:43:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAFB20729
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2020 09:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="QU9adQb8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="liA8KitK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKabU+d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAFB20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kcmeQ-0003uN-NR; Wed, 11 Nov 2020 09:42:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <robinh3123@gmail.com>) id 1kcmeP-0003tl-QF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Nov 2020 09:42:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HWsx9B0i+km7rETi/ATPtzslVhr3RwpBYH13dBR/3Ho=; b=QU9adQb8shvVKk70BKirOxipcP
 jvDsQC4eWPbU15T2qQztYZoun1ct0khO2J/oeHcbVCum1biiaZdO24v7Ctk/xPnAj+B9dEjVXaFDR
 4Diu92kUhl+VUxsF2J/rm0CBfRfakqFkWhwYssYknXfyk2I1ueKUcL5IzLazfOnCmPog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HWsx9B0i+km7rETi/ATPtzslVhr3RwpBYH13dBR/3Ho=; b=l
 iA8KitKwCaE1ps0ib6IkxuN5mXA9LE3peFA0CAVhqToxnE0t294A2xCkpRyZCrYo4w/wXgUj+jD5a
 Oap5pmOzm3RzsRKv6IneD81w2GMs7F87Q0gLo5DSmcKUlHVTCLJp7R4bpIdfyQWkUn8zuk9oq5N6f
 CrS16KUpa9pf5Jcg=;
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kcmeO-00GbyL-3s
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Nov 2020 09:42:49 +0000
Received: by mail-pj1-f67.google.com with SMTP id oc3so460785pjb.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2020 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HWsx9B0i+km7rETi/ATPtzslVhr3RwpBYH13dBR/3Ho=;
 b=aKabU+d70ye27wRjrFfr+zLkzU7wnCVr3xRHRKWIE7Oq9GDMjvy8utFfxpWMpQBPFs
 3YfKsz8+rgkxal0IkYjsU9OGcszs+1HpGO90e0i5dny0FGSHqHz0rDENOBO8ri83guof
 AAWx+LuEEG4CvzX/MhgwPMNjaZTMBkIM1+Cii+f3+8mMCKSTQ9ezsWb/smYac4M1MafP
 gY+xV99NJcackueC0L6Lbkf5RumOpkFhaQTVCHq6kCMmepexWf72hRpaW+xOgdzRyPXQ
 sH5QOCosy2tgkj8ZeyXlbRigHC/NKh6eGKv0ecQwnZCjrOyb+ITneQakI9fL/7RYE0e+
 cPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HWsx9B0i+km7rETi/ATPtzslVhr3RwpBYH13dBR/3Ho=;
 b=pHh/EzFfkhgXCmu8yd8nyggrmnIp9yiQ4eKeuN7l1Y+y721JVAI8IENfWjyONwVXaP
 tEZDzXKx7QNhNnmBZeL4q+lSIIUs0PHEax1U2u2SaCDl0K93xOZEZEaWuastV+00eauY
 SjJ4XV60lu9Jx0Nn2MlLOXY3FJ19RdGOsETiDrkT/yfU6Nu8/orkacV3HKXhIvuTc0Rg
 MCS0OcDuXyjri2inV0boJy8pTvpvarIH6LIFUObuSnHvigAwoiKv0mo++QfjBlvf2qkD
 XdEuBniLYt03DC3/PpvIeKcUIXFIPZG426br3HDwny4q6YamTNmClAuV62Xv0DQ/LayH
 Ck5g==
X-Gm-Message-State: AOAM5324vGmSm5sJ8xpR2HgvFgi2ylC10/k4JA7BDZWdUHsb2BpPqqDf
 HIzjiKq25HjaSbawpapBDMexjKtnBWA=
X-Google-Smtp-Source: ABdhPJxF9CrnQP3mrjGSrpaI3VkSCPqLt91T6zdmfpg6ZKKbVlMCoPMLu8DxAAjOxRgn5GwVkcpSeQ==
X-Received: by 2002:a17:90b:300a:: with SMTP id
 hg10mr3134852pjb.30.1605087762350; 
 Wed, 11 Nov 2020 01:42:42 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com
 ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 by smtp.gmail.com with ESMTPSA id o132sm1857300pfg.100.2020.11.11.01.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 01:42:41 -0800 (PST)
From: Robin Hsu <robinh3123@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.org
Date: Wed, 11 Nov 2020 17:40:57 +0800
Message-Id: <20201111094057.565522-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
X-Headers-End: 1kcmeO-00GbyL-3s
Subject: [f2fs-dev] [PATCH] f2fs-tools: skipped to end on error syntax error
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Robin Hsu <robinhsu@google.com>

When error were found, we won't need to do any initialization but
just quit.

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 fsck/main.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 32559f1..e70048b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -597,20 +597,22 @@ void f2fs_parse_options(int argc, char *argv[])
 		}
 	}
 
-	add_default_options();
+	if (err == NOERROR) {
+		add_default_options();
 
-	if (optind >= argc) {
-		MSG(0, "\tError: Device not specified\n");
-		error_out(prog);
-	}
+		if (optind >= argc) {
+			MSG(0, "\tError: Device not specified\n");
+			error_out(prog);
+		}
 
-	c.devices[0].path = strdup(argv[optind]);
-	if (argc > (optind + 1)) {
-		c.dbg_lv = 0;
-		err = EUNKNOWN_ARG;
+		c.devices[0].path = strdup(argv[optind]);
+		if (argc > (optind + 1)) {
+			c.dbg_lv = 0;
+			err = EUNKNOWN_ARG;
+		}
+		if (err == NOERROR)
+			return;
 	}
-	if (err == NOERROR)
-		return;
 
 	/* print out error */
 	switch (err) {
-- 
2.29.2.222.g5d2a92d10f8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
