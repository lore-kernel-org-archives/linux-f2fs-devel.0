Return-Path: <SRS0=a7YV=FL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DBAC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 10:58:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62BA20809
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 10:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62BA20809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmEE8-0004Cv-BN; Mon, 07 Dec 2020 10:58:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <liush@allwinnertech.com>) id 1kmEE6-0004Cm-4o
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 10:58:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pQvDsTgLogbhQpnASGAMoKaFIEGjmsxH1nOn7dd7BfY=; b=bmIdws8lKQUaDdDjK3TcT3aFlW
 1PJCJZorkMenJdo/vDQPRhqjXGGJYHCUnssBJ0VQFUBNzmxO53WvE+b49oawXiDtTDj+Eg0MVsFIN
 ISgRYd9IXmukFJCaRfQ+LlEzeLaC5PeO3KHCJKHxfQo9NWPFWfE9EjoLBj6YOFnKJHrY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pQvDsTgLogbhQpnASGAMoKaFIEGjmsxH1nOn7dd7BfY=; b=PCMWGUUkHyTM4kxtL/y1jb/eaK
 6t/ZqbWFLSWSWdd8hbVDFewCpZcbkWroz2rYsT2EEm55p8B/bZXyOHfFhsSQlI/id2JVrc7vPlhMR
 G3mOCc4Kw1qWP3miPXDKb6fcoLXYo99UICwY9ac3brWT3YuFWv89RZQJnn3CsLax7n1Q=;
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmEDt-001r6v-Se
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 10:58:41 +0000
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1358769|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0423175-0.000134208-0.957548;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047193; MF=liush@allwinnertech.com; NM=1;
 PH=DS; RN=7; RT=7; SR=0; TI=SMTPD_---.J48LPz9_1607338688; 
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com
 fp:SMTPD_---.J48LPz9_1607338688)
 by smtp.aliyun-inc.com(10.147.41.143);
 Mon, 07 Dec 2020 18:58:15 +0800
From: liush <liush@allwinnertech.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  7 Dec 2020 18:58:07 +0800
Message-Id: <1607338687-8477-2-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607338687-8477-1-git-send-email-liush@allwinnertech.com>
References: <1607338687-8477-1-git-send-email-liush@allwinnertech.com>
X-Headers-End: 1kmEDt-001r6v-Se
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, Shaohua Liu <liush@allwinnertech.com>,
 iny.windzz@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
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
