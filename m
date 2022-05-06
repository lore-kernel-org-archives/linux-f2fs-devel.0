Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33B2C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 May 2022 23:20:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nn7Fg-0007zI-Uq; Fri, 06 May 2022 23:20:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nn7Ff-0007zC-C1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 May 2022 23:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z3enMeOy1vKytaaFLS1vtPMycKJAsSbgTOvsZdKCodw=; b=Fh+FaiFJSE8LIDMEw2AoluQtSQ
 HJhdrtjL29c2JyxViicQYbYeTXIuDsTolQP5Obh5O4AVw3sVmtSCOHCXycNzLjspfnr7K4ZCTuXfF
 LNIo5oXLn8AP09kH4sPv0VFDWgKI1gHJgQNbDaUY3gjPm2AUHF4VHPmHCPzfJLTUIJ1s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z3enMeOy1vKytaaFLS1vtPMycKJAsSbgTOvsZdKCodw=; b=VKEqDx3d6JbGZsg/aWpDhiL6Rn
 SxCMVP9Qvrd//0ItdIiE8FvYcErRZtwakaSWwURqxXDSWZSJoEKSKE691MtUDgWxa0xMUnYCsPDrY
 Yr4HAerSx27v8UCyF2C4tEwcSiP2AIMX4P5QnEKAt/+a43gWXrT0KBIcu632Vd/4HwZM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nn7Fd-003dAx-TB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 May 2022 23:20:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 03B92619E3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  6 May 2022 23:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB1C385AE;
 Fri,  6 May 2022 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651879236;
 bh=JhOY5jQYZ0kMCKxk2E2Oa1KKHlQS0zvgZSIVhTOL09Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ox9zIlJQXm+flQVsd5sWotVo8KA1c16jziEiQ7i04XzoSj+iQvtwc5zof32Dpzp9p
 DmVCjpc0I4VO9I7FJlf5tPeG48rxYIjrUADoj1MXMXhrHFQxF1axzToaL/ehWoIemi
 VL9PDIhCkdwsiORKe16vBIC2zQb8w4lkkSPl7PzmSRsrjH8waJneaWBpiu+qHr8v94
 HrDfPC1N1zf+LCrKivpgyI5czb6MceacQB1OfrtZK3DUoY0R5poU1JsRNKZq0TBkjA
 d+PgTouNyCgYsXWlJW4+gfSRm7WsKSVkFrTgcJ/2JcZGNlyB2D60UX6w9wc2jpWP5+
 ZldaQMDCd26tg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri,  6 May 2022 16:20:30 -0700
Message-Id: <20220506232032.1264078-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220506232032.1264078-1-jaegeuk@kernel.org>
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1nn7Fd-003dAx-TB
Subject: [f2fs-dev] [PATCH 3/5] f2fs: keep wait_ms if EAGAIN happens
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_gc thread, let's keep wait_ms when sec_freed was zero.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index aeffcc1d5c02..ec3f6f876e76 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -37,7 +37,8 @@ static int gc_thread_func(void *data)
 	unsigned int wait_ms;
 	struct f2fs_gc_control gc_control = {
 		.victim_segno = NULL_SEGNO,
-		.should_migrate_blocks = false };
+		.should_migrate_blocks = false,
+		.err_gc_skipped = false };
 
 	wait_ms = gc_th->min_sleep_time;
 
@@ -146,7 +147,6 @@ static int gc_thread_func(void *data)
 
 		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
 		gc_control.no_bg_gc = foreground;
-		gc_control.err_gc_skipped = sync_mode;
 
 		/* if return value is not zero, no victim was selected */
 		if (f2fs_gc(sbi, &gc_control))
-- 
2.36.0.512.ge40c2bad7a-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
