Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1156C531DC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:55:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgQGq-0004q8-7f;
	Tue, 20 Aug 2024 14:55:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgQGo-0004pv-JQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AlKtkv71Y5dMQWzz+ZZduEIH4qLJToicukWYZuVv5KY=; b=haYyvM4i1dS/d8jrxTJIOBKzCz
 Gi1TBlbQWHBdxzwbpEk0A3bKsf9bNJAaZzJwltVxS5z9Ca7RtT/VOB/0fjryZT/euMdPcJHQxL2Io
 8BFua16ui83NS8VLhXEXz2YXH2v/XI5ONG88GshmSi4o6aiOH3/OJsgUDwIwMWGWdVDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AlKtkv71Y5dMQWzz+ZZduEIH4qLJToicukWYZuVv5KY=; b=gsOgacJ9gheEfqcgk+k3sew7vL
 2BXYy3UAwpvELzNxHhTw28eXH/FVBJZcPtlkwWUWpwPqkfScgddlgI4i6Fn14RrSSfxaB3/XCx9lw
 F5VOaQYyrX6DIl5uHkjgNtzJ+SzeY2qNVZYHr4oZQUOn693WA33b5EFAQkqyAZoxLCAE=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgQGn-0003JE-6P for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6CD91CE0B7C;
 Tue, 20 Aug 2024 14:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04536C4AF0C;
 Tue, 20 Aug 2024 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724165729;
 bh=B1fWIi1dMz6E5T95/Mb2Eyi2qqkYJmzRfHyiW0GG3tk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X+LTHXIZ/rFjlHLGGVRl75m3/4HDF/y4pYZp/ji0IyHooyX3INet8dv1e/IYcq1jH
 vqgho6/9iUkn6pT4GzOBJT2jxVzC/pKKRGSDxzEmMPdPSBvKrcSeejaH+xUmJVlICK
 nTWT4dkoVXHWsQuGzJ6UyJDRD5BVEYr1sAoJnMVwai+Zybd5yKwUSeAdkIbeesXT31
 GlXjjwxkk6s6U9qcPwtgwBqatmNWmXrymzE5NQ5UheySvwLzQYU3+D5OguvrAmGDXs
 MB55ztRN5lvsR5QpLVTcC4aGwrDwN12dRPbHumszFFM0SzNKIM+/eqmv44FJ9Sz8lh
 R986GzaS7ehlg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 20 Aug 2024 22:55:06 +0800
Message-Id: <20240820145507.1372905-8-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
References: <20240820145507.1372905-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1sgQGn-0003JE-6P
Subject: [f2fs-dev] [PATCH v3 8/9] f2fs: convert read_node_page() to use
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index aeda3eecc9e2..f5e5abce695b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1369,6 +1369,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
  */
 static int read_node_page(struct page *page, blk_opf_t op_flags)
 {
+	struct folio *folio = page_folio(page);
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 	struct node_info ni;
 	struct f2fs_io_info fio = {
@@ -1381,21 +1382,21 @@ static int read_node_page(struct page *page, blk_opf_t op_flags)
 	};
 	int err;
 
-	if (PageUptodate(page)) {
+	if (folio_test_uptodate(folio)) {
 		if (!f2fs_inode_chksum_verify(sbi, page)) {
-			ClearPageUptodate(page);
+			folio_clear_uptodate(folio);
 			return -EFSBADCRC;
 		}
 		return LOCKED_PAGE;
 	}
 
-	err = f2fs_get_node_info(sbi, page->index, &ni, false);
+	err = f2fs_get_node_info(sbi, folio->index, &ni, false);
 	if (err)
 		return err;
 
 	/* NEW_ADDR can be seen, after cp_error drops some dirty node pages */
 	if (unlikely(ni.blk_addr == NULL_ADDR || ni.blk_addr == NEW_ADDR)) {
-		ClearPageUptodate(page);
+		folio_clear_uptodate(folio);
 		return -ENOENT;
 	}
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
