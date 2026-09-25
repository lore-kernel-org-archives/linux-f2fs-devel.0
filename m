Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0D6C9830D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/YhHUmr8MTwjGS2BFeXz+VS3ZZcduxkxNjc9eEP8cU=; b=T8PtiJWnW+5WOQGpbXnBHUtiS5
	pJNbem1lyXHkSjmdiA/im20kti6CHEkB76oGoaGEdTFyxtcB98EL+IxByQwqJspsexm5QmvZjpZpo
	DSEg8vuQPoMeD9IHR+EzkmLhtILI+m3Y+zxs1Ztt3+r08pEhkMYSBqtFOHW+svB6mw9A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xA4VD-0001xV-Mc;
	Fri, 25 Sep 2026 11:54:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xA4Ut-0001vj-LB
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:53:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VUnDpZ+sMKkCvGtPwOYaHkBm+oV0KE1oKFnjibpJ6OQ=; b=enu6e9F1D/V55lEsJ7wPvneDQa
 V41pBL5HWJ/38bSMbAOeccg2HBfEXg3yrffUK7/zITUidc0mMjjxQFLchVF4Nt4/xtbMm8N3HRDqj
 /Y+EzodLLMDgjplmApWTbRK2qNY0laqq9lOj37kSShrX7vqUcwL+DZLm6jdEiXu/iDck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VUnDpZ+sMKkCvGtPwOYaHkBm+oV0KE1oKFnjibpJ6OQ=; b=lrmJKa3YUlsGw5Ou+zvz2LcsUA
 BadgScarrPqSOwiONbNDmXDw76uXnqa55lEhGEYj1qkXH0yRb1UbaCLr1UD3glo4hYPdLaljn+G1e
 R/iRI5E8zdzRKirlgYs/dNkEOZtwE0OufXPPTSsMczSfrLikCtBIuy/TIiModZr+yXSI=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA4Ul-0004ck-RM for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:53:40 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260925113506euoutp01f18a17446673fa551d3dc70fd9c67e03~YjTQQWbBy3035330353euoutp010;
 Fri, 25 Sep 2026 11:35:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260925113506euoutp01f18a17446673fa551d3dc70fd9c67e03~YjTQQWbBy3035330353euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790336106;
 bh=VUnDpZ+sMKkCvGtPwOYaHkBm+oV0KE1oKFnjibpJ6OQ=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=HmyDpMeNlJ4a3p2uP8E6lCuBVJn48Hj33kwhf2b5PcJgfYJHUgDTmvxGD8b7lOtq3
 eW5yPrPiuXDZU0RZkl9OuVh1kDNrseUy+68InhW0/nGjxnM8cWhle5AoRRxqTU6c99
 APpz9eC1BHrWsykceNNz6hlsYTWn4TxRLZDENzOA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260925113505eucas1p22390762781266971ebfa0279f09ef838~YjTPnvbOP1156911569eucas1p2s;
 Fri, 25 Sep 2026 11:35:05 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260925113504eusmtip26af5e16ef3fce2a22894b8135105c6f6~YjTOEADxq0094300943eusmtip2p;
 Fri, 25 Sep 2026 11:35:04 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 25 Sep 2026 13:27:38 +0200
MIME-Version: 1.0
Message-Id: <20260925-lz4-vendor-upstream-v1-8-1c7ffbe21c4b@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7630;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=qExvuSloK/xuoquIgfT7AFOKdD3W5Y4K6+3YR2Dl7H0=;
 b=owGbwMvMwMWoY/uld7nT7DzG02pJDFnbYsK9NI4xqVlnrvgoMW9WRBRjit+V44k590wTkm/oz
 T7J+0qqk9GYhYGRi0FWTJGl7IjIXZ934XWtwh7PYAaxMoFMYeDiFICJlC/lYJj3IiTQ+5V71hv9
 pWaW2tMSXRmj8sLuOnzri255f/bKBPsTX15e1lr+mTHi3ZRb9s2T5zsF6fVu/rr4TbRZ9Em/JE7
 nylc3JqxQvbKd9XydMmv47NLvGnIClwIXFfyXueTZcPPrLt3+q79EXn6bJSQUJMPBPEduSeHHNn
 U15iUzWowtpTcYWOgdi3WL/e5/IETHxVf43iWDyNbbR7+/69Bz0LXR1vat2v3M5pKE1dyUq2t+6
 YWfbox227Xkvi9jy4z9LtrzVgaV2Dw96/Vnxt+a/Fc6LDVRKxZ4d8Qf4eX4n+Fco6IkmScmZftY
 J6p+upZxmHq/x2n3ma2ia+PT51Se5Q/0UNvxtLZR3poFAA==
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=76C414DD4CEE577E851348E62C3DF48DA7429B6E
X-CMS-MailID: 20260925113505eucas1p22390762781266971ebfa0279f09ef838
X-Msg-Generator: CA
X-RootMTR: 20260925113505eucas1p22390762781266971ebfa0279f09ef838
X-EPHeader: CA
X-CMS-RootMailID: 20260925113505eucas1p22390762781266971ebfa0279f09ef838
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113505eucas1p22390762781266971ebfa0279f09ef838@eucas1p2.samsung.com>
X-Headers-End: 1xA4Ul-0004ck-RM
Subject: [f2fs-dev] [PATCH RFC 8/9] lib/lz4: fold lz4_kernel_api.h into
 <linux/lz4.h>
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

