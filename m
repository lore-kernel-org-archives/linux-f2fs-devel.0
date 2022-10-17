Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4772DECAAA7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Oct 2022 20:25:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1okWfq-0008T3-GS;
	Mon, 17 Oct 2022 20:25:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1okWfp-0008ST-0r
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E33K4tt62trvRpPvq+30izBLUL0IuVPL5OXIZrHr8HE=; b=U8Eg6F9yFCc7tFjHtmaBbxER6N
 Sk/+OzuxJUKoHEl/rlCm4SnyCXigvZPhA7gp1l+X67oBFmLOGqZ7kixR/q6Q1hYKlRlDhjgyg1zbo
 ks+x31YPnK9XVuoVaZZ2MS2VF8G9UkaNOXQQS3T1zu+mTZ5ea2IL8b5dH0t58xPFJRIk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E33K4tt62trvRpPvq+30izBLUL0IuVPL5OXIZrHr8HE=; b=iR7X25ERFSqfTeIxx6blEvMzgt
 UlxDHZ2PxWA69+UYgw0rxmBN7N/ml0G3KeWh/aVC7EsmBerp5AzifwzoKK9CKN689Gh6H94pSotRS
 2eK3cXnpHG3L8vjoDqhfTxWnYLR0zTcH8LzQZcMjpUqAof42os/R4/p9sqlJjaRVV0Js=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1okWfn-0008Ss-Rq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:20 +0000
Received: by mail-pg1-f172.google.com with SMTP id r18so11430557pgr.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Oct 2022 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E33K4tt62trvRpPvq+30izBLUL0IuVPL5OXIZrHr8HE=;
 b=cl1Xi/1e0WoTPVgLswyDuFR7lxs/43LEKKD7Bo9Uw9kac9ra7cvb01UWyMEi5xxewT
 hyL1BtZ+mvM34/0A7+CMLc6hilzxun99rEMpx9xjsykG1vTPGkIhB0QBQ69a8Au+JrCf
 AfOyDw8pkWku9S+gAdDsIMskLeX96aYNe6IMl5AUvy5q7T1Ssku0uduQ+1wzM3YP9ppY
 7I0Y8VcM5OTQAhlJHbjcqxwUUfDUbj/f/tlW+sAL897w74AqpJQalJRfI1m2YFF1Lzb9
 r7eQ9gDkU5KFgK435GKStDS+BPmOYqtl3hyxC8hNrnbgmF0V6L78/uFd3xZV3vd3SDtq
 /rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E33K4tt62trvRpPvq+30izBLUL0IuVPL5OXIZrHr8HE=;
 b=mCce1NnL09Rvqzu46o/RbWpVJSSL6/nSJ/QduyX4sjLSdXJXPUSRnyi8UmH7gw1FOd
 iw1VD54PDlyXrcjmDY856w7pUX6WYOD2Xb3ekvLCI6O6gPJvXKNPmb1/AMA1Kf8h4vRB
 izeeAsw0CgjTQHY2mzsdCiAHJsam335feOlo4+vwXTKlEQEqajE9QdZxAIEsHYAAoLE0
 xUpNiDslIPvctHyYvPZuhDwp9Hy+VedurxcNWAbTLR8UccCTQfjMiKafh3RfVx5QDUEL
 a+afxYyFcJSzd2En36ICnPaGXUi70AQhUvMqypBxzrMicrz5Mp0oWvEewFIl9eizFdiN
 o15g==
X-Gm-Message-State: ACrzQf14At8EGpRF+B9Bif7sGVUAOPNiWMMtaEyXOlgiiDSymNGxcqNK
 lFlLxllRmEO6cWiFs7i+Grk=
X-Google-Smtp-Source: AMsMyM4kkO8T2vzywfYNW+3YWnKus1E6ExkXrh/gFAwlSfcvcWcDhTQV3uPrw41ayn+7UcqM6SSDWg==
X-Received: by 2002:a62:584:0:b0:55a:a7a5:b597 with SMTP id
 126-20020a620584000000b0055aa7a5b597mr14379661pff.71.1666038314860; 
 Mon, 17 Oct 2022 13:25:14 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
 by smtp.googlemail.com with ESMTPSA id
 pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 13:25:14 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 17 Oct 2022 13:24:49 -0700
Message-Id: <20221017202451.4951-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1okWfn-0008Ss-Rq
Subject: [f2fs-dev] [PATCH v3 21/23] nilfs2: Convert
 nilfs_copy_dirty_pages() to use filemap_get_folios_tag()
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
Cc: linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 "Vishal Moola \(Oracle\)" <vishal.moola@gmail.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 39b7eea2642a..d921542a9593 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -240,42 +240,43 @@ static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
 int nilfs_copy_dirty_pages(struct address_space *dmap,
 			   struct address_space *smap)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i;
 	pgoff_t index = 0;
 	int err = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 repeat:
-	if (!pagevec_lookup_tag(&pvec, smap, &index, PAGECACHE_TAG_DIRTY))
+	if (!filemap_get_folios_tag(smap, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch))
 		return 0;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
-		struct page *page = pvec.pages[i], *dpage;
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		struct folio *folio = fbatch.folios[i], *dfolio;
 
-		lock_page(page);
-		if (unlikely(!PageDirty(page)))
-			NILFS_PAGE_BUG(page, "inconsistent dirty state");
+		folio_lock(folio);
+		if (unlikely(!folio_test_dirty(folio)))
+			NILFS_PAGE_BUG(&folio->page, "inconsistent dirty state");
 
-		dpage = grab_cache_page(dmap, page->index);
-		if (unlikely(!dpage)) {
+		dfolio = filemap_grab_folio(dmap, folio->index);
+		if (unlikely(!dfolio)) {
 			/* No empty page is added to the page cache */
 			err = -ENOMEM;
-			unlock_page(page);
+			folio_unlock(folio);
 			break;
 		}
-		if (unlikely(!page_has_buffers(page)))
-			NILFS_PAGE_BUG(page,
+		if (unlikely(!folio_buffers(folio)))
+			NILFS_PAGE_BUG(&folio->page,
 				       "found empty page in dat page cache");
 
-		nilfs_copy_page(dpage, page, 1);
-		__set_page_dirty_nobuffers(dpage);
+		nilfs_copy_page(&dfolio->page, &folio->page, 1);
+		filemap_dirty_folio(folio_mapping(dfolio), dfolio);
 
-		unlock_page(dpage);
-		put_page(dpage);
-		unlock_page(page);
+		folio_unlock(dfolio);
+		folio_put(dfolio);
+		folio_unlock(folio);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 
 	if (likely(!err))
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
