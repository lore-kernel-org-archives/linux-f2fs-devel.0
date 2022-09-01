Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF384C6FA8C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Sep 2022 22:02:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTsH2-0000Sr-DX;
	Thu, 01 Sep 2022 22:02:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oTsGz-0000ST-Hj
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:02:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=; b=db04a/JTdhdYR+rUzrNwvIqf2Q
 shdYr0/H78hZkME8phvJ7UQMDb0OHSndZv+ddjySo7TfJw/XZsSgiU2ETpud357Frfxeekdza3Dc9
 EsDU9kFdZGskMKFEDJsp/sCcbcuu1C6r7WCVNr7duFvzVHI+wUEdqsO06Cq7wAnXyneo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=; b=EoJrrhsy7PzcN/00nDBgdrsWxP
 4A8gH0kWbFFALHicD64Bjh5cj9DJDYbQTfBS+7TjnuRzGXK1nGNOZ+yAxyHK4I9xRNf61QbngtSWD
 17Q95f2POq7PEb2hEsl3JGvfVVm0TXvJj+Xr3D4RFXmEvapkEQcHijTTJyVo3ueEjHKw=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oTsGz-00Aafj-0U for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:02:53 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 z3-20020a17090abd8300b001fd803e34f1so3745899pjr.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Sep 2022 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=;
 b=GtrGYdGLszgBq1fvi5V2PSfoLOXh1TNyiK0ofvUFGiVvwdQ6PkaGy3Ns4qJwLgF4b3
 aIYdrsYMX+clX1Y+yOXcuDls8w+WiavI/64KPDiJmDgxyBZ4dAulShvhPc4ENInwd3Br
 cmukOGKll48ywyFlU3xTzvvA/EhYiy85fvbJiJhltWdFBrenWV2xIc1tgrmQTV6xVFrr
 kPWQoFcSoXWz75f58hl6lYhesgfwr3gasm4nlqUw3/vIqwimOmHoTKvTQsLxit2YTq1H
 EGgbgkZ8lcymg9dX7HeYXgo7ygr9E+FPEd+ZGk8VSDrPOWMvOyx7zdOCyAyIqsvEGW5B
 7Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=;
 b=MzmxQkuwrIW5ASAmFEf0VLN45Th0mlOcJKzALvI0uQ73vdymWisozz7bx3bEQSRRB0
 869XMgJolPo/QeOF01ietoF1YuomqhTdUx4CsznCNr7HsjVQxHXsSWBzDMZfN09B6omJ
 Xr0ipXR4YJkfqNjp9MXMrFvF1DxrCXVgxP4qPhvUp+JlDW4hNtnSVtPypZDlmFN/Wh1h
 tzrfnBD81CeExF5YA+g2ac8ggfQeOyNKUJLf6UUNt9KuJofI/zH8mnG7+ZLe69KEwn3k
 NuJ0Fm6cXA3ZoZkz3Tg+SY0gTpSaBCDHJfEDg0nBqYGsfyn0IzUzfzyNizS0LI3AE5LK
 uneg==
X-Gm-Message-State: ACgBeo3SiNFQwtNEvObjWPLX3UXDvTS/GAc60AtI67K8zkt6xQ3QS00Z
 zt4Lkv6CS9fqwW+nri4VksiCTU2UBtRV+g==
X-Google-Smtp-Source: AA6agR7dfnvwb+YDcWYBRWPejd1+fbHl6FDcd6aRRcb1reei6qT56P411IPlU9pH3GjxRMm/z5BQBg==
X-Received: by 2002:a17:902:c613:b0:174:7a32:f76 with SMTP id
 r19-20020a170902c61300b001747a320f76mr24825305plr.165.1662069767428; 
 Thu, 01 Sep 2022 15:02:47 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Sep 2022 15:02:47 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Thu,  1 Sep 2022 15:01:24 -0700
Message-Id: <20220901220138.182896-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oTsGz-00Aafj-0U
Subject: [f2fs-dev] [PATCH 09/23] cifs: Convert wdata_alloc_and_fillpages()
 to use filemap_get_folios_tag()
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