lz4_kernel_api.h carried its own copy of the twenty public prototypes
because it could not include <linux/lz4.h>, which defined the stream
types that upstream's headers also define.

The types are incomplete now, so it can. Two prototype lists for one
ABI is a drift hazard: the entry points were built against one and their
callers against the other, so no compiler ever saw both, and MODVERSIONS
would not catch a mismatch either, since it hashes the exporter's view
only. Now there is one list.

It also puts the public constants in scope of the entry points, so the
size assertions can name them, and the HC level clamp can use
LZ4HC_CLAMP_CLEVEL, static_asserted equal to upstream's
LZ4HC_CLEVEL_OPT_MIN.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 lib/lz4/lz4_compress.c   |  2 +-
 lib/lz4/lz4_decompress.c |  2 +-
 lib/lz4/lz4_kernel_api.h | 71 +++---------------------------------------------
 lib/lz4/lz4hc_compress.c |  8 ++++--
 4 files changed, 11 insertions(+), 72 deletions(-)

diff --git a/lib/lz4/lz4_compress.c b/lib/lz4/lz4_compress.c
index 19b877fc96d1dde6fd5ff832f79beca42d5b783b..40ebbc850f42f60ca2ddbcacd3b804cfde9e8d4e 100644
--- a/lib/lz4/lz4_compress.c
+++ b/lib/lz4/lz4_compress.c
@@ -29,7 +29,7 @@
 
 /* Catch any divergence from upstream's layout at build time. */
 static_assert(sizeof(LZ4_stream_t) == LZ4_STREAM_MINSIZE);
-static_assert(LZ4_STREAM_MINSIZE == 16416); /* LZ4_MEM_COMPRESS */
+static_assert(LZ4_STREAM_MINSIZE == LZ4_MEM_COMPRESS);
 
 int LZ4_compress_fast(const char *source, char *dest, int inputSize,
 		      int maxOutputSize, int acceleration, void *wrkmem)
diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 68c8a87476df58fff48b1ffbeee8f2d3bbf743df..49e6f76af975435c10c387c09bb639525a89b5f9 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -31,7 +31,7 @@
 #endif
 
 static_assert(sizeof(LZ4_streamDecode_t) == LZ4_STREAMDECODE_MINSIZE);
-static_assert(LZ4_STREAMDECODE_MINSIZE == 32); /* LZ4_MEM_DECOMPRESS */
+static_assert(LZ4_STREAMDECODE_MINSIZE == LZ4_MEM_DECOMPRESS);
 
 int LZ4_decompress_safe(const char *source, char *dest, int compressedSize,
 			int maxDecompressedSize)
diff --git a/lib/lz4/lz4_kernel_api.h b/lib/lz4/lz4_kernel_api.h
index 795434a64d2cb744c8ac8027d9ed59485ef6e7f3..9d21add27deb207ddba4d90fb36fb6cb62205ef9 100644
--- a/lib/lz4/lz4_kernel_api.h
+++ b/lib/lz4/lz4_kernel_api.h
@@ -3,19 +3,10 @@
  * Copyright (c) 2026 Samsung Electronics Co., Ltd.
  * Author: Michal Wilczynski <m.wilczynski@samsung.com>
  *
- * lz4_kernel_api.h -- the LZ4 API this directory exports
+ * lz4_kernel_api.h -- hand the LZ4 names back to the kernel
  *
- * lz4_deps.h renames upstream's entry points to __lz4_* so that the kernel's
- * own definitions can use the real names; this header undoes that renaming
- * and declares what lib/lz4 exports.
- *
- * The same functions are declared to callers in <linux/lz4.h>, in terms of
- * opaque stream types.  We cannot include that header here -- it and
- * upstream's lz4.h describe the same library and collide -- so the
- * declarations are repeated, expressed in upstream's own types.  Keep the two
- * in step; <linux/lz4.h> is the one callers compile against.
- *
- * Include after upstream/lz4.c or upstream/lz4hc.c.
+ * Undo lz4_deps.h's renaming and pull in <linux/lz4.h>.  Include after
+ * upstream/lz4.c or upstream/lz4hc.c.
  */
 
 #undef LZ4_compress_fast
@@ -41,58 +32,4 @@
 #undef LZ4_compress_HC_continue
 #undef LZ4_saveDictHC
 
