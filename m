Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0ABC3DA63
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:19:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sWfe3-0000qC-Bo;
	Wed, 24 Jul 2024 17:19:19 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <n.zhandarovich@fintech.ru>) id 1sWfe1-0000q5-Op
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jul 2024 17:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U9ly8I5/I3GWMuVwLZ1H/RN9JgTLhEc/iauMR2BOiCo=; b=A6f8BpmhoDX2ObWCvn6y6asKDf
 JGiyWFquPihMwWyzbwedkxNUBEkfDLUV7KfZi6dwZ30bNiEDasFJGEs2V7ERsqMWH+ANxfbFr9nXB
 /CwaVQ8OmZb5ny0uiOfZxG61mzTC+TEjTRI42ffpFhC6FPeNMEZRwkBwpKayeuYFDwkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U9ly8I5/I3GWMuVwLZ1H/RN9JgTLhEc/iauMR2BOiCo=; b=Q
 EW4WYHB/AztssEoBMPamloWN3E8KZ8wvgd0J496XZr0PhfA34SAbQQFGjUAKZBHQefywgVUv+y5C1
 K6vEvOg3d82N9hTChK/zpYF5IbC9heGAWpUmw5jeX6kkvX2YXXK2ispGj2Yf4kaGxZLTxYsne/nXZ
 kIi344kQ2GkoGSh4=;
Received: from exchange.fintech.ru ([195.54.195.159])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.95) id 1sWfe0-0004PQ-0L
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jul 2024 17:19:17 +0000
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Jul
 2024 20:05:49 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 24 Jul
 2024 20:05:48 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Date: Wed, 24 Jul 2024 10:05:44 -0700
Message-ID: <20240724170544.11372-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Headers-End: 1sWfe0-0004PQ-0L
Subject: [f2fs-dev] [PATCH] f2fs: prevent possible int overflow in
 dir_block_index()
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
Cc: lvc-project@linuxtesting.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The result of multiplication between values derived from functions
dir_buckets() and bucket_blocks() *could* technically reach
2^30 * 2^2 = 2^32.

While unlikely to happen, it is prudent to ensure that it will not
lead to integer overflow. Thus, use mul_u32_u32() as it's more
appropriate to mitigate the issue.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 3843154598a0 ("f2fs: introduce large directory support")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 fs/f2fs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index cbd7a5e96a37..14900ca8a9ff 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -166,7 +166,8 @@ static unsigned long dir_block_index(unsigned int level,
 	unsigned long bidx = 0;
 
 	for (i = 0; i < level; i++)
-		bidx += dir_buckets(i, dir_level) * bucket_blocks(i);
+		bidx += mul_u32_u32(dir_buckets(i, dir_level),
+				    bucket_blocks(i));
 	bidx += idx * bucket_blocks(level);
 	return bidx;
 }


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
