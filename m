Return-Path: <SRS0=GBMW=C7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C7C2D0E2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:06:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B585D206FB;
	Tue, 22 Sep 2020 21:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Wz6rP+Jz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fhjApVEs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML0s+z4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B585D206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kKpU5-0001G7-Nk; Tue, 22 Sep 2020 21:05:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nickrterrell@gmail.com>)
 id 1kKpU3-0001Fg-0X; Tue, 22 Sep 2020 21:05:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=; b=Wz6rP+JzMP0f98KPHovQDrvSyF
 HpU4O4HpCD4h3Hu8QICc7R1Cu2l2ABW4wmtZ14yOQURnoJk+B59qOjER58St0rIdT2OY0xbXMITTF
 LcJndoAENX0l9nM1sbkYuFBUoRQcgeCJ9lXqXzsqaVTBvaOOeg1EJipwpKeCajLKOcho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=; b=fhjApVEsopixTBHCMWFS3twKgx
 RbKwJY1RGHl0D0S+0AoUN3JqMvH9q5zsYsL9ig6tNt6ZvsrK3GSF2TOrxwVh8Ux23FmW7wbqk1Q9j
 v9gQg6BenapwXR2PfLhcaCffBc7NDk/1gMDXATFK8vqaAIv+tyMMNF1pgsvCBriG263w=;
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kKpTn-001ipR-P8; Tue, 22 Sep 2020 21:05:54 +0000
Received: by mail-pf1-f196.google.com with SMTP id b124so13582919pfg.13;
 Tue, 22 Sep 2020 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
 b=ML0s+z4JiTGGpbGPOVB62fUQXSz8pBkrRGE1exLoA5L8vRau2DwvSWAXq5wm8EfgfS
 eO88W0lcJ0tX/ctYDhv/PwogvmF3gpvH7/XNB5AAcGy4qZwD0VnfGjN7iNStIFA4+Fxy
 wwTL4MzsEQAkh2IEJc/x9MH7j3pe5wliicssOGpMOFguasGvioTiF87/VBdMCrlDhJaz
 vCxOZJw/Q+TH2sSIr+kVXxR8lOFWnCWswm6nDTZSRPz9GFvZBl8VTRsyEtf/GIaeVGbQ
 Z6+Ld/5dYMMq+fGLtJ8DOS0JNLuc5IB0IaSeUql+ezqKOXj7lCQVXHfU7W/GpalbKAjE
 qEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
 b=LbWaTAvDMhcHHOnlanfkrdCABSx7WQfW4MxVDkMZlLx4WsCynZXhQQkBisaHGa56aA
 OOGenf1ISdNr0zL71w5vIvQHdAuBwNZzatOJHzwEE16V0PjkXQGxgo5HAY+BtjiExC4P
 ekPYT/aeMm+Wo9nQtwYdvzP/yQq0sIYQ8ByrXosDQMv1b1/fgiuWBVeZ83WmDPDI2vRh
 ++dfIBL0pk86biF1fAzYp4d/VY+qJP6OYyQSkRBZFDq/LSvfG1fUpqfnKhQsqNYzFH6p
 bZcgw0syO2bikBjAuGspyG8gdBClyd2PWSZkLKjKFCuZgQDLT5+dYEaRLgd3dBOD5T+1
 xEkQ==
X-Gm-Message-State: AOAM533zegHynYJvR0JCifKQyjiiuB8UpTfA3z8f2PE4PH31aACnmtDG
 ntiRh7UPtQF7ofiCyLO4p4A=
X-Google-Smtp-Source: ABdhPJzpIRe/uXi9oko6PATw8guaQq7mv8V7LLBJQB2a9sT+vfvvH75/JxXt+7bx/mgfndJLJK6jQQ==
X-Received: by 2002:a17:902:aa02:b029:d0:cbe1:e7b4 with SMTP id
 be2-20020a170902aa02b02900d0cbe1e7b4mr6181491plb.37.1600808734213; 
 Tue, 22 Sep 2020 14:05:34 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net.
 [98.33.101.203])
 by smtp.gmail.com with ESMTPSA id i15sm16118945pfk.145.2020.09.22.14.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 14:05:33 -0700 (PDT)
From: Nick Terrell <nickrterrell@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 22 Sep 2020 14:09:17 -0700
Message-Id: <20200922210924.1725-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922210924.1725-1-nickrterrell@gmail.com>
References: <20200922210924.1725-1-nickrterrell@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1kKpTn-001ipR-P8
Subject: [f2fs-dev] [PATCH v2 2/9] lib: zstd: Add decompress_sources.h for
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
index dbc290af26b4..a79f705f236d 100644
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
