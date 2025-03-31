Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914C7C369AD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVi-0005ef-PC;
	Mon, 31 Mar 2025 20:13:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVZ-0005aT-Un
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5veWta8fA/pqCSJ1vQ+k8cHHJnfpWUs+SBO9BNqoFGE=; b=hRpDpeDWKDsbtsl5nF5N8ydPo+
 /kCYZIagI7ieodb6NOyiZ9JvrvrIzVoZ4X9H/RSZqRkI7pTdMU0z1MtLINPE8V6ct+YMX87S9tdTa
 Hdm+DXJG1HwVPp6pqvEnUDhmW8GiVQi2cStISpzO2E699Ppz/nB3ZDmOkD7hIO8Lyk/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5veWta8fA/pqCSJ1vQ+k8cHHJnfpWUs+SBO9BNqoFGE=; b=Tl9nQ88sFGZoB7eR2CMJrzbibL
 hpAg5y67W9qMQvkjFwrEUu3K4Q8X3kEMmqbis2IymAa87XBhOtyELpU8KTaVDEmnWeeAQwKjIB0XW
 8aVFu3GzaBQM/RMxo73Ux8lPx9lHEG7nV2wu9fl+W6XyfjA7lXJeUTK+CmYe4dk3vF+E=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVT-0003ZP-Pe for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=5veWta8fA/pqCSJ1vQ+k8cHHJnfpWUs+SBO9BNqoFGE=; b=IrE5e0LK50arYPRuLMzJKznG5k
 j4BAXcXyaSsTwJN5Hu46sbPB9jtiVmEuJDjLZYc4DndIDXhmLCnRLuMCXIeodgqlZtv87/3k6Ink6
 Fe9o0f8umpveAFAOoeqShc8EeceMWXXKpodoVttGh/JtfQqBUvC5VJf7zOms1GzSF7zl75g0A4lYs
 KtW0rdOZGHoflGNMTD0Xnsfh34w5t2GLzKCpFxfDtzU/X70QXmcCad0TCzg3E1wlZKG+ySvFU8f13
 3OeCdxD4/NMHrIX6l2oOE0DMbs8IvBhTQcoUi66Bif0jjuGe0k/6z2v2PhH1yYeByV2P1w7mn+rfB
 qEvhtW2w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVI-00000004RZz-1mFz;
 Mon, 31 Mar 2025 20:13:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:10:44 +0100
Message-ID: <20250331201256.1057782-25-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVT-0003ZP-Pe
Subject: [f2fs-dev] [PATCH 024/153] f2fs: Use a folio in
 write_current_sum_page()
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Grab a folio instead of a page.  Saves two hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/segment.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 41b9a69c995c..3e6acb9ab610 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2704,11 +2704,11 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
 						int type, block_t blk_addr)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
+	struct folio *folio = f2fs_grab_meta_folio(sbi, blk_addr);
 	struct f2fs_summary_block *src = curseg->sum_blk;
 	struct f2fs_summary_block *dst;
 
-	dst = (struct f2fs_summary_block *)page_address(page);
+	dst = folio_address(folio);
 	memset(dst, 0, PAGE_SIZE);
 
 	mutex_lock(&curseg->curseg_mutex);
@@ -2722,8 +2722,8 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
 
 	mutex_unlock(&curseg->curseg_mutex);
 
-	set_page_dirty(page);
-	f2fs_put_page(page, 1);
+	folio_mark_dirty(folio);
+	f2fs_folio_put(folio, true);
 }
 
 static int is_next_segment_free(struct f2fs_sb_info *sbi,
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
