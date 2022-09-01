Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C68C6FA92
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Sep 2022 22:02:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTsH3-0000Mo-RL;
	Thu, 01 Sep 2022 22:02:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oTsH0-0000M6-29
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=; b=boEAOzxQ+NvcC+MkPZ70l8rLt8
 NZTKhSXSjs8RaBDwVVVs6AuHPKg7r+83wpH8YH0opqrDlpJli2uKWeoWco8t5NBf0gC9Mwq/95MqI
 gCI/ZGm/fktuFUsj8vosM3a7aiy+b4oDVGjp6RBAj9hxn1QVj7v0l+0o55TpIW9q+/AI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=; b=BKWcwpqBGQfmXSm0GYjUJSZB/A
 R8fJgRHJJ34QZPl5aWpMEcK8SFgzCkKIwYEkioz7hA3mwzNq3bkmdIeQA8VNuoVSfIFyDPHTY/I1C
 zXxWVDBkK1g/n01QeJbwJNoo6MOMmaILYwx/Ns9RCibQa7yU7FLHEyGNJk4Tl6Fg/lRE=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oTsGy-0007uU-Aa for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:02:54 +0000
Received: by mail-pj1-f41.google.com with SMTP id q3so257729pjg.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Sep 2022 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=;
 b=b1/QSkbA0KE2xUlFrUXQEVG0tKpol73bVxgD0JU9l+NoBY6qShuSjNB+kmeBlOMRM5
 JTyIWvr9pHHuB5iH3YW16+gbFOwJPd0guEmk3lwDKP1rofaLlcFIYJW7KLMyPaqSsnUL
 3ANonRcxOaEgEr3fjaSMK6EhvpBNrqrC9y5jO3YalIG74gceZr+XlLuEMojU3DQOF2YT
 ZNnm8VG78RQtVu2G6CZxxzpbZ3oGLbUw/rcEMpsLZCHgtIqvQM56vT9Mo84bDHjBrKPR
 idwfoeW+VWrVke2zu158oVXXH2A5l7M+GBuTmwchmOVovptMyXXZZra4FRtAg/MbnMB0
 QMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=;
 b=csUelESaui84MEkiIosG7V34763s+Qr04OL14/1XrfKtjw+884mOXVRPJnd6u02C4H
 SF3mXN+yoM9h+JMDPn3pqJNv41VDO24b1/EzoXzGCjds3ntLkdbANessER4TOSGcX4cx
 LL5tdXiWTMNJbK4HN2Wq19Dvo2AblmFhmt+OEILSavj8twj5UFYivwgmoryllMKwFnDI
 TBj+LdS68lDekO4T0YqjCLr32uXVZJwgoodMSwMYOgxXEJep5UaVhjV0XzIyR/Ie2fsT
 GOTWWDhLbiWEU9BDyqtMV/YgvPKzGLGpbdigECUPk/aUeGhtvvvrzfW9s2oFLR9iwh1J
 uPGg==
X-Gm-Message-State: ACgBeo2zQwDtS/AJbaol1TCnW1AYNp3XKJ20k1N+EogTdSMVivDOd7nt
 ZMIhsjw15ecOVxU9eE1f8AU=
X-Google-Smtp-Source: AA6agR66Ea/tFozfkhDfcVtnv3hw9p6c/dgn9A3H0n8S4fBp6aMTRwJJz8RoIdyCPNF25qzur+Vgow==
X-Received: by 2002:a17:90a:9309:b0:1fa:d28b:3751 with SMTP id
 p9-20020a17090a930900b001fad28b3751mr1262365pjo.189.1662069771948; 
 Thu, 01 Sep 2022 15:02:51 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Sep 2022 15:02:51 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Thu,  1 Sep 2022 15:01:27 -0700
Message-Id: <20220901220138.182896-13-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oTsGy-0007uU-Aa
Subject: [f2fs-dev] [PATCH 12/23] f2fs: Convert f2fs_flush_inline_data() to
 use filemap_get_folios_tag()
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
of find_get_pages_tag(). Does NOT support large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a3c5eedfcf64..c2b54c58392a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1885,17 +1885,18 @@ static bool flush_dirty_inode(struct page *page)
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 {
 	pgoff_t index = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec,
-			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			if (!IS_DNODE(page))
 				continue;
@@ -1922,7 +1923,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 			}
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
