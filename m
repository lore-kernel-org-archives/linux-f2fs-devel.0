Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C47BC76195
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Mar 2023 13:58:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgnMs-0003dA-0i;
	Mon, 27 Mar 2023 13:58:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jyh429@gmail.com>) id 1pgnMr-0003d3-BX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 13:58:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z1Gx6hpiQ6E/pjxy2KWHAjzK7MQQtrVJ/I63KQY+/Xk=; b=kvkUhpZDdVHUphv1GIrDWdVCoF
 g3jGq0bA9ktNSHE8LWjwUGF2LAtduTfQUSKWSFAOdgdIVsXj0H2oXSsMyaW4FPAQpp/7gLVzPJB2w
 9ukb5xH9doeheWa3V3ka9rkodDuGDn05AzrfXvImFLrL6nnnwn3JgvQ69lmrPZCf1leE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z1Gx6hpiQ6E/pjxy2KWHAjzK7MQQtrVJ/I63KQY+/Xk=; b=l
 DerGaQTuyvrW7P7mb01KZiswludR2LHuM4cRY/VhkJklN1UbS77HsA36mSKzLI7T7vkpJXIBdhNzz
 LSM1VDmWCxeUV+xlW/yrCD9bI20XYwIBdTIjolVmgMyusayvFwDKCK36JGo3Y8yTGOiQ5z9JMzo3H
 GUY/momu2zJ5FJds=;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pgnMr-005pVu-4j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 13:58:37 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 f6-20020a17090ac28600b0023b9bf9eb63so8911807pjt.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Mar 2023 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679925511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z1Gx6hpiQ6E/pjxy2KWHAjzK7MQQtrVJ/I63KQY+/Xk=;
 b=ZbFzZrfKuMTr4Xjs+F6s/P1aqzpZRLiLKb1UFloK9qUMOGJ4j6ThaZbN9EmEt0q3Eu
 759dpj8EfjK2LipQgCZsKVUF3eNQYWsuAILal1YdT0dt8mtFHq2PsltxUxXuVF/DpFbW
 vre2zPxglWy/+uOrN7y3ds+dE15+RAjun8lWKudPz6DK9CROJBHo9MGZYwH4Xvko4yyv
 B4K1TTqlsnYhaNOtO5nScDjHPIOFhAHo3XPyT/SgfJz5jMkB0/6T3aS+g+ytZ/X+tR7G
 nvlqpiVsoe1PwxLa2pJyH26ljq0NCnyvtsp0osVqMJoLehJ/liUOp49Gf5F2VnCNm86b
 FuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679925511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z1Gx6hpiQ6E/pjxy2KWHAjzK7MQQtrVJ/I63KQY+/Xk=;
 b=QjGllgmxPz2Vp5BumVyxeo1rUE7xgEkObYLz8korRibgku3V84iDDo0XduvZZeimZi
 edL4i9OCzUlbV7NYD/6y13uDB+CX4ARHTocYmI+58M3uFISLisnGmxYnfBFuarQGqqWp
 edZoyy3oEI6BTX/v0YNF2DKKwGFzLJG9ELaibZJV3DjGwKGjDvHMscfNsm/WpAye6q+Z
 De8fp57v0Ns6WqRPQlm3r5bfYfFh+gG8WPJXhrTuY8eQ1WcKP1H2g+FK8rhJXveZSeJ+
 cK/iMw0iFGGylHCg+FMHmZ+ONfBgTXQa5S2KqlsN0oQdOVluA15fAPHZ8L/APq2P/D6f
 qJtg==
X-Gm-Message-State: AAQBX9dOXed2N6MhiPu/H8miH2Q29azwXfofqt8yGF/kDal33R8iDFFu
 GU43YvuAeTlYk5V0rE/z4k0=
X-Google-Smtp-Source: AKy350Yvp2sDiWx+7IFe+pzISfF4KIfvlsaCIXeVDiEfPo49dfQC3b8yn9ct0NUPwT6496rPOkF3Jg==
X-Received: by 2002:a17:90b:4c8b:b0:23f:2c65:fab7 with SMTP id
 my11-20020a17090b4c8b00b0023f2c65fab7mr12857311pjb.42.1679925511466; 
 Mon, 27 Mar 2023 06:58:31 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
 by smtp.gmail.com with ESMTPSA id
 ge13-20020a17090b0e0d00b0023fcece8067sm7388246pjb.2.2023.03.27.06.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 06:58:31 -0700 (PDT)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 27 Mar 2023 22:58:00 +0900
Message-Id: <20230327135800.524-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1pgnMr-005pVu-4j
Subject: [f2fs-dev] [PATCH] f2fs: add radix_tree_preload_end in error case
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

To prevent excessive increase in preemption count
add radix_tree_preload_end in retry

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/checkpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1e0164cde23d..72205a9437b5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -508,6 +508,7 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 	if (!e) {
 		if (!new) {
 			spin_unlock(&im->ino_lock);
+			radix_tree_preload_end();
 			goto retry;
 		}
 		e = new;
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
