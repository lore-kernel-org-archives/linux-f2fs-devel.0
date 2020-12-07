Return-Path: <SRS0=a7YV=FL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C43C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 10:58:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856A720809
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 10:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856A720809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmEEB-0000bz-Gk; Mon, 07 Dec 2020 10:58:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <liush@allwinnertech.com>) id 1kmEE6-0000bj-4g
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 10:58:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hghRK4yd8P4g5MPg2/zet41UQzFNslY+xZNfQc0jv6k=; b=PSf/2rDwsOXzChmMtHSkr5xj6O
 y3vpuDHfNtFduj8Y+iY/nkqPUzIl8j7iFEAw0z0yJLVsta0+UlvKPRaSKJibniskD4/8l84hqXeGJ
 bP5ZH5NrUOnQttwiEXwrJqdcqXAD5Gp7nSEDT4ZoBr26vXBu754Z6jZhnPuo9tQfBNsQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hghRK4yd8P4g5MPg2/zet41UQzFNslY+xZNfQc0jv6k=; b=KLPHFHLjtfUwTg4SQFjqMPEyHr
 ipA6OKSdDGgfNEnJxQ7zML5koA4V5UG8ELgZGEV0gA/8giKiGyqiIXRLHMF7WyJkDSU6RhLwVOQVS
 MQ8K9vg3+poocauybtpQJQtiPdfunuWYrAWozL+ovgn0lfo28WNjS6g0r66VRZBPBiwg=;
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmEDt-001r6F-Fc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 10:58:41 +0000
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2116129|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0159781-0.000759197-0.983263;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047192; MF=liush@allwinnertech.com; NM=1;
 PH=DS; RN=7; RT=7; SR=0; TI=SMTPD_---.J48LPz9_1607338688; 
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com
 fp:SMTPD_---.J48LPz9_1607338688)
 by smtp.aliyun-inc.com(10.147.41.143);
 Mon, 07 Dec 2020 18:58:12 +0800
From: liush <liush@allwinnertech.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  7 Dec 2020 18:58:06 +0800
Message-Id: <1607338687-8477-1-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
X-Headers-End: 1kmEDt-001r6F-Fc
Subject: [f2fs-dev] [PATCH 1/2] f2fs: convert to F2FS_*_INO macro
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

Use F2FS_ROOT_INO, F2FS_NODE_INO and F2FS_META_INO macro
for better code readability.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Shaohua Liu <liush@allwinnertech.com>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 00eff2f51807..d3ccf89647df 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3071,9 +3071,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->total_node_count =
 		(le32_to_cpu(raw_super->segment_count_nat) / 2)
 			* sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
-	sbi->root_ino_num = le32_to_cpu(raw_super->root_ino);
-	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
-	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
+	F2FS_ROOT_INO(sbi) = le32_to_cpu(raw_super->root_ino);
+	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
+	F2FS_META_INO(sbi) = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
 	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
