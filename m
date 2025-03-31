Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C66C3601C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVY-0005a4-Nw;
	Mon, 31 Mar 2025 20:13:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVS-0005ZB-Hj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DYU/MSaj6EPyYYdyeu/xQyh9xhs9afR0e3OYf4+VkeI=; b=m2Si54LnqBeKC+kQFavUoYks5U
 K7HzMTAYWg1+h3d14r/NQ/drqr1uENyX8oBPhwpNg/jtcWb83IVEQon4EZHOOs65IvMn+22fjZ2QW
 VzDd/YVJd8mI3ZGDTycQfPnGdDh7zLiTz5xfSvgU3F1V+b/6Xc6mpYZaZqBSX4HSDM7g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DYU/MSaj6EPyYYdyeu/xQyh9xhs9afR0e3OYf4+VkeI=; b=mS02mmtQryIVBjELn1PsQHGK8K
 wMWFQh4e1DE8FEkVKRqE49RXEKTa9fVAsm9EtT+A1MCAka4Hh76ra3EKgv5mpE6mWTWZoXgvr/KgU
 D89PybAxkWrwKwHl82f2DTSg2kIKBcMusxVZBdDcFo+yFCPa1JLfD9120bOk0L3/MTFo=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVM-0003Xz-A6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=DYU/MSaj6EPyYYdyeu/xQyh9xhs9afR0e3OYf4+VkeI=; b=V8TIbEB/iqPen2tGpgo9t2QsQW
 dlpi/zWhRivaX5oBdTNY/05PyxyMP8G7BPHyLxLMtDcEjDedpE9Rdeip7RozR/dnUXYthVjkMGUdF
 5IIM4Tf9I/XzBpAaLsZ3iJSiqlDM5z8Ynna+bSVYqQxpezrdeYzglNuXJdvoNsAE/AsOQcPp4IA67
 zt5a2ka+vNLFwCYQOoQ65L56o0sn0wdAgAe2Ydkj20+OiZlxBhlRWzEA0vi8R5nYbgx83uRmvHCGp
 NBZv6t1k0FgsdoVLOFdN5XBqED3JlOEfuGC7/vDIDQTGqvVXh/LF5wLPY+lLBR69GNxAJLKSSXLlV
 iRFIboKg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVF-00000004RTp-1VBE;
 Mon, 31 Mar 2025 20:13:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:10:22 +0100
Message-ID: <20250331201256.1057782-3-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVM-0003Xz-A6
Subject: [f2fs-dev] [PATCH 002/153] f2fs: Use a folio in
 f2fs_write_raw_pages()
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

Convert each page in rpages to a folio before operating on it.  Replaces
eight calls to compound_head() with one and removes a reference to
page->mapping which is going away soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/compress.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 9eecc167b1fc..668c04e93a95 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1532,37 +1532,39 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		f2fs_lock_op(sbi);
 
 	for (i = 0; i < cc->cluster_size; i++) {
+		struct folio *folio;
+
 		if (!cc->rpages[i])
 			continue;
+		folio = page_folio(cc->rpages[i]);
 retry_write:
-		lock_page(cc->rpages[i]);
+		folio_lock(folio);
 
-		if (cc->rpages[i]->mapping != mapping) {
+		if (folio->mapping != mapping) {
 continue_unlock:
-			unlock_page(cc->rpages[i]);
+			folio_unlock(folio);
 			continue;
 		}
 
-		if (!PageDirty(cc->rpages[i]))
+		if (!folio_test_dirty(folio))
 			goto continue_unlock;
 
-		if (folio_test_writeback(page_folio(cc->rpages[i]))) {
+		if (folio_test_writeback(folio)) {
 			if (wbc->sync_mode == WB_SYNC_NONE)
 				goto continue_unlock;
-			f2fs_wait_on_page_writeback(cc->rpages[i], DATA, true, true);
+			f2fs_folio_wait_writeback(folio, DATA, true, true);
 		}
 
-		if (!clear_page_dirty_for_io(cc->rpages[i]))
+		if (!folio_clear_dirty_for_io(folio))
 			goto continue_unlock;
 
 		submitted = 0;
-		ret = f2fs_write_single_data_page(page_folio(cc->rpages[i]),
-						&submitted,
+		ret = f2fs_write_single_data_page(folio, &submitted,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
 		if (ret) {
 			if (ret == AOP_WRITEPAGE_ACTIVATE) {
-				unlock_page(cc->rpages[i]);
+				folio_unlock(folio);
 				ret = 0;
 			} else if (ret == -EAGAIN) {
 				ret = 0;
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
