Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A95AC3601B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVm-0000p0-JD;
	Mon, 31 Mar 2025 20:13:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVY-0000kI-7X
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vk7MYJnwTrfCNGqALaJeZNfSvpX2USuZEo+VbRUfyeo=; b=i8vUh6XgbddhRrKf3lKz+DeySX
 wSEhD0w280utua0q6ChGD8390scJkBXOQ6STL3z3kmks3fC1ftxIxmvqxyBhAFJedhPqHoa+79H79
 MHIwF4NRVMfzD5Kk7rkVfudR1yGRkQcojoz0RmfGRCmFPf8RpCsyXUIWs6G//LZClPsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Vk7MYJnwTrfCNGqALaJeZNfSvpX2USuZEo+VbRUfyeo=; b=HmssATFUYIwsrv+6Z7c51hZneK
 gXbRvnpVMt1/m4vP6AYs1ewsicU0qoqerkxdRoSIoPYyfXCH9dxRvgja/CIzjP0dOuqdbKqiQQDgE
 K+pm/JZXsNUZwS1rtl9Hc5Db61raqgBB6eC4I73ZG/dzzY8j8jpO0084Lbk2Pn4N3PKM=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVY-0003af-2S for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Vk7MYJnwTrfCNGqALaJeZNfSvpX2USuZEo+VbRUfyeo=; b=NNVAN9jX01C14EMQ0uGv1qw9+t
 ug7YaMA5PuBr1WV0JNbm5LApQ0BJMZe8P0d7VLrYPI+qL8kZagLhVclmgxAIu2YIQP2JuK/ELmesr
 InqK53yllKzrqQ0qX301UR2rUWrPR6mEpv73O3GhgS2V06XhXHuRiz8J1dUkVDzaJKuHC2OJFjVB2
 elWfoM9KHRHdukcUWejrDJuid7DYMDWWDI/Kll9oZXlhee+BvY6u/k5jvLJXvAjU0nBTxzJAuQUYg
 r6E+nMoYzfwEEknTffiXfBFs64osJheuBd4HlaJoJ3qYQv4cdBossRmZ9+YXgllOjNUE0oDWCm9gc
 1MhoriAg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVM-00000004Rks-31Qf;
 Mon, 31 Mar 2025 20:13:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:11 +0100
Message-ID: <20250331201256.1057782-52-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVY-0003af-2S
Subject: [f2fs-dev] [PATCH 051/153] highmem: Add memcpy_folio()
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

The folio equivalent of memcpy_page().  It should correctly and
efficiently manage large folios:

 - If one, neither or both is highmem
 - If (either or both) offset+len crosses a page boundary
 - If the two offsets are congruent or not

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 5c6bea81a90e..fd72f66b872a 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -404,6 +404,33 @@ static inline void memcpy_page(struct page *dst_page, size_t dst_off,
 	kunmap_local(dst);
 }
 
+static inline void memcpy_folio(struct folio *dst_folio, size_t dst_off,
+		struct folio *src_folio, size_t src_off, size_t len)
+{
+	VM_BUG_ON(dst_off + len > folio_size(dst_folio));
+	VM_BUG_ON(src_off + len > folio_size(src_folio));
+
+	do {
+		char *dst = kmap_local_folio(dst_folio, dst_off);
+		const char *src = kmap_local_folio(src_folio, src_off);
+		size_t chunk = len;
+
+		if (folio_test_highmem(dst_folio) &&
+		    chunk > PAGE_SIZE - offset_in_page(dst_off))
+			chunk = PAGE_SIZE - offset_in_page(dst_off);
+		if (folio_test_highmem(src_folio) &&
+		    chunk > PAGE_SIZE - offset_in_page(src_off))
+			chunk = PAGE_SIZE - offset_in_page(src_off);
+		memcpy(dst, src, chunk);
+		kunmap_local(src);
+		kunmap_local(dst);
+
+		dst_off += chunk;
+		src_off += chunk;
+		len -= chunk;
+	} while (len > 0);
+}
+
 static inline void memset_page(struct page *page, size_t offset, int val,
 			       size_t len)
 {
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
