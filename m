Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209B5C3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Oct 2022 20:25:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1okWfp-0002d7-C0;
	Mon, 17 Oct 2022 20:25:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1okWfn-0002cM-3c
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PjCPDi1AZDHrB7VlRdP/cqyMu6n+VbdajeULasyuImU=; b=dv532Br+P4ENNECMUr42q2VESM
 QZB/i/TGVNXv7I5xndCxxJX9uA07MQU7pyD+9hk5sWAAkAYpO1QKIRKJHQ5qGMSUfH+RSATR4efBJ
 cIbov9FrWdHTGTBs1z07fuNT6Rg4jsMvcu/yMOklw5vcdpvTpM8Evxq2a83ZN3/0vcrA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PjCPDi1AZDHrB7VlRdP/cqyMu6n+VbdajeULasyuImU=; b=eVTiMEF63Gopw/jeby+F5hOhXz
 NvR/CM26hC7hQuWHFq+mZXa5o4yCTlGvNhx2k+g0RJOhXEikU8Iel/msFJRGMu2A2TX3CjZSLkbpp
 2Iqka/wFafgkUFCcRPMpcYE94rVZ53GpJt1YHrSsm8XlY0/7WB0XOFQSiAITsKlV4h9s=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1okWfl-0008Si-V8 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:19 +0000
Received: by mail-pf1-f169.google.com with SMTP id h13so12136447pfr.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Oct 2022 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjCPDi1AZDHrB7VlRdP/cqyMu6n+VbdajeULasyuImU=;
 b=Qk4yM75otecrzeUngFuKVCGaeUXfETNaFI0p6N/nABjpdCTLoTvjKNLJZ9OllX2bwP
 +U+4YR9Pv2UlaBNn4Ln/tBqDVA5+5H9uo8/ty5z3YSkoXkt/t+1/eR8X1FXv4Ci+T49/
 wSVeFfxPMGrcmtuVOElrygDRrVNHoyFvAO+52XX8XFX3fZxBUKvCeAeRlBBlvxD+jYUA
 hW/fboSfjF2JsTe1GHEut4uWvlw1NT8ZvKkfI2RSo40rbSyNsY3uBQc7Sbd/6dY7EIEd
 1BRYOETZSIBmP7Zq93eqEum+LCrtx8kl0OnMaxT9yXrWMw3yXtWBRbeDNWR3Teap7EmM
 YJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PjCPDi1AZDHrB7VlRdP/cqyMu6n+VbdajeULasyuImU=;
 b=p6pCQG3g8qDa0vmeVPmlcyHIEnlXqfVP8E73yfczT3/nb2toj3Tr04TjltEaOUoiWt
 OFh0iAyjV+5U9A5miDYazqPXsbVfR5c1WP4vx93BJfOvKu7KZqz01qCeso72njAQ3cWj
 dbAVdkZ278T6zt9ztz6FjguYRPj2lGov3k8IOVN2Owu3+5rD2vZD46lQSLGzKLo3nXM5
 A2wPGiKyv9NqZt9OYK5IW3S6gpDEcF+19qAOEV4a5sBdFSNBCHPLuZBQjjaeKk8s6slL
 3CO+zQ1IWtGP8Q8oVUsx7Yb2SU88JZeCBc+/9AVi3h5uHZGBsOyKpNj6fHsEK/Jzdeuc
 jTUA==
X-Gm-Message-State: ACrzQf11YA0DwwsvBsLzkcQ8n0QBVwDqLMqeycoECrEVIPsTJgG8PycU
 1VWadPp+w/oUFUV820Lg58M=
X-Google-Smtp-Source: AMsMyM4ObH7Ae50qNEBFYILKD/38ZVBDIyWh1WqZ5jC4uO0xoFWyIhzUJ8Q8K2qEcR3Aa5uaxx2opA==
X-Received: by 2002:a05:6a00:194e:b0:566:5da:ea67 with SMTP id
 s14-20020a056a00194e00b0056605daea67mr14416761pfk.77.1666038312970; 
 Mon, 17 Oct 2022 13:25:12 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
 by smtp.googlemail.com with ESMTPSA id
 pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 13:25:12 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 17 Oct 2022 13:24:47 -0700
Message-Id: <20221017202451.4951-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1okWfl-0008Si-V8
Subject: [f2fs-dev] [PATCH v3 19/23] nilfs2: Convert
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
 fs/nilfs2/segment.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2183e1698f8e..fe984def1b1c 100644
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
