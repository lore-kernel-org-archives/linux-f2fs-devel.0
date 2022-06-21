Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7065AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jun 2022 06:46:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o3Xeq-00019M-Vy; Tue, 21 Jun 2022 06:46:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chaoliu719@gmail.com>) id 1o3Xeo-00019F-IR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jun 2022 06:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JI5187A/roVo6JAbOBFXjnebVpVgrehVAoIVRGh0e44=; b=ClvWw4HsM1PsIGe7dWBL3aju7U
 z5PieQNMbSLtWVY49IhbnYYZU4KgCw2blTBRkqoQpwbUtPIbzA5luT1V8mO+aJJIKvQsAytKqdpk5
 heUDOKo29tG9p5ZtWsLEk/yIQwt35hnVRD3xgjMYd7n2Y2meP8Pht9OomiQwpj55h2Yo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JI5187A/roVo6JAbOBFXjnebVpVgrehVAoIVRGh0e44=; b=R
 XOYeVRk/pM27oc4UkjA5UtLRiewnMde5kkC/9eJB1ZilpRy3Y0xbyfN7O/Jou41YwmmmA0muYYAKm
 AkKA1dJTPRouXOYf5KhIncb6G+aJM3VlO0r7GRmGAlZnPwLybJ10JJxgl9FW7loNBYKcpbTpYs4Ou
 jMw2UmxkdHCGxodA=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1o3Xeo-0095nz-MQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jun 2022 06:46:39 +0000
Received: by mail-pg1-f172.google.com with SMTP id 184so12236407pga.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Jun 2022 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JI5187A/roVo6JAbOBFXjnebVpVgrehVAoIVRGh0e44=;
 b=FrXBiLnBfk7eFPJKW6Gs5IKtpFdUBAPc6uwr6+eSP2SzABCpb7yrfxCn5YRntMh9Kg
 VfQEb4+xfRce7XuCdKObakYlW9+58/BWhmZEJiaXm/YmvOyhWBCcimbvtzn7ywmmbxBd
 ILgZg1pgFC/WEKM154UsesXVjDBOfvtpZbfdio7UlTYbrchMMh5+nJEkP1WnsXbsrTC/
 SubEcYEBYrTVLvtxUD68hcJeDY7xcvzCZrwng2nBwF2cfzKpyRVACqDaufI3Xd+4v1Ix
 JepineKyh+NyAmKYnxZjL4TWGK7keAwOypf/JfNGGhy1JYSrbS3g8UbvB0GwONwdFBYM
 NjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JI5187A/roVo6JAbOBFXjnebVpVgrehVAoIVRGh0e44=;
 b=aSTE17lo2LyxPkxMAVAwJLP0ZMtIzi5rhA+aWGN82D4GVFFWFgDeGhyeIbSWC4Su0N
 HwbQbe1sX23il2W+nNaQexsKtbpPeY3M/Z4HWcXfKpe2s7QN00FrLuooeG8v5TGHcFgY
 3Zsv2lnmslLfTaKGJk3mL1AsL3SaJ4ZKnD422EQdSsNX+JkO7++GWCz+A48kZomMe/ie
 o3Gu1uTe3Btl5HEBFNjNEBrDwZ2pcHFgUvi28r3T7+YMI2B6Vp0lEZi00m1acqg5DwPW
 b1naa+ClkMbP/4KzmzDRB+bmcSNcq1yhH9ceMdoTlK41o8/Vps75FKJX7tBrQwMRiAGt
 pmQA==
X-Gm-Message-State: AJIora9xWZiWwLGxn7HayQdFf3IGlQJSE6WGKC4Kn4RkkBWYDL7n/xIY
 pEp/trztjXFdSKhFalciJLk=
X-Google-Smtp-Source: AGRyM1sWxhn1YJDFuMUpYnrb9WUa5XI5GyMrWbeFjTWiF4Ic/BDExoj4a5wCCu0/L6ZPm9rIbGYNMQ==
X-Received: by 2002:a05:6a00:410a:b0:51e:6fc6:e4da with SMTP id
 bu10-20020a056a00410a00b0051e6fc6e4damr28721999pfb.84.1655793993060; 
 Mon, 20 Jun 2022 23:46:33 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a170902654a00b0015e8d4eb29csm9709043pln.230.2022.06.20.23.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 23:46:31 -0700 (PDT)
From: Chao Liu <chaoliu719@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 21 Jun 2022 14:42:02 +0800
Message-Id: <20220621064202.1078536-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1o3Xeo-0095nz-MQ
Subject: [f2fs-dev] [PATCH] f2fs: allow compression of files without blocks
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
Cc: Chao Liu <liuchao@coolpad.com>, Wayne Zhang <zhangwen@coolpad.com>,
 Yue Hu <huyue2@coolpad.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Liu <liuchao@coolpad.com>

Files created by truncate have a size but no blocks, so
they can be allowed to enable compression.

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2d1114b0ceef..daaa0dfd2d2e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1879,7 +1879,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		if (iflags & F2FS_COMPR_FL) {
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
-			if (S_ISREG(inode->i_mode) && inode->i_size)
+			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
 				return -EINVAL;
 
 			set_compress_context(inode);
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
