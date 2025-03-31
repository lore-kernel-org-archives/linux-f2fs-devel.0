Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBB7C369A5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:14:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLWX-0001IV-09;
	Mon, 31 Mar 2025 20:14:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVt-0000v0-L2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5h49PQaL4SMIIhfJdx14qjzDUQWxTowgOpJVHTqC1OI=; b=hjlbjWcx8UwLvQ1NgM/xODakEo
 XhHPghJD1AHQXxXSAo9ZsOuqdkqDYxoiWzrsJH7BaYizobStyN3wp+YhxJfBpeSNpjkSuWWC51TrQ
 X+9upA5QXZ/8JPNvMNheLMkEDqke+Nfi8GK637T5Ig9ydkhHNM3EAsRpfulGwIq5HYBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5h49PQaL4SMIIhfJdx14qjzDUQWxTowgOpJVHTqC1OI=; b=BLvG7hwjE4Q5w81A8DDN/80RQq
 oVi5C8fNJ+j55wbK0vBPgsD3TL+zxRu2DHTO0G8WYGBP86h2VjnqvwjFQgH3gjGQxJe+ZgEHVXSZc
 YryNvD00AjirzjPnhEtpR6Wueqm0z9txK60Sc3O9SdUD7Ixu4WOCO2oIOP3SeIL1AwAA=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVj-0003fW-HU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=5h49PQaL4SMIIhfJdx14qjzDUQWxTowgOpJVHTqC1OI=; b=vb8PqAQVyQj3N3iuaxm1EYxgNV
 A9EJlor9PhIQ4armNhepo5MnYhzEoHoDnsgyVupO3lypnJpVC6+bxDbSko0Z17HeTHA2dwAbV7JvO
 wPYI2Yass+LhjJqM486BeAj6nvPdMSiHiv9dMWcRO9zHHvlbUAaWgefbxMHa1LT9oeo5L1NvE5VCU
 CVIA+QrwAtKS7Zapp8mXxTE1XoSN4x4+Tu95AG1VruKhHIE9jL4+0g5GC/JIyImWdWLmy53O9VN9z
 NQgCUELBdfQUfOo4xphiE5dDfGigB0nkUIlBGsc2aEQqlKMJRCZ6L4zLuWE50anwUDPh/o3Kml3P2
 8usL+TsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVd-00000004Sby-0rOP;
 Mon, 31 Mar 2025 20:13:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:41 +0100
Message-ID: <20250331201256.1057782-142-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVj-0003fW-HU
Subject: [f2fs-dev] [PATCH 141/153] f2fs: Use a folio in
 f2fs_encrypt_one_page()
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

Fetch a folio from the page cache instead of a page.  Removes two calls
to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8980b77bfdab..d67731f042cf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2503,7 +2503,8 @@ static void f2fs_readahead(struct readahead_control *rac)
 int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
 {
 	struct inode *inode = fio_inode(fio);
-	struct page *mpage, *page;
+	struct folio *mfolio;
+	struct page *page;
 	gfp_t gfp_flags = GFP_NOFS;
 
 	if (!f2fs_encrypted_file(inode))
@@ -2528,12 +2529,12 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
 		return PTR_ERR(fio->encrypted_page);
 	}
 
-	mpage = find_lock_page(META_MAPPING(fio->sbi), fio->old_blkaddr);
-	if (mpage) {
-		if (PageUptodate(mpage))
-			memcpy(page_address(mpage),
+	mfolio = filemap_lock_folio(META_MAPPING(fio->sbi), fio->old_blkaddr);
+	if (!IS_ERR(mfolio)) {
+		if (folio_test_uptodate(mfolio))
+			memcpy(folio_address(mfolio),
 				page_address(fio->encrypted_page), PAGE_SIZE);
-		f2fs_put_page(mpage, 1);
+		f2fs_folio_put(mfolio, true);
 	}
 	return 0;
 }
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
