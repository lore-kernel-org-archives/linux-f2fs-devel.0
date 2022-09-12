Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB86C6FA93
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Sep 2022 18:25:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXo7j-0005Gd-AK;
	Mon, 12 Sep 2022 18:25:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oXo7h-0005GX-Bn
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CVjZRQRXjU7sjBLr6rHvAQKfUIl2rAWam+cMUVwdi8E=; b=EC2JVR3pv9XlxlvlX9eBeALf+8
 SB2CilsvlHTl1jX2O2zGdzn4DawW11MJgUfe92sqkzz7iKP/cs9OwWhsZZwTT0kCwVKuaTfRWi3ZE
 HM1Gs1F4NaJmEaQjvGqncu3TSGCi66H3EBgl49HDwQlsu/CdN0Gw1V2bF/NKBtpitcZo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CVjZRQRXjU7sjBLr6rHvAQKfUIl2rAWam+cMUVwdi8E=; b=FKxemcq8t4HGA8HP9RmaZRXnOD
 9qeHNyLraDT3UcyrdVK2UTQmvonqWuzkNpTm1xQs3kD+tjhXxlzKVnFyc55z9l77QV/lyHp6wKTUa
 nR/WY2aSkLUi2+kO39HKZ8F5CW8rShybh7lAv9Y3wHs+btlVGBA1uL0a4uilHeto4/n0=;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oXo7d-0003lg-BJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:33 +0000
Received: by mail-pl1-f171.google.com with SMTP id x1so9384651plv.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Sep 2022 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=CVjZRQRXjU7sjBLr6rHvAQKfUIl2rAWam+cMUVwdi8E=;
 b=C8tTc8TnMRmq8rC87xPSSFuWkjT3xmHJ0btLP2zj1KPi/mYfzMf8Rr4ArHYir2v9F0
 aDLj56lDM+iFTWk/zg8V9FMLydED1mER+7ZW+HSacA1Ej5sNBEeth+9uec6b+pru0Fpv
 3sKnfJN/oUk6XdHc8r+TXXl+xNqynm1rWDRyJu95M1GlHq2pvxvtoyD/Kya0tcn4ND8L
 v1Lj8AH8zQNtOiQyHh0+tz0ZCnJc5SPGGoRYBgWwYy1Ws7ceTUrmQfwfqPJzc7zkKdfX
 2VvNkqm5gSbU5GD8ydRTGzlx8S2HOxhhfdTfh+LhphtedIuii+OhWYM3mjKtn9npS+TQ
 RINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=CVjZRQRXjU7sjBLr6rHvAQKfUIl2rAWam+cMUVwdi8E=;
 b=rs/W7GpoKf49lKaM74suuVrihON4QVo6ShjcaOXq+x1+130vsZYhR2OBF0hWjtKbSE
 OtPpgbCV+tfypdLcLBdxnZWFSWa7ySseOuC5XS0mVRaVzhp5tabTYhdJOprcdqbqQUJd
 x3Hn2bFBmhPwfoE8pOFjmC0SgQdXf05WXneB/eNppWNd73ukd/QUDq7sdaj0LJiIB705
 iMNPs2wU9lptHTo6r75vMt00tqnoMO3BWqjooGgKgUrr6r6TB9KqaGp6IqDEgXj3WXDG
 7BECgMYZkOKX2Wp8ciAXfExB2N6R77NfMiex64bA7S0w9xH+YyK3GYPJ4/fo7eDb/iTj
 M0/Q==
X-Gm-Message-State: ACgBeo2KkK3d/c+gd6Wfa9rF7N9vd8/yAck7nXDTdyvOFtHkILtu1fXh
 OVO0iMh2+6ooViXymrNccUo=
X-Google-Smtp-Source: AA6agR40OpkZ83mFEur41Nd8yYH6gBhsxOKDPQNbIwZqQIbEwWceV824CZSdb5ygWwDeOXZ24XfwnA==
X-Received: by 2002:a17:90b:4c46:b0:202:b9c5:2f24 with SMTP id
 np6-20020a17090b4c4600b00202b9c52f24mr10473866pjb.180.1663007123740; 
 Mon, 12 Sep 2022 11:25:23 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 11:25:23 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 12 Sep 2022 11:22:03 -0700
Message-Id: <20220912182224.514561-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oXo7d-0003lg-BJ
Subject: [f2fs-dev] [PATCH v2 02/23] filemap: Added filemap_get_folios_tag()
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

This is the equivalent of find_get_pages_range_tag(), except for folios
instead of pages.

One noteable difference is filemap_get_folios_tag() does not take in a
maximum pages argument. It instead tries to fill a folio batch and stops
either once full (15 folios) or reaching the end of the search range.

The new function supports large folios, the initial function did not
since all callers don't use large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4d3092d6b2c0..85cc96c82c2c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -740,6 +740,8 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
 			       unsigned int nr_pages, struct page **pages);
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..3ded72a65668 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2254,6 +2254,59 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(find_get_pages_contig);
 
+/**
+ * filemap_get_folios_tag - Get a batch of folios matching @tag.
+ * @mapping:    The address_space to search
+ * @start:      The starting page index
+ * @end:        The final page index (inclusive)
+ * @tag:        The tag index
+ * @fbatch:     The batch to fill
+ *
+ * Same as filemap_get_folios, but only returning folios tagged with @tag
+ *
+ * Return: The number of folios found
+ * Also update @start to index the next folio for traversal
+ */
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+			pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, tag)) != NULL) {
+		/* Shadow entries should never be tagged, but this iteration
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
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
