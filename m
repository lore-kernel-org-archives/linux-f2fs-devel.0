Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A255BC54EBF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Jan 2023 21:15:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pDB6h-0002Pn-78;
	Wed, 04 Jan 2023 21:15:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1pDB6c-0002Ok-9r
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L90Su4X0B6ZDbXSVecEDf/ou5Q5FXQ0WnoUVcaVOv6Y=; b=YgvcIdb9b6MdNjYUPfibYeUktk
 b5fFEYc+TK2nNvcrB7dOEfrR5h+Zz9/m2xG8UJFuVbT9AoiWFQ1v8dLNjv0ux6KWfo2XLhh/rVxqj
 4iLuEMePFPb1rwL5G/dKWtr8wYOczkZYuJ/mfS9en9aTcxBZzhu/kR1uWlvb8NwA9bfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L90Su4X0B6ZDbXSVecEDf/ou5Q5FXQ0WnoUVcaVOv6Y=; b=h+LNHN8hBgQTBM56tLZ3cAgV48
 MnOs8duaGwoYHB9/uyMPXt4eCVaSvxMxkH+ubWFOZFhWW0wG6ieVyqVfhovj6qJgio40ikorJrC2R
 wUgzdhzL+N80p5BZuK404XlUo9UZCmnoHOGIk6wkKXAGMj+OREveGE08BOPVUEAoKtxk=;
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pDB6Y-00054h-Br for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:23 +0000
Received: by mail-pl1-f181.google.com with SMTP id p24so14705612plw.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Jan 2023 13:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L90Su4X0B6ZDbXSVecEDf/ou5Q5FXQ0WnoUVcaVOv6Y=;
 b=IJQ2lGSLIhJxuzMRKK4freJEwBJhCzBUrph/WLRQ43Sy4Xeacbh1o7/sSt5j3pOh8Z
 LL8WHQC/7wF5bp73Ob+g8tBBd0notcEteRMybn5RyZfu96sHRm/Pwe8Ls04wVXfjMg20
 8FMDvGDJgsLK1C7YpCx3k79sPNIbPSWeB8cC6hxkdsp0thSpN2GQNQUGqoi3GcaDthu/
 w+Bbr2ES9OtWsORlXKrzLdZc6TBzxjM1qEpazgTeIQ7mhN7PD2UYDA1xUnKMGnkHAoYQ
 iN/0O7yxoY8ZPHeBYXpu6QcmywT4JFhGiJUbmS68g6J79g5xBmH4zGz9QdwEO8z0grET
 Xf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L90Su4X0B6ZDbXSVecEDf/ou5Q5FXQ0WnoUVcaVOv6Y=;
 b=eNCST1S7QWDkSWYIwGnkL4iXEeAAk+CJno3nkXz4jF1yAS2DrAiMfBv0jk5bic0StY
 GFmDvsSm8LDmoe6UmwD8wmAaOg0UHEMJVW4X4xxymVFcjxFGfYae4Q/m5l8Uyw7qmo9I
 Rwt0UWftLozAdUx8xIFs7x/0lIPV/lw+q7c+lMhDwa6dE5SOum7+19veg21ccAPlOjNI
 m1qeYsVW31GPXeHToeWjYXKnKWh1cHff5vWios0nGIOpJRvqMOF4ALFFEV50UuB6aZ4s
 lOTEWenu2FFtPCMIBy2c0KElj/t/K+2jVj4stURJuMjI2bSBTOzgHIdsIQmoE2c8e8Su
 /L5g==
X-Gm-Message-State: AFqh2kqZiVIUknTzH8acSv9tHF7hYKt/Isgu0qwKRQjVmz4Rf9bXHWzE
 969YiTjopaZRRNYy92Bjg1/nc8Sb0XG2uw==
X-Google-Smtp-Source: AMrXdXs0jILNZaSP5jFG9YIUbLTH48SWLc/tHrgI72duQuw1JM4+CAQ/qirxeGWB7GaMFZz6MKkM3A==
X-Received: by 2002:a17:90a:8c18:b0:221:5897:d46d with SMTP id
 a24-20020a17090a8c1800b002215897d46dmr51320455pjo.1.1672866921917; 
 Wed, 04 Jan 2023 13:15:21 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
 by smtp.googlemail.com with ESMTPSA id
 i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 13:15:21 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  4 Jan 2023 13:14:43 -0800
Message-Id: <20230104211448.4804-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1pDB6Y-00054h-Br
Subject: [f2fs-dev] [PATCH v5 18/23] nilfs2: Convert
 nilfs_lookup_dirty_data_buffers() to use filemap_get_folios_tag()
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
the removal of find_get_pages_range_tag(). This change removes 4 calls
to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 76c3bd88b858..8866af742a49 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -680,7 +680,7 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 					      loff_t start, loff_t end)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	pgoff_t index = 0, last = ULONG_MAX;
 	size_t ndirties = 0;
 	int i;
@@ -694,23 +694,26 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		index = start >> PAGE_SHIFT;
 		last = end >> PAGE_SHIFT;
 	}
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
  repeat:
 	if (unlikely(index > last) ||
-	    !pagevec_lookup_range_tag(&pvec, mapping, &index, last,
-				PAGECACHE_TAG_DIRTY))
+	      !filemap_get_folios_tag(mapping, &index, last,
+		      PAGECACHE_TAG_DIRTY, &fbatch))
 		return ndirties;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
 		struct buffer_head *bh, *head;
-		struct page *page = pvec.pages[i];
+		struct folio *folio = fbatch.folios[i];
 
-		lock_page(page);
-		if (!page_has_buffers(page))
-			create_empty_buffers(page, i_blocksize(inode), 0);
-		unlock_page(page);
+		folio_lock(folio);
+		head = folio_buffers(folio);
+		if (!head) {
+			create_empty_buffers(&folio->page, i_blocksize(inode), 0);
+			head = folio_buffers(folio);
+		}
+		folio_unlock(folio);
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			if (!buffer_dirty(bh) || buffer_async_write(bh))
 				continue;
@@ -718,13 +721,13 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			list_add_tail(&bh->b_assoc_buffers, listp);
 			ndirties++;
 			if (unlikely(ndirties >= nlimit)) {
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				cond_resched();
 				return ndirties;
 			}
 		} while (bh = bh->b_this_page, bh != head);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 	goto repeat;
 }
-- 
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
