Return-Path: <SRS0=1yAE=CZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE57BC43461
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2020 03:43:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA6E21D94;
	Wed, 16 Sep 2020 03:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VffZty1O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="XkRuSU1B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2tIH0hJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA6E21D94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kIOLh-0006G0-J1; Wed, 16 Sep 2020 03:43:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nickrterrell@gmail.com>)
 id 1kIOLf-0006Fo-D1; Wed, 16 Sep 2020 03:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2E/IwoJzArQOI0tLeIWcAV63W6gwJ92+ohjyeEw8pg8=; b=VffZty1OfrEuzI5NY/ErSLPRH3
 OTaVGDGa6LLcCd8s6swqAwVwBfg+LReJIdIp5vSPDcNOJXIe3EuhCiaLcckZKmlqZ9Tw3aqlrJjMo
 jjgHgBC+ee/Sj9NiV3xJ6YsOY+SYaVayHsbBD/z4rOBVoB0OqDiOmThKqaoGTDH/uV0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2E/IwoJzArQOI0tLeIWcAV63W6gwJ92+ohjyeEw8pg8=; b=XkRuSU1BXd9X15kOUjjvMXVmnK
 jp79q14H+QJGIAS1MLzJxZrm0jCIMdf+2MI1MSVvFjNZ05vff2ys0LOZudQnUqz1TGWw2D7quPOYv
 W6CLOXQMCi2A9ZTEmRX1tdGJzFgGfHeVfGhdr0MOhaD7szs1UBQl+HRwifJD1ePocrtQ=;
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kIOLY-00Albs-G2; Wed, 16 Sep 2020 03:43:11 +0000
Received: by mail-pj1-f65.google.com with SMTP id jw11so837309pjb.0;
 Tue, 15 Sep 2020 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2E/IwoJzArQOI0tLeIWcAV63W6gwJ92+ohjyeEw8pg8=;
 b=G2tIH0hJDw6zI92LS/tcNNlHDcmmoUZfw6SbHD2guhCP/EguIR999y1+FxTCyDDkfe
 tjeVfQvqKsrNK+fL1PW2rN3SgLNUzKQsjOhtyUluz64Nn26tecg/JoV7tGaQbJxl2vWC
 ETAOh8fJeuYCih2snpvYiVesT2gc+G6V7nEltdTnwaYh0ZeDREqR3uD+pz1yufF4yIBg
 0/wVV0fh2VO7OjDuDeB4y44DBhTYavxu5IiHz/qajUNFVQJONemtgDf11ZSNd033wB4h
 r71tBBSO9GLay1+LZWnGZtTCmWLiGdzfXQDojF6LjzIvnRJrsr6fabApBnQblS6G6s2/
 L7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2E/IwoJzArQOI0tLeIWcAV63W6gwJ92+ohjyeEw8pg8=;
 b=mD6O+IZ+veCbqI1bTLElbfs2zAKi4Oy86dJZTjQheF4NutXwfl+WhoN4J4PEZIVRYa
 IEAIK5cSj2nvHHZ6TPJ5F9dTeVvkcd2YAHSdOC/kXht7/6e87OPtRHoyEvkA0waRPwUV
 YtcSQxTTY6oJIigmlKmZa5MFCRFA+AWnMKp41UiG/Pk6bfTY4/vOmsEAtrbepvLfx4Xs
 1/WTn5XctaaENiyjKTS3c1KcXyaqw/4seuyKBqJx0ZwVtpmOmYiumKFzaLxEsYQTDhSy
 FHPoK1a6Ub2SeweMlfajCuNF87lmEUQ1bjtBeMXiQ5HziygTiOkswnm7WMODCddyTBvX
 jmYA==
X-Gm-Message-State: AOAM533FG+5kx28aIiZBy3H0y++pmuGZN9zjuFJghANyCAaL88XhrN5m
 w/XKYqKzkMWvVt5Sz0mR6/k=
X-Google-Smtp-Source: ABdhPJwIdN9jdHWNUgbnk9X/e5/fIUkyDrTm/Ylx6HjufZ434p5aOCgnmfBhcKOD3fa2jkVsQXis+A==
X-Received: by 2002:a17:902:20b:b029:d1:9bc8:37f5 with SMTP id
 11-20020a170902020bb02900d19bc837f5mr21043614plc.41.1600227771832; 
 Tue, 15 Sep 2020 20:42:51 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net.
 [98.33.101.203])
 by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 20:42:51 -0700 (PDT)
