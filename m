Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DDAD5E39F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Nov 2024 05:20:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tGWwj-0006bD-OP;
	Thu, 28 Nov 2024 05:20:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tGWwi-0006b6-9v
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Nov 2024 05:20:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CnXrj1DPaUR8ec+yHvj9N7vSnboioXigoKtrv3zbVEM=; b=VIyuB2dq+GUM3r0ytgPq1QJcKJ
 ynwzYmp70myBRJc4krmVB2dJwZk7FKyIex8B0p3xOms2M8vV77AlKZ4JrGBN2I0A0S3R3LwfQprRV
 u36n+fiQriRvfJIdENP9H3RTNpReD5NoMEw4I47WxDGWVnxgLLw0oWTHnUnh0UEWm34w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CnXrj1DPaUR8ec+yHvj9N7vSnboioXigoKtrv3zbVEM=; b=ARvqOcEMSp1bFkJR7Jpbjzm+by
 eHcEwS8RoJ1RGNQZlbDx5lwq/VomgcRDfczCx731YJ0K5SjKRX+SBo3XFGs5F+85Gxf7tOLpBKKfA
 iZY6LU8wwScEHZQPcOKE68m1dZFvDP0GytfgJdo+mZkmMJY0c5dqwWNx7xzhlkiW2kHw=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tGWwg-0004hx-P3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Nov 2024 05:20:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=CnXrj1DPaUR8ec+yHvj9N7vSnboioXigoKtrv3zbVEM=; b=AUWf2kO1qq2yrDifmE2C7n/j0b
 BzY8/qoymEO+HwTtyOHSl69WemX58iaF0plhy507TjQf46L8PwEmlwSSuuQftJb4E+PXgj4LM8/35
 FYyJ4zjLAYsI+l82fgevcfDI9D9i45ACnlmlEyM03FDxr4LuJ49p2Biohc6bZ3abr9hY/uusnbX1u
 sC+O+K3oiFBepjEEEjO9uT0HmmAU0xmcjpO1rbth9tqW5C7PPLAu5TvdhQoXmaH0WvZ/+GeZZsLFF
 +oQEfGXwa9yOpnC64e8+3GmQ9+BNk7D5vnLkNrrYQPhagWBbtS4PZm8Eqn4Gdp9jR+pBIPaBqV366
 JpD/ZoMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tGWbq-00000002DFt-3WJy; Thu, 28 Nov 2024 04:58:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu, 28 Nov 2024 04:58:21 +0000
Message-ID: <20241128045828.527559-7-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128045828.527559-1-willy@infradead.org>
References: <20241128045828.527559-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tGWwg-0004hx-P3
Subject: [f2fs-dev] [PATCH 06/11] f2fs: Add F2FS_F_SB()
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

This is the folio equivalent of F2FS_P_SB().  Removes a call to
page_file_mapping() as we know folios seen by f2fs are never part of
the swap cache.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6f2cbf4c5740..f523dd302bf6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2003,9 +2003,14 @@ static inline struct f2fs_sb_info *F2FS_M_SB(struct address_space *mapping)
 	return F2FS_I_SB(mapping->host);
 }
 
+static inline struct f2fs_sb_info *F2FS_F_SB(struct folio *folio)
+{
+	return F2FS_M_SB(folio->mapping);
+}
+
 static inline struct f2fs_sb_info *F2FS_P_SB(struct page *page)
 {
-	return F2FS_M_SB(page_file_mapping(page));
+	return F2FS_F_SB(page_folio(page));
 }
 
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
-- 
2.45.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
