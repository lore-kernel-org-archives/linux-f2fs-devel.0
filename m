Return-Path: <SRS0=sdIt=BD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85243C433EA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:19:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B592065E;
	Fri, 24 Jul 2020 12:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="kSU3YRn0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="U2zbCxXa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fJjWpC+P";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="KoB83sJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B592065E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R761vhhU9gqptoxiGf9YQLpCvvswflgcqjpLQkPe/vs=; b=kSU3YRn0FFhmhbqLZzEglSxaQ
	7vlFOBJI0C//8J29YxEzFhWs68dznz65mfi2vRWMCE+39e8fS8wt5ShwlYXvfxmShqCitoxD0L8y+
	zACU7uMf416iaCfodJCiaky98oQ3ItxqynIOjpLZjt5j62GVOR32YZBtNnRxFXK2UeOYU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jywfw-0003Xi-Su; Fri, 24 Jul 2020 12:19:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3CtAaXwYKABUDvEJvE19916z.x97@flex--satyat.bounces.google.com>)
 id 1jywft-0003XN-2T
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 12:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cZRHJd9vm6wSJv/XnptuJQLr+rxaeXJfolkFtRJQLFQ=; b=U2zbCxXaeBVRiExt7RIbPd2wT
 FbIhno2bXmgNJab/pZcY3oJKDdxyKBPnRR76tglPV+uh5PzFrZYBTIT73hl4UagaWWc2yJTl0BsKN
 f15zfzWLXd0UQMVwZ70VVnstfVinh1IkXM9l538LUN8ugQ9sCaOk2T/IqVnWufqIloZ0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cZRHJd9vm6wSJv/XnptuJQLr+rxaeXJfolkFtRJQLFQ=; b=fJjWpC+PyX3HKj5AIonivJieNh
 KzoRGktOrWDkxw7UC94xrSKnAEU02hM941gU5lhVL+yIlfJjVJ1z66kF+l5ZH0SFOlLuWxIzry6j+
 pGpIbNry3bIaYE62ktiZF/LoGcG2pKMH69jUnrJBeioEB7arm6TgiK/khyJ+1kB6qW34=;
Received: from mail-oo1-f73.google.com ([209.85.161.73])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jywfr-001Mm2-Pg
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 12:19:41 +0000
Received: by mail-oo1-f73.google.com with SMTP id d143so4561105oob.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2020 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=cZRHJd9vm6wSJv/XnptuJQLr+rxaeXJfolkFtRJQLFQ=;
 b=KoB83sJ7CUVdLVzAAXXB1d5HIww3b9w4WXANf6RJDhlArPSiHhTK/PK8WuhB2tEWdE
 kCcFKQn/yySmnkf4jT6de1v2OPxpX9sjJn+U5/tromL2TKBfU60c+bjV00XwXIrTLEu4
 8vI0PugTGuvm/QxFdiB0sqTcNW/MonZSsudP+hxmFGx4UuhVFhTp54Uxrhu5H9iG4l9R
 KkcujV6MJnRby0uWob+6hiQIuEJret9I5UCLvXr8+0CAJYPwHv6lDGhKsfT9uWS8Cli0
 18olVrcMqQGc8/lazYnAKA5yuqsfJKFeFrR+BYovE5b8eq9DSEwSvqm/zrJXl71JukyE
 b5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=cZRHJd9vm6wSJv/XnptuJQLr+rxaeXJfolkFtRJQLFQ=;
 b=HZefpHdHusvz60lnwZjDijFRVI3EoY72j2LyUt4I8y4Dj+5+v0byoJdNAY/wlazQKd
 UTyFoCMoxriTzxDflGPXIFKLPpxVy4YnOHHirBlVJnaEDOFFBWMq8Pn1MBxvsP+hwB+7
 7dL58OiPD6Vr0zkdDl3ACQnlQ8Xw4Hc6gAkfCvF59e9whm1JqhT8Wi17NJsvFVMKOp10
 XbdbW+51DnK7seeKQuBrJ4n2NW1SLn6YwuvccQ1cEZDAHmEjL88GHK2eBZqDDi40XDuw
 9bNqFx5E4x+0QL+S+96xgpplvOxboDwV/jsyTnjAp1u4CMJqiYth3J68FbQ3Y1PMVtKT
 TtJg==
X-Gm-Message-State: AOAM531IwGLV/sdaRcVdI1UQGdANaKFL0R9wicib7zcxoWpcvfXaajdl
 TJMW+TaVKDFRdYuYVeH/hJHBBHiND6g=
X-Google-Smtp-Source: ABdhPJzqW0b3TqyL5cn0deoeV5HaYLyzoiAc0kf0C/GsHjnYYMOhspEGJ3mRFCHxl3UhNASvV8FA7vQBd2k=
X-Received: by 2002:a17:90b:f05:: with SMTP id
 br5mr5218030pjb.42.1595592714411; 
 Fri, 24 Jul 2020 05:11:54 -0700 (PDT)
Date: Fri, 24 Jul 2020 12:11:39 +0000
In-Reply-To: <20200724121143.1589121-1-satyat@google.com>
Message-Id: <20200724121143.1589121-4-satyat@google.com>
Mime-Version: 1.0
References: <20200724121143.1589121-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jywfr-001Mm2-Pg
Subject: [f2fs-dev] [PATCH v5 3/7] iomap: support direct I/O with fscrypt
 using blk-crypto
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Set bio crypt contexts on bios by calling into fscrypt when required.
No DUN contiguity checks are done - callers are expected to set up the
iomap correctly to ensure that each bio submitted by iomap will not have
blocks with incontiguous DUNs by calling fscrypt_limit_io_blocks()
appropriately.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/iomap/direct-io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..a8785bffdc7c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/iomap.h>
 #include <linux/backing-dev.h>
 #include <linux/uio.h>
@@ -183,11 +184,14 @@ static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
+	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
+	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, iomap->bdev);
 	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 	bio->bi_private = dio;
@@ -270,6 +274,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
-- 
2.28.0.rc0.142.g3c755180ce-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
