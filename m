Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6937CC369A7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVf-000101-9j;
	Mon, 31 Mar 2025 20:13:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVc-0000wr-My
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+l8S/kMp/JB5DjWo3sDJEYwSzUZlPjx0jneMv9E4SXs=; b=QzbThxFUletE7fuQlgHgg7RcKJ
 tDMhc339CUulTuSZbYMLoKSMufBDjn8MQ/KAK8fkx4SGYKWinvYQoFBsgjL4/q7FPFqgGY1iF+sZ3
 c0O9ACeL2ktuBBjRK80GJk0Cp5p42Qq6gscIiou2LtbcsG6SZk+Wr/8erpmQJlSlU6BY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+l8S/kMp/JB5DjWo3sDJEYwSzUZlPjx0jneMv9E4SXs=; b=aTpo4RXaTSMdY6lmQ+LMm0tV16
 FHlYDYdY/f5G0h4XRo7NzhnUsjpWYQBjHxb/Q9iURYJGSa0ZFCSvAlpqinSKcCXZ0jCriS5NK3eDq
 aNKUQVxrYfR0j/qHoPlUTVg3pi1lC3PJM3LtTYpbOHIF/Hdo9Aq2dnwIYZjJ7iTmIi4o=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVX-0003aW-Qo for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=+l8S/kMp/JB5DjWo3sDJEYwSzUZlPjx0jneMv9E4SXs=; b=T+jMsjzeBk9JmhP6it6EAFCzLV
 KelgVhp+UNpGBAJaNfawXRiM9gJtin9PosLkNYjyTzdHjqvsVle5xmqrebItGaV93KvYgSf50m1bv
 rvnLrpW6faNc9dmhbAVbrjlLHCtfUDCkL8u5SNItF2JfD2Q8hUnjdtYksKp6BIMg1FcuIXVeez/2q
 5Q4JQ31azMzAnzAonXECQXeP/HttWjXMLZu2/RLzORkO+LX1p3RHQELIQVTUPh/3BHZPciHLN3c8Z
 elGq3DJEuCFnHnsk7y6KmshdzkH/QCzXKZY06v1Uc39QAlPgBxnbpJjUrFD3V0Wwe61iIcU9WXlYd
 87+zgK6w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVM-00000004Rjs-1gvt;
 Mon, 31 Mar 2025 20:13:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:09 +0100
Message-ID: <20250331201256.1057782-50-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVX-0003aW-Qo
Subject: [f2fs-dev] [PATCH 049/153] f2fs: Use a folio in
 f2fs_migrate_blocks()
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

Get a folio from the pagecache and use it throughout.  Removes two
calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9c79ceed1c6d..2301daf57e56 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3879,18 +3879,18 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 		set_inode_flag(inode, FI_SKIP_WRITES);
 
 		for (blkofs = 0; blkofs <= blkofs_end; blkofs++) {
-			struct page *page;
+			struct folio *folio;
 			unsigned int blkidx = secidx * blk_per_sec + blkofs;
 
-			page = f2fs_get_lock_data_page(inode, blkidx, true);
-			if (IS_ERR(page)) {
+			folio = f2fs_get_lock_data_folio(inode, blkidx, true);
+			if (IS_ERR(folio)) {
 				f2fs_up_write(&sbi->pin_sem);
-				ret = PTR_ERR(page);
+				ret = PTR_ERR(folio);
 				goto done;
 			}
 
-			set_page_dirty(page);
-			f2fs_put_page(page, 1);
+			folio_mark_dirty(folio);
+			f2fs_folio_put(folio, true);
 		}
 
 		clear_inode_flag(inode, FI_SKIP_WRITES);
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
