Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEADC369A9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLW2-0000zx-1B;
	Mon, 31 Mar 2025 20:13:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVf-0000lM-3H
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fEocn8anI90E8Xb4wGuY8vDf469Fzvz4/Y7lMgf4+JY=; b=CMsREFagGQQ4EtYMAhLh8kXRHi
 JoRbrG3uigF697IlJDUWOX58ONiHSRC/aOVaG84LT8sPlJyW/2qPM4tuZsoRS331w1RzDO9RKN5VW
 dulJmyF+X+IA2lc5o6zCSmM02BXtDDviHwlAQ+CqrUftAcfJU5w0yoBYU++2U5OrG8cY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fEocn8anI90E8Xb4wGuY8vDf469Fzvz4/Y7lMgf4+JY=; b=agGkrbxHPtH1+IuuoSm9Wejzkw
 F2dQYMOjH8QYD3hTvUgar+inzn7VsA0xmFaoY3wAa14zgrAvwNsB4UVhBG+L8H1WXHXCzk3DQmbZg
 7HAyOZAbyEab5o5DprJaz/wPlJD7MBzAWC4x7METu9DxOSIphUGaHVOKeSuehbtsUm5U=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVZ-0003bK-VI for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=fEocn8anI90E8Xb4wGuY8vDf469Fzvz4/Y7lMgf4+JY=; b=cJhRHQfEDSgQZvXUtcy00r7tSN
 j7bYdYVlf3HaNsNvHragAjGKDD4Ut/21Zz7Bims5pmwiUyhyXhJBnDA1UYUJb2kjNwMZTXP7J4HDV
 cgkNLotpn3kxDV4TgIQEc6GemKZEEXIRpAgzT/sKUm3vMF3T6UK7kn9MiT4qocAf8ZkzWwbomF3Ri
 /oC0R6D+10SfG8IGwuKn81nOdHp29dkVO33dn4KyaFoqj/3/WfCGi34vw44/gqeotcjgqFKQE4x6y
 V+NPDO0bY+lnCuowOSbvvNQHSxFXiCpEKESfaFdfB+1QaRh/MHqlQlswi40fKoOQbjVOyX50BZhbW
 gBEDpMpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVO-00000004RpM-1BcA;
 Mon, 31 Mar 2025 20:13:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:22 +0100
Message-ID: <20250331201256.1057782-63-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVZ-0003bK-VI
Subject: [f2fs-dev] [PATCH 062/153] f2fs: Use a folio in
 f2fs_convert_inline_inode()
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

Remove a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/inline.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ad92e9008781..4b0a7062a0e0 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -218,7 +218,7 @@ int f2fs_convert_inline_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
-	struct page *ipage, *page;
+	struct folio *ifolio, *folio;
 	int err = 0;
 
 	if (f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
@@ -231,28 +231,28 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	if (err)
 		return err;
 
-	page = f2fs_grab_cache_page(inode->i_mapping, 0, false);
-	if (!page)
-		return -ENOMEM;
+	folio = f2fs_grab_cache_folio(inode->i_mapping, 0, false);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	f2fs_lock_op(sbi);
 
-	ipage = f2fs_get_inode_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage)) {
-		err = PTR_ERR(ipage);
+	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
+	if (IS_ERR(ifolio)) {
+		err = PTR_ERR(ifolio);
 		goto out;
 	}
 
-	set_new_dnode(&dn, inode, ipage, ipage, 0);
+	set_new_dnode(&dn, inode, &ifolio->page, &ifolio->page, 0);
 
 	if (f2fs_has_inline_data(inode))
-		err = f2fs_convert_inline_page(&dn, page);
+		err = f2fs_convert_inline_page(&dn, &folio->page);
 
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_unlock_op(sbi);
 
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 
 	if (!err)
 		f2fs_balance_fs(sbi, dn.node_changed);
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
