Return-Path: <SRS0=a7YV=FL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D34C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 11:00:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13AA2158C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 11:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13AA2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmEFY-0002Dg-Hr; Mon, 07 Dec 2020 11:00:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <liush@allwinnertech.com>) id 1kmEFV-0002Cz-8e
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 11:00:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pQvDsTgLogbhQpnASGAMoKaFIEGjmsxH1nOn7dd7BfY=; b=nSZ3LfU5+WeiORYaQxYb2x9IJS
 c6uYgAab/UEAR3MCdho5srwGaCx6uILLU0B0cgvcgRYJRADF0PY/yRtyeaFZvSjaVJnbtNsgqFC17
 vZqgHM5xYqZjQDr9ag9810SgMkMN+cy5QBWgaqGRebhZMrFf7GvXOe/M9RweQSaaIqaQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pQvDsTgLogbhQpnASGAMoKaFIEGjmsxH1nOn7dd7BfY=; b=G84rERbEAwYPikLDejCxmWDMjx
 kx/0qb2mLkXS7IIncku9QJ6JbUoAEBwJIFvBfzHDwW04lGi8+Y8Va7ANyblA0qe6eCv19NRqCgZz/
 572VeUm5PRVxl5SHs/cE/xhfQmYRzb9AvkoELLrpFPoy04flG/32YZB8PtOp5FpoD/ro=;
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmEFM-001rCw-W7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 11:00:08 +0000
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1358769|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0423175-0.000134208-0.957548;
 FP=14281600786208716458|1|1|4|0|-1|-1|-1; HT=ay29a033018047206;
 MF=liush@allwinnertech.com; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.J47Legk_1607338777; 
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com
 fp:SMTPD_---.J47Legk_1607338777)
 by smtp.aliyun-inc.com(10.147.42.253);
 Mon, 07 Dec 2020 18:59:45 +0800
From: liush <liush@allwinnertech.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  7 Dec 2020 18:59:34 +0800
Message-Id: <1607338774-8541-2-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607338774-8541-1-git-send-email-liush@allwinnertech.com>
References: <1607338774-8541-1-git-send-email-liush@allwinnertech.com>
X-Headers-End: 1kmEFM-001rCw-W7
Subject: [f2fs-dev] [PATCH 2/2] f2fs: don't check PAGE_SIZE again in
 sanity_check_raw_super()
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
Cc: tiny.windzz@gmail.com, Shaohua Liu <liush@allwinnertech.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yangtao Li <tiny.windzz@gmail.com>

Many flash devices read and write a single IO based on a multiple
of 4KB, and we support only 4KB page cache size now.

Since we already check page size in init_f2fs_fs(), so remove page
size check in sanity_check_raw_super().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Shaohua Liu <liush@allwinnertech.com>
---
 fs/f2fs/super.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d3ccf89647df..a39a81ab8dee 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2770,13 +2770,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	/* Currently, support only 4KB page cache size */
-	if (F2FS_BLKSIZE != PAGE_SIZE) {
-		f2fs_info(sbi, "Invalid page_cache_size (%lu), supports only 4KB",
-			  PAGE_SIZE);
-		return -EFSCORRUPTED;
-	}
-
 	/* Currently, support only 4KB block size */
 	blocksize = 1 << le32_to_cpu(raw_super->log_blocksize);
 	if (blocksize != F2FS_BLKSIZE) {
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
