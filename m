Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FE3C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Apr 2022 22:19:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhf90-0001ig-8S; Thu, 21 Apr 2022 22:19:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1nhf8y-0001i0-LF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r7B6va58ztFzexCbp+IzQPGrgh5J3MZhR3OFeRJ/XZY=; b=U2Z6nVoBkIonHFsgYAkEILTGYK
 2szm2g+byZggHGjA6tjFHpH7W2XfBqstjsF1gGaO3cBckjaa5Ng5JGZDLoukvDsU5MF/KdMW0W/jY
 PdLNDCh3T+VXiliUMzLF/jYo5ZlrQCKUKqZ4AR9TLBgyWosMacBtOf1WKpj9l1wSH6qc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r7B6va58ztFzexCbp+IzQPGrgh5J3MZhR3OFeRJ/XZY=; b=AEnAv/PjLdZ+41R11GZVu+WdkW
 Z4PktaJD8H+ICnxwrXTMnifQQD+TQQum/v9uLDdadznU0OUj1MFyDJbnb4F0XYBeSu7U943+RqTzt
 +fMc4gbJXQFHYUaaH8kamMZHTmGGNn2cGOiSKgUyq2meNHYnKTib629jXpNrfx7aIE7U=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nhf8w-005sQq-IJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:18 +0000
Received: by mail-pl1-f172.google.com with SMTP id s17so6761219plg.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Apr 2022 15:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r7B6va58ztFzexCbp+IzQPGrgh5J3MZhR3OFeRJ/XZY=;
 b=bEAewRiFVaLD03pSFhBojIAirN9cDcIt4cmJYRsQcmjpLoTCjVv+6yl5pfCyS5rD6U
 8ewl92sp/Gs2cmrDH13E0bZ/3ss9Cvbhst5bjfmdprYLwLFzG7c5Bu+4eKYeGj6krVvR
 oOaDgg3hRuz//39TdtrWIcWMulT/hXs0/SiIwIbjEyv1Pt55DQQnLCrG3DypkUHhv1+y
 hXw6STXvFzwKGr1v2WvrA06m3AwULWGxg8653yAUVvjMiyJUjI8hDHDfxNfnvbg7ALUA
 K/hGs7PxNojc8jRXgfm/3wxkjZYR0B8y6gDoZNmsn6vKQoD/DTF6REEDy3MuqCbEVBlQ
 zaig==
X-Gm-Message-State: AOAM531Ng0Y/NM+TGhVuDzVHLlXDavMJcRBzNhBeD958CxmrtoD3w7Ci
 bMHI8UdXlx6TyFFCRedN5+GCFL0817b3Pg==
X-Google-Smtp-Source: ABdhPJz8+MAAneSzpnULDRk9SLtX2X7bYIH0kAexh7YUoxiLUt9k3YmeS7Gjro0cbtrdjzvEuIeqng==
X-Received: by 2002:a17:903:41ca:b0:15a:4442:e74 with SMTP id
 u10-20020a17090341ca00b0015a44420e74mr1580969ple.154.1650579552992; 
 Thu, 21 Apr 2022 15:19:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:a034:31d8:ca4e:1f35])
 by smtp.gmail.com with ESMTPSA id
 hi21-20020a17090b30d500b001cd4989ff4csm3794876pjb.19.2022.04.21.15.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 15:19:12 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 21 Apr 2022 15:18:21 -0700
Message-Id: <20220421221836.3935616-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220421221836.3935616-1-bvanassche@acm.org>
References: <20220421221836.3935616-1-bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1nhf8w-005sQq-IJ
Subject: [f2fs-dev] [PATCH 16/31] Use %zu to format size_t
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use %zu to format size_t as required by the POSIX standards.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fsck/mount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index e075d3184f83..584385d682b5 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1429,7 +1429,7 @@ static int f2fs_early_init_nid_bitmap(struct f2fs_sb_info *sbi)
 
 	if (nats_in_cursum(journal) > NAT_JOURNAL_ENTRIES) {
 		MSG(0, "\tError: f2fs_init_nid_bitmap truncate n_nats(%u) to "
-			"NAT_JOURNAL_ENTRIES(%lu)\n",
+			"NAT_JOURNAL_ENTRIES(%zu)\n",
 			nats_in_cursum(journal), NAT_JOURNAL_ENTRIES);
 		journal->n_nats = cpu_to_le16(NAT_JOURNAL_ENTRIES);
 		c.fix_on = 1;
@@ -2381,7 +2381,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 
 	if (sits_in_cursum(journal) > SIT_JOURNAL_ENTRIES) {
 		MSG(0, "\tError: build_sit_entries truncate n_sits(%u) to "
-			"SIT_JOURNAL_ENTRIES(%lu)\n",
+			"SIT_JOURNAL_ENTRIES(%zu)\n",
 			sits_in_cursum(journal), SIT_JOURNAL_ENTRIES);
 		journal->n_sits = cpu_to_le16(SIT_JOURNAL_ENTRIES);
 		c.fix_on = 1;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
