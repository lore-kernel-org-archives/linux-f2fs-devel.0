Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A8DC19F32
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:22:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tqcKr-0000UN-EN;
	Fri, 07 Mar 2025 18:22:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tqcKp-0000UG-HU
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Mar 2025 18:22:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T8fXRyaYOssoLEG59sUpr97PSMqTmPmVh2Clh/QPZVU=; b=JfWPn4ijTv00DQgXHnng4+/gET
 CoUHkFXeXkxxB6MYAwr+YqVrBohYHpBM9rA4PWfMslRQiAwOIrF2yucNK6y+iypEpdbbqYtxmocYM
 6bVWFpvTqvBe8oBNw0MJW9RVBdKdxYZYTwA8Q47oAhmXZhR2ciE9SUB5zgsVRl+Y2Cl8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=T8fXRyaYOssoLEG59sUpr97PSMqTmPmVh2Clh/QPZVU=; b=ThOMLWWw1/F4kSOcabhz0X9tPN
 gKgjr7xmSaYssS6fpP5OsMxIbD+VixL3dyCdkrBrV2QSmgFnIB+0Hw1Gc9EgH6Vx+DMHpZN8KLmzx
 o4oKsD+k/Y6hovKYNW7HL1uiGTZLuHF/KUIZ0dftcQD1CWonh93oOL3KygANLBr7FZAg=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tqcKe-0004Wm-BK for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Mar 2025 18:22:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=T8fXRyaYOssoLEG59sUpr97PSMqTmPmVh2Clh/QPZVU=; b=VqSVwG2q44DQjB2VdNTLCmCUcC
 5fxZ5lK4EKJ1ka5T4Wo1HeorWt7by+y9ih2BiLpjoCR0aWZ43UZ/rPpzvW8M6FRDW4PNpQ5oPSnFD
 6Pyn7FYsRFquFHD0/dT4QJ6ZSzCAa3ylZmpXyHvIbsEENGKmTCy7rDn3fPTK903OsJJ2bNwzFFma0
 OYd8NdCM/7lag9GRtE1ZdQQGZrUB4IjAzeRzqzk2tHdUnaK402UUASWGQ0OqZ8uHIn5wxcuQ4Oi3T
 ER9qS5bxIm2dvf3kZ0InhmNfNjmlxnhyuVnTXZREnTAYrEoPLyKaV4TXYgz9Xfjn+q9rdERCe4Dxj
 pa1g+isA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tqcKX-0000000EFjf-1jin; Fri, 07 Mar 2025 18:21:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri,  7 Mar 2025 18:21:49 +0000
Message-ID: <20250307182151.3397003-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tqcKe-0004Wm-BK
Subject: [f2fs-dev] [PATCH 3/4] f2fs: Remove f2fs_write_meta_page()
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

Mappings which implement writepages should not implement writepage
as it can only harm writeback patterns.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a35595f8d3f5..412282f50cbb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -381,12 +381,6 @@ static int __f2fs_write_meta_page(struct page *page,
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-static int f2fs_write_meta_page(struct page *page,
-				struct writeback_control *wbc)
-{
-	return __f2fs_write_meta_page(page, wbc, FS_META_IO);
-}
-
 static int f2fs_write_meta_pages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
@@ -507,7 +501,6 @@ static bool f2fs_dirty_meta_folio(struct address_space *mapping,
 }
 
 const struct address_space_operations f2fs_meta_aops = {
-	.writepage	= f2fs_write_meta_page,
 	.writepages	= f2fs_write_meta_pages,
 	.dirty_folio	= f2fs_dirty_meta_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
