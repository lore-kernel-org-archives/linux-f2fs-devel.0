Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E435CC52D6F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2024 01:29:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgwe8-0002IJ-2i;
	Thu, 22 Aug 2024 01:29:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lizetao1@huawei.com>) id 1sgwe4-0002IA-GN
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v2lX9I+aEv1Z13UTaxYbs2AX5slg8C4mkzQIHML+wo0=; b=Oqv06vF14k0ZsnPa1pGNkk3Rp/
 uEp76TsA0e0qKY7UEeKJlxF6kOw2Isp/Y7ad4lzb18yJFPFaps3NkVdX+jQIlNDiai4tUeDxOyGgh
 SJKwKHSePfnLzieKO8CEC1W8QkFRRRmFkIYsfk8xzR2fW9PRi7bBaVXp2MW3H/E15IPc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v2lX9I+aEv1Z13UTaxYbs2AX5slg8C4mkzQIHML+wo0=; b=Rih4sJw9Xitk5LszKeg3uaPVTA
 6+WNO8nCsK5gunOFoAvxNP9gJOlG2owionDP6ffiLh7VMNn0YIjxhtDPFGoNbrM8X9ECw6fCwXXfg
 +bOAe5O1bwpoYz3DujmWwaBqW0IsqbNTwlBKszStc4zNqvlELcMBHFUKo0f5EqvUAPzw=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgwe2-0006bn-KJ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:47 +0000
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wq5GS1XV2z2CmwF;
 Thu, 22 Aug 2024 09:29:36 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 4C27D14022D;
 Thu, 22 Aug 2024 09:29:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:38 +0800
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>, <terrelln@fb.com>
Date: Thu, 22 Aug 2024 09:37:01 +0800
Message-ID: <20240822013714.3278193-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)
X-Headers-End: 1sgwe2-0006bn-KJ
Subject: [f2fs-dev] [PATCH 01/14] btrfs: convert clear_page_extent_mapped()
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
and folio.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 822e2bf8bc99..3c2ad5c9990d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -951,18 +951,17 @@ int set_folio_extent_mapped(struct folio *folio)
 	return 0;
 }
 
-void clear_page_extent_mapped(struct page *page)
+void clear_page_extent_mapped(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_fs_info *fs_info;
 
-	ASSERT(page->mapping);
+	ASSERT(folio->mapping);
 
 	if (!folio_test_private(folio))
 		return;
 
-	fs_info = page_to_fs_info(page);
-	if (btrfs_is_subpage(fs_info, page->mapping))
+	fs_info = folio_to_fs_info(folio);
+	if (btrfs_is_subpage(fs_info, folio->mapping))
 		return btrfs_detach_subpage(fs_info, folio);
 
 	folio_detach_private(folio);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b38460279b99..236da2231a0e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -249,7 +249,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
 int set_page_extent_mapped(struct page *page);
-void clear_page_extent_mapped(struct page *page);
+void clear_page_extent_mapped(struct folio *folio);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8ad540d6de2..5e3b834cc72b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7240,7 +7240,7 @@ static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
 		wait_subpage_spinlock(folio);
-		clear_page_extent_mapped(&folio->page);
+		clear_page_extent_mapped(folio);
 		return true;
 	}
 	return false;
@@ -7438,7 +7438,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	btrfs_folio_clear_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
 	if (!inode_evicting)
 		__btrfs_release_folio(folio, GFP_NOFS);
-	clear_page_extent_mapped(&folio->page);
+	clear_page_extent_mapped(folio);
 }
 
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
