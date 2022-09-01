Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C1AC6FA89
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Sep 2022 22:03:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTsHF-0007Bi-Mq;
	Thu, 01 Sep 2022 22:03:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oTsHE-0007B6-4l
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R1s+Q+mQAi/BIrt6gOgtRlGYE9v+cGNlC5URnwM67nk=; b=jQPzOYtW9NW3ysvyLUPXDjmV3M
 LMZqWDJzWZIx25rwV4diwBhql/WrCLDRtPvZhlOH03Zqfepmp5L5jLZKz6LKUckaE0Mdo2T2Atr9+
 0gxek2Dp55paIjrEWS0559qderikpSO137MbiC5PsUy1vBiuYb6BTxCh83ZGH87D0wSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R1s+Q+mQAi/BIrt6gOgtRlGYE9v+cGNlC5URnwM67nk=; b=R8ttgPS2HmIzYM4P9i/n+W/PvR
 ZnSk2WK7uLlDqQJC6DCdKbfLBdexx+tBrf32xJJczTXEYK+3rzeGQ5K9+xn9uRAtNxN6i44yFih2w
 1Nna/cTnGiHUaBKrgYET7RYHe2Uf37L2/ibf3Q+kqDYfYNCFnbj0OOvARUpb8do1kohs=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oTsHD-0007xM-Gv for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 22:03:08 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 h13-20020a17090a648d00b001fdb9003787so358422pjj.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Sep 2022 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=R1s+Q+mQAi/BIrt6gOgtRlGYE9v+cGNlC5URnwM67nk=;
 b=g6fAyp3iJgf3LzmTu5bD5zWTZ7od9i2yk9cu47djS4LzM5/vaCauETEa79FJPDbfwN
 cLdqlUh9d8nI0Nm+LbuAhIItiLNmHGfoqlGAYhSfTiRw4ljsDmSdVadB+3m2xO1TNUJa
 0nuVGnoNqQQoLmodKszRhMXSnkLvvjZ4R3brnkvtlDRm/qXRnT+DMRacWFesHhTBBNKc
 0V+89RIxZ0WLehbpnGAbTdJ5uOSPOqVqMofTzLN0E95dgYKuDPhCGssRW2KFzlTQQNsi
 D66yCF12E7iDcZecg+ujt+pmVYyoJIOMaXlKUD3A3/5c5nIgJRrzLjZgJB8I6DmUxegn
 s9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=R1s+Q+mQAi/BIrt6gOgtRlGYE9v+cGNlC5URnwM67nk=;
 b=Gn3RBoRsUDGcWlsSy6eomaylbkb0tNyI8iCVWjBF3fc4uYS4gXKr+eoABuA5Yqwd+m
 c3nBRxqn6PHIZDvPDnloUUk5tVSgMeD9hVX1MkLxWLcF4XfNIK7ZKgmX7Jq2emuFEpbc
 K/htSeQT0kaWjAO6dTJ8OHaGaGOnNfKHIsNbZcK6yiV/gWvoYhYIcrDx+nlvDN4aBYJ7
 n4lyA5E/xBpvggBMR61I7xe5+ZmmHl4q4qFU0xHDDENokbWbUMDGfDmvURxRxlMVaIId
 KtKantRe1h2Dje2Z5suK/Mr1hLBWZ9BDr6ZbCBweDFvapj6spvMXVEK7zWK5N6V6zCNH
 9X4Q==
X-Gm-Message-State: ACgBeo23C+nRid8S0fRtfwhvOMp5WP5oKm3N2QW/HIGpHjtit1uYlfIQ
 OHwDsAfpZDU1uyq1Qdhjk7Qy2jSEb2KSMg==
X-Google-Smtp-Source: AA6agR6TsbdMkmC0TPigfGG4lOziD2qdPKDR4aZqEoxc5g1boqEfjdmsGUoCDRdXOVT8V8NL8wfwag==
X-Received: by 2002:a17:90b:1bc4:b0:1fd:b913:ef58 with SMTP id
 oa4-20020a17090b1bc400b001fdb913ef58mr1275606pjb.220.1662069781924; 
 Thu, 01 Sep 2022 15:03:01 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Sep 2022 15:03:01 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Thu,  1 Sep 2022 15:01:34 -0700
Message-Id: <20220901220138.182896-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oTsHD-0007xM-Gv
Subject: [f2fs-dev] [PATCH 19/23] nilfs2: Convert
 nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
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
 fs/nilfs2/segment.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index e95c667bdc8f..d386d913e349 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -737,20 +737,19 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 	struct inode *btnc_inode = ii->i_assoc_inode;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	unsigned int i;
 	pgoff_t index = 0;
 
 	if (!btnc_inode)
 		return;
+	folio_batch_init(&fbatch);
 
-	pagevec_init(&pvec);
-
-	while (pagevec_lookup_tag(&pvec, btnc_inode->i_mapping, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btnc_inode->i_mapping, &index,
+				(pgoff_t)-1, PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh) &&
 						!buffer_async_write(bh)) {
@@ -761,7 +760,7 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 				bh = bh->b_this_page;
 			} while (bh != head);
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
