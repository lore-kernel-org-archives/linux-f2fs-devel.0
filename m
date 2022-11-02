Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34153C41535
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Nov 2022 16:11:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oqGKz-0007bx-NR;
	Wed, 02 Nov 2022 16:11:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oqGKl-0007aR-UZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:11:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ViGofEkX7yEcmkcXNm3flvqY1FjypmnwIzQ3h5+k6EI=; b=eflTqn5Yw1WyHWmXO44LP2UaPN
 5RO5M51nUr7SMUndOa+YfqD87Zq3A5GWS8JoAllf2ND/XlwUF45BJoNTQLzD7QHCMEKd3UV/ljGF6
 GAOvmEoqUVpMygYb5IcUjeoEFYlqzlUjYru+JhPJzrmjwCFHNT/Jyk1FCQs6tcoWH1Ho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ViGofEkX7yEcmkcXNm3flvqY1FjypmnwIzQ3h5+k6EI=; b=YFV3Iaob2/QGbdgMuP3iLsGTZr
 25EapLti7JimQhGoc2gkoaKvX93KJEp0KRNMRbuJJLIWccDa7Z0lfqzw9RFpDxliLPlRg30JedFu8
 /Cn1Zyi0/0hdC7Ow9Rxplx/qjUfIHssCd1LK4u+aIFpwhZd7wTCZtGOIW8+OfFPO+Dug=;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oqGKh-00058a-NY for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:11:19 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 r61-20020a17090a43c300b00212f4e9cccdso2528183pjg.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Nov 2022 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViGofEkX7yEcmkcXNm3flvqY1FjypmnwIzQ3h5+k6EI=;
 b=n1wMZVPJgGAZfgmD3ZkM/SCD642n1Mc4Zn6+qTmFZdbiwhyj7wS8pZ8SFI+liwrQ2r
 jRtU/zEufgYnUSRmaPQbqmHP5jt+qqrNY2eB+O1n3FUDftvsWT7jdtVrRY3CCZiGe3K8
 A4WNFuGywv6YgnSjp3gkRLGNT2bhdMiVnpZ6tPSRX71fvkRoyEtYetGSXc69oJ1O1mWz
 KZNpeejY8S04w/0+Biv+H5A7Zb8g5E/3r8QLYAtAdy+fJFIPdJKL3md+xbL3oUEKqTZx
 /4olLVxViCwqQAaoUx8z7sEV7+rlEHas4BS4I6u0JIigVObca1ahPMhG3dFM4vj2Miz6
 v6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ViGofEkX7yEcmkcXNm3flvqY1FjypmnwIzQ3h5+k6EI=;
 b=nKpaKCiSZpJ0VTjVeiM5vKLQHJFBvgGbogTMfY7bKVd4hgb65I++DrvTfyFrgMtVAg
 6N5Jsej1L3ka1gK3f5qw21fz4R1H5b79GnSvzSlp0dGZri6WSQbmT24s6m6RrOjQLcPk
 Y2m7IbYJmy0gmhfmLRg6umSYSogxdAxYhG9HVzot5uMYVQpm4MbYHM4ESuqpRM3bJyJM
 kyhSID+vrzhhgfsFRnqFFa5v1U+rT2k49DQu7ALaPuOFooOo59mmwrIgH8OvU3oPDh4A
 s3EKbhUfFXRIXPJrIN/xXT5eNjw5FYy4D/FmSIAXhWIqxA4HTWlegLC1vh5+Bbb/s2Vq
 hHxw==
X-Gm-Message-State: ACrzQf2PZ+rxEgezSfyW8CPZRWTGp1KyvHl4C6SxbwJ+UVlNk9k3Yd6A
 HfyJLygDfdzaUOOU1sCYJPk=
X-Google-Smtp-Source: AMsMyM50Il1duVwG4WCRXyqqx6zo9JX2k0qIMVQGpTqxyyUEKMma/iNuAz7sS7Uhi64hLkOOMPexZA==
X-Received: by 2002:a17:90b:2248:b0:210:10dc:a314 with SMTP id
 hk8-20020a17090b224800b0021010dca314mr42536562pjb.15.1667405470077; 
 Wed, 02 Nov 2022 09:11:10 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
 by smtp.googlemail.com with ESMTPSA id
 ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 09:11:09 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  2 Nov 2022 09:10:10 -0700
Message-Id: <20221102161031.5820-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oqGKh-00058a-NY
Subject: [f2fs-dev] [PATCH v4 02/23] filemap: Added filemap_get_folios_tag()
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
index 74d87e37a142..28275eecb949 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -740,6 +740,8 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..9be22672ce1a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2262,6 +2262,60 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
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
