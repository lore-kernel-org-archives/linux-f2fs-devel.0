Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C86C98321
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iABg1z9p+m7e4RMJf7oqjQKksdP8Ve7coiUxHsxphkI=; b=B28pKjIWXpD4WKPJjFfvGIxxJp
	g8DThtpFr356sl7sHHFR9fEqVCkegK3e/W8W6AFag6V4/Z0VUNLUaYHKaxaKudz3rCatkB+rgdjmo
	8whuNrcz3nRtpwjlqzN+9uUCGmbbO+Cm3f4dTRzZ1K8P+pCNndNUt5l74EPTpmxmjWVE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xA4Sz-0004O4-Th;
	Fri, 25 Sep 2026 11:51:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xA4Sc-0004Nk-OW
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BK/ZO0j+/1U2W4dSDj6wpjb4BQ1wGqY1PMOGQk1/AfY=; b=ae8by16bQOUcAl1Dqnzd5pJrlW
 KAOkq8rkms8Bbz6lnaadtimkD6AANopSpvs54doji+33HEXwk6tFx6+HBYSpKdFSoPkZXNnj6doNa
 Jxf2I3oJH7YPl7ope/rvOVPj1V+nWLvEvIVaudfz8eiAlMnv01KEug3+iZQifYtElwA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BK/ZO0j+/1U2W4dSDj6wpjb4BQ1wGqY1PMOGQk1/AfY=; b=FkN01ybZYLJrNXlnG6xPJb9ybK
 t8V9Pd9rxq1b1XyFeMOYa6IvxlwD5d0IMDHmmWcdrw9A0fBHWxXyPkcAPBHeGDQbpUCO6a2GrF5r2
 hI7j5esVx4XlsmuH5b2KcZ0NVJLMwK99Dwx3oCvLvcgdbM8jEqSPklr2TqCEODEZlZIo=;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA4SZ-0005o9-NR for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:51:26 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260925113456euoutp02d2078a69ecfd67b52bc971e8d34b548c~YjTG-4u_w0861408614euoutp02o;
 Fri, 25 Sep 2026 11:34:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260925113456euoutp02d2078a69ecfd67b52bc971e8d34b548c~YjTG-4u_w0861408614euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790336096;
 bh=BK/ZO0j+/1U2W4dSDj6wpjb4BQ1wGqY1PMOGQk1/AfY=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=ktN3cYyjOnldGaPvCUIhelemivn9+O6LSaY0FjQI3zp9HFuTfCnHdFeiL/KhsRFEj
 YAyeGJASYcQM3Sy72uwNbCsCJWI2AyG6t36gtwyd8a8S+hqDrofWnV7rzWVAVlnMwM
 FkoxZvdKKhdVV+GTXsu9rcKai8u6dZO8YlbTFPj8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d~YjTGsGKoi0254802548eucas1p1e;
 Fri, 25 Sep 2026 11:34:56 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260925113454eusmtip2712d691557cd347138d3b800b2885687~YjTFHISZQ0094300943eusmtip2l;
 Fri, 25 Sep 2026 11:34:54 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 25 Sep 2026 13:27:33 +0200
