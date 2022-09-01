Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3FEC6FA8D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Sep 2022 22:02:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTsH1-000775-Q2;
	Thu, 01 Sep 2022 22:02:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oTsGt-00076c-Dl
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e1eM0qi5kNEXaBuV4o8U+3ZrhdfXdzoi+l/ai4waThY=; b=XaVlvirCX7uqMqaK1jJHDcdHIl
 65D2PJjw3e//oJj2BoWdU+jNGzlFg7RcF5flAeEUb/FW0d+z+LoQv6d5zewnh3pzXBzhaWzlyCak4
 DAeR28rveT3lbzmHsCE7YLev1N9MmbrfwWrsKVYZ/ycf5jEb4lowqemMRO4g6Z+BEPEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e1eM0qi5kNEXaBuV4o8U+3ZrhdfXdzoi+l/ai4waThY=; b=NCH3KbcVzGgMu68RJUZdrzZ0Oa
 qPDTo320Ye+5WmSLNBllmE5wH96ljdcF8SoVcqkO5CsDO1c1l++NfVBtrs5fwy8+7+ZjPbz2oU7hk
 wwklwYOgZVJdZElYVRVx4Zo3PYuzjL7+JbAMyVLk/NRrAyeJk5+vWy5rK3+4YbMUiTw4=;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oTsGq-00Aaew-6y for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:02:47 +0000
Received: by mail-pl1-f171.google.com with SMTP id m2so109626pls.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Sep 2022 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=e1eM0qi5kNEXaBuV4o8U+3ZrhdfXdzoi+l/ai4waThY=;
 b=gNJXwxFuFke6eYj0nz2/PiDYXJ6uuw/+y6pvA6QnWq7eouNcHBf6+EJm5Gq193Grgh
 QKheBVVmh8HekBMRDB/fVleY8+effRW479vEXXGHLR3S87K//Jhw2e5O+6agt21yf265
 3kAUpqXavBcWDTvapyzBiis+xac8n0OHDWu3AZnWr0Wr+BK3whUep7JGlwqONOkwM7N0
 +1XX1ffonfhplIVIfU/utkDEIIZZiHHrp7IYcKrC4ceg3Zt1nHegjtwcFABUPSqNEdnl
 4EwYzeXkwp7J8eKW59Rb1lKWQlyJ5HTmd9bz7AQHe6l+E5Qrn3Xr5kUs3+qXtBgSUL9M
 Ozqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=e1eM0qi5kNEXaBuV4o8U+3ZrhdfXdzoi+l/ai4waThY=;
 b=t3rJbZJGIyta6UMOMu9Tow6zzgOqHx+cJwAQ4d6rEr6ivP5uzFmF+3HUIn+1JfE6py
 XNwDcO7vF/idROo3RJv39nS0QhE/JgvScUBdYj743wvkHD08zNIVskGcmynkl+rm5Mmr
 FKspBTaaWuR0Ldp154Ywkki+wJngbIFBmsnIDvXsxuKaxN5nWVLQIjwv/dMPdeLXNsUl
 pZoHmxlJYjQSsW/Yk14qX6ncd+2y0GDTWPlRDcPfcaX3j3e4w4NdRSKedhJPPCAbZAXf
 WFfhaVKOytgEnl0cPwZuIDbDAO5H3iV9m+hX+439UqJ9UDD1zDkbbR3z7jeAThy4qZdX
 PH3g==
X-Gm-Message-State: ACgBeo3Z3YgGqsNxgK6yo+IRviKx8sSpw8GE20TlhKQwlA4U9x6Zj/ma
 7Thme5lVIlXysrNduIEDZc4=
X-Google-Smtp-Source: AA6agR79ut39yeQZLj/LWKnnlXRQp19F2hOxIhYbazSQ5kgq5xXWtmAM1WGiML8jodYQoBXi0CNqGg==
X-Received: by 2002:a17:90b:2bca:b0:1fd:a06b:ef4f with SMTP id
 ru10-20020a17090b2bca00b001fda06bef4fmr1267475pjb.201.1662069758626; 
 Thu, 01 Sep 2022 15:02:38 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Sep 2022 15:02:38 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Thu,  1 Sep 2022 15:01:18 -0700
Message-Id: <20220901220138.182896-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oTsGq-00Aaew-6y
Subject: [f2fs-dev] [PATCH 03/23] filemap: Convert
 __filemap_fdatawait_range() to use filemap_get_folios_tag()
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
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Converted function to use folios. This is in preparation for the removal
of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3ded72a65668..435fc53b3f2f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -503,28 +503,30 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 {
 	pgoff_t index = start_byte >> PAGE_SHIFT;
 	pgoff_t end = end_byte >> PAGE_SHIFT;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned nr_folios;
 
 	if (end_byte < start_byte)
 		return;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
+
 	while (index <= end) {
 		unsigned i;
 
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
-				end, PAGECACHE_TAG_WRITEBACK);
-		if (!nr_pages)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				PAGECACHE_TAG_WRITEBACK, &fbatch);
+
+		if (!nr_folios)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			wait_on_page_writeback(page);
-			ClearPageError(page);
+			folio_wait_writeback(folio);
+			folio_clear_error(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
