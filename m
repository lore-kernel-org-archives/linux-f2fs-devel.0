Return-Path: <SRS0=1iDP=MU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CFDC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jul 2021 19:38:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEC36101E;
	Wed, 28 Jul 2021 19:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FEC36101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m8pNr-0006KM-0T; Wed, 28 Jul 2021 19:38:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1m8pNq-0006KG-36
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Jul 2021 19:38:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qfmiBSUy0m89ACHPYq151CEHSd3AdxvV9MPMF5qQK0M=; b=O7e/EYj9ReoSJqoBnWREftnRSx
 o4Wy9ykRyNFo4Jt83scuOc8qh0qOMgLhN8WsyBuSc4NK3986ROCdJLfUc4FgEmzdFHnmcfFPUJM3c
 OATFPuuLiYt3nd8TK3VdrVylcaQaNbNY/A68p1SEp2enoNGqFBaQncVFTN8ems+X9DIk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qfmiBSUy0m89ACHPYq151CEHSd3AdxvV9MPMF5qQK0M=; b=j
 I19ANGZhu90TtklZ5MrfqLgAQ7pn/ZheOZoot51PXUfxTem0Zld08QGFj979a96KZnRTS6Anh8HnB
 L2dTJDnUg+rxwTTwqAPqzbuZ47lvIGUdwhemumFNm/keURb14V+4rrn7LX35ty6tCq2fcZBrSx6PF
 HIJrJQFJxZFGMfnk=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1m8pNl-005kAi-Ty
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Jul 2021 19:38:25 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 k4-20020a17090a5144b02901731c776526so11719578pjm.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Jul 2021 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qfmiBSUy0m89ACHPYq151CEHSd3AdxvV9MPMF5qQK0M=;
 b=CrSdY90uBzF24xeu3OTgmcLWve+jUYrMlNJ4pwYP60/pqYnSZlLCjbZy4fJ436pel7
 1eeArlZinJDCKmvV2pLG9KfR35XAvwTKKlO8jKBURucrFRQsgAbVor+FGIZqDWvfxmFn
 zc3079U073CAKhYx7tWqaCRN8ZoK9/q7k8E0wsgGNlb2RoOPb3pwJCXmTYEIQbUb2tYa
 IJS7PlbpuK4QjjNf4OsvtjjniphEMQWZbAkqmpHP3CyjUdg1cgNVW0Q99/g98kyV9nmE
 E9AhaEt02gWF0kPRrmCiZY3FKu3LFv/6N3YWXjqr+oPHLEmabIk6ssOftnj4cl0DWXCn
 HC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qfmiBSUy0m89ACHPYq151CEHSd3AdxvV9MPMF5qQK0M=;
 b=GG5vxxUHLmb1HDHjvGTS9yLmwmBxENgFDvR36QOnX21s1jcSqAhw96Byji7sPFYLqe
 76Ipt9Qfg+YQiRecredFtiyU6E92U/FwC64AIZRifJtVUHpwTCn3rMcxx0rzuVuAjxo7
 e7aLIGkWPgkcLRGNBSYIFw8cec6/uI2TwF2DzHdRzz2eRbtlk3FGcWp449F890FnJBV+
 6XnWj1nrFBwufK5CDMsv+824Ay3e775q9EYX+U6isYYw8hZWSOlnIskbMXzjWS66FdeG
 XkRq1IvsOGc0BmhRmYxqFmKLkDJkCaKgqOC6lMvvrZ0/OTJ9yAEBHOnx3CWu6GBKEfYu
 OoXA==
X-Gm-Message-State: AOAM533C85hOB4RvF2fx9l+RWBfYU8bSCukvVL90TDMTPbqtLganpnSp
 aKvoMo+bZRyGb4/pueG3YzI=
X-Google-Smtp-Source: ABdhPJzcK0bRqvyQAbSL+jz9O1uSmP/wYuUfB/OvZ5Nckb6iT9r8Ad8dFxdTwltQ7k9N56yA3R2lng==
X-Received: by 2002:a62:c501:0:b029:32a:dfe9:8648 with SMTP id
 j1-20020a62c5010000b029032adfe98648mr1440975pfg.28.1627501096217; 
 Wed, 28 Jul 2021 12:38:16 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:6456:ee63:e147:5ea])
 by smtp.gmail.com with ESMTPSA id n56sm820113pfv.65.2021.07.28.12.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jul 2021 12:38:15 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed, 28 Jul 2021 12:38:11 -0700
Message-Id: <20210728193811.2519412-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
X-Headers-End: 1m8pNl-005kAi-Ty
Subject: [f2fs-dev] [PATCH v2] f2fs: turn back remapped address in
 compressed page endio
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
v2: avoid knowing too much about lower structures
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1a716c3b5457..0ec5950949fb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -116,6 +116,7 @@ struct bio_post_read_ctx {
 	struct f2fs_sb_info *sbi;
 	struct work_struct work;
 	unsigned int enabled_steps;
+	block_t fs_blkaddr;
 };
 
 static void f2fs_finish_read_bio(struct bio *bio)
@@ -228,7 +229,7 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx)
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 	bool all_compressed = true;
-	block_t blkaddr = SECTOR_TO_BLOCK(ctx->bio->bi_iter.bi_sector);
+	block_t blkaddr = ctx->fs_blkaddr;
 
 	bio_for_each_segment_all(bv, ctx->bio, iter_all) {
 		struct page *page = bv->bv_page;
@@ -1003,6 +1004,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		ctx->bio = bio;
 		ctx->sbi = sbi;
 		ctx->enabled_steps = post_read_steps;
+		ctx->fs_blkaddr = blkaddr;
 		bio->bi_private = ctx;
 	}
 
-- 
2.32.0.432.gabb21c7263-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
