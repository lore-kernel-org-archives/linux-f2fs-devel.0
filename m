Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0832C54722
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2024 01:29:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgwe8-0003Xp-Mi;
	Thu, 22 Aug 2024 01:29:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lizetao1@huawei.com>) id 1sgwe7-0003XP-HQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BFsc+RD3fiiWC0yJbm9Y6gpQnfAsgzfquMpGWxCT/9Y=; b=A/qP2sFk1ZirNcgA5b8NIgkK/I
 yUh0Vi6lqBYsNcC6cFFvMqCiCKgCgloJlrBokluggZwQJf/YHDO0n9YD27Px8vwqas/FgbfvpIjWw
 N+UmmlzitCQoldU7fPUuOkVn3agHXP2CJYnnyDS46f7jTBSNL3D8U72W1mZ9MiEH6UNE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BFsc+RD3fiiWC0yJbm9Y6gpQnfAsgzfquMpGWxCT/9Y=; b=e44QJR93geZ8tl2MDTp4xpUG2p
 BynXDZsnvij/1JyAwvHVVZ8vjJknBTWVNGeFQgaq+lqcOe6pKthuJDvhns9uENwfjSpHTtue3VKKM
 TVopNjtMs8YpOuvY6k6cmDUVfUW8KIz7geMTTStXl13nMxGh6YAmz3h6/NEZt7UrDYlk=;
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgwe5-0006bt-Eq for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:50 +0000
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wq5Fp2rYBz13TVL;
 Thu, 22 Aug 2024 09:29:02 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 2A9B2140361;
 Thu, 22 Aug 2024 09:29:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:41 +0800
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>, <terrelln@fb.com>
Date: Thu, 22 Aug 2024 09:37:08 +0800
Message-ID: <20240822013714.3278193-9-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)
X-Headers-End: 1sgwe5-0006bt-Eq
Subject: [f2fs-dev] [PATCH 08/14] btrfs: convert try_release_extent_state()
 to take a folio
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
and folio. Moreover, use folio_pos() instend of page_offset(),
which is more consistent with folio usage.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e16477ef0bfb..27ca7a56d8f5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2397,9 +2397,9 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
  * to drop the page.
  */
 static bool try_release_extent_state(struct extent_io_tree *tree,
-				    struct page *page, gfp_t mask)
+				    struct folio *folio, gfp_t mask)
 {
-	u64 start = page_offset(page);
+	u64 start = folio_pos(folio);
 	u64 end = start + PAGE_SIZE - 1;
 	bool ret;
 
@@ -2508,7 +2508,7 @@ bool try_release_extent_mapping(struct page *page, gfp_t mask)
 			cond_resched();
 		}
 	}
-	return try_release_extent_state(io_tree, page, mask);
+	return try_release_extent_state(io_tree, folio, mask);
 }
 
 static void __free_extent_buffer(struct extent_buffer *eb)
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
