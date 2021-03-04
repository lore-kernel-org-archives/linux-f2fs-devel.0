Return-Path: <SRS0=rnqh=IC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F63C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Mar 2021 09:21:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6155C64EBB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Mar 2021 09:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6155C64EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lHkAr-0006Ac-VJ; Thu, 04 Mar 2021 09:21:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <colin.king@canonical.com>) id 1lHkAq-0006A7-MB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Mar 2021 09:21:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=euUkgjoINdSJOLGagz7MkAFqEmnvly/KMcbKiGgsPOk=; b=bmSH/XI+bRQPSueLS77sG+rtij
 T2AbxpuQvSXJEl3ziQ0awLk3BnWmXLegTrRta2A9DvInWCpUr0wEBT2tjagoQSHG53yOSwM+jd09i
 gR2ryYmHpybkwMJZyHdxi4iy86lCx5MSdcYmcNyXywDzRaJB0k+Q8/6vm/0qreb/mB64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=euUkgjoINdSJOLGagz7MkAFqEmnvly/KMcbKiGgsPOk=; b=j
 laGE+sfcnyrV7CTsvG8HQAEcJO/S1p1Z95rcuTNGO07Xtit2rBBOMOeFB6cs45Vi92OHKZa4DBuu9
 CW1nEA9ajhPB3Vq8jO00HkroOwIV0w/9/5XXyMcrtZu4oJVwYZ80f2FRkLUf3+fooLrWceFmXWdp/
 YIrFD2rCTHANc0DA=;
Received: from youngberry.canonical.com ([91.189.89.112])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-SHA:128) (Exim 4.92.2) id 1lHkAf-00DaOe-Ap
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Mar 2021 09:21:36 +0000
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1lHkAY-0001W7-J6; Thu, 04 Mar 2021 09:21:18 +0000
From: Colin King <colin.king@canonical.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  4 Mar 2021 09:21:18 +0000
Message-Id: <20210304092118.2279879-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Headers-End: 1lHkAf-00DaOe-Ap
Subject: [f2fs-dev] [PATCH] f2fs: fix a redundant call to f2fs_balance_fs if
 an error occurs
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Colin Ian King <colin.king@canonical.com>

The  uninitialized variable dn.node_changed does not get set when a
call to f2fs_get_node_page fails.  This uninitialized value gets used
in the call to f2fs_balance_fs() that may or not may not balances
dirty node and dentry pages depending on the uninitialized state of
the variable. Fix this by only calling f2fs_balance_fs if err is
not set.

Thanks to Jaegeuk Kim for suggesting an appropriate fix.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 2a3407607028 ("f2fs: call f2fs_balance_fs only when node was changed")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/f2fs/inline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 993caefcd2bb..92652ca7a7c8 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -219,7 +219,8 @@ int f2fs_convert_inline_inode(struct inode *inode)
 
 	f2fs_put_page(page, 1);
 
-	f2fs_balance_fs(sbi, dn.node_changed);
+	if (!err)
+		f2fs_balance_fs(sbi, dn.node_changed);
 
 	return err;
 }
-- 
2.30.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