From: Nick Terrell <nickrterrell@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 15 Sep 2020 20:42:59 -0700
Message-Id: <20200916034307.2092020-7-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916034307.2092020-1-nickrterrell@gmail.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1kIOLY-00Albs-G2
Subject: [f2fs-dev] [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
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
Cc: squashfs-devel@lists.sourceforge.net, Johannes Weiner <jweiner@fb.com>,
 Nick Terrell <nickrterrell@gmail.com>, Yann Collet <cyan@fb.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Petr Malat <oss@malat.biz>, Chris Mason <clm@fb.com>,
 Nick Terrell <terrelln@fb.com>, linux-crypto@vger.kernel.org,
 Kernel Team <Kernel-team@fb.com>, Niket Agarwal <niketa@fb.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nick Terrell <terrelln@fb.com>

Move away from the compatibility wrapper to the zstd-1.4.6 API. This
code is functionally equivalent.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 fs/btrfs/zstd.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index a7367ff573d4..6b466e090cd7 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -16,7 +16,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/zstd_compat.h>
+#include <linux/zstd.h>
 #include "misc.h"
 #include "compression.h"
 #include "ctree.h"
@@ -159,8 +159,8 @@ static void zstd_calc_ws_mem_sizes(void)
 			zstd_get_btrfs_parameters(level, ZSTD_BTRFS_MAX_INPUT);
 		size_t level_size =
 			max_t(size_t,
-			      ZSTD_CStreamWorkspaceBound(params.cParams),
-			      ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT));
+			      ZSTD_estimateCStreamSize_usingCParams(params.cParams),
+			      ZSTD_estimateDStreamSize(ZSTD_BTRFS_MAX_INPUT));
 
 		max_size = max_t(size_t, max_size, level_size);
 		zstd_ws_mem_sizes[level - 1] = max_size;
@@ -389,13 +389,23 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = 0;
 
 	/* Initialize the stream */
-	stream = ZSTD_initCStream(params, len, workspace->mem,
-			workspace->size);
+	stream = ZSTD_initStaticCStream(workspace->mem, workspace->size);
 	if (!stream) {
-		pr_warn("BTRFS: ZSTD_initCStream failed\n");
+		pr_warn("BTRFS: ZSTD_initStaticCStream failed\n");
 		ret = -EIO;
 		goto out;
 	}
+	{
+		size_t ret2;
+
+		ret2 = ZSTD_initCStream_advanced(stream, NULL, 0, params, len);
+		if (ZSTD_isError(ret2)) {
+			pr_warn("BTRFS: ZSTD_initCStream_advanced returned %s\n",
+					ZSTD_getErrorName(ret2));
+			ret = -EIO;
+			goto out;
+		}
+	}
 
 	/* map in the first page of input data */
 	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
@@ -421,8 +431,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret2 = ZSTD_compressStream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_compressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+			pr_debug("BTRFS: ZSTD_compressStream returned %s\n",
+					ZSTD_getErrorName(ret2));
 			ret = -EIO;
 			goto out;
 		}
@@ -489,8 +499,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		ret2 = ZSTD_endStream(stream, &workspace->out_buf);
 		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_endStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+			pr_debug("BTRFS: ZSTD_endStream returned %s\n",
+					ZSTD_getErrorName(ret2));
 			ret = -EIO;
 			goto out;
 		}
@@ -557,10 +567,9 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long buf_start;
 	unsigned long total_out = 0;
 
-	stream = ZSTD_initDStream(
-			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
+	stream = ZSTD_initStaticDStream(workspace->mem, workspace->size);
 	if (!stream) {
-		pr_debug("BTRFS: ZSTD_initDStream failed\n");
+		pr_debug("BTRFS: ZSTD_initStaticDStream failed\n");
 		ret = -EIO;
 		goto done;
 	}
@@ -579,8 +588,8 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		ret2 = ZSTD_decompressStream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_decompressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+			pr_debug("BTRFS: ZSTD_decompressStream returned %s\n",
+					ZSTD_getErrorName(ret2));
 			ret = -EIO;
 			goto done;
 		}
@@ -633,10 +642,9 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 	unsigned long pg_offset = 0;
 	char *kaddr;
 
-	stream = ZSTD_initDStream(
-			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
+	stream = ZSTD_initStaticDStream(workspace->mem, workspace->size);
 	if (!stream) {
-		pr_warn("BTRFS: ZSTD_initDStream failed\n");
+		pr_warn("BTRFS: ZSTD_initStaticDStream failed\n");
 		ret = -EIO;
 		goto finish;
 	}
@@ -667,8 +675,8 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 		ret2 = ZSTD_decompressStream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (ZSTD_isError(ret2)) {
-			pr_debug("BTRFS: ZSTD_decompressStream returned %d\n",
-					ZSTD_getErrorCode(ret2));
+			pr_debug("BTRFS: ZSTD_decompressStream returned %s\n",
+					ZSTD_getErrorName(ret2));
 			ret = -EIO;
 			goto finish;
 		}
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
