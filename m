Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BEDC3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:55:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgQGn-00023y-Vc;
	Tue, 20 Aug 2024 14:55:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgQGn-00023s-2t
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pVkda070V/cbUxqxCp8oMh9qO6QLojXvPwXoNvqbT50=; b=JiJseN9UrwxflGGejZdBVOKeEL
 7UqYB+0DcI+//Xv+MT/1KPFprZYwnsI3yVsulfNGYniN2ufnd077rFlaVL3DSWg8cyhP78vp3gYK9
 OkMGusY8NSYLgYOycW5N7fY7T2Yb2uxWjiopOqdqyAVJ1CAdVftI9RCeSKZw/XO7zLaQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pVkda070V/cbUxqxCp8oMh9qO6QLojXvPwXoNvqbT50=; b=jrZMtxjAdGq08DIuplnqiouX0d
 YQM6HFvO+YYZnXFNve2+ohsTVsnZQsm7QWvDQXkzhpw1sucyj83WKD3En5VEWTQEpdYhajY0olefK
 hGcBtcSTmFA6Od5OIDmVXZIbub44KkgAkdnBx1k7AXGPZ+LJWuQurbyt2cTgPlijTbjo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgQGm-0003JF-Ej for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1FFDD60E00;
 Tue, 20 Aug 2024 14:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EA6C4AF13;
 Tue, 20 Aug 2024 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724165725;
 bh=Gv9T9VqQEXP+t9GsufY3LhPD+LhHvt38T1omk9U0JGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GZ9W16IRFWd2LFPtm1XvzpXZaxI1c02blG2XPDJLi5qAEfDHfMUuvhkdDQcfVlBxx
 vIOzU0poC6k/ikW84ZvfV2qNsZll5T+qBBqsOz/qTORz4DIYydEyKw8NQKV+RV0PTy
 4NNf+sHcvapSH77owmgh1JVqpXLXBTvYCxAxTsARh8ZmpJUmU2K8yITBEwZlE30MAr
 wo/Xa+bzmX+2jPbTI2WtqWVNZ3nZzJ05CEMdPCA2MPOTKjMo7uAH3fd3Yj1A1W0fgW
 V8tmY3a3Pd1tAlBv5cKW/qUmHLg5lyNBwVNux9mRfd1G/EUX0vFiZAZXEUyTX8vgcl
 FrpAkJIaiekfw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 20 Aug 2024 22:55:04 +0800
Message-Id: <20240820145507.1372905-6-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
References: <20240820145507.1372905-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1sgQGm-0003JF-Ej
Subject: [f2fs-dev] [PATCH v3 6/9] f2fs: convert f2fs_write_data_page() to
 use folio
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
