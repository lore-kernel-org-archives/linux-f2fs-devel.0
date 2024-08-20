Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4A2C3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 03:47:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgFq6-0007wN-2L;
	Tue, 20 Aug 2024 03:47:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgFq3-0007wD-Fo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 03:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4GknH1Zwi0GWeOzSpYsC4QgaC/LmZ0emVEef2dI0udw=; b=L0PrvRer20FNa3CaoRpG4StQvF
 UZDp8S0dazYUlPlYJCoQbaIQTzgHXiuJ0BywCP7t3Fe5uVf+0rejVBurKgEjk17E66TrL05rbY0KO
 6yGYdACVmFXRpeOKKzN1j9r5Ks/cAm//O9CzeC1CEwj9PSaX4k1esrWj68iqpJulUvfY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4GknH1Zwi0GWeOzSpYsC4QgaC/LmZ0emVEef2dI0udw=; b=OTqkY8OFUbn2v0r/Ba46fDRdwM
 8+WMyc2Dg/N3D5dw3lC3o1yITkhZbFkUyGsGHmKeBoQbMbxl9+Y6979NIJ3z+q2fKW8Jqz/iJZqS0
 CPUw520yW+x6LCbUAE2hgpqzCQebNfE7X5lKdULlY+jmpErFgDm4Y9DFBxnTKX1KKAm4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgFq2-0006Ra-SO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 03:47:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 791D260DB7;
 Tue, 20 Aug 2024 03:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4FEC4AF0C;
 Tue, 20 Aug 2024 03:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724125628;
 bh=7JJv4KN9xSbK50goC7fnEuayXM2V2u/CfyhdMECGBOI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EufZ7fid6iK5WZ0mY5vev5+v9YjCzqJ7/tbDQ2aRbfmnviIuxm5LjcYRhpcYSf+39
 9ppD9U2cI3wYMNsQd64WOJD2HnPHzXbKaRVaMgKNa2OM3aJmJM1nRsVKuPV9BAZTTX
 t0zy/kxs9BhCsjbM7qlTAzKKEQgx/FnalQIP8+gdGyqR9yngo9I9VxdLB05HtmOVg0
 lSqeI4r0UBHSeoIyu8GxAvmrfF+AZ0lHfR9kqjymU0uIbq/ng32cxPZG3zFsG64Vct
 Tg2GI11CbPYBZsZV+smUi5oiMOVXq3+QZP+U2GWrkruCdI2a+xTE8iE5PdAn6IUUgN
 hyfAsPTomRFLw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 20 Aug 2024 11:46:49 +0800
Message-Id: <20240820034654.698236-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820034654.698236-1-chao@kernel.org>
References: <20240820034654.698236-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1sgFq2-0006Ra-SO
Subject: [f2fs-dev] [PATCH v2 3/8] f2fs: convert f2fs_set_compressed_page()
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
