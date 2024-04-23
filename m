Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65464C10F15
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:56:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzP3d-0001Bz-40;
	Tue, 23 Apr 2024 22:56:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1rzP3c-0001Bs-0G
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Apr 2024 22:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1UBrmnaxgdYln7b2mU/BBhde5q/G6uvD2LkDa5Pux+I=; b=Hpb1U0wTIzpFuirMOz37EnsdQe
 6aFunxNqBxvZP5XnavgRNe5oHlFjYVdaZlfqRAo2OCzsm/sMRhnHpkctXQkg2vi1QfMGOmlEQ1UTu
 yDrRyk31yh8yTMSmY9zxE/ddAgBhzSGO97Sig0fvtdw8RnkyijZx5jVrExIfxXGbT2aQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1UBrmnaxgdYln7b2mU/BBhde5q/G6uvD2LkDa5Pux+I=; b=FBnd/DVQMvAXm+E5bjtMH2aMrx
 vOwdVYZhIQtYiYtCq7qbKLOEpHjB2M7ARJjhnXHQ5/oKVFEeQ3fYrPcazWHxzLm4Y6xtLI+c6k8sX
 GUgXQorzdHrSfov6CRJdAycBG+i8OBopiTc2fgBQcZ5R/a0yy9rTb1n3S6+sLQeaScpY=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rzP3a-0007Dq-Vc for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Apr 2024 22:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=1UBrmnaxgdYln7b2mU/BBhde5q/G6uvD2LkDa5Pux+I=; b=FXyig58gEqE0F6D2bAAxl1bEFd
 TbFp9s4R4fwTdL3FoSptQkFN5bTLYpT2jK+iDm6A9Vd2xto13SwNEaT1EwGTWmHY1vfbQefgEJuOR
 b/BHY7oS1QcrvdIAreAEC6wH3j+qFshjaaKAPEK3+Po/R/mODKCCYi59tgvKXJci0zKzuL66k1o8i
 4eYUH1+6nTLEPJc8Yut2z5NOHLc3JqxriqRcbP7ZBOS06YHw0F5qkjuzColyWuGAuOyZbByJWdqHu
 eN0FPCovV+XhG6nor35qADfuyXqAP339rkydvrF9oaJrG+/FwSONIFwhfZ9uaTxpLs0ZwZSOumrKM
 mX1TZc+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rzP3K-0000000HG6I-1wTt;
 Tue, 23 Apr 2024 22:55:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Date: Tue, 23 Apr 2024 23:55:34 +0100
Message-ID: <20240423225552.4113447-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423225552.4113447-1-willy@infradead.org>
References: <20240423225552.4113447-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1rzP3a-0007Dq-Vc
Subject: [f2fs-dev] [PATCH 3/6] memory-failure: Remove calls to
 page_mapping()
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is mostly just inlining page_mapping() into the two callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e065dd9be21e..62aa3db17854 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -216,6 +216,7 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
 
 static int hwpoison_filter_dev(struct page *p)
 {
+	struct folio *folio = page_folio(p);
 	struct address_space *mapping;
 	dev_t dev;
 
@@ -223,7 +224,7 @@ static int hwpoison_filter_dev(struct page *p)
 	    hwpoison_filter_dev_minor == ~0U)
 		return 0;
 
-	mapping = page_mapping(p);
+	mapping = folio_mapping(folio);
 	if (mapping == NULL || mapping->host == NULL)
 		return -EINVAL;
 
@@ -1090,7 +1091,8 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
  */
 static int me_pagecache_dirty(struct page_state *ps, struct page *p)
 {
-	struct address_space *mapping = page_mapping(p);
+	struct folio *folio = page_folio(p);
+	struct address_space *mapping = folio_mapping(folio);
 
 	/* TBD: print more information about the file. */
 	if (mapping) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
