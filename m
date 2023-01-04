Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB138C46467
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Jan 2023 21:15:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pDB76-0002Wf-0W;
	Wed, 04 Jan 2023 21:15:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1pDB6o-0002Sk-8b
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4RtaC30O7Atkln5EkUr8a2iVlJILm+qXX7isWy43phI=; b=C0hop180tCoDKrJk3c5B3I2nUI
 hxUOWTIi3sAQDgXnfWSUCefcwN28MLPJWInKn9c3SCK0QRyqf9HcoWQVvoczDmfJ8S3vvPQZ4MAAx
 fhzBOGA4NjlvP9Q58M6FE7ihypY80aujh/hDdNLl4Utl2faz6M6nOit2E8quMEspI5Bw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4RtaC30O7Atkln5EkUr8a2iVlJILm+qXX7isWy43phI=; b=KxTKjEZU1e1gGbFBNAY02m8Tgl
 Oyr8PRoDX09QWy4pxTs4jRW+HV+K8t9fqJ26lfLb4HUnrTiyhELhEL0V2iL4Tr7uVAZMxbYXHaNhp
 C1KnVLVNjMhf44En1G4bs+kN4o9pvqWc/q/sF4GWUIXuJthIdrwkUwqraJhabMXok7B4=;
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pDB6k-00056P-SE for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:38 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 o7-20020a17090a0a0700b00226c9b82c3aso555599pjo.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Jan 2023 13:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RtaC30O7Atkln5EkUr8a2iVlJILm+qXX7isWy43phI=;
 b=dI7AOinQpZsTE8QFnkWx5x7pHBIx2GIKp/y/hPSc1NHAIhQSCV/YW9CIK9cZelspMz
 /UcbMNCeprdqj2GgjwjFWFax2vwmTS97zF8XvJynP1ckPDpwGdDlfgcvFL/67PrZtHoe
 8p3Tw9Jon6YIgT2dQef0u6QzS5v45L3ZduPZ7Vuz5T+efr2+eM/L19V2q4WYQQWenBXe
 r/FJhL2oCKug1uqMTJTCUDKbhH4a7abWBWe80Bzb0hil6lc0QxeilyS7fU95p9sAo3Hd
 5RiIKFAfe4YEQeX4Nw8KbDxJ6n6FANkPiGgIF3O5WGmAPzm6MuSYa4JZ31MPUbzgC2kF
 JUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RtaC30O7Atkln5EkUr8a2iVlJILm+qXX7isWy43phI=;
 b=zyICDdRgSksrxSUcGpaYfAXalwFJzbFvXvzCD27tnPG3tH8QNfWc2MWWwO/YsGXpWX
 Ec5bsuomxT6hiM6koH9SUzGrftodUztWfnVP6df34xYV5zZwH5NfYpVt5Sb4hsZbth3w
 UeApJlG7R6zzLKaWp4r+C84ALNpTTL2PzJUG/OcDv0WGeYAccvKn9aEcTNui8DdBUrIC
 l/koV1/+pmL1hXodcHuXYJHCX4HA4dmsZAZHeycnEl4MYyi42Hmn83L/Hru8CfrrS2rx
 1TsdAMOEJV4MVSk7ZDc29kfragio899otohqyRnFaQYaDh3FZDerOARgd6hgj6SbLa3L
 QsDg==
X-Gm-Message-State: AFqh2koy0N2yrTuqHem3yXWkkxAjY9qlgcQhSAs4f6bTYIIQENPrwuDy
 BivfnQ0ap4mO9IHYdPwXrvE=
X-Google-Smtp-Source: AMrXdXuPAz2h5R8V/Em6rEDV3mKeDGvzwSSguYGVRMwHcsp8CRceXnVJ+9DQaRs2mIwZh0/fEI9s7Q==
X-Received: by 2002:a17:90a:ab8d:b0:226:7efc:989b with SMTP id
 n13-20020a17090aab8d00b002267efc989bmr10104588pjq.49.1672866929215; 
 Wed, 04 Jan 2023 13:15:29 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
 by smtp.googlemail.com with ESMTPSA id
 i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 13:15:28 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  4 Jan 2023 13:14:48 -0800
