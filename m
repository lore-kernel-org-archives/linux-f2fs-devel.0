Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1EEC43219
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Nov 2022 16:11:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oqGLI-0007eo-S1;
	Wed, 02 Nov 2022 16:11:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oqGL1-0007cn-N1
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UZvXQK7eydj6IBrzU3IQ20y8xajH5CKQhE5ttfKWvGg=; b=UwCCLfok/bkpd1CBBXE8N8DB7i
 vaMdsg9zZj/fajBqV0GzWwZdDemHY2qz1RHvnosJHFVzBSUXQ7i9tbAGu7AVXAwNr2Jd3DpvG36Rq
 vDmL1XIzln9FhzqXe1mb23a0uUSBdpoQ7Wis5HX5pvYpHBHgvrUrr15vfKDsnNuJYXX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UZvXQK7eydj6IBrzU3IQ20y8xajH5CKQhE5ttfKWvGg=; b=Uvp3y8QkH9fSBFM22L+3ALnNtf
 LUuMKm8/fZUuywqpTyx0nle1p9IuzisWIXnE7rpC2Q2H2c8Zjaku/5edIXLdNVb/FSeUsgSx7K7N0
 +S4via0ei8/eVBrGUBHJvyzPmYta1kbKNvQaQOs+gf7hg/KMGTXHItlMeLsozcoUN6BI=;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oqGL1-009aAF-6i for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:11:35 +0000
Received: by mail-pg1-f181.google.com with SMTP id 64so355840pgc.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Nov 2022 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZvXQK7eydj6IBrzU3IQ20y8xajH5CKQhE5ttfKWvGg=;
 b=O4nbwv9cmBtSK1CT58yVHNsSMZiY/FKUA/O6oX43Ac0n4IX7vDCV2QLGEuoLXlUkd6
 eHvyReQOL/NVjRshopa6fHkLaexjtpSCxifCTQBr0YR9yB++gFXMjIc34iHceLJdJagf
 WrwXLuWuCgB23v0+FXg91vjEGb1kLv6sB3PxXdVEjMmof4a7ofgr/GbDbkATXjxgH/8d
 +4RfUgwVsqN79UT/+0gaRpPE8h5g92Y8O3mytfBiXv715U8K+NOc/77TCeiz+rmrrP3T
 lHzCxF89bepNGUmoT3nYJomOxqi6w38Xq/9CrZcXJ2HzWpJvvHbi3XeAXF5vgGVoLqbr
 TnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZvXQK7eydj6IBrzU3IQ20y8xajH5CKQhE5ttfKWvGg=;
 b=NtUQYtb4g4dKTmfJ9RDOcVB3IO+vUxzvXHxwPlliTsWpN/jSboY/2W5vg0XNBayssY
 yEiz2Fx0KKwuTQY2fHvHNHmQCIcCVJFaQPsUHxU7+FVw8S5ui9vj+V/sLyskuEqdZseu
 Sj2INWwO5rp9vdTP+pBIl2UzQ6qslwRWNe1IpYDEPfwq2WEA3+SWICzOqe1QFIh1/AuE
 pN73y7SzytfJ2VOxy95Sb/v2Q+HmeLKHvNWqq9jAesu2gqgT83dqh96xXrTMPEv9P5e4
 JF+aj40d5WFKq77mn8LTgbSr0Fl6vqhcfzJ9/lkaOV6aCvkpGoBFTNiXgjxQGHlrR0ju
 RbBA==
X-Gm-Message-State: ACrzQf2dGRPulfDRlVetSmFUO+DqwEgtrQ6mjoy8VCntBStahojLGJzF
 4m8kTpjdDOdkCze9kwtOWO0=
X-Google-Smtp-Source: AMsMyM4Mu8mWuuJ9LsgyTXKiaDYuEixqiDshaCcEnGHSJqDXPNt4rQCX6PHQQ4mtu+d6jEWOcHwjbw==
X-Received: by 2002:a05:6a00:999:b0:56c:3d0d:96fe with SMTP id
 u25-20020a056a00099900b0056c3d0d96femr26077443pfg.12.1667405489645; 
 Wed, 02 Nov 2022 09:11:29 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
 by smtp.googlemail.com with ESMTPSA id
 ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 09:11:29 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  2 Nov 2022 09:10:23 -0700
Message-Id: <20221102161031.5820-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oqGL1-009aAF-6i
Subject: [f2fs-dev] [PATCH v4 15/23] f2fs: Convert last_fsync_dnode() to use
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
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 38f32b4d61dc..3e1764960a96 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1515,23 +1515,24 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
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
 
@@ -1562,7 +1563,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
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
