Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DE5C6FA8E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Sep 2022 18:25:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXo7f-0002mk-UA;
	Mon, 12 Sep 2022 18:25:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oXo7e-0002mI-2e
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=; b=ZV7fsAaE4y9M2d4x5S2mKHNDlF
 dX3eeA1ZvxAidbwSiTIvZz0ErX8Xb/HiRYMFaof48v543Ws/ASOAqznhA20f069bXUy+1wKCeNGbe
 hIsYqSkiNpnDHqazSVN5pMaWpD/2PM4MEdu21bH7rS27mhdIQ2dBKJYH1fo/ekQH7unk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=; b=UfAzEg04whi8B8KrWL53xY9HqT
 sPmv56eOT4bTk0WiERuR6P7LvPn1B3A8+db3xpp+rCc2setfmgTm4GJKVozOl5hik8c/ouNnb5aFT
 3e2vDv3Fqep+cMxQPrwzjIvEBlpDY/2UPVz713PzsjJJQXkr+zwS5Swo8lewBPMZv7Jc=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oXo7q-0065RH-3x for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:42 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 d64-20020a17090a6f4600b00202ce056566so3762833pjk.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Sep 2022 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=;
 b=CMK8yl635va04HaezlxwqGhnc+NtummcvVNmTRj+Aw0HdTOOjXrLWIHc/0WvZVthz9
 bzWNt4H/6kQaZG8pah0JB/zkRrjO2mSmUA4YdG+oM60f4pwLDpVOwTiFSDJmLRBSSkqW
 EEW2Wo57bBwPulyzdO9DrvL55rSoSkqNNPVgL8G8YFmqICIR1UW6FDiPSgv2lsM+Q0m6
 /oU7NxbfHNZ8dpXgDc+YLPWC34LYvTWZ2BfNI54J83f2NzdnRxeNf+B0Hi7YTy4uPL/r
 upU0ewURmuwmSgNW8yL4rSBCTkMXuY32/p+GZ9IWURvmoFbJFCIyPmyZRHOiuWFLgtsj
 nOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=;
 b=frhKP6GEVJ7R51QwuRgsFQUXdVc8W4w5ruYLmtxTF/vL3KCYdtF490Rk+gx/nG4Sxp
 UvLa2gKW14nbjl+N6Bh2vpu1ZYw4rCY/eKpNW6HtQpvKH1Fk3uvXiGJPAiYvJ86dzDjL
 AWHjeIpfx9KMmWeohfHehfzdZ70nZ7B9PrtZEohpuO5zAzHRS9Gqm4Uo/NFuy/pTis1p
 2qpIy5EjMhrGyao53gDhdMd9vRTI9h5TCt9Pv8WjseSplNJf7XwKuqOTC1NB6Eo93gXn
 tOIr/NpPl3YKlMRdSf3uKeLV+IKPq5iNFp0sBU5ypJl8aus2Z+/fqzQWzw2getg1R3aC
 u5Gg==
X-Gm-Message-State: ACgBeo00Yu6vLJDrqRVCj/oPyKCKbXMVxad5PP0jjLnJfW2vHdQRi5Dw
 Fafdf3ba5zFhvaEg9wUr8O0=
X-Google-Smtp-Source: AA6agR7XZwnzw2DppXNHM2jt00EgZHgdqYAADme8SoBB2ov63KPo6ZhrqFFvSytcKiLABstme34owQ==
X-Received: by 2002:a17:90a:6783:b0:1fd:ab56:5af7 with SMTP id
 o3-20020a17090a678300b001fdab565af7mr25916929pjj.39.1663007136527; 
 Mon, 12 Sep 2022 11:25:36 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 11:25:36 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 12 Sep 2022 11:22:10 -0700
Message-Id: <20220912182224.514561-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oXo7q-0065RH-3x
Subject: [f2fs-dev] [PATCH v2 09/23] cifs: Convert
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

Convert function to use folios. This is in preparation for the removal
of find_get_pages_range_tag(). Now also supports the use of large
folios.

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
index fa738adc031f..c4da53b57369 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2517,14 +2517,41 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
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
