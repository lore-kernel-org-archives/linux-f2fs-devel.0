Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF04D65553
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Nov 2024 05:20:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tGWxV-00045g-PQ;
	Thu, 28 Nov 2024 05:20:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tGWxU-00045Y-I7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Nov 2024 05:20:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FQBW9QgG4KLuphkQ4f5nlHL2gjcLmM+r5DMaibDcNhA=; b=VR4l1+4Yug7b+lx/mvujYrYw7C
 8ypMlLEsnBxKPl3fNl9BlB2eNyl1x/3yQuB7j8neVDVKY7qFW47/bkqHGE4uuXYotmdSOSJPPoaAd
 3AR3cNaON5pktKbIVCJKyL5p4JiEBL7se4yz6kGk679KdstE0lF7eh5PvHaDoiBrLl2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FQBW9QgG4KLuphkQ4f5nlHL2gjcLmM+r5DMaibDcNhA=; b=fbmTrlcNLYnZ7XGeHLenuqJT+b
 KcWeL4YI4uyhMw7ABTj/u4wqZVL3xFopBzE69FPBFjfkFkjThzS5bH9VRcjThspN44ISBwR2h8ed1
 QT/a8mHlnfXc00o7luzqiIw2ItPz6utxEnI6in48g3NuJqIm35r/U1xhE8+viAgBj+ZU=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tGWxU-0004mx-El for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Nov 2024 05:20:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=FQBW9QgG4KLuphkQ4f5nlHL2gjcLmM+r5DMaibDcNhA=; b=jmxZI9T1pZoG4HG0nhepPiKTxv
 ksY/S87zjtYngqKQewOmYnHUdiJ0jUX8cEnHDUspNpyxXhkPqJrz2tCl6BvhhIyxuuhhkRu/HtzXO
 iknPOakFPpiYvxtyok1T3yAprpaxj88bkN+IM6/Bv2bGk1/k3p8eHJvibh+KmVnQsEWRhtyo1T3KO
 1CkXn5M5SBNlp/fUQ5jD13L5WGQyRh6PCwPLFBGmj2Sm5ynGk1KM8fxIAdjxmTMvufRGmak8xTEJO
 s9XzBBPDzv1DfvQvYbjh3nsgIDc1PVXEt59ltFPd4qnL6IKYHmz4VOxRnGcOMAZOiFKht9BMef5Iw
 d9+3QhPA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tGWbq-00000002DFb-1wXn; Thu, 28 Nov 2024 04:58:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu, 28 Nov 2024 04:58:18 +0000
Message-ID: <20241128045828.527559-4-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128045828.527559-1-willy@infradead.org>
References: <20241128045828.527559-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tGWxU-0004mx-El
Subject: [f2fs-dev] [PATCH 03/11] f2fs: Use a folio in
 f2fs_truncate_partial_cluster()
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

Convert the incoming page to a folio and use it throughout.
Removes an access to page->index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/compress.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c91a2e4fe60c..494baa1e8bd3 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1242,13 +1242,14 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 		int i;
 
 		for (i = cluster_size - 1; i >= 0; i--) {
-			loff_t start = rpages[i]->index << PAGE_SHIFT;
+			struct folio *folio = page_folio(rpages[i]);
+			loff_t start = folio->index << PAGE_SHIFT;
 
 			if (from <= start) {
-				zero_user_segment(rpages[i], 0, PAGE_SIZE);
+				folio_zero_segment(folio, 0, folio_size(folio));
 			} else {
-				zero_user_segment(rpages[i], from - start,
-								PAGE_SIZE);
+				folio_zero_segment(folio, from - start,
+						folio_size(folio));
 				break;
 			}
 		}
-- 
2.45.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
