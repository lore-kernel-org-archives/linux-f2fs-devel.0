Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E0EC369A9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVq-00016l-5e;
	Mon, 31 Mar 2025 20:13:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVe-0000yw-C6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D5OqbobZLnn/Ml/OhYbdF1jnOj3DFCD0YIFQNOq7kHc=; b=NiG9WggjrqiXzdIlfl/jFuoDQh
 amOFRBy/PUIF/Brklj4CJvJB4f2A1DWFwQSfUZnPjYJaeJsEQqnToHAa9GP8VAEqfQvTIr1loqb6z
 82pcphZBCoPTVcfjAsJNzHtclmHQHZzfTrU21ZM9q3RysaOVDJxJEAMrEGGnnYVmnA20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D5OqbobZLnn/Ml/OhYbdF1jnOj3DFCD0YIFQNOq7kHc=; b=mwDPIlrWAR1WX11hqjGF52gW3A
 xErj7gP/iM7a4UUvk59rM2kbiIZzCaW7pUISUSjbsHC+kVOF2CFK3Uo1e/a3wtmMMC+crFD5LV0cl
 ScWqYKJv6FGFikNhSqyrnCPjwn6RWu8rBIHfLMN/MRD42cyLloIjSGQ1WKjn6bB2aauo=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVZ-0003bA-HW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=D5OqbobZLnn/Ml/OhYbdF1jnOj3DFCD0YIFQNOq7kHc=; b=MFF6jYGFNKh0I/6A6H4W3b9f8K
 npy5zf4cwXGUzQi67PwxkdPVzqx91wqifkR0uWzJX7wKP/2QrP1j3QItlDyAB6FGAusgPrEUcpOKI
 lPoBlbZO9QAj+SSpp2cLfqq2/vAmLCwH/YAg5SlUrKbBaqIuGpWj7pzVLKCsK9mL9QT0Ax2mET33M
 w+NoOnFNJ37SATSZm1TbsiswgzkDACS+edYt8GuQBmHgbuuFB4AThuUUgu2oMUgGwrDiupMsNjP2P
 ebVbGQnH3zoxBRiPlUgBlh0jXIc2lzdytsMQVMenr3Ydtmm/9oov1msQ/lrS1Co7P5L1XyYpq1uPJ
 a/73Wt4A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVT-00000004S1R-0Yh9;
 Mon, 31 Mar 2025 20:13:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:44 +0100
Message-ID: <20250331201256.1057782-85-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVZ-0003bA-HW
Subject: [f2fs-dev] [PATCH 084/153] f2fs: Remove f2fs_get_node_page()
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

All callers have now been converted to call f2fs_get_node_folio().
Remove this wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 1 -
 fs/f2fs/node.c | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 92b5878dc5d3..9fd4640f67bf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3730,7 +3730,6 @@ struct page *f2fs_new_inode_page(struct inode *inode);
 struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid);
-struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct page *f2fs_get_inode_page(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f3fbf0d14341..5fb4f9c3c20f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1542,14 +1542,6 @@ struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid)
 	return __get_node_folio(sbi, nid, NULL, 0, NODE_TYPE_REGULAR);
 }
 
-struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
-{
-	struct folio *folio = __get_node_folio(sbi, nid, NULL, 0,
-						NODE_TYPE_REGULAR);
-
-	return &folio->page;
-}
-
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino)
 {
 	return __get_node_folio(sbi, ino, NULL, 0, NODE_TYPE_INODE);
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
