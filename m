Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC98BC369BD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVv-000412-Fh;
	Mon, 31 Mar 2025 20:13:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVg-0003qW-Uk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RcONFj685gQdBmLQsjxfJ3ZBYOYMauMfkqPbdtfEV7U=; b=bX3c4kbnGYp9gke9h6RxCxtbWK
 T9hpNsKblh/QCHokBh0AD9Z9ioB37mOuM44IPaepinjztoU+T6MQnE1Qemh5dzgcCYP+gSttanIW/
 aAjk5bKYTpTkq13q4zVisaQyFGeDPbtXqr3EsNUQQ038w/BrI+kDW+ST+UT7nNIwyv+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RcONFj685gQdBmLQsjxfJ3ZBYOYMauMfkqPbdtfEV7U=; b=letHFiwUCDdy9hIPCTdvxSzpZC
 zBPQRCiAKrj6kWfqZmzVD0v8uQgwxGt39lPP1Tr24f8V7Ntd51mIuantaES6GqVUlUIYyp5fNwluT
 nGmAC1a8ZLV0nPV3a/yK5qEymtuFnnDOUjmtmduM0AfpbY3JKY3ruTnrgO2sCOfygeH0=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVb-0003bo-65 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=RcONFj685gQdBmLQsjxfJ3ZBYOYMauMfkqPbdtfEV7U=; b=W5YcLDiNjflh0qJ8pU6UkTVpSC
 zGAOMBURERCS3qMbfZTF37lB/uU9lGhfoDUN9OPge/wyHSSDoxEmHYoKeuDOUO2tfft2limjIAe1f
 ds2NKb7XsdF1LZXyC0G9acw0YaUYd8cHIf3famVHFIrfLIX9jfQ5Y7DcJIzcNktOmvyt5lk7M/4V4
 Em+1smWMYa7wgBZ+BqSk0/PII0ljpXfyDJBfzIQczZ/pmb/k3FHzVuW8VX44ut4sMy2Ff9XWdXNqJ
 NeOKAgHMk1s7tccOTYEZYfU2dZYtm7ndgBHt5pfv4d7K22HxQfktVKy3TdtgqtMY8H2XBbnJ+PolP
 mbf+IjRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVP-00000004Rt3-2h0W;
 Mon, 31 Mar 2025 20:13:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:29 +0100
Message-ID: <20250331201256.1057782-70-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVb-0003bo-65
Subject: [f2fs-dev] [PATCH 069/153] f2fs: Remove f2fs_grab_cache_page()
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

All callers have now been converted to f2fs_grab_cache_folio() so
we can remove this wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d975d7f7d269..a32ac1ecb61c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2849,16 +2849,6 @@ static inline struct folio *f2fs_grab_cache_folio(struct address_space *mapping,
 	return folio;
 }
 
-static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
-						pgoff_t index, bool for_write)
-{
-	struct folio *folio = f2fs_grab_cache_folio(mapping, index, for_write);
-
-	if (IS_ERR(folio))
-		return NULL;
-	return &folio->page;
-}
-
 static inline struct page *f2fs_pagecache_get_page(
 				struct address_space *mapping, pgoff_t index,
 				fgf_t fgp_flags, gfp_t gfp_mask)
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
