Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1C60A2611
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XbAh8UvH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A1Lva15P;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QPWSUKVH;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=F0Upi6Kj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=XOkmWaDzO5JzaodccHygI6rTy3tUCw4G5EF6dVJU5K8=; b=XbAh8UvH2F+Ee9Ahg60ZzMT5Gd
	71dsrQvIlyK+00zWK1376pGQaWa29vUfpTqdkzyREpgrY0xo9MxoHlIYjdXLc1Hf89/OqnqXTQHFg
	Cfye4Bg27oYVR/Kj+Re0PD0UcogI4dinh8MCsPb3GMSZ9jncGcfTlhiulmUm5M26yXVA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPL9w-000000001hs-2bra;
	Fri, 06 Nov 2026 14:43:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xPL9u-000000001h2-1CA0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FoTgZCV1Goo86SpjfyfS0uvZJSie1dRSA+Nptn0ArC8=; b=A1Lva15PY1Wo0MyrYquaDY4m4n
 4w8dpKEZpTCl8n4LB58t0SXxv09QGy2nF9v8Wkpzs5CjDDa6m+GaSZih/Y/2ePFLKLxWp0QKAZSvs
 vQkoODRfN9hYoYfhAu7gMQV6s4EJvvTxaoOBU5G5UAUCMZp+t+Qtyq+NNB6jyM+HY76A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FoTgZCV1Goo86SpjfyfS0uvZJSie1dRSA+Nptn0ArC8=; b=QPWSUKVHLVQ7fFEyc98YwhWguC
 Ci8QmfIyV94JuvnxlEmaUHsyJv4x2AZK0F3dYi35GX2V00JoPkYpe52EyVXVuyr0WSVA/j1k8W37j
 G0YN7RsK0OIHMBqwIUkM8uXfooKiyzkT66D72KeiVCJB3RaPD9fXimBizBHWVzZQDFXM=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPL9p-0000000051w-1ALC
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:12 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106144302euoutp01e3afc94e2b93840d2dfd813d85bdd5a6~le9VP5hy42284422844euoutp01g;
 Fri,  6 Nov 2026 14:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261106144302euoutp01e3afc94e2b93840d2dfd813d85bdd5a6~le9VP5hy42284422844euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793976182;
 bh=FoTgZCV1Goo86SpjfyfS0uvZJSie1dRSA+Nptn0ArC8=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=F0Upi6KjRBpfkn3FB5uW1jbpRrKlWwvL4AQpNHG1SZhHs+7tFYTDgH36uD20Whmo+
 249aMJvUN9m1wbI5MTcglfe8IIANGRUi8+NDhua7cWFRVLgzStiAyhVegoNwDkaEhs
 32fq2YkHNJqqZoFqXo7zHCoMRFBOtIXlWF9UfaIA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144301eucas1p1882c2f6ac262ef7c10c3e0cabe333a6b~le9USbGSR2112621126eucas1p12;
 Fri,  6 Nov 2026 14:43:01 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144259eusmtip10ef219b0b43a75100edc1390cf7fb029~le9St_xPI0550005500eusmtip1b;
 Fri,  6 Nov 2026 14:42:59 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 15:42:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261106-lz4-vendor-upstream-v2-8-ee04c3f0d7dc@samsung.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13756;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=WLJaU46vth6DQ+ro+pNGla0mX/S9QL0xdDoBMtKQdNY=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9fZ6qWNxu66Fd3TXH+1jM6uzPGrn9e6uMu1fvPLRK6
 vqv91oSHaUsDGIcDLJiiixnN0YbSf5jeFp+/PEvmDmsTCBDGLg4BWAiUUWMDLf8Zy8oy5zAcylO
 Q/qy6I9PG48nP3p6LcmpofbwsemLIl0ZGZaY1t9hClrGsTLjUYaKgUHdlpW/2O7ZZL0VLbD/ffM
 eHwMA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106144301eucas1p1882c2f6ac262ef7c10c3e0cabe333a6b
X-Msg-Generator: CA
X-RootMTR: 20261106144301eucas1p1882c2f6ac262ef7c10c3e0cabe333a6b
X-EPHeader: CA
X-CMS-RootMailID: 20261106144301eucas1p1882c2f6ac262ef7c10c3e0cabe333a6b
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144301eucas1p1882c2f6ac262ef7c10c3e0cabe333a6b@eucas1p1.samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xPL9p-0000000051w-1ALC
Subject: [f2fs-dev] [PATCH v2 08/15] lib/lz4: add the build environment for
 the vendored sources
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Nick Terrell <terrelln@meta.com>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-parisc@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
 David Laight <david.laight.linux@gmail.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-block@vger.kernel.org, Sungguk <sungguk.na@samsung.com>,
 Yann Collet <yann.collet.73@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Gao Xiang <xiang@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-erofs@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

lz4_deps.h makes the vendored upstream sources build in the kernel. It
gives every upstream entry point internal linkage, so an object carries
only the codec it forwards, selects heap mode with failing allocators so
LZ4HC's ~64K optimal-parser buffer stays off the stack, and renames the
entry points the kernel re-exports so the kernel's own definitions can
use the real names. LZ4LIB_VISIBILITY carries __maybe_unused for the
functions an object does not use.

