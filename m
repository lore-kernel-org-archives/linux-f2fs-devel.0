Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6CDC3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Oct 2022 20:25:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1okWfj-0007ZS-1J;
	Mon, 17 Oct 2022 20:25:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1okWfg-0007Yn-1W
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xF+S3kLPZzaI8oQb5OfM6HGraMAqxwArE1NOeePgjJI=; b=YPW6aVyFPExor81RK29kR9jqp0
 UYU2LJIYBkemR4vlQHGbjhOBCX2+z5685IEaaKrZTZTZKETquW3ODkn+NIK78tHSkipEfJ6GMpd0v
 16oD32xAUVB3BW4q9Iazz6jNYFKm4W2u9zWagsaTHjPdro5trSbDAhm1n8EAbes7qLiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xF+S3kLPZzaI8oQb5OfM6HGraMAqxwArE1NOeePgjJI=; b=VaORcizxrvq42riUssNuAY9A/9
 1RZn3Fvo972QZZbpzWRupznGezPIQGApueBnqraxzuxCEAbwpD3pmG+AU5V5zCELwPXNA13Ui3Zar
 J4JMyPW+Wg4ifqfIiCw9jQ+KHPen42PI3XCReRCmdtefvu5p66hK7xHcUZwZy8JFrVwg=;
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1okWfc-007LiW-Ln for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:11 +0000
Received: by mail-pl1-f181.google.com with SMTP id h2so4465592plb.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Oct 2022 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xF+S3kLPZzaI8oQb5OfM6HGraMAqxwArE1NOeePgjJI=;
 b=XUUSSIaIijy9nz3gVf5iV3Ax7/gZZZ7Kjy+jjIIePV53CqFWJIxxsOvnffQtyfkxjP
 Yj1nwTiH0AguMsbOTQeu+8Z9mi7qRPLyE0S6M0xCFwiO28OMVRcOXq6yKjJFASnj7zDP
 hHzCZ7l/wbiBSCCq8oyptJveE7nl6roT2dTX39Tmm+YHanI6ZLWRKL+GxVNnWAVi/aqd
 Utqx7yMucx2sjXgfOeQmOc8qMiwP1URFKwVETpEX4YOe1sQaY88gGBHBUZvpmMyb0f0m
 PLVAeL/JerSDZqt4gfmESRBxYd+ZqACu4QMuoto8SFxAd6Gjw4atWFM001xVBLWGQnUL
 y/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xF+S3kLPZzaI8oQb5OfM6HGraMAqxwArE1NOeePgjJI=;
 b=sm8/G7oMVUMui0cmf2klYGZwprZD7zwTbv3iYokeAHhtVp9/r4fSkPGPwxo32NUXye
 +svEei8kpJd0WUzfZjrE/YOKd60M3njd1sTd5gdYiW6hmasYIk3hh5TtYyNhx/4ruNeR
 RL+pXXK1o0ObUq51FXgOaznKT+xCv96D7pU4AhxN3Ql/s57p+KOpasxCnp/UoU5q8Zfx
 9HViDust8kIa0itD1syq/XPM6ZOw35aeDKB5TkT7GkWM7yCWfwRQ/ee9ckbvx30N7Q2u
 WB2iROvKJsS4BeN9GTA6hi3dVhL+FyaxWRTs0cjGddD96kG5sCn7meuDiXuKIUCz9JFS
 ps9g==
X-Gm-Message-State: ACrzQf0OiI/+DnAM2KtaK9jc2maBNbNlnSWKyGzjDInr9EkCm1ghA4tz
 zyteuJeWZvXps6Vci5eSqtU=
X-Google-Smtp-Source: AMsMyM5ypUsG5+WrImTP5bBtDzNgzyRwr/KD3LkLMPonj3Tjj7JKkPzBbmJwUrqdFqpFWlWztsuaxQ==
X-Received: by 2002:a17:90b:400f:b0:20a:9965:ef08 with SMTP id
 ie15-20020a17090b400f00b0020a9965ef08mr15928728pjb.155.1666038303106; 
 Mon, 17 Oct 2022 13:25:03 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
 by smtp.googlemail.com with ESMTPSA id
 pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 13:25:02 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 17 Oct 2022 13:24:37 -0700
Message-Id: <20221017202451.4951-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1okWfc-007LiW-Ln
Subject: [f2fs-dev] [PATCH v3 09/23] cifs: Convert
 wdata_alloc_and_fillpages() to use filemap_get_folios_tag()
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

This is in preparation for the removal of find_get_pages_range_tag(). Now also
supports the use of large folios.

Since tofind might be larger than the max number of folios in a
folio_batch (15), we loop through filling in wdata->pages pulling more
batches until we either reach tofind pages or run out of folios.

This function may not return all pages in the last found folio before
tofind pages are reached.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/cifs/file.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f6ffee514c34..9a0675dd2d3c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2520,14 +2520,41 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
 			  unsigned int *found_pages)
 {
 	struct cifs_writedata *wdata;
-
+	struct folio_batch fbatch;
+	unsigned int i, idx, p, nr;
 	wdata = cifs_writedata_alloc((unsigned int)tofind,
 				     cifs_writev_complete);
 	if (!wdata)
 		return NULL;
 
-	*found_pages = find_get_pages_range_tag(mapping, index, end,
-				PAGECACHE_TAG_DIRTY, tofind, wdata->pages);
+	folio_batch_init(&fbatch);
+	*found_pages = 0;
+
+again:
+	nr = filemap_get_folios_tag(mapping, index, end,
+				PAGECACHE_TAG_DIRTY, &fbatch);
+	if (!nr)
+		goto out; /* No dirty pages left in the range */
+
+	for (i = 0; i < nr; i++) {
+		struct folio *folio = fbatch.folios[i];
+
+		idx = 0;
+		p = folio_nr_pages(folio);
+add_more:
+		wdata->pages[*found_pages] = folio_page(folio, idx);
+		if (++*found_pages == tofind) {
+			folio_batch_release(&fbatch);
+			goto out;
+		}
+		if (++idx < p) {
+			folio_ref_inc(folio);
+			goto add_more;
+		}
+	}
+	folio_batch_release(&fbatch);
+	goto again;
+out:
 	return wdata;
 }
 
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
