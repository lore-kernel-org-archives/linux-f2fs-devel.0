Return-Path: <SRS0=BY5/=FG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C262AC6369E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Dec 2020 20:29:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E41621527;
	Wed,  2 Dec 2020 20:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E41621527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kkYkb-0001i3-NC; Wed, 02 Dec 2020 20:29:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nickrterrell@gmail.com>)
 id 1kkYkK-0001eh-A7; Wed, 02 Dec 2020 20:29:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WENPVElJQF3n0FCtwr/Deyj/08dbHxSq1tQKlooFAvw=; b=UUL39zT+nuCImaoAdUxGH1iK1E
 6pfk8DKsu81FX7ecWWxRTG6YwF3VzM9nsgLhy7VgSWWqEhubuaTkGDEj/FftM2fFBjc+KlLTkx/K4
 4nzQZkF5/a9qoZL2FFAxhdlq4tn6URgCdtEswKRIHpNzUU4YY/NMHelDca0x6kiM+XeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WENPVElJQF3n0FCtwr/Deyj/08dbHxSq1tQKlooFAvw=; b=c3HVpaEUJNBPOngVvRL2jYfDIb
 cpXb9ZZZWUzrI03VUZjowggZd07zDicjlNMlS7t4wYsHEtLE6HHpv5gPdN0ORL3BujtcSiftJzDJa
 cN88zazP2/OLwpTbCrRkFEZAS+uE5nrL1dStSgx1nIF3P6YbVtaunAKzX/LrrqtzuiYA=;
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kkYk2-00C2WK-0l; Wed, 02 Dec 2020 20:29:02 +0000
Received: by mail-pf1-f193.google.com with SMTP id q22so1962932pfk.12;
 Wed, 02 Dec 2020 12:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WENPVElJQF3n0FCtwr/Deyj/08dbHxSq1tQKlooFAvw=;
 b=ezehFisbVfB+MB8e754s3Ekkx0EUMSCv2vXtrYfxfh+ntN+w8g96YN7QKALLza/OYJ
 mpanSL+Ly9/PnLfUOOGTw0C/6bozOQ6lX0LrzyEqYN/0cyNh2GcvHPS/aG71VQ/sMKWO
 AND6z5oZxtEjUeNwq0aObCu0zdewzC4QNtTYzymORIggWs2ZQx2wjUuZxsFolCEDf+7v
 bHR6L1FO1cIObDSoDksj/MxYT82noLVvkLCoQrFlt3clf/RlQEx6mzxQt3NFPrs6e/I7
 mQ1Vi7USiZD/8CXlOS3rH83MsN0aVWU57mALEm6mC+3VCBSaWJiWQNorfZq1QqOEDAiz
 9MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WENPVElJQF3n0FCtwr/Deyj/08dbHxSq1tQKlooFAvw=;
 b=dZj7HNfyc96/ui9NZtb4CNNTpkRscLLH87CfsdvMe9ReVB1PlgAGM6Tvj6oKTGtn1i
 oHj3fRwH51yateyZLU2ip6k+c/WcLUhOYYcDrmoJ0XEd8c542n0RxIoPdGptd6hSW4BR
 Rsa9Sc+PqCY1hojyCHverAiBmq9txs/n5oC5bq0py9sXJy4tde9+mzz8KJH2pPplf4Re
 /3jufGdA/a8yCKrLGJF8SBC0Gk5SY9AvcdbSBnv4ZZk9+p1hBEc8JJGNS5cRbv7seTEd
 FMUClR2OoqZ5MNFV3c2KorK2Pq4cDy0zh7qioSg/n9VxkMQNjqKRM5Bjj05HEbivoUeL
 jaxA==
X-Gm-Message-State: AOAM533jt7OsjD72wo3wjq+bh7x3m8jXGwvfDHFWPvlY7j4vocixssSs
 AKBzBha3xT4mRYXpbxImWyw=
X-Google-Smtp-Source: ABdhPJx8DYIDpxyFh2AnnF0HS8udrS8iv3EKguuhCCjewcbdOTJFX69vygn3dqnL3eh8PqeuPKQTIA==
X-Received: by 2002:a63:b60:: with SMTP id a32mr1424789pgl.275.1606940913171; 
 Wed, 02 Dec 2020 12:28:33 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net.
 [98.33.101.203])
 by smtp.gmail.com with ESMTPSA id r11sm535120pgn.26.2020.12.02.12.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 12:28:32 -0800 (PST)
From: Nick Terrell <nickrterrell@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed,  2 Dec 2020 12:32:41 -0800
Message-Id: <20201202203242.1187898-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202203242.1187898-1-nickrterrell@gmail.com>
References: <20201202203242.1187898-1-nickrterrell@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1kkYk2-00C2WK-0l
Subject: [f2fs-dev] [PATCH v6 2/3] lib: zstd: Add decompress_sources.h for
 decompress_unzstd
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
 Christoph Hellwig <hch@infradead.org>, Nick Terrell <nickrterrell@gmail.com>,
 Yann Collet <cyan@fb.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Petr Malat <oss@malat.biz>,
 Chris Mason <clm@fb.com>, Nick Terrell <terrelln@fb.com>,
 linux-crypto@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
 Niket Agarwal <niketa@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nick Terrell <terrelln@fb.com>

Adds decompress_sources.h which includes every .c file necessary for
zstd decompression. This is used in decompress_unzstd.c so the internal
structure of the library isn't exposed.

This allows us to upgrade the zstd library version without modifying any
callers. Instead we just need to update decompress_sources.h.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/decompress_unzstd.c       |  6 +-----
 lib/zstd/decompress_sources.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 lib/zstd/decompress_sources.h

diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index 87ff567fd76d..d42281d7d416 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -68,11 +68,7 @@
 #ifdef STATIC
 # define UNZSTD_PREBOOT
 # include "xxhash.c"
-# include "zstd/entropy_common.c"
-# include "zstd/fse_decompress.c"
-# include "zstd/huf_decompress.c"
-# include "zstd/zstd_common.c"
-# include "zstd/decompress.c"
+# include "zstd/decompress_sources.h"
 #endif
 
 #include <linux/decompress/mm.h>
diff --git a/lib/zstd/decompress_sources.h b/lib/zstd/decompress_sources.h
new file mode 100644
index 000000000000..d2fe10af0043
--- /dev/null
+++ b/lib/zstd/decompress_sources.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * This file includes every .c file needed for decompression.
+ * It is used by lib/decompress_unzstd.c to include the decompression
+ * source into the translation-unit, so it can be used for kernel
+ * decompression.
+ */
+
+#include "entropy_common.c"
+#include "fse_decompress.c"
+#include "huf_decompress.c"
+#include "zstd_common.c"
+#include "decompress.c"
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
