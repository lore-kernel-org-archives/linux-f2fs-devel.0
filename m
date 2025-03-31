Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE65C36019
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:14:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLWM-0001Vz-HD;
	Mon, 31 Mar 2025 20:14:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVt-00019N-Es
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lZyL6aNccIchMqBlm+LAqCPG8c6J3/si+JMhozx7h5A=; b=iB04vtHXOoAXb3CNmZgcxiEyyo
 Kge0ywUDVqWo/OuC+/vsLOCpipDM+zHLFliWt5xxr6/NlBff7f80kpOj5BGWsvtN2vY69vvykcRzC
 gYyQVT9hDsECHE8bGjyLL3LBm1S/pAep++5LOgsQqBVE79VUjvEZ1tC5MgVSq50L2jHo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lZyL6aNccIchMqBlm+LAqCPG8c6J3/si+JMhozx7h5A=; b=UU0GHqxZsmD+aKwilg7xDw4cV8
 uxd6qgQX16WVnhxlDpzc/t+Lqm3u9oHe1v5yHiPxQcHoqnonzKHlmXGcB/4bMRhme4FfKsMfboSV5
 lk/znQ+22XW1E8ZHoaFZP0h3gXHKrIXFDKBxqV4fp8SsvH3hhEsXYyqXp0861Bp7ob4s=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVj-0003fY-Lf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=lZyL6aNccIchMqBlm+LAqCPG8c6J3/si+JMhozx7h5A=; b=MfoHTI+EF4zmkGBr8+IHWX1TyL
 UdtDAsiEoHAJNjWqel9u1n6UhUlzcOXJgNbrJxfsTTks73dgcXz/RxBFogpa7+Efplml1hB6UDoED
 mLZpB0MdSkkei3WeH3nKv+8z//Kf9FrSZI/0U4iEnaRxzWoX44TIJhORQiuRAVN2P8ppkYEItiIb8
 qT2KRf8L8ifKxoHOvVtKJNR2OiiTZCNHgRmAPLESGsmZaqh8lJKLoXWaCY9dOu5p3BpzeCy9Guvoc
 W1mV83n5JfytMLveZIatLll1eYdzuufjR5LvBK4BDAk8lOI9IOh1jKPtEwSnhdEX3t2NUamW1uJgZ
 IBlXSOmg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVY-00000004SNB-1FQv;
 Mon, 31 Mar 2025 20:13:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:12 +0100
Message-ID: <20250331201256.1057782-113-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVj-0003fY-Lf
Subject: [f2fs-dev] [PATCH 112/153] f2fs: Use a folio in read_inline_xattr()
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

Remove a hidden call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/xattr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 43f363f0658b..28b32728a113 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -276,20 +276,20 @@ static int read_inline_xattr(struct inode *inode, struct page *ipage,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned int inline_size = inline_xattr_size(inode);
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	void *inline_addr;
 
 	if (ipage) {
 		inline_addr = inline_xattr_addr(inode, ipage);
 	} else {
-		page = f2fs_get_inode_page(sbi, inode->i_ino);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
+		folio = f2fs_get_inode_folio(sbi, inode->i_ino);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		inline_addr = inline_xattr_addr(inode, page);
+		inline_addr = inline_xattr_addr(inode, &folio->page);
 	}
 	memcpy(txattr_addr, inline_addr, inline_size);
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 
 	return 0;
 }
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
