Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B74AC43602
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Erey7mErEMr7Uptr99xFFbcs/NMrhBjFdwNk9TBlx+g=; b=N5aym0voKRDtQiseLWYnSsRphJ
	LUFczzEzBV6Ghq9B+l/NgouFSQn80QJy2XKPTXFlhiqjsdjdigbrlRnrsYOoMkVIAAjyvf1WYBZpe
	piQDDzCO+KfTlTTEJiKodGQxJqNWaMSK3380JiB+nIg4YOizsvZ31KMfqp1aMHlQsQaY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgSp3-00063Y-MI;
	Sun, 05 Jul 2026 19:48:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wgSoz-00062Z-Ab
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 19:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RZfeHOCc27xPfH8VN0KI68mDzTcNu0zUYX/Le6+dSiI=; b=Tiqmu5FwOURfwQDaWiCJQwadAm
 b+/UAvkjvm4AeQA2XZ0MtIxMVnscD9jIFMx5g39zQUfX+6Uvyn4fYWTzAbNMOrk9pwKJw8GSOVhM0
 J+MiEaCnE+UOGAwoLEIpCavuNslCxENNJ1Vf2GO4lLWevRk38X6qIBDHjJza9jdNvmpQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RZfeHOCc27xPfH8VN0KI68mDzTcNu0zUYX/Le6+dSiI=; b=iZedmtoddLxiUQHoX38Rsu3L0W
 C9ZtTKnKXFmQ7fNSuCLTBZTJUTujick0qrxZrCQ+9+oiDxVDku1OcNsK9VK/hQ6JMpj/fJMbbLetD
 evXINh+AU6ys6KpO3K/NuoZZWU4Qb/MgKG1iXaKcKFWcEOLaJYNVrbWf2Ol4UcBnI/5M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgSoy-0001FK-Ve for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 19:48:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 326DB41187;
 Sun,  5 Jul 2026 19:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6471F00A3E;
 Sun,  5 Jul 2026 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783280884;
 bh=RZfeHOCc27xPfH8VN0KI68mDzTcNu0zUYX/Le6+dSiI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dCUWXxStrR2eOV1gBkCjVKl8HprfmtTXTqDLVsslA94yuzSsxV71f9Gdye7oOgxI9
 Zf9Kn0aSnR+KH04QPpAiE3NPFpnDJDGIc2lHq8J9hWibwlVAubPRgMlhCmiYqIm4rl
 ZPUKD1HlBtp3g1+G/3B8dbe5mA6eiE5h8vIq2aT0o4w0SYdTcrzmfC7DTM5U+rpHtD
 1feDA5mDnTpzhERNtFlMutgixYafi6GFcTw/Y6CvblcvIARt65K2J6Gvx042BiLl6j
 Czy4sHlYUNFd2kfOd4ztdMA0IZzjhTm06kWiWIvaG7OvK8dciUYmwB+446sBqSZDB4
 2Pwvez8xKiAkQ==
To: linux-fscrypt@vger.kernel.org
Date: Sun,  5 Jul 2026 12:45:48 -0700
Message-ID: <20260705194555.75030-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705194555.75030-1-ebiggers@kernel.org>
References: <20260705194555.75030-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wgSoy-0001FK-Ve
Subject: [f2fs-dev] [PATCH v2 11/17] fs/buffer: Remove fs-layer decryption
 code
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 "Christian Brauner \(Amutable\)" <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Zhang Yi <yi.zhang@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
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

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/buffer.c | 45 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9af5f061a1f8..21dd9596a941 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -336,7 +336,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 }
 
-struct postprocess_bh_ctx {
+struct verify_bh_ctx {
 	struct work_struct work;
 	struct buffer_head *bh;
 	struct fsverity_info *vi;
@@ -344,8 +344,8 @@ struct postprocess_bh_ctx {
 
 static void verify_bh(struct work_struct *work)
 {
-	struct postprocess_bh_ctx *ctx =
-		container_of(work, struct postprocess_bh_ctx, work);
+	struct verify_bh_ctx *ctx =
+		container_of(work, struct verify_bh_ctx, work);
 	struct buffer_head *bh = ctx->bh;
 	bool valid;
 
@@ -355,29 +355,6 @@ static void verify_bh(struct work_struct *work)
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
@@ -387,27 +364,21 @@ static void bh_end_async_read(struct bio *bio)
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
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