Message-Id: <20230104211448.4804-24-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1pDB6k-00056P-SE
Subject: [f2fs-dev] [PATCH v5 23/23] filemap: Remove
 find_get_pages_range_tag()
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

All callers to find_get_pages_range_tag(), find_get_pages_tag(),
pagevec_lookup_range_tag(), and pagevec_lookup_tag() have been removed.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h | 10 -------
 include/linux/pagevec.h |  8 ------
 mm/filemap.c            | 60 -----------------------------------------
 mm/swap.c               | 10 -------
 4 files changed, 88 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bb3c1d51b1cb..9f1081683771 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -741,16 +741,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
-unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
-			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
-			struct page **pages);
-static inline unsigned find_get_pages_tag(struct address_space *mapping,
-			pgoff_t *index, xa_mark_t tag, unsigned int nr_pages,
-			struct page **pages)
-{
-	return find_get_pages_range_tag(mapping, index, (pgoff_t)-1, tag,
-					nr_pages, pages);
-}
 
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
 			pgoff_t index);
diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 215eb6c3bdc9..a520632297ac 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -26,14 +26,6 @@ struct pagevec {
 };
 
 void __pagevec_release(struct pagevec *pvec);
-unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		xa_mark_t tag);
-static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, xa_mark_t tag)
-{
-	return pagevec_lookup_range_tag(pvec, mapping, index, (pgoff_t)-1, tag);
-}
 
 static inline void pagevec_init(struct pagevec *pvec)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 85adbcf2d9a7..31bf18ec6d01 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2337,66 +2337,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios_tag);
 
-/**
- * find_get_pages_range_tag - Find and return head pages matching @tag.
- * @mapping:	the address_space to search
- * @index:	the starting page index
- * @end:	The final page index (inclusive)
- * @tag:	the tag index
- * @nr_pages:	the maximum number of pages
- * @pages:	where the resulting pages are placed
- *
- * Like find_get_pages_range(), except we only return head pages which are
- * tagged with @tag.  @index is updated to the index immediately after the
- * last page we return, ready for the next iteration.
- *
- * Return: the number of pages which were found.
- */
-unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
-			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
-			struct page **pages)
-{
-	XA_STATE(xas, &mapping->i_pages, *index);
-	struct folio *folio;
-	unsigned ret = 0;
-
-	if (unlikely(!nr_pages))
-		return 0;
-
-	rcu_read_lock();
-	while ((folio = find_get_entry(&xas, end, tag))) {
-		/*
-		 * Shadow entries should never be tagged, but this iteration
-		 * is lockless so there is a window for page reclaim to evict
-		 * a page we saw tagged.  Skip over it.
-		 */
-		if (xa_is_value(folio))
-			continue;
-
-		pages[ret] = &folio->page;
-		if (++ret == nr_pages) {
-			*index = folio->index + folio_nr_pages(folio);
-			goto out;
-		}
-	}
-
-	/*
-	 * We come here when we got to @end. We take care to not overflow the
-	 * index @index as it confuses some of the callers. This breaks the
-	 * iteration when there is a page at index -1 but that is already
-	 * broken anyway.
-	 */
-	if (end == (pgoff_t)-1)
-		*index = (pgoff_t)-1;
-	else
-		*index = end + 1;
-out:
-	rcu_read_unlock();
-
-	return ret;
-}
-EXPORT_SYMBOL(find_get_pages_range_tag);
-
 /*
  * CD/DVDs are error prone. When a medium error occurs, the driver may fail
  * a _large_ part of the i/o request. Imagine the worst scenario:
diff --git a/mm/swap.c b/mm/swap.c
index 70e2063ef43a..5f20ba07d46b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1119,16 +1119,6 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
 	fbatch->nr = j;
 }
 
-unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		xa_mark_t tag)
-{
-	pvec->nr = find_get_pages_range_tag(mapping, index, end, tag,
-					PAGEVEC_SIZE, pvec->pages);
-	return pagevec_count(pvec);
-}
-EXPORT_SYMBOL(pagevec_lookup_range_tag);
-
 /*
  * Perform any setup for the swap system
  */
-- 
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
