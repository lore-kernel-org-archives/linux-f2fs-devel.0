Return-Path: <SRS0=Klf2=NC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D479C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 13:37:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C2A60FC3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 13:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24C2A60FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mDoQV-0001ZS-SB; Wed, 11 Aug 2021 13:37:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <frank.li@vivo.com>) id 1mDoQU-0001ZL-IX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 13:37:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zlcPRnHZ6BZyWxmBnVq7XrsQKI0MPV06uCFVUZ0+aQ0=; b=krZHketsEg16OmUKtePkXqEut0
 UBlBRcp7t5NLV30v3Vp5+vo87UNk15SCEdvTl+16LjVa2qhJ+tyAkTHrJOXCQJ/ulLBOD2TMN8BzK
 q8zKDAMiQEO61/HwxrRs+cpp2XngSHk9+k6VmbpinDJxG00ZNZ0NAe0A9lPUihnvVqek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zlcPRnHZ6BZyWxmBnVq7XrsQKI0MPV06uCFVUZ0+aQ0=; b=T
 EZPEpDGR0y3stxjLbmBOLOCQ91+ybD0z8GxOfF7qRo1Nw6glvy5dHyqE7sZBCH1dvOFFB1uIxA2ms
 fV+1sepDRPekbyMw6jP2hvEIkz+/FbKEcC3KP/51YCo6Web83rIpywwFlho4GJZ5zQoFxwMpX8UtE
 fKE9xgFVnvakZUMY=;
Received: from mail-m17636.qiye.163.com ([59.111.176.36])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mDoQQ-0007Wd-LI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 13:37:46 +0000
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
 by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 86099C401AF;
 Wed, 11 Aug 2021 21:37:34 +0800 (CST)
From: Yangtao Li <frank.li@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 11 Aug 2021 21:37:33 +0800
Message-Id: <20210811133733.227456-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMaTUxWThpPTxgZTEJDSE
 oYVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDY6UQw*ND9DLSJMSy4RGg00
 Hk4wChJVSlVKTUlDTUNCS05OS0NIVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
 VUpLT1VKQ0NVSk1OWVdZCAFZQUpMQ0M3Bg++
X-HM-Tid: 0a7b356ebbebd996kuws86099c401af
X-Headers-End: 1mDoQQ-0007Wd-LI
Subject: [f2fs-dev] [PATCH v3] f2fs: warn on when fsck flag is set
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
Cc: Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
this flag is set in too many places. For some scenes that are not very
reproducible, adding stack information will help locate the problem.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-Remove extra parentheses
v2:
-Convert to WARN_ON
-One more blank
 fs/f2fs/f2fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 67faa43cc141..0d08e31214a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -33,7 +33,7 @@
 #else
 #define f2fs_bug_on(sbi, condition)					\
 	do {								\
-		if (WARN_ON(condition))					\
+		if (condition)						\
 			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
 	} while (0)
 #endif
@@ -1999,6 +1999,8 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 
 static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
+	WARN_ON(type ==  SBI_NEED_FSCK);
+
 	set_bit(type, &sbi->s_flag);
 }
 
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
