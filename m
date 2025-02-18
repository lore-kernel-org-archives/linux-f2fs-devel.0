Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB6AC021B3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2025 05:52:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tkGWq-00024Y-Mc;
	Tue, 18 Feb 2025 05:52:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tkGWm-00023k-EM
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mg8CE4y5cf1Snnnvi8f+NPDzZONlmEcVa2aiieEuBaA=; b=BLGZ0i8mI8TNA/nAUHxqvHCb2F
 vCSbjYKUxuQuuconLAvdURQAO52xoBkTc2veK3yD6DEwUt/7E+vhz63ItycHWTEB1lrqG95LooCHS
 MAFevF9wvPMC/4BWcy3b5Gy9ccxlTGSQnbd2hCY9gPnD6bwEKy+bPXbyjLhznfauGESU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mg8CE4y5cf1Snnnvi8f+NPDzZONlmEcVa2aiieEuBaA=; b=Ga/LjgV0eB1TJHp2UrppZ5rfji
 F+iuAfxKF3iKNyKjFq2GWG30GUSH9+ZSjZk7ymesbAoL11diJrdhB3LxTWqScVmmx1pBaVZId2QRn
 ENArXc1/MkECbCkKj4dNVMwSQVDFTOAmKV10kQPoGxJYeWzP8Ddo8FHTtpYFdLL6P5z4=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tkGWk-0007bd-FP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Mg8CE4y5cf1Snnnvi8f+NPDzZONlmEcVa2aiieEuBaA=; b=Nw/1HpszThT9iCqTEk4sQAiZK2
 yeqli20VboViPfpHNFI/hU+cQPYD84UyG3KQ67ONrPZpuORE/6o1oeZJqBmSA04XmiuDwsRNx9FOw
 Su85IOGF5kZ0P0eyJXPBepKHEIAgU6u+oYX52+uIRs+OAqU/SSxeXjmtIhPJDuJS72KsWK8f5s5jU
 4ySJavkhcvPI3DvSh5HzqHAENSgMzdQoRl8Vrae+mGKHcTFW+fMw5dGWxbM8MEyU4Bx0X0CE4HSjN
 +dgeK0c4BL6ZbAKWFdojGIE2a9kNIti4dSmw7a9fm8besxiQR9OM0QXr3xbkxGOIh2PBbD7nK86vr
 vI5NW0MA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tkGWe-00000002Tt8-0nfT; Tue, 18 Feb 2025 05:52:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 18 Feb 2025 05:51:54 +0000
Message-ID: <20250218055203.591403-21-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tkGWk-0007bd-FP
Subject: [f2fs-dev] [PATCH 20/27] f2fs: Hoist the page_folio() call to the
 start of f2fs_merge_page_bio()
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
Cc: linux-fsdevel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Remove one call to compound_head() and a reference to page->mapping
by calling page_folio() early on.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d297e9ae6391..fe7fa08b20c7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -888,6 +888,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	struct bio *bio = *fio->bio;
 	struct page *page = fio->encrypted_page ?
 			fio->encrypted_page : fio->page;
+	struct folio *folio = page_folio(fio->page);
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
@@ -901,8 +902,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_VECS);
-		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
-				page_folio(fio->page)->index, fio, GFP_NOIO);
+		f2fs_set_bio_crypt_ctx(bio, folio->mapping->host,
+				folio->index, fio, GFP_NOIO);
 
 		add_bio_entry(fio->sbi, bio, page, fio->temp);
 	} else {
@@ -911,8 +912,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	}
 
 	if (fio->io_wbc)
-		wbc_account_cgroup_owner(fio->io_wbc, page_folio(fio->page),
-					 PAGE_SIZE);
+		wbc_account_cgroup_owner(fio->io_wbc, folio, folio_size(folio));
 
 	inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
 
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
