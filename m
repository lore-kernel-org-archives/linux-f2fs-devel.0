Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4D2C83F17
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Jul 2025 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OVWTAPV3lAtKsVsRTRKXdscYx0xrozNoauR7kuj56N4=; b=XOKWhSRNAbYLOeJS9zvRICVeXF
	dA6mPedUdMerjV78HeahfZsa3KNyGEL+y41ZcL1iZu8jMq39jNgesddPr4LzO0E+mHy0wfy+50Vi+
	fr+w4B8Bl0mYq3NwH9wlbWPPeLl3TLVPtznh0rG5/W3uPXsGX2VqXBbo8eQqVSq+thtU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uZBkz-0005mf-SQ;
	Tue, 08 Jul 2025 17:05:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1uZBjy-0005XF-Lu
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Jul 2025 17:04:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cjb9GrSqelcYJ3RDFl6DJ+3hKKzXOwq3bnXSpFPOOw8=; b=JXHbu26paHakr4TR2YvcG04cXT
 txAjFfs107gFwT1ruY9s0LoYTDgz10an9MBZ5MtsJTQcMl0oOsFCrj/iTtXP6ezyfMbNxbQmSYJQL
 RlBmzWxFSe4BV3rJqkU7xFn8BTS0F+dbO4xdRoSy784Mbm1+/ZpHEA/RikCilp2dfSgM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cjb9GrSqelcYJ3RDFl6DJ+3hKKzXOwq3bnXSpFPOOw8=; b=kXXkxQc0z6UAadAwiOLDkSf9GS
 J1TUPBeqXhqvOx7XHYqnbkRxepeFwMvlnZT/rpp0v4AySCjiLBUAV+G2hs3UjhaMtIp0/MMWsnSKr
 PriRg8vShSr8eR7p1OaK6eDRDQ2LjncrwPNiEwKBeQvAC7U8EXPWiAHryotK1thc8ISA=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uZBjv-0006G8-CL for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Jul 2025 17:04:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=cjb9GrSqelcYJ3RDFl6DJ+3hKKzXOwq3bnXSpFPOOw8=; b=Ozp9o7RCt0wSUo+t+gxG/4C9bq
 dHVNT9OXxqFwGNrjHHH7NlUbm8JFuiEKi21xtifSD/nm2VnBprR/K3//ki9pBQypVs1dJNKiHuJF7
 VkGE7ilpN1LAMuOs41oyLAIXLLUUbHJ7hJcIS/I4AzdOQXhF4P9m9VcBII/mnBny0rsawM7qHZgp6
 YyuyJH9n3cAaVKxt8DuwkEL/VQuNh6/9MdNVXqvp7P7Ov9kINTYC/pUiHXTW2+gpW1krOmZlMOm30
 kcwiee857UGs/QrObqGrxkWAMLM6xGmbd+wOGUW51iu2K9w2CFzXqlr0EZceI56eibD1pii7sgv+3
 9bvtM6PA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1uZBjj-00000000T7o-3Vfo;
 Tue, 08 Jul 2025 17:04:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue,  8 Jul 2025 18:03:41 +0100
Message-ID: <20250708170359.111653-45-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708170359.111653-1-willy@infradead.org>
References: <20250708170359.111653-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1uZBjv-0006G8-CL
Subject: [f2fs-dev] [PATCH 44/60] f2fs: Use a bio in f2fs_submit_page_write()
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

Convert bio_page to bio_folio and use it throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 01c0358ef66f..4649c0a510a0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -949,7 +949,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	struct f2fs_sb_info *sbi = fio->sbi;
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
-	struct page *bio_page;
+	struct folio *bio_folio;
 	enum count_type type;
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
@@ -980,33 +980,33 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	verify_fio_blkaddr(fio);
 
 	if (fio->encrypted_page)
-		bio_page = fio->encrypted_page;
+		bio_folio = page_folio(fio->encrypted_page);
 	else if (fio->compressed_page)
-		bio_page = fio->compressed_page;
+		bio_folio = page_folio(fio->compressed_page);
 	else
-		bio_page = fio->page;
+		bio_folio = fio->folio;
 
 	/* set submitted = true as a return value */
 	fio->submitted = 1;
 
-	type = WB_DATA_TYPE(bio_page, fio->compressed_page);
+	type = WB_DATA_TYPE(&bio_folio->page, fio->compressed_page);
 	inc_page_count(sbi, type);
 
 	if (io->bio &&
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
 	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
-				page_folio(bio_page)->index, fio)))
+				bio_folio->index, fio)))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
 		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
 		f2fs_set_bio_crypt_ctx(io->bio, fio_inode(fio),
-				page_folio(bio_page)->index, fio, GFP_NOIO);
+				bio_folio->index, fio, GFP_NOIO);
 		io->fio = *fio;
 	}
 
-	if (bio_add_page(io->bio, bio_page, PAGE_SIZE, 0) < PAGE_SIZE) {
+	if (!bio_add_folio(io->bio, bio_folio, folio_size(bio_folio), 0)) {
 		__submit_merged_bio(io);
 		goto alloc_new;
 	}
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
