Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63894C369B4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVj-0000mC-IK;
	Mon, 31 Mar 2025 20:13:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVR-0000jX-L9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ANhTq1B1HclWX/Tr8ILvJ7gkp31a71/eqYRR1zgUDPU=; b=RQXbciBZPPV6s2f0ueHXpFztNl
 NBQH1mQIb+3s21hLrSfCCOXjgaP01wAn4zMGaRAxjyH9SNdfEP+PJasC19BY0ZeMWHSeMJiH3HDBi
 IWs54J4IMntQmVLE+Do4WlTafnN57MaJUj3m3lyxrY/Rb8RLrUmJ8YTcDs3OUtVcZmCM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ANhTq1B1HclWX/Tr8ILvJ7gkp31a71/eqYRR1zgUDPU=; b=DXxZqJqtTzYJ0e8juNhXaabdb3
 zLqFDCDfjgpkdIoUJl5Virj7z5iNfqifjwzLuE+xmmkq+DmEx0wCwhZdGCIx2JESgnO/GPiAt3sDI
 TZ6g9Nlps8k4rMqfRYHRzsJR63mMnSepjtuxJiiZ7v/MZNYKviDsnlO6bXYmhvSZdr3I=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVR-0003Yk-Du for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ANhTq1B1HclWX/Tr8ILvJ7gkp31a71/eqYRR1zgUDPU=; b=qvNjFdGPy13PJzrssskbJRDppm
 TyBmj5mBRZX/GptkfBhxQx8yKl2+3/IWIiWQDuo5dq56WYMh8TtU7VTAdUGBWh4aQcGtdQBskFXUC
 osk98f+xlZs9RdwnAPFIw0/j2YBdFszBdYJITE+rKHBi0F41HdI2KPHJIa2Tc0I2IvWsZguu47TgX
 hry+gqIZ1qVIFL83slsHwE5UM2QCc0pF8Ac951NqYYFvP4jryE2M2byQYsXjP7cq6ToqesMw2LE16
 IsgwpNfH2BaejdiFz2Hkj5S3T6CI01WRLH97wQvlq3fAWly9k5ueyW1Dw9YhLSC4Klx6n3nyp9+nL
 S3CcgGuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVG-00000004RV3-0Jht;
 Mon, 31 Mar 2025 20:13:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:10:27 +0100
Message-ID: <20250331201256.1057782-8-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVR-0003Yk-Du
Subject: [f2fs-dev] [PATCH 007/153] f2fs: Remove access to page->mapping in
 f2fs_is_cp_guaranteed()
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

page->mapping will be removed soon, so call page_folio() on the
page that was passed in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8d25af7a4cfd..e668497ed3fc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -49,7 +49,7 @@ void f2fs_destroy_bioset(void)
 
 bool f2fs_is_cp_guaranteed(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page_folio(page)->mapping;
 	struct inode *inode;
 	struct f2fs_sb_info *sbi;
 
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