freestanding/ forwards the four ISO C headers upstream includes to their
<linux/> equivalents. lz4_kernel_api.h undoes the renaming; it carries
its own copy of the exported prototypes until a later patch can include
<linux/lz4.h> instead.

Two settings upstream leaves to the build:

 - Unaligned access goes through memcpy() where the architecture has
   efficient unaligned access, and through packed structs, as
   get_unaligned() does, elsewhere. Left alone, upstream uses plain
   misaligned loads on ARMv6.

 - On ppc64le, lz4.c marks functions __attribute__((optimize("O2"))) for
   GCC, which drops command line options such as -fno-strict-aliasing
   for them; see commit 080b6f407635 ("bpf: Don't rely on GCC
   __attribute__((optimize)) to disable GCSE"). lz4_deps.h defines
   optimize() to nothing for upstream's sources.

Nothing includes either header yet.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 lib/lz4/freestanding/limits.h |  14 +++++
 lib/lz4/freestanding/stddef.h |  15 ++++++
 lib/lz4/freestanding/stdint.h |  14 +++++
 lib/lz4/freestanding/string.h |  14 +++++
 lib/lz4/lz4_deps.h            | 118 ++++++++++++++++++++++++++++++++++++++++++
 lib/lz4/lz4_kernel_api.h      |  90 ++++++++++++++++++++++++++++++++
 6 files changed, 265 insertions(+)

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
index 0000000000000000000000000000000000000000..23d69c75867f71224cb533e9341bd38439b9dee8
--- /dev/null
+++ b/lib/lz4/lz4_deps.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * Build environment for the vendored upstream LZ4 sources.
+ *
+ * upstream/ is LZ4 v1.10.0 plus three backports: 5ef1f16929b5, the aarch64
+ * fast loop (0aa33884faf5, 51f8af506b4a, ed86bc1ed802) and the match length
+ * limit of 587ed9557708, adapted.  Replace it with a later release rather
+ * than patch it further.  The three entry point files include this header
+ * first.
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
+/* Static so an object carries only the codec it forwards.  Each object
+ * forwards only some of them, so mark them __maybe_unused rather than turn
+ * off -Wunused-function, which the pre-boot builds would not see anyway.
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
+/* Left alone, upstream reads unaligned words through packed structs, and
+ * on ARMv6 through plain misaligned dereferences.  Use memcpy(), upstream's
+ * documented default, where unaligned access is cheap, and packed structs,
+ * as get_unaligned() does, where it is not: there GCC builds a memcpy()'d
+ * word through a stack slot.
+ */
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#define LZ4_FORCE_MEMORY_ACCESS 0
+#else
+#define LZ4_FORCE_MEMORY_ACCESS 1
+#endif
+
+/* On ppc64le GCC, lz4.c marks its decompression entry points and every
+ * LZ4_FORCE_INLINE helper optimize("O2"), which makes GCC forget command
+ * line options such as -fno-strict-aliasing for those functions (see commit
+ * 080b6f407635).  Expand the attribute to nothing; lz4_kernel_api.h undoes
+ * this.
+ */
+#define optimize(level)
+
+/* lz4.c sets this before including lz4.h, since its own code calls
+ * deprecated entry points.  lz4.h is included below, ahead of lz4.c.
+ */
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
+#define LZ4_setStreamDecode		__lz4_setStreamDecode
+#define LZ4_decompress_safe_continue	__lz4_decompress_safe_continue
+#define LZ4_decompress_safe_usingDict	__lz4_decompress_safe_usingDict
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
index 0000000000000000000000000000000000000000..de75e5d976eb9dd318da5318a26b91d7aed81042
--- /dev/null
+++ b/lib/lz4/lz4_kernel_api.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * lz4_kernel_api.h -- the LZ4 API this directory exports
+ *
+ * lz4_deps.h renames upstream's entry points to __lz4_* so that the kernel's
+ * own definitions can use the real names; this header undoes that renaming
+ * and the optimize() override, and declares what lib/lz4 exports.
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
+#undef LZ4_setStreamDecode
+#undef LZ4_decompress_safe_continue
+#undef LZ4_decompress_safe_usingDict
+
+#undef LZ4_compress_HC
+#undef LZ4_resetStreamHC
+#undef LZ4_loadDictHC
+#undef LZ4_compress_HC_continue
+#undef LZ4_saveDictHC
+
+#undef optimize
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
+int LZ4_setStreamDecode(LZ4_streamDecode_t *LZ4_streamDecode,
+			const char *dictionary, int dictSize);
+int LZ4_decompress_safe_continue(LZ4_streamDecode_t *LZ4_streamDecode,
+				 const char *source, char *dest,
+				 int compressedSize, int maxDecompressedSize);
+int LZ4_decompress_safe_usingDict(const char *source, char *dest,
+				  int compressedSize, int maxDecompressedSize,
+				  const char *dictStart, int dictSize);
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
