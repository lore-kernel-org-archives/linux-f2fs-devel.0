Return-Path: <SRS0=+lo7=NW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5508C432BE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Aug 2021 00:54:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D9C60FE6;
	Tue, 31 Aug 2021 00:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92D9C60FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mKs2I-0000MG-HA; Tue, 31 Aug 2021 00:53:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1mKs2H-0000M5-4z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Aug 2021 00:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S/eM6ub/e/UKAnLGYQrIwljPO3L/gHJfpOtSIwN+JGc=; b=eFV8wzCpWT2xPOKNMkjCb3lmNS
 Y0M4WkdAp2JQ/eThS+llQdz/rFTWfH0fx7tXU9PRVyVo6V84q47d6FEZ0GQ5aJI49sWNShlLMP3sI
 SKYaFL9mExVFkY8+LI14Z5IHEnGfBMkbyg6b9cG2cn0oQiZlBxQA8nlY1Z22KoY+lP+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S/eM6ub/e/UKAnLGYQrIwljPO3L/gHJfpOtSIwN+JGc=; b=J
 BO1m3Jle/q12qmS3r6YuxTMxuZx/c5/cT1gIYpgUwxXJNAH7LEiKNzoHUAPoLBqlWMoxO22TSdZ76
 kxZ852KBv7goJj+StnaGwEWXQngnyc/mhIKEBVv6+RXwUgsfBjf77YUBXn1SVFZAKWbJcl4rbYhIL
 rBcGJjAGRpDKnKic=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mKs2F-0003mu-JT
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Aug 2021 00:53:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 767A260FE6;
 Tue, 31 Aug 2021 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630371228;
 bh=ooTDUto4Y8X1OmuC8lpldPc6v/zwqtRT620l+46tx0c=;
 h=From:To:Cc:Subject:Date:From;
 b=asjTqDVPpZEmoBXOBj1lHhcouEn9iDwA4r5DOw8i0HfIcKsq5N/baZc2n19KOMziG
 ppoP9V4ey2IqQoOmsJqNSdRV84vibU70KO6vy13o+fCqeKD3cD6e/BiGGg7CuBjvQY
 IOHvVluo0KhZ6t33ysLfjRUoT/2IVAIQ+UG53G2T2CNTBdt/omBPgf88GAyBwSjFTC
 UXOLBHIdhqF0B0mhUJr4eAz28PZi2V3VxILSkCRVPq12dp/zc+Kxl00DUCuePFXv7z
 25tWMz00qIZzedzbHRAZVb7yZpeVp4ZY9yezFG8wKwYKoLLTwgSbGBbHOStWGyuJck
 UK48Duvrcf4YQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 30 Aug 2021 17:53:45 -0700
Message-Id: <20210831005346.118701-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
X-Headers-End: 1mKs2F-0003mu-JT
Subject: [f2fs-dev] [PATCH 1/2] f2fs: deallocate compressed pages when error
 happens
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_write_multi_pages(), f2fs_compress_pages() allocates pages for
compression work in cc->cpages[]. Then, f2fs_write_compressed_pages() initiates
bio submission. But, if there's any error before submitting the IOs like early
f2fs_cp_error(), previously it didn't free cpages by f2fs_compress_free_page().
Let's fix memory leak by putting that just before deallocating cc->cpages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ec70a0a32327..c1bf9ad4c220 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1394,12 +1394,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	for (--i; i >= 0; i--)
 		fscrypt_finalize_bounce_page(&cc->cpages[i]);
-	for (i = 0; i < cc->nr_cpages; i++) {
-		if (!cc->cpages[i])
-			continue;
-		f2fs_compress_free_page(cc->cpages[i]);
-		cc->cpages[i] = NULL;
-	}
 out_put_cic:
 	kmem_cache_free(cic_entry_slab, cic);
 out_put_dnode:
@@ -1410,6 +1404,12 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	else
 		f2fs_unlock_op(sbi);
 out_free:
+	for (i = 0; i < cc->nr_cpages; i++) {
+		if (!cc->cpages[i])
+			continue;
+		f2fs_compress_free_page(cc->cpages[i]);
+		cc->cpages[i] = NULL;
+	}
 	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
 	return -EAGAIN;
-- 
2.33.0.259.gc128427fd7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
