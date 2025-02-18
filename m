Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F98C021A9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2025 05:52:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tkGWn-0004sZ-Ak;
	Tue, 18 Feb 2025 05:52:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tkGWk-0004s9-F9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Syw2hpXqanXPir38dFqOWLHHdVuEk3K5wwtxHpZ/n4=; b=cpv00sYKSugpMGmpz12MEkHJPn
 7o8OCGY1YizEHDzfma7Re7w5ShcWY0FO9kuqpBTV3HTnWEuzm7LARypgsB0tfU+cRdutecrKvlLYa
 TBAAquCZaajnKTM3UwGvuYWHC9ffhko1Ev9bVe5YOrqZv6itblTtkqnuc/jt0iQITtVE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+Syw2hpXqanXPir38dFqOWLHHdVuEk3K5wwtxHpZ/n4=; b=FIGwS5R2MRtvF/y4/jzsp41fjE
 tOQH283HBtH6qkB+FsCjj0nN4IvYpjRM3LEORe+cHaRi8o2s5MI/Q9W8h/SeyvrM4lVAWBG6y5pxF
 g782tFg6+CvOqIsczmKextOpaa1QaNI2z5kYbApG62btdT86Ra/D+FDLhBHRKHBWWLG8=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tkGWj-0007bT-C0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=+Syw2hpXqanXPir38dFqOWLHHdVuEk3K5wwtxHpZ/n4=; b=WctRG+C4lsUZm+Zrddr4t3s0gi
 of/RkQflhhZ8vazQsxlQW3tw+X2p1IBuoiljtcJXf2c1FwKu4ew7MY8aMX/0UZbzwRgDvj3WARn01
 q+PLjAelPSitbzHTrPcY5Xp6emsgV3zXBeK0vMv953eb+0hD3ZzoRrZ2jZf2eMpVf0CeOCwFn1FML
 i+y2dtv8lCfKsXGJGEDQ5+8fmk3GwlKObGXrVxrohJCP2mZKmgO7wFtom0ascQwPjDsYyLc+QlULT
 CaGvwklCWYz78eFU2d6cbojv5tpKcZomUGxwNjIildopRHoHfuUQwYLGMZSgUKOxrb6VU7Ze8gFcg
 1aHC1yxA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tkGWc-00000002Ts5-3AXx; Tue, 18 Feb 2025 05:52:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 18 Feb 2025 05:51:45 +0000
Message-ID: <20250218055203.591403-12-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tkGWj-0007bT-C0
Subject: [f2fs-dev] [PATCH 11/27] mm: Remove grab_cache_page_write_begin()
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
Cc: linux-fsdevel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

All callers have now been converted to use folios, so remove this
compatibility wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 3 ---
 mm/folio-compat.c       | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a19d8e334194..45817e2106ee 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -990,9 +990,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 
-struct page *grab_cache_page_write_begin(struct address_space *mapping,
-			pgoff_t index);
-
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 5766d135af1e..45540942d148 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -84,11 +84,3 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	return folio_file_page(folio, index);
 }
 EXPORT_SYMBOL(pagecache_get_page);
-
-struct page *grab_cache_page_write_begin(struct address_space *mapping,
-					pgoff_t index)
-{
-	return pagecache_get_page(mapping, index, FGP_WRITEBEGIN,
-			mapping_gfp_mask(mapping));
-}
-EXPORT_SYMBOL(grab_cache_page_write_begin);
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
