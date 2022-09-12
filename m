Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F0C6FA93
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Sep 2022 18:26:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXo82-0002se-Nh;
	Mon, 12 Sep 2022 18:26:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oXo80-0002s6-3M
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lkGrgC7rGv3gNtROZri1LZJW+W1eletv7YqP1zeCUhw=; b=hCMoUCEFViC/tlcY4Gca86KsO1
 I8zvbHtjHjb4J48hk+9VgxS18SXbXjV9rU+vxpdcQ+jlbBrFpFONcV8s8YPa9ihCpS2f+Ilm++jWB
 zfYf5DlsVQfsJu+yXHu0vhiWN+DkO4KD5wX2/6NAJaMG4ucw1kfphRgur4+gKlE/aku8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lkGrgC7rGv3gNtROZri1LZJW+W1eletv7YqP1zeCUhw=; b=WASlk0GqZ2tpV+8kuZvddjOVUW
 P2tHlH5dK45kUQZCcxJck+DcOY5FB7uPbTrH65RX9XJQZJBW/q+eSa+a24boExwHNdbevOK4jYzoP
 hK5v01iarduhm3hfoBlib5t9RjjsbfZ9czX0xqczw9DMd60OfurM4a6t5OPJ/ylEA+TM=;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oXo8C-0065SV-4U for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:26:04 +0000
Received: by mail-pl1-f173.google.com with SMTP id u22so9360774plq.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Sep 2022 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=lkGrgC7rGv3gNtROZri1LZJW+W1eletv7YqP1zeCUhw=;
 b=fCy8TLtpc+2sHdfZpYJzZ3/33zUyiKgotMXve7zJnxVipv/nh1oXHb8bS2ysugI/9v
 DPPmXTfFd2REo9KrIQqrSQArNmn2PIXW2Xf5/1Ut4j4N93Wdp+lwmDib+aOUEWzjjW2z
 ZE7UUCvkcyVxvhRcudTBKvbY7PZCczmbSlXfRTufHjK1lQKZiPD4cVbUJ3kgQLIdrvTd
 DEsLz2Pp7SVPdQ+qvHM0m7ftgUr0guyVgV77dhlT4Kf3Rdhp8jR2Z6CWYrkquI7PqWFw
 z1Xy/MN+eXfTN+XVOyRTS9mw9r9QLcv9wmvp2cqbpHgbAYtX/bPNPHQhK3HBKbjjHYbK
 mZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=lkGrgC7rGv3gNtROZri1LZJW+W1eletv7YqP1zeCUhw=;
 b=i5bTnOT45v73lkv5JYH6B/v9P6CJ+wCceDiNuwXgCErV2p3Nt/Kd+sR/Ua/L6uB54s
 ajxsKpFa36LkPb3NcBtXnS7LuAtAjZ1m/iMGc/tmbqJ5gr5YYTL7HMNH2n/QF2KIPuOJ
 xb6yn0bN1vtThVdgqJ5XeBbPIPkTTIfH9ULpx8OY7h9sTmd4cLoqZvUHl7q4V2J76WKe
 0nJyLst94+zbCC1+lArOtvVCaJKKVw8vciwY1IRWEeQBghYRLQPHRh1JK55DRLexHmPb
 TYxpKM/iOwXrta/5KA7Khwg+LdGP5hXFpzQKoO65g/0/zd+NnDic4nHQA659UrXPgink
 pbdg==
X-Gm-Message-State: ACgBeo2eV7M+QSQ2lDwJmNH51+HD8OcQBiHn10TGR2cdvVX9wuN73NxD
 HAJ8IlYoefzghyvnTIZiEDk=
X-Google-Smtp-Source: AA6agR7ugObnvvF7oyQiEw4Z3c3fWFD4/N8jwEvlip2DlQU6J5KyEtNgXLRq2aVr22deGLsWpY1Yvg==
X-Received: by 2002:a17:90b:1d8c:b0:202:abf5:4b21 with SMTP id
 pf12-20020a17090b1d8c00b00202abf54b21mr13212396pjb.162.1663007158527; 
 Mon, 12 Sep 2022 11:25:58 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 11:25:58 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 12 Sep 2022 11:22:23 -0700
Message-Id: <20220912182224.514561-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oXo8C-0065SV-4U
Subject: [f2fs-dev] [PATCH v2 22/23] nilfs2: Convert
 nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
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
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 5c96084e829f..b66f4e988016 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -358,22 +358,22 @@ void nilfs_copy_back_pages(struct address_space *dmap,
  */
 void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i;
 	pgoff_t index = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while (pagevec_lookup_tag(&pvec, mapping, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+	while (filemap_get_folios_tag(mapping, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
-			unlock_page(page);
+			folio_lock(folio);
+			nilfs_clear_dirty_page(&folio->page, silent);
+			folio_unlock(folio);
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
