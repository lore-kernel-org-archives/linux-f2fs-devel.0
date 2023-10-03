Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76D7E8FDC0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Oct 2023 23:02:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qnoPG-0004IX-Ve;
	Tue, 03 Oct 2023 23:02:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1qnoPF-0004IR-Iy
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Oct 2023 23:02:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nEaRtaRax1n0h+1IKPeikRHaTx6MRk96Qy5GH4j8LaQ=; b=LO0t3wW/LfSU4x31T3DelqjCNJ
 nCTm20dGeyA1ZKvp1UHm78NWJ9lNReuHHnjDtra9CWUiMcjASQ4CivKgD405QEVYnMJusmLnoTGgo
 UyfTKEwBdqxbyCLFh+lGQwEZQck0USXFBhctWsx1uj79a5PkicPseRKqrK3YZkotrSL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nEaRtaRax1n0h+1IKPeikRHaTx6MRk96Qy5GH4j8LaQ=; b=Z
 kchweATTNkKCUewThz/jaxm11Ch6IxHa3MrWoAxstNJXFrMALsPXNoMAeC7hx+gUCVHjW/qgF/Us1
 kAl3o1zlG3m1kbxQaipqzWnXMNQCmdzR7I7MLpbQ/X/CTIglQJ2fx8uYPXILaNHTt9qaytzwRrgME
 ooJNODv6EGoGdMvw=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qnoPC-000LMS-Py for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Oct 2023 23:02:20 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-27763c2c22eso1074493a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 03 Oct 2023 16:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696374133; x=1696978933; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nEaRtaRax1n0h+1IKPeikRHaTx6MRk96Qy5GH4j8LaQ=;
 b=DY2VMA0O7ZNGxR/itPO+zBQyfPfHXWu8UXMwpn3QYi0vsiEt0BOof9+V6EPl7bRXWP
 Zw4zzjOWNUwpI+M8wtuAg7vQjnZkTsTQAsduqc1cc9vv1GgwZ2tA19Xd1c+NC/SrrubU
 vc+8KMSAM7cRrNeq8j4t3MMj4D58acGO/RMeWlnGfpEw87tnKIFP4zC6pnnPD1MsTTQO
 CmPgKGxk+k225EM1vrG8BErqsrBW7WfJOgRFlTlCxnuw3KriH5YlyJpKwLBextFJR4YO
 /AuEgfDk/fLAqFb3iw1c8rhqL586sTggnTIuwDUc11AWkpiO4TfCinJnfV5eC04xeqK0
 lYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696374133; x=1696978933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nEaRtaRax1n0h+1IKPeikRHaTx6MRk96Qy5GH4j8LaQ=;
 b=ed51rUuaR3MFjmgEwHOtQCyyohoqtWcKnm2AQ8SMt/DYNfOZ+DePy+0d9oqk1TOQLS
 W0tz/C1VJk8mRdo9Rt2qesHLDqAlRd6U2WGJTETSvYgNSjO+p2ZiTq1PbHerVlyYocBw
 cTu4oke5MMht+lGNPjgqrAfXnw4EVt+ktBIvX6ma5d3/Q1uc/cYoHKPeW217VwT6Qo3B
 3Fze2olu5h49AZ1NhnZlt9XO9+joxcHGBomU7sR4WH5CyKnZlwnTdBTaCxXqdr4C2HNl
 XkdnZeXGpzWLkxn1erwmMBVfm4lfrbRYxvN38r8ZJJ90IfCBQtIpgaY5ERlw5MofFqYc
 FrzA==
X-Gm-Message-State: AOJu0Yz5/JUYrqTcshIrawSgMbe5rtq8CbJfkpbODD+ipzrzG4Q3TC/j
 za/NEdWbCQizFpUWf756mig=
X-Google-Smtp-Source: AGHT+IHSyviMq44U3UuFEk2M4ds+PrQx58KEBZHBDUujKrCVVa2ZnMDeTAUbtE9+odUQcUIRWSBM3A==
X-Received: by 2002:a17:90a:4292:b0:279:be6:bf73 with SMTP id
 p18-20020a17090a429200b002790be6bf73mr732397pjg.11.1696374133149; 
 Tue, 03 Oct 2023 16:02:13 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:1d9:902f:6531:9779])
 by smtp.gmail.com with ESMTPSA id
 ji13-20020a170903324d00b001c727d3ea6bsm2167940plb.74.2023.10.03.16.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:02:12 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  3 Oct 2023 16:01:55 -0700
Message-ID: <20231003230155.355807-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
X-Headers-End: 1qnoPC-000LMS-Py
Subject: [f2fs-dev] [PATCH] f2fs-tools: use proper address entry count for
 direct nodes
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

For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 78ffdb6..56a7d31 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2894,7 +2894,7 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
 	fsck->chk.valid_blk_cnt--;
 	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
 
-	for (i = 0; i < ADDRS_PER_BLOCK(&node->i); i++) {
+	for (i = 0; i < DEF_ADDRS_PER_BLOCK; i++) {
 		addr = le32_to_cpu(node->dn.addr[i]);
 		if (!addr)
 			continue;
-- 
2.42.0.582.g8ccd20d70d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
