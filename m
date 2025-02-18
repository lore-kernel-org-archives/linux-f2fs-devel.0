Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C92C021B1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2025 05:52:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tkGWx-0006a7-Jf;
	Tue, 18 Feb 2025 05:52:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tkGWl-0006ZA-Mu
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8fsH5DarnIkPPvANleakPOl+/DHdlSsWPg4cSSBvLV4=; b=nA8hY3sqKuQTDlkZ93T5oba4+5
 oBBIfmqGSO+R3cewD8r1irXg9rNnhjMJCFRqB8L2MP/BmEynGkqIa/ktmwrbBsTIG1mSA41DAsGCH
 l4D0oEg40hfk7qzcDDEmIqX5NKlfPTMi05H43sgiRz5L4hYkhP/XCFuGCotJrxBPtuv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8fsH5DarnIkPPvANleakPOl+/DHdlSsWPg4cSSBvLV4=; b=JG0V91ZhbSjBleVR3ZAeAu2hwz
 AtEPZQO9d97gBIhz9QOCXRE/8UtVpfAAkJ+ptnpmXjlSEQOSYHLzcwUeD+l/YRcoSOfQEUGt1mUan
 OEjDiaI3WqShgiVe1dV39Lh2B9tarTF6UY4a7c/AeB8vnvq+jYBKrGrQDbVPDmyqesxc=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tkGWj-0007bO-Bs for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=8fsH5DarnIkPPvANleakPOl+/DHdlSsWPg4cSSBvLV4=; b=OxlS5iHsxCBRvfY85wh4IGvPLF
 Vn8XUCIiVvmwtwfQg8HIrr5uUoDj2gBhIO9AyU4a9d7D/cRnOjnv/9/BU7zSI1EKyNwOuJ5Yx4IX2
 R9KcKC37ANhB1RGK5EM6hfpm5KES+7lPUy3i9Mp13y9A1jy+9dgG6mpoud56CExCiphE0BPaqPlAD
 //TW8Iwd3cSw/6MphORR0Ndj62ifPnoimkngDXyNRPzxVewrtWQOXOM94iHu/LP9X54bFbONvLW3m
 EafFhtRy+CsreuEGfF0qdEwsW3L+aBnMy7tEU841Tn0B7VTOkYch8hdAc7rhDL+V2Iri9bdgj3dk2
 cFM9j4VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tkGWb-00000002TrI-3Lw2; Tue, 18 Feb 2025 05:52:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 18 Feb 2025 05:51:38 +0000
Message-ID: <20250218055203.591403-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tkGWj-0007bO-Bs
Subject: [f2fs-dev] [PATCH 04/27] f2fs: Convert f2fs_flush_inline_data() to
 use a folio
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

Use the folio APIs where they exist.  Saves several hidden calls to
compound_head().  Also removes a reference to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f88392fc4ba9..522bf84c0209 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1951,32 +1951,27 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 		int i;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct page *page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
 
-			if (!IS_INODE(page))
+			if (!IS_INODE(&folio->page))
 				continue;
 
-			lock_page(page);
+			folio_lock(folio);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
-continue_unlock:
-				unlock_page(page);
-				continue;
-			}
-
-			if (!PageDirty(page)) {
-				/* someone wrote it for us */
-				goto continue_unlock;
-			}
+			if (unlikely(folio->mapping != NODE_MAPPING(sbi)))
+				goto unlock;
+			if (!folio_test_dirty(folio))
+				goto unlock;
 
 			/* flush inline_data, if it's async context. */
-			if (page_private_inline(page)) {
-				clear_page_private_inline(page);
-				unlock_page(page);
-				flush_inline_data(sbi, ino_of_node(page));
+			if (page_private_inline(&folio->page)) {
+				clear_page_private_inline(&folio->page);
+				folio_unlock(folio);
+				flush_inline_data(sbi, ino_of_node(&folio->page));
 				continue;
 			}
-			unlock_page(page);
+unlock:
+			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
