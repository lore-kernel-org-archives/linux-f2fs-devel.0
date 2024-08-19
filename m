Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DBCC5321D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Aug 2024 01:21:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sfr55-0004bg-QR;
	Mon, 19 Aug 2024 01:21:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sfr54-0004ba-Jq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Aug 2024 01:21:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pVkda070V/cbUxqxCp8oMh9qO6QLojXvPwXoNvqbT50=; b=gYqcIlaVedLtFNiGiy57qKgr+j
 /vX7DVdY1SYjxvFUGaIPyQ8A3Cv21lAoVM+mTfsQbGvZADjXrxDV/ZCQFQStzGJuEcQznmf30saKz
 mmZNJNk2ILbu0J6/GOczHMEpyT283Mi7NWEUA+GudNt5K1dA77SPUw2plNC4t8cQQBjE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pVkda070V/cbUxqxCp8oMh9qO6QLojXvPwXoNvqbT50=; b=MYugnlEyxWJ/Pv1Fbfsx3IqLhB
 rTMzdy+yDK2D0pqzliCr+aSV+FklJjRud/prvM1fnU44glEGXmL3qsRBdGMioN90Rp6mAuMFfRyuf
 3CMWPoaC5/516ZhrYZLhYWQKA7zk6iM/k7klAUV86JjRFVa1keYvinFotsBXelV25jwM=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sfr53-0003Zi-5h for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Aug 2024 01:21:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 69AC8CE092B;
 Mon, 19 Aug 2024 01:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92440C32786;
 Mon, 19 Aug 2024 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724030462;
 bh=Gv9T9VqQEXP+t9GsufY3LhPD+LhHvt38T1omk9U0JGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZbRYsQzetuZRIRFPWhOiNqwQxgfMVNcgiXrmvVe0jjaau42YXhHHUtDXQYsNxAHPh
 GVPmMfmspB2yvdcXUBQ43orXBKCF59vSuW7T+XkhFZc4btSv89jvK9qvZ5B/0DkqQQ
 803lkBBj/zf6CeXNu6+g9yNzxzpWu2o5hWhDDmOB/zlP4tNYHjPqcvreiQNuCY1RRm
 38ZTIv028YQqmHv7mvYxUZQPs3p+3LqSrfVa/a6bC6QRuOexT8lN3iIhZx9UlF9hog
 J4tAGzPVTZpWCo4g+5tWXZ6XPifxbQrdnV7TK2A1pyNQRgb9TiSOG02+zO9ZynPE7g
 vqBK06cFORMjQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 19 Aug 2024 09:20:20 +0800
Message-Id: <20240819012023.3871272-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240819012023.3871272-1-chao@kernel.org>
References: <20240819012023.3871272-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1sfr53-0003Zi-5h
Subject: [f2fs-dev] [PATCH 5/8] f2fs: convert f2fs_write_data_page() to use
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
 fs/f2fs/data.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c57ddee2c7c5..e69097267b99 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2945,22 +2945,23 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 static int f2fs_write_data_page(struct page *page,
 					struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		goto out;
 
 	if (f2fs_compressed_file(inode)) {
-		if (f2fs_is_compressed_cluster(inode, page->index)) {
-			redirty_page_for_writepage(wbc, page);
+		if (f2fs_is_compressed_cluster(inode, folio->index)) {
+			folio_redirty_for_writepage(wbc, folio);
 			return AOP_WRITEPAGE_ACTIVATE;
 		}
 	}
 out:
 #endif
 
-	return f2fs_write_single_data_page(page_folio(page), NULL, NULL, NULL,
+	return f2fs_write_single_data_page(folio, NULL, NULL, NULL,
 						wbc, FS_DATA_IO, 0, true);
 }
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
