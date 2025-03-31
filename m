Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365DBC36017
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:14:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLWM-0001VB-2g;
	Mon, 31 Mar 2025 20:14:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVr-00018I-SH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cm0tB6NcgkBTWbbGAdcCO85MJQgWpZ7T8cEdPPAV/nw=; b=VOAMAQiqrxLo8I7aoPg63HwEE7
 wxgSgKaH4sz/GudHa5sYhTg0AFxqv1bIHb0PWknHHSqiqu5ioxl6z/+urAFmtL/QY7QBbuj9AalhZ
 +5DYOhXdUwVfdSAS3WWIVNI1Ekcwx4mRbHdrTmaC4dNEbhF+Ym8x+UgA4y7M3aGWOw+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Cm0tB6NcgkBTWbbGAdcCO85MJQgWpZ7T8cEdPPAV/nw=; b=Gb7VDJUZR60O57/yRqmUs58Z57
 p/vlivPr8cDvUmk3MiNuYp7TzLbCWqZhlo/8+ohw8uBdmof+O+LdMV4PKhMsDQCV9bOvGcvJ1d37u
 iPMkba1dXQU/X3vwB085Ab4m4QaTAHOj8kEZ1cYyLzp/Vb+J7fNsVKOn/3NYz+io6jHI=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVn-0003hG-1h for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Cm0tB6NcgkBTWbbGAdcCO85MJQgWpZ7T8cEdPPAV/nw=; b=UnBQJizollIzqHjfgaSCGK8WI6
 54orjeyRv9KDZCvpe0/KR7uh7Cz+hF0l443NtmSieovroCAdpfL9+6q8cwHOGk6PinMCcCGz4R5B3
 Nkp6MByzaI4PqsKtWD+p8VOQ6JoPQ0SRKBFSSnuFdFWKryDgt7jhgW/Jqv2steUz3moiZsflZBxSL
 Bvg6bSNEH4r4Qwj1CvxRd5+LJfRaIuFrTKsNDh8oOtBe2IXZuBkJR74mDcl3D332N+nguc7zuBpAW
 BKJ6lMg6lnrCzmvuKEF6AzUjSVdh20Jb9H1DKMud8qW/NXfvIFEJqIF0TXIAGyXuvErPMGxEWJd4S
 ID8PZo/A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVb-00000004SYS-2GZt;
 Mon, 31 Mar 2025 20:13:23 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:32 +0100
Message-ID: <20250331201256.1057782-133-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVn-0003hG-1h
Subject: [f2fs-dev] [PATCH 132/153] f2fs: Pass a folio to
 __recover_inline_status()
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

The only caller has a folio so pass it in.  Removes two calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cbfd536efe20..eda71c432cca 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -95,19 +95,19 @@ static void __set_inode_rdev(struct inode *inode, struct page *node_page)
 	}
 }
 
-static void __recover_inline_status(struct inode *inode, struct page *ipage)
+static void __recover_inline_status(struct inode *inode, struct folio *ifolio)
 {
-	void *inline_data = inline_data_addr(inode, ipage);
+	void *inline_data = inline_data_addr(inode, &ifolio->page);
 	__le32 *start = inline_data;
 	__le32 *end = start + MAX_INLINE_DATA(inode) / sizeof(__le32);
 
 	while (start < end) {
 		if (*start++) {
-			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
+			f2fs_folio_wait_writeback(ifolio, NODE, true, true);
 
 			set_inode_flag(inode, FI_DATA_EXIST);
-			set_raw_inline(inode, F2FS_INODE(ipage));
-			set_page_dirty(ipage);
+			set_raw_inline(inode, F2FS_INODE(&ifolio->page));
+			folio_mark_dirty(ifolio);
 			return;
 		}
 	}
@@ -471,7 +471,7 @@ static int do_read_inode(struct inode *inode)
 
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
-		__recover_inline_status(inode, &node_folio->page);
+		__recover_inline_status(inode, node_folio);
 
 	/* try to recover cold bit for non-dir inode */
 	if (!S_ISDIR(inode->i_mode) && !is_cold_node(&node_folio->page)) {
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
