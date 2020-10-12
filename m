Return-Path: <SRS0=LL+R=DT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E7C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:00:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064442076D;
	Mon, 12 Oct 2020 05:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="a52EyTYw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Eh9oCpLH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+9c8REI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064442076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kRpwW-0002L6-FX; Mon, 12 Oct 2020 05:00:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kRpwV-0002Kv-On
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Oct 2020 05:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dIyTJjrKnc7YAlTA+e8+0Y005mOhxECeaDQ+HPR9acY=; b=a52EyTYwjf0wUqh4N2lax9/vkN
 JMTPHmnYz0XjmxtbI0z8DYple8VmOWzksFRR4nPgXz7oBObqAzaiBBrgty00GHNRjAh5/8E+nCK0R
 hKX5Uj82D3jKqcSsa1WCQdP6ULZXzINWsV4kovSq90nQ5cb5Ty6jRrJeJW8M6AxN3wfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dIyTJjrKnc7YAlTA+e8+0Y005mOhxECeaDQ+HPR9acY=; b=E
 h9oCpLH5oGWjILIM8MgLkPtCi86h7uMIeDLD5+z85z0yALrnjSH0IAnms6VMK7TQ0RZuEd8TkrAz5
 hFkmYMb3o+/4SeDDUVS1bQUHwG9kXjPvOQ+BvH8z9WMb+a0G8roMcrOa8IkQjFWJeNAIVsnrHpWCB
 iZbTFvmhVnYrx9x4=;
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kRpwO-00BdkQ-6i
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Oct 2020 05:00:15 +0000
Received: by mail-pl1-f194.google.com with SMTP id 1so2091724ple.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2020 22:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dIyTJjrKnc7YAlTA+e8+0Y005mOhxECeaDQ+HPR9acY=;
 b=u+9c8REIOdyK2+u/SgztypQ/7EGMc14U/m9HHsxlS0czY+2FtTJlv+58hPxTLRC6Li
 80ObzNgT0y0VT9dS8kiKqTWlB/ECa6A1TC/FMLMlpKPRVqj/mACFl0KkfqKjjPEQZZdO
 2RQlWF86lxRluRsASiQyBKqFmzOPhRFqSinp67fNnPtelHG0DTU3D5RnHKmISmMpnKgO
 3TyzzRz48zGINGK1hpeoiKP5cT6G+Z7EMC4NXewNryMHuF9Syn6GoZwqJ+wwRXy9MbwD
 JzsT93W0zDp1y0+rxydd2EiUArWjuE3BXpHTMFA2uyxtDWKNNkVILQW8nLIK2WYZwaR2
 X1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dIyTJjrKnc7YAlTA+e8+0Y005mOhxECeaDQ+HPR9acY=;
 b=iED9OHBPampiZtgTsxYnZX/KOiIaRR9ofaqzmdUCjMR/N9ldk/WatgedMXTjfG+QG5
 k1xkGkmumixDqms47wMo94eFowuxLD7yNu2dHd8u0KHLFTQwLdrTQq/e/lr+4DMBPpXD
 BNVanixwfKBPmqno8NPMkn/GelZSODkax7Laj5o4IwB37sbMnpEAA+hp5kH2KCpClho5
 b5OCUoaokWbdwsd/6ikclxrmbCvVG7vGQhr6fzDp6aC+kifYtWgei9lc0t8Dcqaoe+Qy
 Zmd1qk6DK/+Kg+b/JYSVO7nrnflyyaenBF71Flvq3mC3NRVkjy/zWLs5fEbXv8gTIuAD
 9ExA==
X-Gm-Message-State: AOAM530PL/OYm+PiEqjiwVNQQ1gJW6Gc0d1pCmJUcMhJBz/NIqgt0lJb
 TFG/SGIzdr5DrRHHOoG4ilU=
X-Google-Smtp-Source: ABdhPJyvFvRbObN4Qy1DMd+BVZo59q35cx/g7BtKo73dG2Zo7Gm5jWusAe+t9x0UOfcGCQeoKaYYAQ==
X-Received: by 2002:a17:902:7589:b029:d2:686a:4ede with SMTP id
 j9-20020a1709027589b02900d2686a4edemr22379964pll.45.1602478795165; 
 Sun, 11 Oct 2020 21:59:55 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
 by smtp.gmail.com with ESMTPSA id n4sm18424118pjo.49.2020.10.11.21.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 21:59:54 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 12 Oct 2020 13:59:47 +0900
Message-Id: <20201012045947.3622888-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
X-Headers-End: 1kRpwO-00BdkQ-6i
Subject: [f2fs-dev] [PATCH] f2fs: fix writecount false positive in releasing
 compress blocks
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

In current condition check, if it detects writecount, it return -EBUSY
regardless of f_mode of the file. Fixed it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0a958eef3d1f..ef5a844de53f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3509,7 +3509,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	inode_lock(inode);
 
 	writecount = atomic_read(&inode->i_writecount);
-	if ((filp->f_mode & FMODE_WRITE && writecount != 1) || writecount) {
+	if ((filp->f_mode & FMODE_WRITE && writecount != 1) ||
+			(!(filp->f_mode & FMODE_WRITE) && writecount)) {
 		ret = -EBUSY;
 		goto out;
 	}
-- 
2.28.0.1011.ga647a8990f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
