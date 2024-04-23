Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36752C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Apr 2024 17:04:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzJYx-0000R0-Q4;
	Tue, 23 Apr 2024 17:04:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ryncsn@gmail.com>) id 1rzJYw-0000Qu-VL
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Apr 2024 17:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Reply-To:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Content-Type
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ccxP7TY1LZd03lAzTUSjd/WMiiw2l1TFGZjibmTvaRo=; b=C4tR0p0B3kJWqz9zx7BcTLrRf/
 QeSkyNXrksV3jLqRt1Tj6mIDp1Yj3ai59ghqXSesCb10xeANzufKgaf5ozaj4H3Q0lW/t5VbiaYOb
 e+AzX7uUnAhtQOukf2RBi5QU1U918xsFJYGUirNT92x1yPLV5if4HWVuDgNuIpeH+3to=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Reply-To:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ccxP7TY1LZd03lAzTUSjd/WMiiw2l1TFGZjibmTvaRo=; b=YKrkJ5irzl5xeziMkymUaebaQq
 +D2bt5ONZiquzK6I3wGrK6VkCmLdexYUSRjWlSDV7oYcxiX+zMvUCmNUv3/tNyKpFcrlkqCN2DS8P
 9cP+pO9ZjPp8YJu6Kb0X1UqI4ob1XSxDTzzHxwm/99/AJySmxihcaM2300luE16AEJmQ=;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rzJYv-00019c-HJ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Apr 2024 17:04:11 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2a58209b159so3913750a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 23 Apr 2024 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713891844; x=1714496644; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ccxP7TY1LZd03lAzTUSjd/WMiiw2l1TFGZjibmTvaRo=;
 b=XLAsc+NcbTbok4xzMgFK7H33oZU+C05+Qq1pdZvrhFf/C7q3RsnTprFiddFhf5cZPC
 OTIh+9z+/yPY2MGdOseCl8CGcvMc+3bt29VJn5ytI4eDpkOEINuiOUgTi5QwIVspYqjW
 SVmivqKGpGjXPHcD+6SIIWYLvO2DEd1vYtvsOwyrSz/jTjUg2qiNbcjFJff7YtlIVRED
 rOZejrzsovSC1foMnvMEZrsmA+WwwzWi1rAgiuaSmpJks97jdzJ+2+IIkAHUEy5gjDud
 +hUhcZd/XA68//GTFy6JuQGOcy8uDO6TyhK/3+nOyf2DC97vbAuv+h4HUP12PtL+mf7T
 hXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713891844; x=1714496644;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ccxP7TY1LZd03lAzTUSjd/WMiiw2l1TFGZjibmTvaRo=;
 b=tSTB2ucrcLsnYnXqFVXu22eFz5e4YczSTgtJAcOOMeQYNlaKCIFLn0yJjR1emYY4Qy
 6A1WpsSVf0CDofnaMuYJAnAej923rhBUOpHyQcOdTvgeQkkCgmmEqmeABKdzL3UBOVht
 g2YRDVJWMjDlPmEg3tC4RhZPDbEqRaRLRoaKJoiuQquvzjPPSKwwx8HwA5bP23lNkmrj
 VAFq3+srdbZbHlMJmdqX/ky8DC7WucFPMekCHFZlrNYVQ5kItzi/IXtsw/8D0uFN7m7O
 qbkpN1ZTrZg88ix5Z6g3HYcBBzikwyVWNBZEs5u+Aed8BznATjAyK4dzomkePFkDW2x7
 CBiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSNJ/Ilx0Vv9RcnAY7CJl/NqrfUXnAvGg7uNT2JT/feQRQtdqL3e82vfOLv6DKArTQsNfRcdrhXb1xH5dwyPbwCz7Z4MhQNDRel1z4frW5iQlUvAdP/g==
X-Gm-Message-State: AOJu0YzaHttuF/drlI1Di/MPDz1CJ27N1kFVdq0XomXXq1bO5efIC6sQ
 DoyeDFKgOWx93PohqfHnYqZvd0hQ23Det0Cuagb6evCTLku8sZ2W
X-Google-Smtp-Source: AGHT+IFl9PJyw3gV5yMYnps/pmPpaL5DbNMyQbbzhrOpZIakLlc/OOAGq7K0pRF3PyTBE2M2iwLZlw==
X-Received: by 2002:a17:90b:238b:b0:2af:15db:c741 with SMTP id
 mr11-20020a17090b238b00b002af15dbc741mr325358pjb.13.1713891844299; 
 Tue, 23 Apr 2024 10:04:04 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.04.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Apr 2024 10:04:03 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Date: Wed, 24 Apr 2024 01:03:34 +0800
Message-ID: <20240423170339.54131-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423170339.54131-1-ryncsn@gmail.com>
References: <20240423170339.54131-1-ryncsn@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1rzJYv-00019c-HJ
Subject: [f2fs-dev] [PATCH v2 3/8] f2fs: drop usage of page_index
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
Reply-To: Kairui Song <kasong@tencent.com>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Chris Li <chrisl@kernel.org>, Neil Brown <neilb@suse.de>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Yosry Ahmed <yosryahmed@google.com>,
 Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, "Huang,
 Ying" <ying.huang@intel.com>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Kairui Song <kasong@tencent.com>

page_index is needed for mixed usage of page cache and swap cache,
for pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here, so just drop it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..12d5bbd18755 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2057,7 +2057,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	sector_t block_nr;
 	int ret = 0;
 
-	block_in_file = (sector_t)page_index(page);
+	block_in_file = (sector_t)page->index;
 	last_block = block_in_file + nr_pages;
 	last_block_in_file = bytes_to_blks(inode,
 			f2fs_readpage_limit(inode) + blocksize - 1);
@@ -4086,8 +4086,7 @@ void f2fs_clear_page_cache_dirty_tag(struct page *page)
 	unsigned long flags;
 
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	__xa_clear_mark(&mapping->i_pages, page_index(page),
-						PAGECACHE_TAG_DIRTY);
+	__xa_clear_mark(&mapping->i_pages, page->index, PAGECACHE_TAG_DIRTY);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
 
-- 
2.44.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
