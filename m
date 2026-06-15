Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F51CD98CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XkqckMSdzDV+3lMDDvurayuFFYi6guf7t/7ba3yIqvY=; b=hy8bBd/mRfSguNcDLTiOmCOOcb
	krCtBU1gLB3l9YoTpGoMYniqwgquaUf870VY59yezLrziMywcgK5UKC6nFFPSm/+KNczgg8FOtuPi
	ow0CFlRY7P4vPr8hRjG3qG3n9VfKCvjgCQmTVyDz9/6hNZqy6KD5IFSEF6MrywEBgb5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ73b-0004OK-U3;
	Mon, 15 Jun 2026 13:08:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ73Z-0004Nw-Vi
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M6uLn6HKNb/6qJKD+yHjmrb8H0jz7uHTJGfjPCDkAmk=; b=e2AZUrFHI90cpbDEmY9HhDue/t
 8q5rldOmXl5WLI1ztFlMMZLGN9vruo93lzZbzxQTaUymMmIOsTrtQ67drVYyb8CT0Co6qviqmvT0s
 HdvqXUQZFViFGhgrNPPXGkKtySd3qaQLq420mlSEFoJLXq3jgLaNLkOzsEfH59gTx+uo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M6uLn6HKNb/6qJKD+yHjmrb8H0jz7uHTJGfjPCDkAmk=; b=EWeEDbTpJyhL5nE1VlycQvN9Kt
 6S4Eky4yNJWig5Q0Nj3JZeAcjfr8fUQKFxK65LJg91a4xsuxf/cXLuuf23pg/Xjm7GQqvGIU1OJJK
 MFwkCGOIFAKF0s9NnBetlDzja3nD7ZURpofvpu4aAT/2utEFWESRNAWSmFJnFTxWFqxs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ73Z-0005xn-Be for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9390A40168
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 13:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700E11F000E9;
 Mon, 15 Jun 2026 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781528919;
 bh=M6uLn6HKNb/6qJKD+yHjmrb8H0jz7uHTJGfjPCDkAmk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DIlYjuIJeEO23aC3SkqKcE0mLUAIeQoGJ/A495H/sekIuPNjMvyVycXbiWsV1HhBQ
 2CgAr1v2+vd7v4JcioveJ+YxU1C/fihnH36FR9kQI3esR+J9LsOrCh+oRSpiKwMOQn
 AtfwO8P8llV6qgAhaIqcch1aqjK2MtwsVvNqHu2PA9uq7/JKU/eSkjTXoLKn1v1KTF
 5HA+rKRMNHvmv1IxuH7r35lpqTvM8ox/3/3UT3f/KYNexqn3uWvXhx071I1XN12tTV
 ictDaVe1b1OjIkv2ZW/HtL29NrBHdJZM3+0TKv0e/PVW1GZZsZm1zDlCzRwqtrbQ/g
 xFiV5IKsy1BNw==
To: jaegeuk@kernel.org
Date: Mon, 15 Jun 2026 21:08:22 +0800
Message-ID: <20260615130822.2576088-6-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260615130822.2576088-1-chao@kernel.org>
References: <20260615130822.2576088-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZ73Z-0005xn-Be
Subject: [f2fs-dev] [PATCH 6/6] f2fs: remove unneeded
 f2fs_is_compressed_page()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

We have checked f2fs_is_compressed_page() before f2fs_compress_write_end_io(),
so we don't need to check the status again, remove it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index aaa0813eabcd..b1209619bb64 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1486,8 +1486,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	struct page *page = &folio->page;
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct compress_io_ctx *cic = folio->private;
-	enum count_type type = WB_DATA_TYPE(folio,
-				f2fs_is_compressed_page(folio));
+	enum count_type type = WB_DATA_TYPE(folio, true);
 	int i;
 
 	if (unlikely(bio->bi_status != BLK_STS_OK))
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
