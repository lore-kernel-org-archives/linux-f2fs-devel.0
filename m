Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B662EC3601C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVs-0005lp-U9;
	Mon, 31 Mar 2025 20:13:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVf-0005bY-0S
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ruG0c1xtMup0AjT5tZPu3UitFKzo2Cb5XfaI6CmpP5A=; b=YFcfpU8GrGyT6NPDu1uMfnDNBt
 Td5/VI9V41wP1ks3AP4O9NeHwfSu7OKpKXA+0m4JYGbyidUeNTJxPT1jOPdU/mc4/zXgWzqTrREvU
 iKihN1Rrx7+I2aws2EGrPgnNUNl/jpLB6jFN4u9GEhjxrnTORhlMrLuuFHR2ttMIf2pg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ruG0c1xtMup0AjT5tZPu3UitFKzo2Cb5XfaI6CmpP5A=; b=jGvy61yBA/TKfGNlRrF9AL4pDw
 dt9etNhNMhoYAsACuyAXEyAc54+LhSSkdkTHYtCTpuYIZb4ufAuN8UIKX9/3Oy1yIteo6H5BavMDR
 zy4NCJi6pTbBb2dZqsz4JkP9mX+M18gtS7+lKuLGHfYpVtTOyDRhEr57GKSID4jUjTKg=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVY-0003at-ME for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ruG0c1xtMup0AjT5tZPu3UitFKzo2Cb5XfaI6CmpP5A=; b=VPbNTPPhRLU/cQuN1v4tJ1QR8d
 KM0VYa2VEg5VRMtkqdvddSYhaqJZvFG7Y7IMHLjmxbtrdnvAZyI30JVwGPXr6Vfip26+kyue0Eic+
 X25rM1/j4zR+y6vsq46eMqZu3xvtB4s3UjKxNTIomcONfZwCRJspEq6ZcIsBGgFyi62NkQzWGLJnV
 kwbb5Jm8VEaVYRkjQUXmEFeJfqC8aOvXt9Agbi482CG4iyO9hJOK/tgkTjoq85KOSSlASNxiEKxKs
 AXfXHOD4OdSPPYrqvBiuztm+DLz3UI07l4TWkBLvKBEz8CmN78/EsIb0JQQBc4ZpwqvEVl5G6gfAY
 oOUHnsOA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVN-00000004Rmg-11wi;
 Mon, 31 Mar 2025 20:13:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:15 +0100
Message-ID: <20250331201256.1057782-56-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVY-0003at-ME
Subject: [f2fs-dev] [PATCH 055/153] f2fs: Use a folio in fill_zero()
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

Remove three hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/file.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ab46fb272cc2..90e71b54e1d0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1161,7 +1161,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 					loff_t start, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct page *page;
+	struct folio *folio;
 
 	if (!len)
 		return 0;
@@ -1169,16 +1169,16 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
-	page = f2fs_get_new_data_page(inode, NULL, index, false);
+	folio = f2fs_get_new_data_folio(inode, NULL, index, false);
 	f2fs_unlock_op(sbi);
 
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	f2fs_wait_on_page_writeback(page, DATA, true, true);
-	zero_user(page, start, len);
-	set_page_dirty(page);
-	f2fs_put_page(page, 1);
+	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	folio_zero_range(folio, start, len);
+	folio_mark_dirty(folio);
+	f2fs_folio_put(folio, true);
 	return 0;
 }
 
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