MIME-Version: 1.0
Message-Id: <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,  Nathan Chancellor
 <nathan@kernel.org>,  Nick Desaulniers <ndesaulniers@google.com>,  Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,  Russell
 King <linux@armlinux.org.uk>,  Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  Helge Deller <deller@gmx.de>,
 Heiko Carstens <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@kernel.org>,  Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Minchan Kim <minchan@kernel.org>,  Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13232;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=RBIGRJF+APfFXgjJMgh3HEcZIpmNj2o7tax1AcsQ9vg=;
 b=owEBbQGS/pANAwAKASw99I2nQptuAcsmYgBqtlxSreoJU3uPZTrNLhyV8bBw1ioZU2fgBxuUr
 2SDaAwhEwaJATMEAAEKAB0WIQR2xBTdTO5XfoUTSOYsPfSNp0KbbgUCarZcUgAKCRAsPfSNp0Kb
 bq3WCAC34eRxLHLkySq8Ts6NCp+IsNVK/D8JPp6cCePO6cuV8lnupdUUVlzXyWuo1HbXD575zk5
 ApGxLuaw3qVPchkhkg+w61QrfWK4NLcDCbq8P2oSXMXnBqTzei+JH+k7Rs3z4ZAnEvMFebItoZh
 tNVnETlIpqHSnN2pDZNLL+QeIvjdYsbqnwyUB5s6TSCqLHyZeK0VzYfKby8P1Qkedxbk37th3Wo
 m77hZfkMWi6P1uVnYXpbTJwjBfQch+8IZKfelnyAxx4hAK5VYcz963gLBXofgEYg7T2PXCfcPdl
 Ic26w1726nZPBbP7CpRouQZak89lBXbBhQtkXp+nXI/zyqRd
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=76C414DD4CEE577E851348E62C3DF48DA7429B6E
X-CMS-MailID: 20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d
X-Msg-Generator: CA
X-RootMTR: 20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d
X-EPHeader: CA
X-CMS-RootMailID: 20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d@eucas1p1.samsung.com>
X-Headers-End: 1xA4SZ-0005o9-NR
Subject: [f2fs-dev] [PATCH RFC 3/9] lib/lz4: add the build environment for
 the vendored sources
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
Cc: linux-s390@vger.kernel.org, Nick Terrell <terrelln@meta.com>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-block@vger.kernel.org, Sungguk <sungguk.na@samsung.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 Yann Collet <yann.collet.73@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Gao Xiang <xiang@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-erofs@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

lz4_deps.h makes the unmodified upstream sources compile in the kernel:
it supplies the ISO C spellings they expect, gives every upstream entry
point internal linkage so an object carries only the codec it forwards,
keeps every workspace off the stack, and renames the entry points the
kernel re-exports with a trailing wrkmem argument.

freestanding/ forwards the four ISO C headers upstream includes
(stddef.h, stdint.h, limits.h, string.h) to their <linux/> equivalents.

The vendored functions an object does not forward are unreferenced, so
LZ4LIB_VISIBILITY carries __maybe_unused rather than disabling
-Wunused-function for a directory. This also covers the pre-boot
decompressors, which compile lz4_decompress.c textually and never see
lib/lz4's ccflags.

For the same reason this header includes <linux/build_bug.h>: the entry
points static_assert upstream's structure sizes, and only some
architectures' pre-boot environments have static_assert in scope.

lz4_kernel_api.h undoes the renaming for the entry point files and
declares what lib/lz4 exports. It starts out carrying its own copy of
those prototypes, because it cannot include <linux/lz4.h> while that
header still defines the three stream types upstream's headers also
define. A later patch folds it away once they are incomplete.

Nothing includes either header yet.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 lib/lz4/freestanding/limits.h | 14 +++++++
 lib/lz4/freestanding/stddef.h | 15 +++++++
 lib/lz4/freestanding/stdint.h | 14 +++++++
 lib/lz4/freestanding/string.h | 14 +++++++
 lib/lz4/lz4_deps.h            | 96 ++++++++++++++++++++++++++++++++++++++++++
 lib/lz4/lz4_kernel_api.h      | 98 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 251 insertions(+)

