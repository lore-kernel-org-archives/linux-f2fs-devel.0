Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8930DC43334
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jun 2022 22:31:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o2KV8-0001WD-GH; Fri, 17 Jun 2022 22:31:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1o2KV6-0001W1-Fw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jun 2022 22:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g6jDrd/6P/XcaDPAT2QLNOvaLy3WnE7N8GNIORYt2rE=; b=fb51ji+Svcf8EGhda55ANa1lBS
 0RDRP7IyTQmacX7gPUBcq2AR1bd75tcOwMenmkZKOg33j00KW+jkiGE8jnm+zO+WGcDlq0uBHMooJ
 kGvB7LLNPv869ukz/la2rUcNP8HbUrO3tJ6VLTBOYDJt22R27yunIqYwmVjWY9B32NUc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g6jDrd/6P/XcaDPAT2QLNOvaLy3WnE7N8GNIORYt2rE=; b=Ypbr1lQTMNINzlU+fI92a1idXJ
 uxRWWExnE4Pre+ruwl8HSfRiTd/QtZw2czOK4JuPpEqtZ9Z20jMxm6+jQdcAqfcKrgMPyix+SPAlB
 Cgw2Tim2OnSCMi8faqfaeGOeboW+i5nglcgSAUJNNKmr9Os26TInDmZwpAO1u2LWVg8o=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o2KV4-0005Vg-Rv
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jun 2022 22:31:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 360BA60F43
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 Jun 2022 22:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7747BC3411D;
 Fri, 17 Jun 2022 22:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655505088;
 bh=5Fok1MzW22buXw55Kbx09DXpCWfLARQYnQkHsxPjVgU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RIXPSr8/QcfEZ1emcqB4Hnk6NDOOenE6LPPApd5hObqqpIADJnvMH4tbKGbfYSbS5
 2yJ82RFPDkY7CayPZaf/mGleS7xkj8Yrv726HU+vG/yoOqJgaIsgkENBahhMcAYAqf
 qKDFP6CdZjJBKOAQAlUkKzIIozRRu/bn1GfuHJx/DohDdltCVgCgg7BDxUPRLAaaF4
 LBhxTH55RjNFNXHSAoqM9zW8BKUcFpfZx6w8dnh7jTEo7+Ncakn531PCa75p5Bp8Bk
 sXydQ9Q1Nwvx8BlouFOp5S0DTTrStzbXbeaR0sYUbuTKxzLu8qb5du9GvoK2JFapam
 oRqm1qNFx1/gg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 17 Jun 2022 15:31:06 -0700
Message-Id: <20220617223106.3517374-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220617223106.3517374-1-jaegeuk@kernel.org>
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1o2KV4-0005Vg-Rv
Subject: [f2fs-dev] [PATCH 3/3] f2fs: do not skip updating inode when
 retrying to flush node page
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

Let's try to flush dirty inode again to improve subtle i_blocks mismatch.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 836c79a20afc..4181d03a7ef7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1943,7 +1943,6 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
-			bool may_dirty = true;
 
 			/* give a priority to WB_SYNC threads */
 			if (atomic_read(&sbi->wb_sync_req[NODE]) &&
@@ -1996,11 +1995,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			}
 
 			/* flush dirty inode */
-			if (IS_INODE(page) && may_dirty) {
-				may_dirty = false;
-				if (flush_dirty_inode(page))
-					goto lock_node;
-			}
+			if (IS_INODE(page) && flush_dirty_inode(page))
+				goto lock_node;
 write_node:
 			f2fs_wait_on_page_writeback(page, NODE, true, true);
 
-- 
2.36.1.476.g0c4daa206d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
