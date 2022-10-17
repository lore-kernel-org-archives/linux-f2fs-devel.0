Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5017C4321E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Oct 2022 20:25:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1okWfY-0008O2-AD;
	Mon, 17 Oct 2022 20:25:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1okWfX-0008Nw-EV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QZRdB+dZmNtA32T+cQHDMYonPyYz7jjivtFD0eVIJJw=; b=hn0RBoQ2LUa6kLIq+u89vVlQGA
 t12bgqGSDQu0t/9AMX8xlzipp+8mTo5h7mziJ8vs92f9iFYpFUOSaBGjOYgzxzq79gjuN/v/YRNQO
 Xn9COw73wR6lgUbZwmrkohdNXasZzFgFouaJy9yt85u8fSViDBCCzDQliwsjZdnYRUSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QZRdB+dZmNtA32T+cQHDMYonPyYz7jjivtFD0eVIJJw=; b=SWtdZi/W62Frs2I+VDjT2hol6S
 a0p+KU/uro1Sj4KcYdt8Yt0gYdSLtjn/0j/zm/HgX8/brwVPi2UbNmiZSZ/sJ926kixb85DgqTash
 b8ziEAdwqBd5KV069BJV7rXhyiqhHhmQ7Kb/+ZnlkuvtRnMAVGPAS0UsBfSO2NbEvEnU=;
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1okWfW-0008RX-B6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:03 +0000
Received: by mail-pg1-f174.google.com with SMTP id bh13so11455142pgb.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Oct 2022 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZRdB+dZmNtA32T+cQHDMYonPyYz7jjivtFD0eVIJJw=;
 b=EMG8zUe6nj+OzUpxpcc6vz9egeLlNxWJFwjbuAX7cIf8UVozlJc16RJgVW6MmHr8wj
 lAYPDYX2mCzW8yaHilBBcng/MkEd3zQadtzIm4aJed/L2hmaKukav+bbHe5lJaIq8Cmg
 0jCDF+tjRM5z3mhRWX4Pz9YQeJePTcm5XXkFfwT7bZ3hhjUxBBExa8JfvRa7z2z1eEE8
 aa1Z+xdo2jBQyaNl3srNu1X1eXAZfvMUHpUQQgygrIgkLcMnTlgBOGGoIPFtqd0FKlwi
 hsEHCzW24ByTmgfjer1ioe0J81eAgCS681a1EYbjZkADJzINZruwqE0d8CSsY1eGT4Gg
 1ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZRdB+dZmNtA32T+cQHDMYonPyYz7jjivtFD0eVIJJw=;
 b=2wZy/vFw+8pas3hf52HBEiDKJaFaFfWAUpckbVqKDVHr4gFpFDgJs0eWPBPFmuhF0U
 CA3mNY3nzRdW0cPY6W3eA4O3OrYUCImehmXBLJAOtt/4L7oyL5DSnZuoVOXOORduZt/W
 xvebbm7+RSw6auKG/jji2QDb+iGCAPQoR66x/ZWkvbazR9gXGZ+i+lfvt0t0JDWhKa/4
 pCazKO1rxU4mvAOlblQhMshH9EkphD0ihP/5qp0/4hqGLAcCz08l/YqzjDwdcEHTqpdI
 +9xBTvaXUAjjN8/xVKAi8x9mtQrfiQT0WvDR+0MYoq/HfEQj1qFiGSdpuxk3V7OV3aA9
 03vg==
X-Gm-Message-State: ACrzQf1Y/+8I5PlVUnVv2v//tzdofRlSQcRMl+VYkkxQkrzU6PNzG5lv
 32+dPX9Q83AV/6aeCBoFp2w=
X-Google-Smtp-Source: AMsMyM6SRYuRbUVytvSXfXMHwh3CkrlxOqmICFrlZTvzhTPoi0L+HxeakG4SqBFzDLfSjWciJ+CMBg==
X-Received: by 2002:a05:6a00:c86:b0:563:b89c:3d0b with SMTP id
 a6-20020a056a000c8600b00563b89c3d0bmr14629107pfv.50.1666038297319; 
 Mon, 17 Oct 2022 13:24:57 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
 by smtp.googlemail.com with ESMTPSA id
 pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 13:24:57 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 17 Oct 2022 13:24:31 -0700
Message-Id: <20221017202451.4951-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1okWfW-0008RX-B6
Subject: [f2fs-dev] [PATCH v3 03/23] filemap: Convert
 __filemap_fdatawait_range() to use filemap_get_folios_tag()
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

Converted function to use folios. This is in preparation for the removal
of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index aa6e90ab0551..d78d62a7e44a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -503,28 +503,30 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 {
 	pgoff_t index = start_byte >> PAGE_SHIFT;
 	pgoff_t end = end_byte >> PAGE_SHIFT;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned nr_folios;
 
 	if (end_byte < start_byte)
 		return;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
+
 	while (index <= end) {
 		unsigned i;
 
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
-				end, PAGECACHE_TAG_WRITEBACK);
-		if (!nr_pages)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				PAGECACHE_TAG_WRITEBACK, &fbatch);
+
+		if (!nr_folios)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			wait_on_page_writeback(page);
-			ClearPageError(page);
+			folio_wait_writeback(folio);
+			folio_clear_error(folio);
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
