Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A450C6FA8B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Sep 2022 18:25:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXo7x-0000oJ-DP;
	Mon, 12 Sep 2022 18:25:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oXo7v-0000nu-Ha
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=; b=idc5u7byAs+F9UXH76ZoGFTX20
 1QmRXq1/op4THFFmfYIAWGaTUuHyYxO7YKcdmeQGvRAj+2p21a7EXgSVIc07c98Fb4DdjShubT2Ew
 l3PSIttuJhdIRgN+h5eXPHNkg3DC3I8XQm4cQgEWkM81ppwb+ZQg24zxcqL7Sd8IERRc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=; b=Wq+v5kvnt9ma/GVjeB8sJEe4gm
 QrAULO4I91HkV3t7UXui2YLbpVB7MIwhJnHGwp5shXX/DUIQHA81KMqXLlEe7yj5chLvaZYsYn3Io
 yKMOC2YQ9/iZGQ6UMxQkh6vRNbeeJ+5zlVANlmBLlqOIfGbyoQi4sj652rqgHGLZ9E18=;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oXo7u-0065Ra-Vz for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:47 +0000
Received: by mail-pl1-f173.google.com with SMTP id l10so9370927plb.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Sep 2022 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=;
 b=mWsacKaljX8MUV8CQf+x9uPNXb4nwg1rqOzW988jKdDxldx2xBwpPizg4HUE3CpOyS
 CZXKfwZl7d7TRsEdibF4COy3CHTtCs9fDbuwKy/fifVJ1Wgwc7dTVk3A2qlzYF1+YqrM
 8u30URko72IeT67j4F37ylnRUZD/Skd/5ByQpr+0jX44vN/bWC2IRka7MCfENYbM9JYD
 72jwWqsS26F/r5BLgNzt2vuVnEfeh6py/P+5GlgXdd1rz/SFRFcCTDhHk5S6n46zAnHH
 K7NUMpASIWQTy8dJGAcYZr2Qd5aoXAfuyQB26U7wlP0wc30bz0T/it+tBSb7KpRupXtm
 b44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=;
 b=Xsksi6D3qC9JzgBKUhfofeDOkQUk1CIWf+OQf4zqw9M0M8KXRyVxbjNrYxnonVVzB5
 4Yq9/EsbDrVJn9kRJCzs1hckGNpdtcmqsIxHWEfvEtHCSCcj1kL33w9/yiRY0sNATPCX
 +j3gJqrZyAHqXdAodys8grStfYnrC37bEP/HQAm05Ei1Y96GjgC40XK/To1bhTno7WwS
 kDx+gaJP9WQHZ8XDew8aMFYtQUkIduUs6U7F+Iuqq4aMCBR+CxRDNjNASYq+yl1tFCnB
 h+/yZzo3lTsYIbij+vqxut8u47D9FMDJzu3vGx6WZQw+YP9h/eaxOjtWEPKdqcUrQm3J
 FTog==
X-Gm-Message-State: ACgBeo3hpKmxbN0KwASJQOK8YQcFJM8JIXwuEBk2NFZr7T+3E1Wxp9H1
 NhdQo4YUAba/x0C2aHuQxog=
X-Google-Smtp-Source: AA6agR7Qn6iVYbgKVLaA7RNhUe092kC4wO4XsubL7Ck/d+hPPUL2KMeZ8CoC2zBbBJEanU/9uLdUng==
X-Received: by 2002:a17:902:f549:b0:177:f7ca:c870 with SMTP id
 h9-20020a170902f54900b00177f7cac870mr20847770plf.4.1663007141405; 
 Mon, 12 Sep 2022 11:25:41 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 11:25:41 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 12 Sep 2022 11:22:13 -0700
Message-Id: <20220912182224.514561-13-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oXo7u-0065Ra-Vz
Subject: [f2fs-dev] [PATCH v2 12/23] f2fs: Convert f2fs_flush_inline_data()
 to use filemap_get_folios_tag()
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
