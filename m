Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFDBC369AC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVi-0003rJ-3B;
	Mon, 31 Mar 2025 20:13:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVa-0003mh-Oe
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gJhRbw+pNbMEDxBZdX/4VaHo2Vo4+yCtS0Ox73FF29M=; b=PWsuWAxja5LuiaUCM97JCNF02/
 EeVAI97yBE3/2QTs/5mHYGt1vDGTOHyoCnXVIB1TV/XNCPCzfIFUbPsFp9yPUGsNOMDo+tGTI01WP
 cbDrwrZ8nBGDGnaZnSeijedu/FTUgtGz6Ol2muderPTwd30DtR289FZTSS2vJ9pBRpqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gJhRbw+pNbMEDxBZdX/4VaHo2Vo4+yCtS0Ox73FF29M=; b=RBC9NCNdwn/cZcFHdk6LxJ297H
 aJcKYz28q7BeU4pvBotjUcYMvZUemPb6tw67Q6bkJRxuwnHH/Tet3Fg44JvHalj+nJe5PBSySaEKC
 7IOd/OMCVWuLSIurpD2B1ihUFZKQGzzkMA6Lzp7ShxU4ZJ4jfMPtoyztcQf5KSL/io8M=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVP-0003Yc-Ta for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=gJhRbw+pNbMEDxBZdX/4VaHo2Vo4+yCtS0Ox73FF29M=; b=baeZETCQWVDtGwC3SfGnGTfwe2
 05vONrzG3coLwZpAEgQY04zmY0pBSPfxYOyQayYwXvqiNbxPthSC7r4ovQp9Xu6XazhVJfqPOhSkC
 5W37qzJrq86iNdd9BcDDyrjqYMsem3hoSkjdfkQDfuy4ExtzUDbfv+uuRaRIET46RJaxr7Vgtnjwd
 QeyB1IY8xvUc0lbRCuk4HmiE8NKO1cTS271fk4rP5kxajUsVAE6LWWF4le0F+1emQ8MH0b+sRgj0s
 d+v0NmIW75F4uk7diNsgdnNvOdp32WMj0+RK5t3WXWokE1n4rZ6mKXe+FCRjUsHotr/64B+s7Vucq
 re0wCaYA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVJ-00000004Rbj-22Og;
 Mon, 31 Mar 2025 20:13:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:10:52 +0100
Message-ID: <20250331201256.1057782-33-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVP-0003Yc-Ta
Subject: [f2fs-dev] [PATCH 032/153] f2fs: Use a folio in f2fs_get_node_info()
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

Get a folio instead of a page.  Saves a hidden call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7c42dd5cd68b..7e32763cc51e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -551,7 +551,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	struct f2fs_journal *journal = curseg->journal;
 	nid_t start_nid = START_NID(nid);
 	struct f2fs_nat_block *nat_blk;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct f2fs_nat_entry ne;
 	struct nat_entry *e;
 	pgoff_t index;
@@ -601,14 +601,14 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	index = current_nat_addr(sbi, nid);
 	f2fs_up_read(&nm_i->nat_tree_lock);
 
-	page = f2fs_get_meta_page(sbi, index);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	folio = f2fs_get_meta_folio(sbi, index);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	nat_blk = (struct f2fs_nat_block *)page_address(page);
+	nat_blk = folio_address(folio);
 	ne = nat_blk->entries[nid - start_nid];
 	node_info_from_raw_nat(ni, &ne);
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 cache:
 	blkaddr = le32_to_cpu(ne.block_addr);
 	if (__is_valid_data_blkaddr(blkaddr) &&
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
