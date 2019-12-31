Return-Path: <SRS0=KtvY=2V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FE3C2D0C2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:15:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB05206E0;
	Tue, 31 Dec 2019 18:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hFp5/ijA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PsW6zh1r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3I6UYzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB05206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1imM2v-00025j-UV; Tue, 31 Dec 2019 18:15:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1imM2u-00025Y-UX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Dec 2019 18:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JjcOOhlRu+nuQQJ/5kcC/ORzZAIBnk3TWoEggLLY5bE=; b=hFp5/ijAsLGyOCEL7XhWP3EGxk
 A3mP+i3bSMczvbZsX6YJiF8+SDlEnmDCZIKnWD9Eu5YxO0tR4Dpfq/qpkpA48gBqirNXYGuVHhjf3
 Jej03KHG1VH10WOeI9Q6xHkFPvJOVudL9t0+7nBHJ4bSARbdoRlyA0zYMgTC3t/dbQEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JjcOOhlRu+nuQQJ/5kcC/ORzZAIBnk3TWoEggLLY5bE=; b=P
 sW6zh1r/OPZhAXJQbMA9CE+zmouWUWQmh8bfY4uCq57WPpbEbvdn0ioJjdJ2ArhrsglN+q8rfD7Bc
 O/4B+i97xjLqOcCKGlCkErnCPM/teJ+JUJIxb4u/z7RMdVNrVD+wjLO/CV+A3iN262E0YP9eODAA7
 bFG/oACY7zfsgZLk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1imM2i-00462M-8I
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Dec 2019 18:15:08 +0000
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net
 [75.100.12.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74F33206E0;
 Tue, 31 Dec 2019 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577816090;
 bh=VRBAeHHuBqRZmHtfK71JmXlieh+xplwpOzsMUUyH3lA=;
 h=From:To:Cc:Subject:Date:From;
 b=n3I6UYzPFU3JqjaAcvlcWImIBC7EiiW3MHlCFhZlohMvYyZs2ojPdGSAmBWzo4fzf
 ZPYHgQrQXefmMgO63Xi83gw0/Oue3SN6rmZvuJBwLQ9VNmToOfFQdJ0zIEwx2ZyvGe
 QUfAv3GQX0MsNamVa99kRxGvfeXZBWZzYqhWgyxs=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 31 Dec 2019 12:14:16 -0600
Message-Id: <20191231181416.47875-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Headers-End: 1imM2i-00462M-8I
Subject: [f2fs-dev] [PATCH] f2fs: fix deadlock allocating bio_post_read_ctx
 from mempool
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
Cc: linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Without any form of coordination, any case where multiple allocations
from the same mempool are needed at a time to make forward progress can
deadlock under memory pressure.

This is the case for struct bio_post_read_ctx, as one can be allocated
to decrypt a Merkle tree page during fsverity_verify_bio(), which itself
is running from a post-read callback for a data bio which has its own
struct bio_post_read_ctx.

Fix this by freeing first bio_post_read_ctx before calling
fsverity_verify_bio().  This works because verity (if enabled) is always
the last post-read step.

This deadlock can be reproduced by trying to read from an encrypted
verity file after reducing NUM_PREALLOC_POST_READ_CTXS to 1 and patching
mempool_alloc() to pretend that pool->alloc() always fails.

Note that since NUM_PREALLOC_POST_READ_CTXS is actually 128, to actually
hit this bug in practice would require reading from lots of encrypted
verity files at the same time.  But it's theoretically possible, as N
available objects doesn't guarantee forward progress when > N/2 threads
each need 2 objects at a time.

Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/data.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 19cd03450066..618a05bf356e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -199,19 +199,32 @@ static void f2fs_verity_work(struct work_struct *work)
 {
 	struct bio_post_read_ctx *ctx =
 		container_of(work, struct bio_post_read_ctx, work);
+	struct bio *bio = ctx->bio;
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	unsigned int enabled_steps = ctx->enabled_steps;
+#endif
+
+	/*
+	 * fsverity_verify_bio() may call readpages() again, and while verity
+	 * will be disabled for this, decryption may still be needed, resulting
+	 * in another bio_post_read_ctx being allocated.  So to prevent
+	 * deadlocks we need to release the current ctx to the mempool first.
+	 * This assumes that verity is the last post-read step.
+	 */
+	mempool_free(ctx, bio_post_read_ctx_pool);
+	bio->bi_private = NULL;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* previous step is decompression */
-	if (ctx->enabled_steps & (1 << STEP_DECOMPRESS)) {
-
-		f2fs_verify_bio(ctx->bio);
-		f2fs_release_read_bio(ctx->bio);
+	if (enabled_steps & (1 << STEP_DECOMPRESS)) {
+		f2fs_verify_bio(bio);
+		f2fs_release_read_bio(bio);
 		return;
 	}
 #endif
 
-	fsverity_verify_bio(ctx->bio);
-	__f2fs_read_end_io(ctx->bio, false, false);
+	fsverity_verify_bio(bio);
+	__f2fs_read_end_io(bio, false, false);
 }
 
 static void f2fs_post_read_work(struct work_struct *work)
-- 
2.24.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
