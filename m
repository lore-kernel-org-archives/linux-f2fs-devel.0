Return-Path: <SRS0=TqvU=G5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14265C433E9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 Jan 2021 15:13:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63072310E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 Jan 2021 15:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63072310E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l4Q1m-0007Np-F3; Tue, 26 Jan 2021 15:13:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+b7a2078c382f6036dc0e+6365+infradead.org+hch@casper.srs.infradead.org>)
 id 1l4Q1l-0007Ni-9M
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Jan 2021 15:13:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HErhv54QBaSjoGpiWf1SZ+x2VawfdyThF54vo2cmZ+0=; b=FZSdcFudBk2FZy3iMquJCyhY3A
 M6gcwB5QrZNLHkYN4BEGTfCUsSEKoOYPtjduR65f7GnjpP6BdmsLLIUz6UKmVo8ixEgqg6i5hU8Ht
 GHBd+ZElY3ok5uR56y42Dmqc+Ep+ZivLM3gBe5zfOJJo1UXtFQTSe76IiV0x9tr0ck/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HErhv54QBaSjoGpiWf1SZ+x2VawfdyThF54vo2cmZ+0=; b=bm1ZJntObqfVfbHgICB/sSlGyg
 zDmqNwJe5L97t+z6JyuiU9QiBhEGkVpOmC+HUE1XW5yDhbJNo+H3rE+LHg8BJWTIPzzOZrWF87G4q
 1n7sdjdx3iBn11WShcHt9APMqw2InA705tgYX7qG21k0AVD0QQ+w4TyanZuoriEVWz4M=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1l4Q1c-00AM9f-05
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Jan 2021 15:13:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=HErhv54QBaSjoGpiWf1SZ+x2VawfdyThF54vo2cmZ+0=; b=psFgtPRZ6D/21BqcKKyxXBT5zV
 Arh/O5/9ipibQp28daCFwPAkwEfB8+qxTkARKVHVe011bePjLLoCZIAzrYjP3M/HV6EqUx4is00Yk
 kOABbaz6Etshz/WgzYdyqQE+9HKqaXrdoZVODEsiOGiRPyCkiK74I61FXpT/fV0sHhSRmxgTQ0iBY
 SFDBTDTQ5plMii25HFVgTG3Wg/BO1lFNS1S2Mmjf3GTuH1SDsGuByg0C1MHlYmglHBfP0gXy8clgd
 Ld4f4GtTIzjg/E/zIYg1Xr48+Gj7Jvj4OIzkm7oxnKOobS8TWjPxW+tR7kP9DT95SnrWdUOiZj+ok
 zlSx8+ow==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l4PwO-005nSC-70; Tue, 26 Jan 2021 15:07:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>
Date: Tue, 26 Jan 2021 15:52:39 +0100
Message-Id: <20210126145247.1964410-10-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1l4Q1c-00AM9f-05
Subject: [f2fs-dev] [PATCH 09/17] drbd: remove bio_alloc_drbd
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
Cc: Mike Snitzer <snitzer@redhat.com>, linux-mm@kvack.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-nilfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 linux-nfs@vger.kernel.org, Coly Li <colyli@suse.de>,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-block@vger.kernel.org,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Given that drbd_md_io_bio_set is initialized during module initialization
and the module fails to load if the initialization fails there is no need
to fall back to plain bio_alloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_actlog.c |  2 +-
 drivers/block/drbd/drbd_bitmap.c |  2 +-
 drivers/block/drbd/drbd_int.h    |  2 --
 drivers/block/drbd/drbd_main.c   | 13 -------------
 4 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 7227fc7ab8ed1e..72cf7603d51fc7 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -138,7 +138,7 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 		op_flags |= REQ_FUA | REQ_PREFLUSH;
 	op_flags |= REQ_SYNC;
 
-	bio = bio_alloc_drbd(GFP_NOIO);
+	bio = bio_alloc_bioset(GFP_NOIO, 1, &drbd_md_io_bio_set);
 	bio_set_dev(bio, bdev->md_bdev);
 	bio->bi_iter.bi_sector = sector;
 	err = -EIO;
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index df53dca5d02c7e..c1f816f896a89a 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -976,7 +976,7 @@ static void drbd_bm_endio(struct bio *bio)
 
 static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
 {
-	struct bio *bio = bio_alloc_drbd(GFP_NOIO);
+	struct bio *bio = bio_alloc_bioset(GFP_NOIO, 1, &drbd_md_io_bio_set);
 	struct drbd_device *device = ctx->device;
 	struct drbd_bitmap *b = device->bitmap;
 	struct page *page;
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index b2c93a29c251fd..02db50d7e4c668 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1422,8 +1422,6 @@ extern mempool_t drbd_md_io_page_pool;
 /* We also need to make sure we get a bio
  * when we need it for housekeeping purposes */
 extern struct bio_set drbd_md_io_bio_set;
-/* to allocate from that set */
-extern struct bio *bio_alloc_drbd(gfp_t gfp_mask);
 
 /* And a bio_set for cloning */
 extern struct bio_set drbd_io_bio_set;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1c8c18b2a25f33..788dd97e6026b8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -138,19 +138,6 @@ static const struct block_device_operations drbd_ops = {
 	.release	= drbd_release,
 };
 
-struct bio *bio_alloc_drbd(gfp_t gfp_mask)
-{
-	struct bio *bio;
-
-	if (!bioset_initialized(&drbd_md_io_bio_set))
-		return bio_alloc(gfp_mask, 1);
-
-	bio = bio_alloc_bioset(gfp_mask, 1, &drbd_md_io_bio_set);
-	if (!bio)
-		return NULL;
-	return bio;
-}
-
 #ifdef __CHECKER__
 /* When checking with sparse, and this is an inline function, sparse will
    give tons of false positives. When this is a real functions sparse works.
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
