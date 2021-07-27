Return-Path: <SRS0=TJoR=MT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFACBC432BE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Jul 2021 07:21:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E9B60FEE;
	Tue, 27 Jul 2021 07:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80E9B60FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m8HOs-0006fE-47; Tue, 27 Jul 2021 07:21:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <daeho43@gmail.com>) id 1m8HOq-0006f4-Fz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Jul 2021 07:21:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aM5Gdqk/l733bLOUCg0KHsU2xabe59VDBoDGvm5k0d4=; b=V6L23xpwep0N3BO+l9PNsRjKvr
 Dmu3xQVhKgS0+8Z7J1j+jyPAPiCFT2g2VpJNDtwkR/OEBXEFJnrpKUfxqEOqusI+VkP1NNibRtREZ
 f9OxvIrO0iOd+tTylpx4+rrqejOxcVRHAl5WdgrbQIJPK2cx7L1sQaFUY8pWOc9vYBSQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aM5Gdqk/l733bLOUCg0KHsU2xabe59VDBoDGvm5k0d4=; b=h
 Yb2HVt1ptAWUhi4QGth0Kt0Hjn6WNeSzpw7VoYtsqLY0upPIpGrbMsts9MlGJiGyrISfCFXZlUJEr
 ODHRn3gNak336SGGsVvP2shb05PxatpCRC5NE4bfzB5ZU+0mymUn2uUnbuBpoXkXGV0I52L9zlWS4
 4r9/zQaGZlwTz/nw=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1m8HOo-00043o-EG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Jul 2021 07:21:12 +0000
Received: by mail-pl1-f176.google.com with SMTP id f13so4271452plj.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Jul 2021 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aM5Gdqk/l733bLOUCg0KHsU2xabe59VDBoDGvm5k0d4=;
 b=BlZ5TORrVdsM9UZVYF5dKWbkiMboKGpufIwg1C75LjfOOb7lIoe3q6V4VvFYc9XTtk
 NcRF87bFeF4VJ7zXEVQJQmmHN3gobfIUIL4aaoPDFmN1nwFaGC6tUxIKUKqFpYGD25QK
 JAXbmhqDkNEsqh0B2Wev0F7nMfdAGUAFxsDUeJMbed0BdD0is7DjXuaZhsOpIfq6IdUv
 yySBMvr4iA1e/mKfIoQovIU+xrSLWcJGNcN/mCPCaMUHNPowZD0+wddp5tNEGFodZNWr
 6e/+oYZpH5YdxxYUsHwn+nrU7qZVOPM/LzLc/ICbmM7aX2OOKPa/okT7EnhUsVVZcPk7
 9SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aM5Gdqk/l733bLOUCg0KHsU2xabe59VDBoDGvm5k0d4=;
 b=VTZ3NYp7i1jWZ9j2ebjWecuhjRbh+Zxh965jZCenlwZwsGb5TYy4oLRkoSzckNyQn3
 2dlvm6njWOZe8Ohc8nf2pziCdOLMTUz9yJJl8k0Rk3Yvp1/HhQPZqx3Qut/c+46qSbHd
 WWGiQ2KGDtA4ortfUAGUkffxtCFTyZHe59PEi4pa3Q8e6US14HMDWM3/iggenEArn0ef
 fuxlhqYWb85pmKAt7WSbDKaz1629vXzJOmperdBgJ3sgKUB9Q4j+z0GhruubM9zSFUob
 Gx9hYSHU4/gW7V3JEuKM0ZVwvPTTeF5DmX965WT5bKBsRr0bWs9hyCYFwXJ3dazMHXYu
 bFyA==
X-Gm-Message-State: AOAM5338CXY1u13MRToTTR0207fh+tYsM6PHO/y+pbq2avlM0D80YcQC
 oyM/3NhcFb83lAsHJonNRAs=
X-Google-Smtp-Source: ABdhPJzUuPYQD1B0AlAlfTtrC8HkKd4tBpdE0l0mIajeEL4KJT2dcV8zw/Dam7WiO49htKf2Hyzvlg==
X-Received: by 2002:a17:90a:dc15:: with SMTP id
 i21mr21566079pjv.139.1627370464741; 
 Tue, 27 Jul 2021 00:21:04 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:669a:4d59:379d:fe44])
 by smtp.gmail.com with ESMTPSA id k25sm2394974pfa.213.2021.07.27.00.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jul 2021 00:21:04 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 27 Jul 2021 00:21:00 -0700
Message-Id: <20210727072100.2246422-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
X-Headers-End: 1m8HOo-00043o-EG
Subject: [f2fs-dev] [PATCH] f2fs: turn back remapped address in compressed
 page endio
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Turned back the remmaped sector address to the address in the partition,
when ending io, for compress cache to work properly.

Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache
compressed blocks")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Hyeong Jun Kim <hj514.kim@samsung.com>
---
 fs/f2fs/data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1a716c3b5457..53e71e1bb673 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -228,7 +228,13 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx)
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 	bool all_compressed = true;
-	block_t blkaddr = SECTOR_TO_BLOCK(ctx->bio->bi_iter.bi_sector);
+	sector_t sector = ctx->bio->bi_iter.bi_sector;
+	block_t blkaddr;
+
+	if (bio_flagged(ctx->bio, BIO_REMAPPED))
+		sector -= ctx->bio->bi_bdev->bd_start_sect;
+
+	blkaddr = SECTOR_TO_BLOCK(sector);
 
 	bio_for_each_segment_all(bv, ctx->bio, iter_all) {
 		struct page *page = bv->bv_page;
-- 
2.32.0.432.gabb21c7263-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