-/*
- * The objects that do not build lz4hc.c never see this type, and it is only
- * ever used through a pointer here.  Upstream declares it the same way.
- */
-typedef union LZ4_streamHC_u LZ4_streamHC_t;
-
-/* Compression.  wrkmem is LZ4_MEM_COMPRESS bytes, supplied by the caller. */
-int LZ4_compress_default(const char *source, char *dest, int inputSize,
-			 int maxOutputSize, void *wrkmem);
-int LZ4_compress_fast(const char *source, char *dest, int inputSize,
-		      int maxOutputSize, int acceleration, void *wrkmem);
-int LZ4_compress_destSize(const char *source, char *dest, int *sourceSizePtr,
-			  int targetDestSize, void *wrkmem);
-
-/* Streaming compression. */
-void LZ4_resetStream(LZ4_stream_t *LZ4_stream);
-int LZ4_loadDict(LZ4_stream_t *streamPtr, const char *dictionary,
-		 int dictSize);
-int LZ4_saveDict(LZ4_stream_t *streamPtr, char *safeBuffer, int dictSize);
-int LZ4_compress_fast_continue(LZ4_stream_t *streamPtr, const char *src,
-			       char *dst, int srcSize, int maxDstSize,
-			       int acceleration);
-
-/* Decompression. */
-int LZ4_decompress_safe(const char *source, char *dest, int compressedSize,
-			int maxDecompressedSize);
-int LZ4_decompress_safe_partial(const char *source, char *dest,
-				int compressedSize, int targetOutputSize,
-				int maxDecompressedSize);
-int LZ4_decompress_fast(const char *source, char *dest, int originalSize);
-int LZ4_setStreamDecode(LZ4_streamDecode_t *LZ4_streamDecode,
-			const char *dictionary, int dictSize);
-int LZ4_decompress_safe_continue(LZ4_streamDecode_t *LZ4_streamDecode,
-				 const char *source, char *dest,
-				 int compressedSize, int maxDecompressedSize);
-int LZ4_decompress_fast_continue(LZ4_streamDecode_t *LZ4_streamDecode,
-				 const char *source, char *dest,
-				 int originalSize);
-int LZ4_decompress_safe_usingDict(const char *source, char *dest,
-				  int compressedSize, int maxDecompressedSize,
-				  const char *dictStart, int dictSize);
-int LZ4_decompress_fast_usingDict(const char *source, char *dest,
-				  int originalSize, const char *dictStart,
-				  int dictSize);
-
-/* HC compression.  wrkmem is LZ4HC_MEM_COMPRESS bytes. */
-int LZ4_compress_HC(const char *src, char *dst, int srcSize, int dstCapacity,
-		    int compressionLevel, void *wrkmem);
-void LZ4_resetStreamHC(LZ4_streamHC_t *streamHCPtr, int compressionLevel);
-int LZ4_loadDictHC(LZ4_streamHC_t *streamHCPtr, const char *dictionary,
-		   int dictSize);
-int LZ4_compress_HC_continue(LZ4_streamHC_t *streamHCPtr, const char *src,
-			     char *dst, int srcSize, int maxDstSize);
-int LZ4_saveDictHC(LZ4_streamHC_t *streamHCPtr, char *safeBuffer,
-		   int maxDictSize);
+#include <linux/lz4.h>
diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index 6070719bab54e90a8a163c08842a5531d7b2b4ac..ad49a3509aaac25850c045347d588b9354a8ce18 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -38,7 +38,7 @@ static int LZ4_compressBound(int isize)
 
 /* Catch any divergence from upstream's layout at build time. */
 static_assert(sizeof(LZ4_streamHC_t) == LZ4_STREAMHC_MINSIZE);
-static_assert(LZ4_STREAMHC_MINSIZE == 262200); /* LZ4HC_MEM_COMPRESS */
+static_assert(LZ4_STREAMHC_MINSIZE == LZ4HC_MEM_COMPRESS);
 
 /* Levels >= LZ4HC_CLEVEL_OPT_MIN (10) reach the optimal parser, whose ~64K
  * opt[] does not fit a kernel stack, so clamp them to 9.  Clamp rather than
@@ -46,10 +46,12 @@ static_assert(LZ4_STREAMHC_MINSIZE == 262200); /* LZ4HC_MEM_COMPRESS */
  * untouched; 1 and 2 are upstream's lz4mid, faster and weaker than the
  * shallow hash chain the fork used for them.
  */
+static_assert(LZ4HC_CLAMP_CLEVEL == LZ4HC_CLEVEL_OPT_MIN);
+
 static int lz4hc_clamp_level(int compressionLevel)
 {
-	if (compressionLevel >= LZ4HC_CLEVEL_OPT_MIN)
-		return LZ4HC_CLEVEL_OPT_MIN - 1;
+	if (compressionLevel >= LZ4HC_CLAMP_CLEVEL)
+		return LZ4HC_CLAMP_CLEVEL - 1;
 
 	return compressionLevel;
 }

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