diff --git a/lib/lz4/freestanding/limits.h b/lib/lz4/freestanding/limits.h
new file mode 100644
index 0000000000000000000000000000000000000000..0d1cafbc77eb5d2f564b51feaa911748446abf60
--- /dev/null
+++ b/lib/lz4/freestanding/limits.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * Freestanding <limits.h> for the vendored upstream LZ4 sources; lz4.c needs
+ * UINT_MAX and lz4hc.c needs INT_MAX.
+ */
+#ifndef __LZ4_FREESTANDING_LIMITS_H__
+#define __LZ4_FREESTANDING_LIMITS_H__
+
+#include <linux/limits.h>
+
+#endif
diff --git a/lib/lz4/freestanding/stddef.h b/lib/lz4/freestanding/stddef.h
new file mode 100644
index 0000000000000000000000000000000000000000..aaafd2413849210fa4ec4fa03ba0e9453a9fe026
--- /dev/null
+++ b/lib/lz4/freestanding/stddef.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * Freestanding <stddef.h> for the vendored upstream LZ4 sources; -nostdinc
+ * drops the compiler's copy, and lz4.h needs size_t and NULL.
+ */
+#ifndef __LZ4_FREESTANDING_STDDEF_H__
+#define __LZ4_FREESTANDING_STDDEF_H__
+
+#include <linux/stddef.h>	/* NULL, offsetof */
+#include <linux/types.h>	/* size_t, ptrdiff_t */
+
+#endif
diff --git a/lib/lz4/freestanding/stdint.h b/lib/lz4/freestanding/stdint.h
new file mode 100644
index 0000000000000000000000000000000000000000..923db05b19f23fb4051d16e5df2bf134cd5ac11e
--- /dev/null
+++ b/lib/lz4/freestanding/stdint.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * Freestanding <stdint.h> for the vendored upstream LZ4 sources; forwards to
+ * <linux/types.h>.
+ */
+#ifndef __LZ4_FREESTANDING_STDINT_H__
+#define __LZ4_FREESTANDING_STDINT_H__
+
+#include <linux/types.h>
+
+#endif
diff --git a/lib/lz4/freestanding/string.h b/lib/lz4/freestanding/string.h
new file mode 100644
index 0000000000000000000000000000000000000000..8f3ea3b63013608a780a52fe9c33bf5df557584e
--- /dev/null
+++ b/lib/lz4/freestanding/string.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * Freestanding <string.h> for the vendored upstream LZ4 sources; lz4.c
+ * includes it for memcpy()/memset(), which must resolve under -nostdinc.
+ */
+#ifndef __LZ4_FREESTANDING_STRING_H__
+#define __LZ4_FREESTANDING_STRING_H__
+
+#include <linux/string.h>
+
+#endif
diff --git a/lib/lz4/lz4_deps.h b/lib/lz4/lz4_deps.h
new file mode 100644
index 0000000000000000000000000000000000000000..3855aac051585f216df71c5039cff19bcee37ca4
--- /dev/null
+++ b/lib/lz4/lz4_deps.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * Build environment for the vendored upstream LZ4 sources.
+ *
+ * The four files under upstream/ are copied verbatim; do not edit them.  The
+ * three entry point files include this header before them.
+ */
+
+#ifndef __LZ4_DEPS_H__
+#define __LZ4_DEPS_H__
+
+#include <linux/build_bug.h>	/* static_assert */
+#include <linux/compiler.h>	/* __maybe_unused */
+#include <linux/string.h>
+#include <linux/types.h>
+
+/* lz4.c uses "current" as a local; <asm/current.h> breaks the build. */
+#undef current
+
+/* Static so an object carries only the codec it forwards; __maybe_unused
+ * for the ones it does not, which the pre-boot decompressors compile
+ * without lib/lz4's ccflags.
+ */
+#define LZ4LIB_VISIBILITY static __maybe_unused
+
+/* Route upstream's "static linking only" entry points through
+ * LZ4LIB_VISIBILITY too.
+ */
+#define LZ4_PUBLISH_STATIC_FUNCTIONS
+
+/* Heap mode only: the stack mode puts LZ4HC's ~64K opt[] in a frame.
+ * Allocation goes through the failing stubs below; upstream handles
+ * NULL by returning 0.
+ */
+#define LZ4_USER_MEMORY_FUNCTIONS
+#define LZ4_HEAPMODE 1
+#define LZ4HC_HEAPMODE 1
+
+/* Failing stubs; nothing in the kernel reaches these. */
+static void *LZ4_malloc(size_t s) { return NULL; }
+static void *LZ4_calloc(size_t n, size_t s) { return NULL; }
+static void LZ4_free(void *p) { }
+
+/* LZ4_decompress_fast() and LZ4_resetStream() are still kernel API. */
+#define LZ4_DISABLE_DEPRECATE_WARNINGS 1
+
+/* Rename upstream's entry points out of the way; four of them take a
+ * trailing wrkmem argument in the kernel.
+ */
+#define LZ4_compress_fast		__lz4_compress_fast
+#define LZ4_compress_default		__lz4_compress_default
+#define LZ4_compress_destSize		__lz4_compress_destSize
+#define LZ4_resetStream			__lz4_resetStream
+#define LZ4_loadDict			__lz4_loadDict
+#define LZ4_saveDict			__lz4_saveDict
+#define LZ4_compress_fast_continue	__lz4_compress_fast_continue
+
+#define LZ4_decompress_safe		__lz4_decompress_safe
+#define LZ4_decompress_safe_partial	__lz4_decompress_safe_partial
+#define LZ4_decompress_fast		__lz4_decompress_fast
+#define LZ4_setStreamDecode		__lz4_setStreamDecode
+#define LZ4_decompress_safe_continue	__lz4_decompress_safe_continue
+#define LZ4_decompress_fast_continue	__lz4_decompress_fast_continue
+#define LZ4_decompress_safe_usingDict	__lz4_decompress_safe_usingDict
+#define LZ4_decompress_fast_usingDict	__lz4_decompress_fast_usingDict
+
+#define LZ4_compress_HC			__lz4_compress_HC
+#define LZ4_resetStreamHC		__lz4_resetStreamHC
+#define LZ4_loadDictHC			__lz4_loadDictHC
+#define LZ4_compress_HC_continue	__lz4_compress_HC_continue
+#define LZ4_saveDictHC			__lz4_saveDictHC
+
+/* Upstream declares these bare, so both entry point objects would define
+ * them.  Declaring them static first gives them internal linkage (C11
+ * 6.2.2p4): this one in lz4.h, the three below in lz4.c.
+ */
+static __maybe_unused int LZ4_compress_destSize_extState(void *state, const char *src,
+		char *dst, int *srcSizePtr, int targetDstSize,
+		int acceleration);
+
+#include "upstream/lz4.h"
+
+static __maybe_unused int LZ4_compress_forceExtDict(LZ4_stream_t *LZ4_dict,
+		const char *source, char *dest, int srcSize);
+static __maybe_unused int LZ4_decompress_safe_forceExtDict(const char *source,
+		char *dest,
+		int compressedSize, int maxOutputSize,
+		const void *dictStart, size_t dictSize);
+static __maybe_unused int LZ4_decompress_safe_partial_forceExtDict(const char *source,
+		char *dest, int compressedSize, int targetOutputSize,
+		int dstCapacity, const void *dictStart, size_t dictSize);
+
+#endif /* __LZ4_DEPS_H__ */
diff --git a/lib/lz4/lz4_kernel_api.h b/lib/lz4/lz4_kernel_api.h
new file mode 100644
index 0000000000000000000000000000000000000000..795434a64d2cb744c8ac8027d9ed59485ef6e7f3
--- /dev/null
+++ b/lib/lz4/lz4_kernel_api.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * lz4_kernel_api.h -- the LZ4 API this directory exports
+ *
+ * lz4_deps.h renames upstream's entry points to __lz4_* so that the kernel's
+ * own definitions can use the real names; this header undoes that renaming
+ * and declares what lib/lz4 exports.
+ *
+ * The same functions are declared to callers in <linux/lz4.h>, in terms of
+ * opaque stream types.  We cannot include that header here -- it and
+ * upstream's lz4.h describe the same library and collide -- so the
+ * declarations are repeated, expressed in upstream's own types.  Keep the two
+ * in step; <linux/lz4.h> is the one callers compile against.
+ *
+ * Include after upstream/lz4.c or upstream/lz4hc.c.
+ */
+
+#undef LZ4_compress_fast
+#undef LZ4_compress_default
+#undef LZ4_compress_destSize
+#undef LZ4_resetStream
+#undef LZ4_loadDict
+#undef LZ4_saveDict
+#undef LZ4_compress_fast_continue
+
+#undef LZ4_decompress_safe
+#undef LZ4_decompress_safe_partial
+#undef LZ4_decompress_fast
+#undef LZ4_setStreamDecode
+#undef LZ4_decompress_safe_continue
+#undef LZ4_decompress_fast_continue
+#undef LZ4_decompress_safe_usingDict
+#undef LZ4_decompress_fast_usingDict
+
+#undef LZ4_compress_HC
+#undef LZ4_resetStreamHC
+#undef LZ4_loadDictHC
+#undef LZ4_compress_HC_continue
+#undef LZ4_saveDictHC
+
+/*
+ * The objects that do not build lz4hc.c never see this type, and it is only
+ * ever used through a pointer here.  Upstream declares it the same way.
+ */
+typedef union LZ4_streamHC_u LZ4_streamHC_t;
+
+/* Compression.  wrkmem is LZ4_MEM_COMPRESS bytes, supplied by the caller. */
+int LZ4_compress_default(const char *source, char *dest, int inputSize,
+			 int maxOutputSize, void *wrkmem);
+int LZ4_compress_fast(const char *source, char *dest, int inputSize,
+		      int maxOutputSize, int acceleration, void *wrkmem);
+int LZ4_compress_destSize(const char *source, char *dest, int *sourceSizePtr,
+			  int targetDestSize, void *wrkmem);
+
+/* Streaming compression. */
+void LZ4_resetStream(LZ4_stream_t *LZ4_stream);
+int LZ4_loadDict(LZ4_stream_t *streamPtr, const char *dictionary,
+		 int dictSize);
+int LZ4_saveDict(LZ4_stream_t *streamPtr, char *safeBuffer, int dictSize);
+int LZ4_compress_fast_continue(LZ4_stream_t *streamPtr, const char *src,
+			       char *dst, int srcSize, int maxDstSize,
+			       int acceleration);
+
+/* Decompression. */
+int LZ4_decompress_safe(const char *source, char *dest, int compressedSize,
+			int maxDecompressedSize);
+int LZ4_decompress_safe_partial(const char *source, char *dest,
+				int compressedSize, int targetOutputSize,
+				int maxDecompressedSize);
+int LZ4_decompress_fast(const char *source, char *dest, int originalSize);
+int LZ4_setStreamDecode(LZ4_streamDecode_t *LZ4_streamDecode,
+			const char *dictionary, int dictSize);
+int LZ4_decompress_safe_continue(LZ4_streamDecode_t *LZ4_streamDecode,
+				 const char *source, char *dest,
+				 int compressedSize, int maxDecompressedSize);
+int LZ4_decompress_fast_continue(LZ4_streamDecode_t *LZ4_streamDecode,
+				 const char *source, char *dest,
+				 int originalSize);
+int LZ4_decompress_safe_usingDict(const char *source, char *dest,
+				  int compressedSize, int maxDecompressedSize,
+				  const char *dictStart, int dictSize);
+int LZ4_decompress_fast_usingDict(const char *source, char *dest,
+				  int originalSize, const char *dictStart,
+				  int dictSize);
+
+/* HC compression.  wrkmem is LZ4HC_MEM_COMPRESS bytes. */
+int LZ4_compress_HC(const char *src, char *dst, int srcSize, int dstCapacity,
+		    int compressionLevel, void *wrkmem);
+void LZ4_resetStreamHC(LZ4_streamHC_t *streamHCPtr, int compressionLevel);
+int LZ4_loadDictHC(LZ4_streamHC_t *streamHCPtr, const char *dictionary,
+		   int dictSize);
+int LZ4_compress_HC_continue(LZ4_streamHC_t *streamHCPtr, const char *src,
+			     char *dst, int srcSize, int maxDstSize);
+int LZ4_saveDictHC(LZ4_streamHC_t *streamHCPtr, char *safeBuffer,
+		   int maxDictSize);

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
