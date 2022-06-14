Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A4C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jun 2022 23:18:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1FnL-0006ep-Re; Tue, 14 Jun 2022 23:18:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1o1FnK-0006ei-8f
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jun 2022 23:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=olGZo4G5qWhNx4sOgVQ6big/g5gyvMiHwloMnqfNjEA=; b=b0HdBNp+y2znP56cwV8ZhLzpG7
 8Yo2O5vHhQgMB/g3AQ5l4n12GwOldqVq7dNgarhaaeZ8Zm7cjp8SMnDkiDDDe8xrQAyKJcWEjDOX5
 7TpnF1YRwhD98WemWLh637u26CMzyZIyHISC7Z0LJux/iAiXpT0O95B8uA2sJ9i6jnqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=olGZo4G5qWhNx4sOgVQ6big/g5gyvMiHwloMnqfNjEA=; b=YGCFGnpoiu+2pqHw4SZySWTFb5
 W78LzUOYqbjxYWQU2jNi+24+DJKJSMfpbqb+EN5oD1+mkmp/p+piu5q6WcPtKtx3iuSmOTjhyyjax
 dhevh0xaGW74kbduTzIaXR7DZJKHycuWsaRkdcmpINFzcIfePTSXxLyQ9DMiYotAeehU=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1o1FnE-0006LJ-Tk
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jun 2022 23:17:58 +0000
Received: by mail-pg1-f170.google.com with SMTP id s135so9821514pgs.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Jun 2022 16:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=olGZo4G5qWhNx4sOgVQ6big/g5gyvMiHwloMnqfNjEA=;
 b=VJBdz378uvhP8BmbxxbXoMQORffntTzEEdpl6AaGrmsYLW3llqnMj/CTETkNhlqUWy
 Wxp7RO3kwqsYI+NyVczp4K/QftGI4bwdiuqYB5PX5bYxpbiYoVBYYzTMUlRoNY0FYgfY
 JO/+tk+M9SXCMBObZI5tTonSG1xOhC67KZ8+gakUTwXioiX7py1bzumuCnD2rP5D9ge8
 EGADZsmSExwqGQc/No7X0W1soubnwuudDqM1DmwXRDnZuit+/+dddJtKGMAPEIGg6/W0
 eUtkdAisGe+6jiKm2AnpXHV1KZ8hdmO6SD0w8vKXQDpL3Tq80PLuyYE6zMdhqNZ6nx0g
 KpMQ==
X-Gm-Message-State: AOAM531jN47KEBs6CekDjw16M2R7PDO99pd4RJ0mtytCkTC+nA71CZcH
 VEdolAwCwgpBFU0IjlkpEJg=
X-Google-Smtp-Source: ABdhPJxkPD/FcYN7tDsVOazsoyZQsRAjgVr3L/Pbg32jmhst16kEg2waI7UYdt6j00DtnHFgIQR4WQ==
X-Received: by 2002:a63:5412:0:b0:408:84a9:9562 with SMTP id
 i18-20020a635412000000b0040884a99562mr6560173pgb.600.1655248668596; 
 Tue, 14 Jun 2022 16:17:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a1709028ec200b001621ce92196sm7769491plo.86.2022.06.14.16.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jun 2022 16:17:47 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 14 Jun 2022 16:17:23 -0700
Message-Id: <20220614231724.776264-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614231724.776264-1-bvanassche@acm.org>
References: <20220614231724.776264-1-bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1o1FnE-0006LJ-Tk
Subject: [f2fs-dev] [PATCH 2/3] Fix f2fs_report_zone()
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
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The definition of struct blk_zone_report is as follows:

	struct blk_zone_report {
		__u64		sector;
		__u32		nr_zones;
		__u32		flags;
		struct blk_zone zones[0];
	};

Since f2fs_report_zone() allocates the above data structure with
malloc() and since f2fs_report_zone() only initializes the sector and
nr_zones members, the flags member is not initialized. Modify
f2fs_report_zone() such that 0 is passed as flags to the
BLKREPORTZONE ioctl instead of a random value. This has been
discovered by reading the source code.

Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 6d7c7b785feb ("libf2fs_zoned: Introduce f2fs_report_zone() helper function")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 lib/libf2fs_zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index f383ce275342..d8de66b82029 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -206,7 +206,8 @@ int f2fs_report_zone(int i, uint64_t sector, void *blkzone)
 	struct blk_zone_report *rep;
 	int ret = -1;
 
-	rep = malloc(sizeof(struct blk_zone_report) + sizeof(struct blk_zone));
+	rep = calloc(1, sizeof(struct blk_zone_report) +
+		     sizeof(struct blk_zone));
 	if (!rep) {
 		ERR_MSG("No memory for report zones\n");
 		return -ENOMEM;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
