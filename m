Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34342CDB47F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g/4MSb1Y3eO2GaFvpGTaZh3FaJy6QbU1UXKBKHDUqdQ=; b=inqH4WcqOUIjfBRGkNdp1cUN/Q
	IoE6351dKRnaQqm6/3ymm5mFV/kYKorAs16SximTxirN88aoNjYjpqjjjVbTP0x4nzFO+cMUTHKP5
	95kmAkoGPhHZQ89EL9Knpk8AGabimUVdHQ1Za0VoppK+tgWexMCOKmnTeUGsTxyNM0y4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcFod-0000wy-56;
	Wed, 24 Jun 2026 05:06:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wcFob-0000wb-4Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ebBXpaAjXk49KLNuYNTlNcNswdiZ5gqBVZ+LrAJfT1U=; b=IMjOcBTFyKzuTUwq86zfq7Vuf0
 h/Q+sW5Y4BhR8JYcmBEslppp50XqCona1LNN08iajs92902x8UN6AXLOli8xPigMH0gqVslWxqgTB
 Ql/hgQSTrG83v6NHOLug/5gc4E4EZu8IlVWA9+jrw44S42a+v2t4YbPq3BjDf3ZHl44k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ebBXpaAjXk49KLNuYNTlNcNswdiZ5gqBVZ+LrAJfT1U=; b=gITyQB7n8wr3vK4rTrSgnkKPFH
 n+NpT2liwQXRj3tO1nO1Q2j2hkDHfrkQeWO35UjHTmXSbPN9dCnFd3vIQRDpOD4zOQh778deWn0SU
 1BlxAkTqWwxw0Qx3dRmPjuUeZH3LJB0h1QHLybonGzGIRtOxi4jKhBgRM842khsRY9kM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcFoZ-0004nI-PI for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FA3D4452C;
 Wed, 24 Jun 2026 05:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798EF1F00AC4;
 Wed, 24 Jun 2026 05:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782277564;
 bh=ebBXpaAjXk49KLNuYNTlNcNswdiZ5gqBVZ+LrAJfT1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=neOJRwaHGAGxAApHKWDtOWnCgMo880nQkDcqwUso4QRaoZNvbLBd8W327XRPDAjvs
 qrPylWNKjSWi7RVCblirUeEF3+BHyAODk9O6vZsf/Ng/1IrGJbnHemVVhhpg4b6Z0e
 5Ljjqea8DP6SaO3OAJk6PDw+IzfcAtbCtGLHh1Nz3VL9GKjdPxvRabIMZsKjx8L7sa
 01mShRsSGaGptFrNBmSatfuF2BNUfABcGpxGGWfjChYJEc9w5qREN5sNVthgrovOkH
 IweiUWOEBPSY4n1USngleRdgPjfigobJjGM4MhHGy0eKo1MsOc+V7xrduAc7RsS+ZG
 oBXJZw9vx7emA==
To: linux-fscrypt@vger.kernel.org
Date: Tue, 23 Jun 2026 22:03:28 -0700
Message-ID: <20260624050334.124606-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624050334.124606-1-ebiggers@kernel.org>
References: <20260624050334.124606-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wcFoZ-0004nI-PI
Subject: [f2fs-dev] [PATCH 10/16] fs/buffer: Remove fs-layer decryption code
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now that fscrypt's file contents en/decryption is always implemented
using blk-crypto when the filesystem is block-based, the fs-layer
decryption code in fs/buffer.c is unused code.  Remove it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/buffer.c | 45 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9af5f061a1f8..21dd9596a941 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -334,82 +334,53 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 
 still_busy:
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 }
 
-struct postprocess_bh_ctx {
+struct verify_bh_ctx {
 	struct work_struct work;
 	struct buffer_head *bh;
 	struct fsverity_info *vi;
 };
 
 static void verify_bh(struct work_struct *work)
 {
-	struct postprocess_bh_ctx *ctx =
-		container_of(work, struct postprocess_bh_ctx, work);
+	struct verify_bh_ctx *ctx =
+		container_of(work, struct verify_bh_ctx, work);
 	struct buffer_head *bh = ctx->bh;
 	bool valid;
 
 	valid = fsverity_verify_blocks(ctx->vi, bh->b_folio, bh->b_size,
 				       bh_offset(bh));
 	end_buffer_async_read(bh, valid);
 	kfree(ctx);
 }
 
-static void decrypt_bh(struct work_struct *work)
-{
-	struct postprocess_bh_ctx *ctx =
-		container_of(work, struct postprocess_bh_ctx, work);
-	struct buffer_head *bh = ctx->bh;
-	int err;
-
-	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
-					       bh_offset(bh));
-	if (err == 0 && ctx->vi) {
-		/*
-		 * We use different work queues for decryption and for verity
-		 * because verity may require reading metadata pages that need
-		 * decryption, and we shouldn't recurse to the same workqueue.
-		 */
-		INIT_WORK(&ctx->work, verify_bh);
-		fsverity_enqueue_verify_work(&ctx->work);
-		return;
-	}
-	end_buffer_async_read(bh, err == 0);
-	kfree(ctx);
-}
-
 /*
  * I/O completion handler for block_read_full_folio() - folios
  * which come unlocked at the end of I/O.
  */
 static void bh_end_async_read(struct bio *bio)
 {
 	struct buffer_head *bh;
 	bool uptodate = bio_endio_bh(bio, &bh);
 	struct inode *inode = bh->b_folio->mapping->host;
-	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
 	struct fsverity_info *vi = NULL;
 
 	/* needed by ext4 */
 	if (bh->b_folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
 		vi = fsverity_get_info(inode);
 
-	/* Decrypt (with fscrypt) and/or verify (with fsverity) if needed. */
-	if (uptodate && (decrypt || vi)) {
-		struct postprocess_bh_ctx *ctx = kmalloc_obj(*ctx, GFP_ATOMIC);
+	/* Verify (with fsverity) if needed. */
+	if (vi && uptodate) {
+		struct verify_bh_ctx *ctx = kmalloc_obj(*ctx, GFP_ATOMIC);
 
 		if (ctx) {
 			ctx->bh = bh;
 			ctx->vi = vi;
-			if (decrypt) {
-				INIT_WORK(&ctx->work, decrypt_bh);
-				fscrypt_enqueue_decrypt_work(&ctx->work);
-			} else {
-				INIT_WORK(&ctx->work, verify_bh);
-				fsverity_enqueue_verify_work(&ctx->work);
-			}
+			INIT_WORK(&ctx->work, verify_bh);
+			fsverity_enqueue_verify_work(&ctx->work);
 			return;
 		}
 		uptodate = false;
 	}
 	end_buffer_async_read(bh, uptodate);
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
