Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C56AC02198
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2025 05:52:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tkGWr-0004td-E6;
	Tue, 18 Feb 2025 05:52:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tkGWl-0004sR-MQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pHzKHgnEZ5wurt4F+CEwoehnkRhO3SEQQCdj/YohkHg=; b=g2ctrRoYfCd+3gIdYeuk5fUO5a
 x0KRoIpHKw0prBgOjNTnkGc5S2Q/odBQsPGbPnE34vwcA4Ic1+oxoifx9hY+1Vp3SXq9cNm0Z4FDj
 3Xrrg4vf+V2K6rPOGPBLTbdMH2g/L+vI0JufKNzyrd/kQNci/6KhNTLdpW30rvyxpsfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pHzKHgnEZ5wurt4F+CEwoehnkRhO3SEQQCdj/YohkHg=; b=LwPF9m5+P/Wo1qquwn2kpyE5XH
 WkVASunuiTZD/aTvtz4uWIycw2qvdqT8Ev5lgczc78HERnyWVq2UE7g7nz6KhyW7SGz9Trdv5+E0e
 xqUsOhsOTY90fVxqBydYQul8AajB/aP1OV90Tk1X3fE0hk2f948nNbEJRd6t1uzBHoBk=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tkGWl-0007bs-I2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=pHzKHgnEZ5wurt4F+CEwoehnkRhO3SEQQCdj/YohkHg=; b=AlVHj72nKrmlohCoQ8noasm5ku
 eFq23dqQHM9xL+nHpLK4vFOkRxjGMopomGKg7ryyTanrrQgjvXv9LJg40WqELhJgKmei03KALucy6
 XQCuJJlk3c6p1BaUBv0g0wIEZD8Pnnta26YMtAqDh+MA3j1hYpKbdFxXfKSLAk+eAPdBuVwUr2WLb
 PbLRIl2d2ByWqCWAu/O4Ecb/n1gXJ8xXYlVW+d3/H80cg29SfAcjBr4kSpkR6EpWVNXR13Bst8eFK
 O0u/HIslyo3vOspFcDrtD5tUat2rcbrxqKnTekILxosKV+74p5xD3KdxZCfzCuAA/zK46KsrroskB
 7Bv/jiFw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tkGWf-00000002Tu1-17tH; Tue, 18 Feb 2025 05:52:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 18 Feb 2025 05:52:01 +0000
Message-ID: <20250218055203.591403-28-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tkGWl-0007bs-I2
Subject: [f2fs-dev] [PATCH 27/27] mm: Remove wait_on_page_locked()
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

This compatibility wrapper has no callers left, so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 5 -----
 mm/filemap.c            | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 45817e2106ee..b8c6fa320ee3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1242,11 +1242,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 	return folio_wait_bit_killable(folio, PG_locked);
 }
 
-static inline void wait_on_page_locked(struct page *page)
-{
-	folio_wait_locked(page_folio(page));
-}
-
 void folio_end_read(struct folio *folio, bool success);
 void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index c8fd285c4287..70d0b579cdad 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1380,7 +1380,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * @ptl: already locked ptl. This function will drop the lock.
  *
  * Wait for a migration entry referencing the given page to be removed. This is
- * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
+ * equivalent to folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE) except
  * this can be called without taking a reference on the page. Instead this
  * should be called while holding the ptl for the migration entry referencing
  * the page.
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
