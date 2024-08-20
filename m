Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B446BC5472C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:55:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgQGm-0004ph-Bp;
	Tue, 20 Aug 2024 14:55:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgQGk-0004pW-5e
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4GknH1Zwi0GWeOzSpYsC4QgaC/LmZ0emVEef2dI0udw=; b=kqGdZ34Kn++jzx8aOGwoGBxZoB
 ZQXZJA7YsCjtj1Lk5mHeU+eWAYY48YpdUu52BTlWq8ipeqTWlNTfII8e6vOWyuHxkUtzzqpsgrsRx
 IsbZNru4q3VAUiWC6V6N5ZB1ScF4NeAJ8GSkxo7KorxB11Ph4yPfJqL3S/SxRKN0h6OM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4GknH1Zwi0GWeOzSpYsC4QgaC/LmZ0emVEef2dI0udw=; b=SAlYPXquvhedvpijqFFY3Y6Zi1
 aV5tSGugN+8XMWx+SmIjeeWSctBdzfTs+Vl+tM+i2vXBD5jNR/p1ufCnidnJCBMBgCK716FOeLKFd
 YQ+OUb2Od0T258LXGD4koRL7jRx8ZrvEYMwWZ1kOgoo/MV5AUP8cWdDsVF6rvq5kRqWU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgQGg-0003Im-QU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 14:55:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BAC24CE0AF4;
 Tue, 20 Aug 2024 14:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF5FC4AF10;
 Tue, 20 Aug 2024 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724165722;
 bh=7JJv4KN9xSbK50goC7fnEuayXM2V2u/CfyhdMECGBOI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J2ry5UY561F4StWJhGVD2VhhyoyqS63hJ9KOFASUCRg3J45saor81xAyXqdmymw65
 R6jd6s9b0mYDKHfQz7MR7oUX6j/mju1mSDaMqIWIG6gmyWqehKKn8c1t0O8i00AldR
 3YSdEky64e03TyGcm+AUqAWDdLV/x+AXTDESNCgf2vLhMYeNVPziyixgpPCpm1LIyz
 ou9AHqgjp1Jni34cVnEyUays8ULOaWHE1qa/yxE+B/mWyXRKagAEZUbmpKW3fZGuJO
 rM48FzzRK9OxtUXMzzzG5hjK1BKHpzy5YQXHhN860JrNNiyLdkz9V5TQM66fanQnLr
 NJ1yeGQ59hCKw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 20 Aug 2024 22:55:02 +0800
Message-Id: <20240820145507.1372905-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
References: <20240820145507.1372905-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1sgQGg-0003Im-QU
Subject: [f2fs-dev] [PATCH v3 4/9] f2fs: convert f2fs_set_compressed_page()
 to use folio
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
 fs/f2fs/compress.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 82c31641e696..67bb1e2e07a4 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -90,11 +90,13 @@ bool f2fs_is_compressed_page(struct page *page)
 static void f2fs_set_compressed_page(struct page *page,
 		struct inode *inode, pgoff_t index, void *data)
 {
-	attach_page_private(page, (void *)data);
+	struct folio *folio = page_folio(page);
+
+	folio_attach_private(folio, (void *)data);
 
 	/* i_crypto_info and iv index */
-	page->index = index;
-	page->mapping = inode->i_mapping;
+	folio->index = index;
+	folio->mapping = inode->i_mapping;
 }
 
 static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
