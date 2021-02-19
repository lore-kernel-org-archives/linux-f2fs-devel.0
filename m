Return-Path: <SRS0=DB5G=HV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE4DC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Feb 2021 12:46:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0615E64EB8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Feb 2021 12:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0615E64EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lD5BN-0004Mn-Km; Fri, 19 Feb 2021 12:46:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jiahao243@gmail.com>) id 1lD5BL-0004MS-K4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Feb 2021 12:46:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YkZDMVGrlUJLCFKpd9BRaJN7THmPouUukWsL1qSWh00=; b=QD1xyGWaWJ0iExRSYlO/xnamGo
 occy/NvwYwXoSjzE3VSqRoEoFG000revcM6LJrEizPHJ2chg+jY7u/2o0qMQwG4kRIO1vP61NlX2L
 rHZTkjrxzfc5Sn28X8QLicM//pMfKzrbwLPAWq2LxvsyqMJTdGG1ospWXcWpLu2I8J5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YkZDMVGrlUJLCFKpd9BRaJN7THmPouUukWsL1qSWh00=; b=dgSHc+JTBXMiPk3wHnCEB4Bm7i
 BE4LjgnAu8EMtJ+KUbnUyiWKhiQN36Cqkcr8nVU97vMyNmJ5LbjHl3TsvciE1CwrkT5/UNUzg7F/3
 4S6DwqJfS/aFcpiB7bdxqGO/hOHhX1rmhUfkzIuHs8mf6gfkqwXkQdQ6XQrwkTpOvnBI=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lD5BD-0005BL-9O
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Feb 2021 12:46:51 +0000
Received: by mail-pg1-f182.google.com with SMTP id b21so4096505pgk.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 19 Feb 2021 04:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=YkZDMVGrlUJLCFKpd9BRaJN7THmPouUukWsL1qSWh00=;
 b=ZAr00k28nhJo35OjjDhJShjbohzdpQeLWSTOGrHRNT8/3CxJJqVL5TWBe5+LxxS0LV
 Opewj4T+01iFZkuaxfy8bnGlALSkZjq7Sj23KkP4+VNj8KvR36VL1Fn1S8ZP1A6NOctl
 CoAcBTcB4b59frmLLPYoZhzK49LIrEEDLWk7bOV4HJY0hV0dVlys5WrK/sUS88kjtPFS
 A55gi/sLmE75394KRbtgwacw6Ka+XygpY78xmN/GYSqpHwrRuOsmngQjEMHQBX4dzSQ9
 30a9AfD3TJhzRv5Rr0b1vPUSLhbLu8hVqRXk2QTfO/uD/XhfHAGXEQYLAmt7h+E31Q+y
 /d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YkZDMVGrlUJLCFKpd9BRaJN7THmPouUukWsL1qSWh00=;
 b=t+TTg2N5/HNyrCOzu16GvUVyClHBgMFjmWaXRvpylH9j8156Gpajk2SXyfIQ6R6N3c
 57BKY/Jvw1+2rgAfd9SZ7h7aZ5VHcD8zEYtym5Mwgbc4oCoC0etfA/ay+ZZnVMl3eF5D
 d0PQhK9Gy2qOr7jVWiS+uIK3ndxbuMfpT2dTZPgkGt+O96wIxeb4u0P56MOaWJJ8DDSO
 mrw7HaFqbUt+hPmN97UKc8l+qVC2G/KzRHc4MRw1BaF7LKCWucuynK8SkDlLbLmpfVW0
 2LJ42m1qbZ1I2blL4//+smip0yUYT2ALxmdU+5ARMQzKgc2u6NFHcp/eOq/qpjVOzLrV
 nVYQ==
X-Gm-Message-State: AOAM53126tNo8SlMH2ZbQhUPr9KLF2iUi4AteU+6LB/4zxrmwrOzBsTF
 fnWtZU35gX7sAYixIw8NX9A=
X-Google-Smtp-Source: ABdhPJwKBlT5r1XHfPoHONyzJhCpMsOp9bX1SAXFgA8YCTmuMmasE7onpIFI4FG09qLvk02boE/33Q==
X-Received: by 2002:a63:2359:: with SMTP id u25mr8585546pgm.304.1613738797774; 
 Fri, 19 Feb 2021 04:46:37 -0800 (PST)
Received: from localhost ([43.224.245.180])
 by smtp.gmail.com with ESMTPSA id v185sm9558088pfb.125.2021.02.19.04.46.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Feb 2021 04:46:37 -0800 (PST)
From: jiahao <jiahao243@gmail.com>
X-Google-Original-From: jiahao <jiahao@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	jiahao@xiaomi.com
Date: Fri, 19 Feb 2021 20:46:32 +0800
Message-Id: <1613738792-14778-1-git-send-email-jiahao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
X-Headers-End: 1lD5BD-0005BL-9O
Subject: [f2fs-dev] [PATCH] f2fs/checkpoint: fix a spacing coding style
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add a space before the plus.

Signed-off-by: jiahao <jiahao@xiaomi.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 897edb7..26dbefd 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1456,7 +1456,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			orphan_blocks);
 
 	if (__remain_node_summaries(cpc->reason))
-		ckpt->cp_pack_total_block_count = cpu_to_le32(F2FS_CP_PACKS+
+		ckpt->cp_pack_total_block_count = cpu_to_le32(F2FS_CP_PACKS +
 				cp_payload_blks + data_sum_blocks +
 				orphan_blocks + NR_CURSEG_NODE_TYPE);
 	else
-- 
2.7.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
