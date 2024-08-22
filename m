Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4CBC52D7C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2024 01:29:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgwe8-0004X5-2L;
	Thu, 22 Aug 2024 01:29:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lizetao1@huawei.com>) id 1sgwe6-0004Wr-Pu
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=klHd8y+gUh/GZ+A26dhqmSvlDk9K7bAvQ/tdE0QJkbc=; b=VPVesUaqJhNp51gQ0TmJy6KuyP
 /d259b8yLCJyNwsdZDlW3d5jbH286MiiMlyNFh1e5R0znE4PrJGHfYCH1GreHRnA3pTWyEX/uweP9
 o72ZaelTpI6+chHIazQzym0U0PbqiJkEsmqgzfjx7f+/c+9ZEUjyiWjSSCjgV0RmrlhI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=klHd8y+gUh/GZ+A26dhqmSvlDk9K7bAvQ/tdE0QJkbc=; b=U1fQSVyHYpfTp1dd0/LGK55ayA
 GhtB+CdCo/dSsTrphB9tttqI8KzP2L4Z4jSZvINJWM0DamFlLzN3daVBqdsG6acLiSP1CU8ufVxAL
 D9Ryw1Gx1RZXseTp3V8JDqwZ7Me3uG4Pi+2iTqXB21zhqIUupzaWfmryuumEg7RpZ0pM=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgwe4-0006bs-BF for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:49 +0000
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wq5972yrbz20mFZ;
 Thu, 22 Aug 2024 09:24:59 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
 by mail.maildlp.com (Postfix) with ESMTPS id B8A101A0188;
 Thu, 22 Aug 2024 09:29:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:41 +0800
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>, <terrelln@fb.com>
Date: Thu, 22 Aug 2024 09:37:07 +0800
Message-ID: <20240822013714.3278193-8-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)
X-Headers-End: 1sgwe4-0006bs-BF
Subject: [f2fs-dev] [PATCH 07/14] btrfs: convert submit_eb_page() to take a
 folio
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
From: Li Zetao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Li Zetao <lizetao1@huawei.com>
Cc: linux-btrfs@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The old page API is being gradually replaced and converted to use folio
to improve code readability and avoid repeated conversion between page
and folio.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca458237ac35..e16477ef0bfb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1899,18 +1899,17 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
+static int submit_eb_page(struct folio *folio, struct btrfs_eb_write_context *ctx)
 {
 	struct writeback_control *wbc = ctx->wbc;
-	struct address_space *mapping = page->mapping;
-	struct folio *folio = page_folio(page);
+	struct address_space *mapping = folio->mapping;
 	struct extent_buffer *eb;
 	int ret;
 
 	if (!folio_test_private(folio))
 		return 0;
 
-	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
+	if (folio_to_fs_info(folio)->nodesize < PAGE_SIZE)
 		return submit_eb_subpage(folio, wbc);
 
 	spin_lock(&mapping->i_private_lock);
@@ -2009,7 +2008,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, &ctx);
+			ret = submit_eb_page(folio, &ctx);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
