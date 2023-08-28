Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B43C83F15
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Aug 2023 14:04:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qacr4-0007Gr-Bs;
	Mon, 28 Aug 2023 14:04:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qacr0-0007Gf-Ap
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 14:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VsjgcgphyD7d2BaJeyc5HfR8xwhqaMC0wg8Fsu3EVhA=; b=nTxvXhKRlai6eFUCTzRfQw9Wqw
 cMiVlMXIUy0moef+vBzK4YLs1vxRoQmhibhP2YzMxJfxJZGjgbpF1YEJymdABuB2MCUT2zBQ2Lf45
 wHS0R/EdzdYTY90vw2ZoTlI0gm5xZa2XPEYGDIN1J4KHnFVV0tHL0sr2eeCrGWLFURzQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VsjgcgphyD7d2BaJeyc5HfR8xwhqaMC0wg8Fsu3EVhA=; b=KHqhhDxT+CMqeG/mo7dFWkTNQZ
 xwHcNTF3l8drFF1LkHi4tjH6MkMJ5Gmr/fygVfK6tb9yasFbhLftpD7OW9pXJjFVcETJ1Tq2JGMGk
 1DbfadZgqT1oM/ytq+gIvJ3d6NwI5N8dx2cCvbBtCCOr1XccSianfQXazR4NBgys1GIc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qacr0-000oNn-4g for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 14:04:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF8D648E7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Aug 2023 14:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4154C433CB;
 Mon, 28 Aug 2023 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693231463;
 bh=iMUwEr3cAOvCDFXTWkzjICy1zMedGFdUbOmrXAATAhQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hW/aG0Oji4GfBL0hMAOlVKlK3cBo764WQfMEm5/m0WntAIfw2U4t+mRSJrVHHEN2j
 yF1Gc9O0cGAkY9QIuszue5QA6wg9Au+ModHq2sGhpWLodh7cg9BtBnKIg4irpDcYD3
 bKQhkawQ0Sob5HncKBs779zvX7ueuu4naDv1pD4+6sjHAuIRkj1kpZzLlbI/89pSFp
 oBrFbq4udXp/uxRpZcRvs2hc8mC6lNwJKJke5+Vso3ZzPloRlQ/jc7W9+LvnssX9pT
 zJLSwZyDolZiCuFlEC7C0uYeT8fj2VXf44ML7/4yTLPLw83rxFbC0oiTwtT4iQhHnd
 AQFixBkAQjVZg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 28 Aug 2023 22:04:15 +0800
Message-Id: <20230828140417.2951796-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828140417.2951796-1-chao@kernel.org>
References: <20230828140417.2951796-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1qacr0-000oNn-4g
Subject: [f2fs-dev] [PATCH 2/4] f2fs: compress: fix to avoid use-after-free
 on dic
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Call trace:
 __memcpy+0x128/0x250
 f2fs_read_multi_pages+0x940/0xf7c
 f2fs_mpage_readpages+0x5a8/0x624
 f2fs_readahead+0x5c/0x110
 page_cache_ra_unbounded+0x1b8/0x590
 do_sync_mmap_readahead+0x1dc/0x2e4
 filemap_fault+0x254/0xa8c
 f2fs_filemap_fault+0x2c/0x104
 __do_fault+0x7c/0x238
 do_handle_mm_fault+0x11bc/0x2d14
 do_mem_abort+0x3a8/0x1004
 el0_da+0x3c/0xa0
 el0t_64_sync_handler+0xc4/0xec
 el0t_64_sync+0x1b4/0x1b8

In f2fs_read_multi_pages(), once f2fs_decompress_cluster() was called if
we hit cached page in compress_inode's cache, dic may be released, it needs
break the loop rather than continuing it, in order to avoid accessing
invalid dic pointer.

Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache compressed blocks")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3f33e14dc7f8..1ac34eb49a0e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2344,8 +2344,10 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		f2fs_wait_on_block_writeback(inode, blkaddr);
 
 		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
-			if (atomic_dec_and_test(&dic->remaining_pages))
+			if (atomic_dec_and_test(&dic->remaining_pages)) {
 				f2fs_decompress_cluster(dic, true);
+				break;
+			}
 			continue;
 		}
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
