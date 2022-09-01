Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A360C6FA99
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Sep 2022 22:03:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTsH7-00078d-QV;
	Thu, 01 Sep 2022 22:03:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oTsH5-000787-Lr
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pWqS4ooFUTFHzhqRBDvFvbwutPU6GCzkgDePLKh0xDE=; b=ZH8CMD29By5Dpqth2nWE+q2K/B
 maTR01Kgq2fe9aJmTDZR0Oxp/yHGMTx+1N2k1lyla9FAOADif2IVExZYKVdTAIsRtc8bdTLRoISDu
 6qJ+vEaFAwfmyt8anKnxm9AyHCHK9XnnYXXjlyOBNk2sKZyDocps+fc/pLCsnSlTfBcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pWqS4ooFUTFHzhqRBDvFvbwutPU6GCzkgDePLKh0xDE=; b=XRecrT6GeOyiH6cjpUkjzMggYw
 0gog2hYN8Rvka0lyGuQvmNdzp/eQ1dw+VYu/ZgE1pFjz4m3AG4ljg84z3AUFQKoYub/b3AM49G2FC
 es/3pbtqfvg1+JAtsVtBQxnN+/1yqBx/A/4s39Wu9wCuKlEyB47bflMR8DOpSe4+4DP0=;
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oTsH5-0007wE-08 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:02:59 +0000
Received: by mail-pl1-f181.google.com with SMTP id p18so93538plr.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Sep 2022 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=pWqS4ooFUTFHzhqRBDvFvbwutPU6GCzkgDePLKh0xDE=;
 b=ltbTUVZlF/Z87l55Zx7YIMdiSlF79NxCKA3kDzN/UdHnBbOhUkxYokZciUF5yB23IQ
 3aZV0dCORuNfmkqtB4Um8rih0THqW1I8+Kg6eCX7JtCSq0qK5FxY5JJ3W+WjbZVvFS/N
 SHzuRTNRkOZU91jiFJ75s3/HaNBfpPrOuW0Q5xjsFySVCqjGc+FQww/RxS0JKeXHhL7h
 kAOi4h68L/U7Zh4Cxk29fMBM+9NAxnpOY6BN4/Gy4hT5bv4ACVWiuAvUMQEQVyDUFGrl
 0WnCZ51DYlpojmaB5f2e+eBCMWO+Ah52Ft8Wrewyr1JSMgQJJeMlPU47Bp2sXDcRwEoX
 fJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=pWqS4ooFUTFHzhqRBDvFvbwutPU6GCzkgDePLKh0xDE=;
 b=exLa7KYNHhVtbpG2jQsWZZ+qLdR2tvG4CM57MqW1jE46JniuCkYOKqxRx7HAsWCpuN
 +acqAdD2Ly3tuFZi9Gca6LmxOQkTLkPJGK9fjl8QAWz+khk+H4153TpOpcTQff0rpVXe
 FbIPd9gARcAneCetoY9M5R9Rir6nDCEiPKgfPOITyrdcNZLHwzER2L7ivX1sXhZIRtmP
 HOa/2Urzl9aFaCX70JIuvf9C0k6nwNMWqzWFkQdyfQB7MQ8lT4lH2aGFZZm40xMMBqe8
 Rcul/TUduVL/6hUCcgvkgsbvILHw6S6PktQcuNCIRv7g2SDgT+lgVGKfRl/2l/g5daLG
 rzuA==
X-Gm-Message-State: ACgBeo22knuejyBnhSKda5F+VQwIUx0an1xgjq17VOHAy/HVwdHo6giz
 hS8zYqmmCrgUhIc/gsIHMNY=
X-Google-Smtp-Source: AA6agR51CwUjM/zXT+7/k4/OH1O/ysrX1I+7Yp9oSarGXCh3bpO5jidmIwe1Ndwhec8sTGheHCwaGg==
X-Received: by 2002:a17:90b:4b52:b0:1fd:ed88:967e with SMTP id
 mi18-20020a17090b4b5200b001fded88967emr1312967pjb.108.1662069773326; 
 Thu, 01 Sep 2022 15:02:53 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Sep 2022 15:02:52 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Thu,  1 Sep 2022 15:01:28 -0700
Message-Id: <20220901220138.182896-14-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oTsH5-0007wE-08
Subject: [f2fs-dev] [PATCH 13/23] f2fs: Convert f2fs_sync_node_pages() to
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
of find_get_pages_range_tag(). Does NOT support large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c2b54c58392a..cf8665f04c0d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1933,23 +1933,24 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				bool do_balance, enum iostat_type io_type)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int step = 0;
 	int nwritten = 0;
 	int ret = 0;
-	int nr_pages, done = 0;
+	int nr_folios, done = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 next_step:
 	index = 0;
 
-	while (!done && (nr_pages = pagevec_lookup_tag(&pvec,
-			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
+	while (!done && (nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi),
+				&index, (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+				&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 			bool submitted = false;
 
 			/* give a priority to WB_SYNC threads */
@@ -2024,7 +2025,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (--wbc->nr_to_write == 0)
 				break;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (wbc->nr_to_write == 0) {
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
