Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D02C46467
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Jan 2023 21:15:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pDB6L-0003OW-PS;
	Wed, 04 Jan 2023 21:15:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1pDB6G-0003OG-Kd
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KWc2oMWZrabUsNL93YYBg0xBgzl7UJM5P4FHRP4dszA=; b=bjZd5IFgSa70xV7PJC4/1bNSz7
 Z0oeY1hgj9wxKe3YOV4fxELVzlg/M6hPv+k26uN1sHL7hGITxBAYbOKEHKi7TUp6r9op5ZwT+HBDV
 skYXenmO4eNpU/k4nf4hngkqOr5S5CgZ00vMHSajJ2i/z1sxGy0euErj6YF1jG5in7c4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KWc2oMWZrabUsNL93YYBg0xBgzl7UJM5P4FHRP4dszA=; b=gV7XVS8ulPpkdR6aZqcCXCNABP
 tDRFKZONqkMe0wIVRfG5fF78fenUpZt81q0ny6bAWzb4+mar4edaOlTJEGr49ovcynCVoHAUZm2Wd
 HHWe85XZuykjT++wS5zqk0qEnupRwXKCUdzcuMSaKU9ejkzmAOE1nxIUUflyf0hT5qvc=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pDB6F-0050wZ-Vr for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:04 +0000
Received: by mail-pj1-f49.google.com with SMTP id cl14so1065616pjb.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Jan 2023 13:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWc2oMWZrabUsNL93YYBg0xBgzl7UJM5P4FHRP4dszA=;
 b=X+JhwQB/YFpkv9O3Sz2RIqehaNfUYePllMKYDSfYMVmQ80S+7Znm3qUhQQutUgGzcL
 0uq/hVoyBfqjmkDpyVZm/VIPt68FQqEGQ82Nd+zz6E+E98NXjR4XSpPj/MXztZhY0W/5
 2SnakvGDdpx0xcZLQD7UZxy8cVZY3oo6XDRKLX6rp+1lZ5XfYRhOxIIbBxK+QOE0O7oY
 mvbbq1JpLOKHZ6D7c98chruQCpXs68i4ZX3rFltoX/XuVJPECIsdkN1cooENDtzYQJT2
 bRwgzwaxOKhTwxGYYDaTYxmm4WsaqrwCXgLa3BEJo54/4GqC8mZRZtI56zwUYC6qebL9
 Oo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWc2oMWZrabUsNL93YYBg0xBgzl7UJM5P4FHRP4dszA=;
 b=Tsv8yB/13VeddX+O0Iz+v4+Fe9Yd6SQE+SetaERDcnpz4h3tp7YV9zKW0twT4zTbAr
 CT2BMfN6Sm4yv4oitnShgz2VSduawdU1ESNMf3aG/bzmkGBfKM1MQvyq3qiui/xGcOF6
 D2+Q6Oxv7JYWAL/vdUMoTdhOJwKkRwy2GsetzXm9amSRQlS95ilqMaytieH2vC5Yypqx
 vsbuw+Rbww5i3076onqYnhIt0rabXBlfcOsfKdncbyyDU5dtJZhSNxo26aKr7UF9pBjK
 VK35yEl5obqg4nAgTFD0422tsS04+VqWx4whyE6uzZxnrWNdq9FlLAx6ORuHSYIG/qWV
 qlnw==
X-Gm-Message-State: AFqh2kpnSFf8FB2O5pZrHX+INOZh2v2YgbJm8COWv0c82ZH1rZ0IUj7c
 WvHt76j9pwN1WK+h5A/BA+s=
X-Google-Smtp-Source: AMrXdXsQLnyc09jFT7hjT2KR1nJMp1M067OD5YrApEuRuIFS+9J6bRUAVKGRrDQmj0MgbIV/5rlsug==
X-Received: by 2002:a17:90a:cc2:b0:219:9973:2746 with SMTP id
 2-20020a17090a0cc200b0021999732746mr65437761pjt.0.1672866898346; 
 Wed, 04 Jan 2023 13:14:58 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
 by smtp.googlemail.com with ESMTPSA id
 i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 13:14:58 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  4 Jan 2023 13:14:27 -0800
Message-Id: <20230104211448.4804-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1pDB6F-0050wZ-Vr
Subject: [f2fs-dev] [PATCH v5 02/23] filemap: Added filemap_get_folios_tag()
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
 linux-kernel@vger.kernel.org, Matthew Wilcow <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is the equivalent of find_get_pages_range_tag(), except for folios
instead of pages.

One noteable difference is filemap_get_folios_tag() does not take in a
maximum pages argument. It instead tries to fill a folio batch and stops
either once full (15 folios) or reaching the end of the search range.

The new function supports large folios, the initial function did not
since all callers don't use large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcow (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 54 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 468183be67be..bb3c1d51b1cb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -739,6 +739,8 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc70..291bb3e0957a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2281,6 +2281,60 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 }
 EXPORT_SYMBOL(filemap_get_folios_contig);
 
+/**
+ * filemap_get_folios_tag - Get a batch of folios matching @tag
+ * @mapping:    The address_space to search
+ * @start:      The starting page index
+ * @end:        The final page index (inclusive)
+ * @tag:        The tag index
+ * @fbatch:     The batch to fill
+ *
+ * Same as filemap_get_folios(), but only returning folios tagged with @tag.
+ *
+ * Return: The number of folios found.
+ * Also update @start to index the next folio for traversal.
+ */
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+			pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, tag)) != NULL) {
+		/*
+		 * Shadow entries should never be tagged, but this iteration
+		 * is lockless so there is a window for page reclaim to evict
+		 * a page we saw tagged. Skip over it.
+		 */
+		if (xa_is_value(folio))
+			continue;
+		if (!folio_batch_add(fbatch, folio)) {
+			unsigned long nr = folio_nr_pages(folio);
+
+			if (folio_test_hugetlb(folio))
+				nr = 1;
+			*start = folio->index + nr;
+			goto out;
+		}
+	}
+	/*
+	 * We come here when there is no page beyond @end. We take care to not
+	 * overflow the index @start as it confuses some of the callers. This
+	 * breaks the iteration when there is a page at index -1 but that is
+	 * already broke anyway.
+	 */
+	if (end == (pgoff_t)-1)
+		*start = (pgoff_t)-1;
+	else
+		*start = end + 1;
+out:
+	rcu_read_unlock();
+
+	return folio_batch_count(fbatch);
+}
+EXPORT_SYMBOL(filemap_get_folios_tag);
+
 /**
  * find_get_pages_range_tag - Find and return head pages matching @tag.
  * @mapping:	the address_space to search
-- 
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
