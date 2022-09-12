Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF70BC6FA8D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Sep 2022 18:25:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXo82-0000pa-86;
	Mon, 12 Sep 2022 18:25:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oXo80-0000pI-C7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cO8ljolH2h2y0oWNA4Z7VoneqopIkQJQEMsP9EWX9UE=; b=iFc/IL0tmVx2MxNd/IiU1lu/gF
 9OJkZYBjj3aG2vpB4I58GAEspIInkKNvjpxOdplevaWcPJECc6nbRToGok1UHRK172bFKFWwTZG+W
 0+7nLWOzxWUT8MdsrlDaN2sZckzqDX45bMQeWeaY65ldqx7Tt6vK/6sVbe5gHDvmhnwM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cO8ljolH2h2y0oWNA4Z7VoneqopIkQJQEMsP9EWX9UE=; b=UB4lfbLXBB63zob7HMarwo1xKX
 gfNeUVSeDT/IWDPc2cxlPrwU/nqMQkAHYyNSnGDQ5xmVyVmPAqnnm8vEj3MDrjejx0GoOYdNXCLEd
 C4ttIWShXf82lSiekXaWOH01ZDaPxQGenDcUDMPzXIy0tImc/4NBvzYWC+9PHeD7zqME=;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oXo7z-0065Rr-Rh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:52 +0000
Received: by mail-pl1-f171.google.com with SMTP id l10so9371159plb.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Sep 2022 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=cO8ljolH2h2y0oWNA4Z7VoneqopIkQJQEMsP9EWX9UE=;
 b=NIg0pAYlAdDBbGDrxjomYDv80mhD4rG4slnGwjyjvuRzDAtDlmS4Gmg7tdlWc7e8do
 cgAHLwZIeIVAcV79nGjweh7uMALusKrXGqVmplYaBk0bWdwbyIopKrh+iEWfFSIilpNk
 z3YT92SaxzRwTmJNbyX6Xt5mjprGXtb+TsFXBq03Qr+7XwlTr+xiXhHXmcMiwCQCUR7C
 qqG75VplmUXuNQ4XXQR6jrK/n4YJ9YGeOs66l52pj4wjeExkbNP8DGjzL8bl5OJ38U5n
 Eo3ak8KaQKVhvelyH5oZZoriH+Gkfr9ljxLjDG6aoAZRb2H0n7U2YsjVruGe3DaNPvsh
 Tt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=cO8ljolH2h2y0oWNA4Z7VoneqopIkQJQEMsP9EWX9UE=;
 b=lwX7/sxzc5+0BslkX3SbEcgx88B73Xs+JJ8arfdMZ6oR6A71JU4OPgd0vLYxmY58zt
 GykBJWzyJk9qfA8UYbjCGmQBCuIPN5spEY+4LmRiAJj8wju6lEeVcHDHx0Y3bOsWWbh6
 aFZR6W7Y375q5xZxN1/hak7cGEDjywDZeIVW935EFoesLO83/vXNruVzV8Cn+XKZvgzv
 000VhdGKqafC9ft6QewroraO+DtjG++7wJemwsVovJBJPLQiiCdLBnzmAq7bTJ4EHL8Z
 W0TAAQ0zFC7tlugMAHi6GbwhXnCQq210l+3cVpea1Hzv6+NpkfmDRNOritI3MnTnW+nF
 5mwA==
X-Gm-Message-State: ACgBeo0CKLCP2r+MalLytyM19oNCkghKse5fFcvyvxp1zE2OSSiJHkc3
 x+X8xzLjkHUoxVV0eDlSe2U=
X-Google-Smtp-Source: AA6agR7Jqhi5sUHPJm5uyDhLBrAb4Z/1SypgFHlxXPSRgH2lkqeGp6P1DkFmieOK2bvhQMtnmicpkA==
X-Received: by 2002:a17:902:9f90:b0:178:1a1c:85d with SMTP id
 g16-20020a1709029f9000b001781a1c085dmr13250833plq.85.1663007146287; 
 Mon, 12 Sep 2022 11:25:46 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 11:25:45 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 12 Sep 2022 11:22:16 -0700
Message-Id: <20220912182224.514561-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oXo7z-0065Rr-Rh
Subject: [f2fs-dev] [PATCH v2 15/23] f2fs: Convert last_fsync_dnode() to use
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

Convert to use folios. This is in preparation for the removal of
find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cf8665f04c0d..b993be76013e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1513,23 +1513,24 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
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
 
@@ -1560,7 +1561,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 			last_page = page;
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	return last_page;
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
