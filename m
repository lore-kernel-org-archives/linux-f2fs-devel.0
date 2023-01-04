Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF33C54EBC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Jan 2023 21:15:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pDB6Y-0003QV-Ah;
	Wed, 04 Jan 2023 21:15:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1pDB6W-0003Q8-Uo
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HZ+AsMarClzul4w07hpaKmVXDP421VTrEgQP9XGRZto=; b=Z0QAx663JwOCYlDH9owm/yhtJ9
 LBPS7G1CBXTlncaD1DoUWBceTesY8MADZXEnkCvbmsCRVgoj1BUdZaDd/cEhNCxERPZwSuO17LNvH
 HIE5mKI2IwxhzLO0bdfxLB8ntcZnepxdX46WSlKKxWLyajd8uKqx2Kg2UX1EnudZGJZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HZ+AsMarClzul4w07hpaKmVXDP421VTrEgQP9XGRZto=; b=VksabDOqdWee5FWZPUMffoKpL5
 lVrmdSAKCnCwuFZED2f3oYVNKbVvJuK1ZkYpfLNw2xxgAPoWprV6XTz6TmtlZSNSkkN+hRSCB5o5Q
 dgbuzipDpLBIV2XH/fEGI/nJ76v5YpaF8rlmgdwDv6fQdzUSDd7NoOUkyNhMdhv+wZVI=;
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pDB6T-00054h-To for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:19 +0000
Received: by mail-pl1-f181.google.com with SMTP id p24so14705276plw.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Jan 2023 13:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ+AsMarClzul4w07hpaKmVXDP421VTrEgQP9XGRZto=;
 b=YYuOdit3NxbNrQLvQKQzYy9fInjz8epNnsAie9l78qOZwItZ1q9762RHvdjHvn0w3T
 Itev/qVCegvvtOsHjlnt/i8oYcY6s8Pbft4yn8UlU5hO8ANcihMCzw6L7clWMBVNlkml
 DdVTstYmIe6uBY+QKphA7A0vNicwDIZfmnlRaGywuDcd3L/Dz6ksmUjm69PNaduiwT0y
 oDarQ2Aeh8wlIFX7joZPiMSA82+zZJyehOMhZmZgTN7kokD4EtjK7YG4/3QTFsugmOWW
 sUQ8oex28ZiETO1YVZLLNiEuF950kwCKMCnU79wH/Yyl7cH+rVKP8QdTlOWRApZ8hx1s
 Ciew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZ+AsMarClzul4w07hpaKmVXDP421VTrEgQP9XGRZto=;
 b=zkGhg8+8kZwVx7SnMaVh2ZvnJQwQDxqD045Zt1vPi881ZcIg5jfxhU1h6GIuvIbsz8
 DzC7gKleFzzMV37WKO6X1JuP6ST+bAo7v18hL3Udu+6Xwb7j/ea2rkHIiBVMg7ny/IZF
 5B8wmlXlPupmAQCBDghONwTeLrlAeeIEbx3rtz3q6uKixGm/qGegzDA7lRTlGgw8Emm2
 D0lK3ARrdp+6uL4uLgbWqMlhn13d3VgKdnuwe5Gf0fcsUHMOJJeIufTyGJceom+c5DUj
 edRZpQKw443kq06rThjv633rM8TqfDxPVldWn8S/SGhU094kT6Ske3lM5114oU7EIdPt
 o5kw==
X-Gm-Message-State: AFqh2kpz5SK0PQi6g71BEYa9bcfpKcac691uyZaDTM6vShkiVg+mzhrI
 gGKnUnCI3GTBwPimovo6TiE=
X-Google-Smtp-Source: AMrXdXtdY5GUpRFH0/rWB1ui6dE4PdO42I8quQD8+H41n2qV43RNlBpjdfLglYXYOXUh6D0WzIQFFQ==
X-Received: by 2002:a05:6a20:429f:b0:ad:bd55:6dcf with SMTP id
 o31-20020a056a20429f00b000adbd556dcfmr72875976pzj.28.1672866917539; 
 Wed, 04 Jan 2023 13:15:17 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
 by smtp.googlemail.com with ESMTPSA id
 i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 13:15:17 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  4 Jan 2023 13:14:40 -0800
Message-Id: <20230104211448.4804-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1pDB6T-00054h-To
Subject: [f2fs-dev] [PATCH v5 15/23] f2fs: Convert last_fsync_dnode() to use
 filemap_get_folios_tag()
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

Convert to use a folio_batch instead of pagevec. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 51e9f286f53a..cf997356d9f9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1518,23 +1518,24 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct page *last_page = NULL;
-	int nr_pages;
+	int nr_folios;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	index = 0;
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_put_page(last_page, 0);
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				return ERR_PTR(-EIO);
 			}
 
@@ -1565,7 +1566,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 			last_page = page;
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	return last_page;
-- 
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
