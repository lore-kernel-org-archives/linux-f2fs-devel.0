Return-Path: <SRS0=8FvW=J3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305C5C43460
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Apr 2021 01:26:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFBE61433;
	Fri, 30 Apr 2021 01:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFBE61433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lcHvj-0001vS-9p; Fri, 30 Apr 2021 01:26:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nickrterrell@gmail.com>)
 id 1lcHvV-0001sN-Sf; Fri, 30 Apr 2021 01:26:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zdyCdL1O6MHAZHMO3v3t2Hk2heeS+Nt7HrJ8IUq+ohk=; b=jpWM84WGeEn6nrcJuTI18SqZXj
 QYQBUK7Wb082RGNoxBgK5AJc66PNHqILSUFg4cKYTMSTv2AXq7rtCKp9uZkrngcbIKIYlOTlvcHeH
 9yNezERrHSRu0qnhG/IZd6HbfIP5ZmV8uLIh04+k/fwTPdgMhp2jShXhqQIZibytsvuk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zdyCdL1O6MHAZHMO3v3t2Hk2heeS+Nt7HrJ8IUq+ohk=; b=PP6BG8KuhwRc3bFXG+k4KDIn36
 7fRUBO9W2S/SkyMTH0Ov/SqWJt9kLJsX95UGTfEmIXbT2azu2y2IT/qTjkg32LoKNkonJbRo3I/yM
 ekUczXAurWTschJ23BOaV82ifDqA05TZUUv3picUuZszho4fdH/MP0rmlT4xWNGZsi1U=;
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lcHvE-0002Ub-N1; Fri, 30 Apr 2021 01:26:28 +0000
Received: by mail-pg1-f179.google.com with SMTP id s22so27274368pgk.6;
 Thu, 29 Apr 2021 18:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zdyCdL1O6MHAZHMO3v3t2Hk2heeS+Nt7HrJ8IUq+ohk=;
 b=BYxmhK1n9H0nKDwO+Ha+zT+rMPj0BzlGTzWDyIUEvUJ27eS/Ny06fZjIa178mQ5kAK
 6KWXx959qlaBOih9YYjuXhRR30lUCqEIjJ+SzYKjXhTJVxEbjOCnbgwfbunn65KI12bG
 MKMNdxbh6g+3fhJaQ7DhxVNM3i7yCd7GlfKrfAMb2pmhgk2R9baWfkP9nbaBrSuOpYzc
 GKq9Ff3w7QwWWbA/etFwGyclavrFk5Dfv92VUIyycgq2nJbU3sh+SRsEc6XHOD++w3+/
 608R0qjpax0lIvHZ9VPSTbNjsVqvQsrOfEw24xPJzRiifGaGdf1Gwp6lwuNfoe3vqNPV
 kGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zdyCdL1O6MHAZHMO3v3t2Hk2heeS+Nt7HrJ8IUq+ohk=;
 b=SyVkjl9MQgLC61uvlYzxuUpGWrDNlE1o9AkKtZyhf+2Yg3F9sADutdYWKDw9xTN5yn
 SUHSHmKX1xB5F/DDQhtKpP8LijMYF7CygbCzxBlxEL1L+b+hV8kE2Ul/lYVH7EbhPvxJ
 5ZddirsY3rxNOs856NXnVr77T6YLXfHTvngGLbnQ481FIj2X8NjjwWLMD7JW1gXdZe0x
 FaBETJtvPEuvpUn6uBf7pMZCR99/ez3TKJczc2JO4Hos5qcp0WqvCqtHqfNlE8VMBwCv
 i1157DILHVriqLErpUtAEdyYQFg+EuJMCgukbXnnEXktaynQRj10OR3P5DYqGJIHbQQv
 xZrg==
X-Gm-Message-State: AOAM532sKAW95HE40KQvTICx0S/aeLFzYPfzc6V+lchTew/NDdOdKuqr
 6MUj17x18WJK8P7wkOE2ZuU=
X-Google-Smtp-Source: ABdhPJxasLAAXECB+ejCznswoVICk6jyMEwCmKhGuuiYamVdkto9Mr5qLdUoNKMo7NUkMExKCMsCew==
X-Received: by 2002:a63:f715:: with SMTP id x21mr2280456pgh.399.1619745979497; 
 Thu, 29 Apr 2021 18:26:19 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net.
 [98.33.101.203])
 by smtp.gmail.com with ESMTPSA id b186sm311004pfb.27.2021.04.29.18.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Apr 2021 18:26:19 -0700 (PDT)
From: Nick Terrell <nickrterrell@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 29 Apr 2021 18:31:55 -0700
Message-Id: <20210430013157.747152-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430013157.747152-1-nickrterrell@gmail.com>
References: <20210430013157.747152-1-nickrterrell@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1lcHvE-0002Ub-N1
Subject: [f2fs-dev] [PATCH v11 2/4] lib: zstd: Add decompress_sources.h for
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
Cc: squashfs-devel@lists.sourceforge.net, Randy Dunlap <rdunlap@infradead.org>,
 Eric Biggers <ebiggers@kernel.org>, Johannes Weiner <jweiner@fb.com>,
 Christoph Hellwig <hch@infradead.org>, Nick Terrell <nickrterrell@gmail.com>,
 Yann Collet <cyan@fb.com>, David Sterba <dsterba@suse.cz>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Petr Malat <oss@malat.biz>, Chris Mason <clm@fb.com>,
 Nick Terrell <terrelln@fb.com>, linux-crypto@vger.kernel.org,
 Felix Handte <felixh@fb.com>, Oleksandr Natalenko <oleksandr@natalenko.name>,
 Kernel Team <Kernel-team@fb.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
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
 lib/zstd/decompress_sources.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)
 create mode 100644 lib/zstd/decompress_sources.h

diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index c88aad49e996..6e5ecfba0a8d 100644
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
index 000000000000..d82cea4316f5
--- /dev/null
+++ b/lib/zstd/decompress_sources.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Facebook, Inc.
+ * All rights reserved.
+ *
+ * This source code is licensed under both the BSD-style license (found in the
+ * LICENSE file in the root directory of this source tree) and the GPLv2 (found
+ * in the COPYING file in the root directory of this source tree).
+ * You may select, at your option, one of the above-listed licenses.
+ */
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
2.31.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
