Return-Path: <SRS0=9+GF=EJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AAFC388F9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:02:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6A22227F;
	Tue,  3 Nov 2020 06:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dNxBSTVB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Y8PoCMfj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM0TrRYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6A22227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kZpOY-0007xi-KW; Tue, 03 Nov 2020 06:02:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nickrterrell@gmail.com>)
 id 1kZpOU-0007wk-AZ; Tue, 03 Nov 2020 06:02:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MWygwZ+ivEMIi25OaiUo1Zam2MncVHjO+BypAFXIYAo=; b=dNxBSTVBUPC6cW08mFvDo/wD+s
 xqt+HSop+z8oKc6gzoTmLABTIRQuQGSoYyRmhjRlwE0Vsb8j7CiKKaGSI98qMuTiK6xbY513WZ2j+
 5kNQ5ZivwVbM5taOWyA7QsDqT3CMXG59A99XzjNh/9EZqG8pjYijaaer8W0RCffhsEkw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MWygwZ+ivEMIi25OaiUo1Zam2MncVHjO+BypAFXIYAo=; b=Y8PoCMfj+CVgDVktVY+HqlDtPe
 jS0B+rP7gnz/d/KhcEiIjpFHjvamfBhz9IfF6SCZ34NzEB3ePQp+By/lKSPwoUhes/Jha0WEJGUGc
 Sbjt7NmHLDrfxcHSQbXe5EFzLrCGyY+mGUNXVIFdFTW+EMhIaO889+dJHg2ZYW6TBb/Q=;
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kZpOQ-007Kha-JY; Tue, 03 Nov 2020 06:02:10 +0000
Received: by mail-pl1-f195.google.com with SMTP id 1so8075281ple.2;
 Mon, 02 Nov 2020 22:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MWygwZ+ivEMIi25OaiUo1Zam2MncVHjO+BypAFXIYAo=;
 b=JM0TrRYa221OBNL+3xlD+e2qFNGW+oJCIa+nKENT/oK16ai1/3ZwfwHdCCnZqVlMYB
 E0bGwvZgYl0/v8cs1ZNEUjKZc35gP7wC+1gzWp/U5+9lLGjpLQwLbinx7EZOVtka9aqh
 uQqpNedOzM3YjO3AHViLpvAbo41ENlIS7TKOXGaXRMlaAuIHQnyQoVyML0Ukr6m10WHW
 GBDilgXFImL026l/ZahUnhrUvoCkxVD564hJ5CkoXicJDznfLp7wcpKbh2r71vd9Movt
 O8FkIttZkOI+aw3Oc6SekaaFb+q4R+5M5dK9b/qwhKYJfzeyE2SOubJ+2H5qtH+wPbug
 uZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MWygwZ+ivEMIi25OaiUo1Zam2MncVHjO+BypAFXIYAo=;
 b=EdIkRn3nczWceBLTAvuAZi1IgZVh8peli3DfTvqZerUgXa5Hib+DA7g13ZlqhuNdwr
 Ux0kX8WkVXOPnW9321wq011UT9g/TcKhhfKgVHjjJNN4r8ZHOqUpxm+RrHdl9hOPm88z
 Sb13e/4jtLIeCQjFdoplmmj797KCESXXbP51I5FJRGk7+p6cQVHR/Nb0kJbaWccflUJm
 a71R+lTX9EXO38TNdHvjnTtMB7ta2S1Wq0G1GufS8gxiUC2T+6l/vH+seZaus+/tWX3e
 1hB46+hzmEBZAaQ3dDOgOFEyQ82PNJ6yYU2czdwtsy//k26EZ4HtjbDMlbGCFzZULVWY
 TM1g==
X-Gm-Message-State: AOAM532wq3L8CrSMQOvgB8OKYaSb2Haq66n+z03uvGYxE/8lCzdJw2Pi
 RZvXunHolalrpwm8rdHg77c=
X-Google-Smtp-Source: ABdhPJwtMrMHoYdikDXTZBypvBnbSnctOVijmsKBxGO4u9Ixf+hOMd80RN9SqJluxhfUII1McD2Y7Q==
X-Received: by 2002:a17:902:8693:b029:d5:d861:6f03 with SMTP id
 g19-20020a1709028693b02900d5d8616f03mr23725211plo.19.1604383320987; 
 Mon, 02 Nov 2020 22:02:00 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net.
 [98.33.101.203])
 by smtp.gmail.com with ESMTPSA id b16sm15647269pfp.195.2020.11.02.22.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 22:02:00 -0800 (PST)
From: Nick Terrell <nickrterrell@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon,  2 Nov 2020 22:05:28 -0800
Message-Id: <20201103060535.8460-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103060535.8460-1-nickrterrell@gmail.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1kZpOQ-007Kha-JY
Subject: [f2fs-dev] [PATCH v5 2/9] lib: zstd: Add decompress_sources.h for
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
index 6bb805aeec08..3c6ad01ffcd5 100644
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
index 000000000000..ccb4960ea0cd
--- /dev/null
+++ b/lib/zstd/decompress_sources.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
