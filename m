Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C774FC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Mar 2022 22:18:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1na37P-0000vt-MU; Thu, 31 Mar 2022 22:18:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jakobkoschel@gmail.com>) id 1na37O-0000vm-2j
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Mar 2022 22:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2jJFh1buoTrN7HCc8BP6Skb98M8mOsri89QUbsb7tYY=; b=ZFGgLKbgnAAXp/1C9PAg2dwsm8
 kkFBrL8qC/JuzSZEVd28yOIIs0031y80JBiYP21MvZyNhkr/GiqeoYQx3KWKnME96SQ5avZJbQM3i
 T1xYg6Sgml49HJttHA50ImWjjf1aQgTK2wEvaLpUWDlmchyI2l3yHaIoGkZ2rlOEoXSQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2jJFh1buoTrN7HCc8BP6Skb98M8mOsri89QUbsb7tYY=; b=QD203AGt09yMMVWeremRTiSKsh
 9qAWPP5TVrZ8qvY/SsxY6ftsGvLhcxpyoxoGFTktZDfxMCNUUdjmbs+Ea8iviu5w8m8H+tKnWjflj
 Qvc8VsSUmJxblzahBUWoUhjKpt/sslTY8/b3ojBLr7Tz47fCWNkd05wSvkpDdNZx3U+g=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1na37J-0015Be-6t
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Mar 2022 22:18:12 +0000
Received: by mail-ej1-f42.google.com with SMTP id bh17so2125603ejb.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 31 Mar 2022 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2jJFh1buoTrN7HCc8BP6Skb98M8mOsri89QUbsb7tYY=;
 b=Ixa7hGhXAGxFtykB67HssQqapnD1Yx3POmhLjco4cuYfv4vHLHz4EF5zJEwqDbx0yO
 O6mRvWv+KlW8w04BK3AoeT1Qu3x96ptadpmzu4vMkKRQjLKBT19oSYISeYxroZ1JLYuy
 5qX3ZuEJ95RlXGSiYkca3n1K1L3sB9DvpmAHk98tlTSH5c0Xdk3nGDNYkffG12STt7JS
 wIM3e9jDLwxk0OaL94fgcDaFKRV5RqbIdj+uu48EqGU1IjGVK+qZKeIHYfjzZeIvo70j
 KCIi+nxUDZM8BUXLvxog5KbWIEuMKf6Qx2jABu/0s9nT7554KiXw6pXjEUsrbl93fM/b
 +6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2jJFh1buoTrN7HCc8BP6Skb98M8mOsri89QUbsb7tYY=;
 b=DOZ0qGsN/gH9CVjDKdqrkmMU6JlAg8j39FXHT49rHsr2LNJpHpNSHFFad7ULXeVHyV
 Mf8G2a1O6qZDcYRp7zelV5mQ0zdWRLZNoVX7mzUH3VrVSp7cFAz1W6aCrbbznm6F/vKi
 c98EvddjnJ3o1IGtLsacE2ACeEivwb16DBR45ypxeOp8uQ+K0pVWgoJdvlicko25C84J
 vA3AoQmdpXkt3AFeUya3i/3ZcBePebeLMQ4+29ehiCExlEQiqVJO2wm3nOoGLf6Ktnix
 n0/R6PAsVU5UnOVmssKefga82tL0bSiBsixdJyTQY5fu1pFZCZmkWxdB9J6lbCH778yo
 dV1w==
X-Gm-Message-State: AOAM533EHj11FX+dVkJgOgtYkCWszu0FU8fBvPM3rkLfdQ8jpeVAuxbu
 hsAab+w7qZMCO2ctQMC/QbU=
X-Google-Smtp-Source: ABdhPJzLAwy79KbD01epwHmvEIt2rFEG3KCTwcXepBTllkd7x5vQlWrXKKh2i8tAhccl+KTU/UkV3Q==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id
 z14-20020a170906434e00b006d0ed9c68bcmr6663371ejm.70.1648765082818; 
 Thu, 31 Mar 2022 15:18:02 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl.
 [62.195.130.160]) by smtp.googlemail.com with ESMTPSA id
 c4-20020a170906340400b006d077e850b5sm267295ejb.23.2022.03.31.15.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 15:18:02 -0700 (PDT)
From: Jakob Koschel <jakobkoschel@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri,  1 Apr 2022 00:16:50 +0200
Message-Id: <20220331221650.891790-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331221650.891790-1-jakobkoschel@gmail.com>
References: <20220331221650.891790-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1na37J-0015Be-6t
Subject: [f2fs-dev] [PATCH 2/2] f2fs: replace usage of found with dedicated
 list iterator variable
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
Cc: linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Cristiano Giuffrida <c.giuffrida@vu.nl>,
 Jakob Koschel <jakobkoschel@gmail.com>, linux-f2fs-devel@lists.sourceforge.net,
 Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/f2fs/segment.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 81ef2c3d08e5..037164bf40a6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1666,33 +1666,32 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
-	struct discard_cmd *dc, *tmp;
-	bool need_wait;
+	struct discard_cmd *dc = NULL, *iter, *tmp;
 	unsigned int trimmed = 0;
 
 next:
-	need_wait = false;
+	dc = NULL;
 
 	mutex_lock(&dcc->cmd_lock);
-	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		if (dc->lstart + dc->len <= start || end <= dc->lstart)
+	list_for_each_entry_safe(iter, tmp, wait_list, list) {
+		if (iter->lstart + iter->len <= start || end <= iter->lstart)
 			continue;
-		if (dc->len < dpolicy->granularity)
+		if (iter->len < dpolicy->granularity)
 			continue;
-		if (dc->state == D_DONE && !dc->ref) {
-			wait_for_completion_io(&dc->wait);
-			if (!dc->error)
-				trimmed += dc->len;
-			__remove_discard_cmd(sbi, dc);
+		if (iter->state == D_DONE && !iter->ref) {
+			wait_for_completion_io(&iter->wait);
+			if (!iter->error)
+				trimmed += iter->len;
+			__remove_discard_cmd(sbi, iter);
 		} else {
-			dc->ref++;
-			need_wait = true;
+			iter->ref++;
+			dc = iter;
 			break;
 		}
 	}
 	mutex_unlock(&dcc->cmd_lock);
 
-	if (need_wait) {
+	if (dc) {
 		trimmed += __wait_one_discard_bio(sbi, dc);
 		goto next;
 	}
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
