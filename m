Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F0EC6FA8C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Sep 2022 22:03:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTsHA-0000VC-TH;
	Thu, 01 Sep 2022 22:03:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oTsHA-0000Up-56
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hDptbc18eb98tE8iQjyPGn696c4/GhyznW32HiLxniE=; b=J0k4uI3fu2Ggh+SdnEoyByweD8
 T1sFoVLXMJJZhDsay/IMp+zFVMti2ERnq31LLY3kP72wFvZ+0SXljxdONRCxwrSdOKSZErXA4noha
 DIrQYJK1MCaavLi7DF9FqGS9CAAiaVfGu97ltHWu7Mmk3QnFR+tb2msWbECF+rdqdJRw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hDptbc18eb98tE8iQjyPGn696c4/GhyznW32HiLxniE=; b=duGs8BRc7fNq0BwvFdUMb/kGiM
 1Xdg79HdJMvWKqBP6TXqn5b7YDCe4TBU6U2zdwUW9oaHtPwodSDagSW1gVonKUIXLEAF/nntFqIic
 hLUI3RW1cX8TB20srqWWJhlCAyI+SDdRcuM6j5udHmVW56aeogM5sMpPlmr4kTbJxN9g=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oTsH9-00Aaf4-Kp for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:03:04 +0000
Received: by mail-pj1-f48.google.com with SMTP id fa2so274019pjb.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Sep 2022 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=hDptbc18eb98tE8iQjyPGn696c4/GhyznW32HiLxniE=;
 b=gUm8S346I3K4ORq4miRaGKQWrBRZuwaXck/yvUpzoYTdcWhN98CW9jDruatqJgoZRb
 Qr7AVjxZmulo+5f9KMRw7o9SzO4VVVP0E6R5Fgix1Tba0Tyc9gA4/EjPT0MKD3o3ubc2
 vB47B4Wkmo9W5esV3vAFQYuGkm6R+OQ7uA08pjBivhfS8LGFryls97UPR15F7iPOmvl2
 dHyicbyty/5LQkxTuojwAF90zrZpQJynSNJ5hxss6FcgzCzxI5JO1ptQdUHVZCAWmElB
 t+fwz3It0ogWy5Uf628XzRjlYTQ/0YWnLDjVYm3aDd4wv+omRXtHPDbeL0giXBfgWA+5
 lhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=hDptbc18eb98tE8iQjyPGn696c4/GhyznW32HiLxniE=;
 b=Y7butt7uRdjMX+IPJclL5ZGYOf53T2OtgEmiysfxUkTH6+twHrYEnBTXCy3xGWEZHU
 6AEoFweSG+wRpveJBHXvm38n/1TzrvwK9DqF1jJSy4xVvk+fbJsgbPmb95Z80IRUQpi6
 jEA/dnFvzdb9IRTwcN46RVawAxIOAPqg5MJ3mEREi+xfio7kHJx6xn/zBUSNQLMnIXdX
 uGWYr+7wMgOFBeU/tXLNxqaEoWurvKIFndk+d2H83TQXwB7zzpRYQML1ZDA6pYBonff+
 Wu745pygHXjP0WHhIkVrP1aOxkoiBEiiIe/J+OpqbycWFjbD2TgM+7j5ON0lS1iktIMQ
 WI2g==
X-Gm-Message-State: ACgBeo1yiIOwo6rVORS0BLltFqgu26nGeaPxWcx/6a1LDnoHC3W3aSzJ
 Q5zZNfJH2C1amRJOVMDWF4JFTxVwEfmjqQ==
X-Google-Smtp-Source: AA6agR5IeTCiSE25gUAjMIUlyuAb/ATe40085kNlIdR9XrP9KH+/bi+PEVrsNM55mfWzwEZYZhZwXQ==
X-Received: by 2002:a17:90a:8581:b0:1fd:62e0:67cc with SMTP id
 m1-20020a17090a858100b001fd62e067ccmr1336794pjn.144.1662069783338; 
 Thu, 01 Sep 2022 15:03:03 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Sep 2022 15:03:03 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Thu,  1 Sep 2022 15:01:35 -0700
Message-Id: <20220901220138.182896-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oTsH9-00Aaf4-Kp
Subject: [f2fs-dev] [PATCH 20/23] nilfs2: Convert
 nilfs_btree_lookup_dirty_buffers() to use filemap_get_folios_tag()
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/nilfs2/btree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 9f4d9432d38a..1e26f32a4e36 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2143,7 +2143,7 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	struct inode *btnc_inode = NILFS_BMAP_I(btree)->i_assoc_inode;
 	struct address_space *btcache = btnc_inode->i_mapping;
 	struct list_head lists[NILFS_BTREE_LEVEL_MAX];
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	pgoff_t index = 0;
 	int level, i;
@@ -2153,19 +2153,19 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	     level++)
 		INIT_LIST_HEAD(&lists[level]);
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while (pagevec_lookup_tag(&pvec, btcache, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btcache, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh))
 					nilfs_btree_add_dirty_buffer(btree,
 								     lists, bh);
 			} while ((bh = bh->b_this_page) != head);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
