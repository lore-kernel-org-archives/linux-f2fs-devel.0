Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F38606EE8E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jc45e+6A;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Tg8sWNtR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EKnlN8c/;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=M8gZZwbj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=mEibUOqPNPQozBoLP/7/LZFL5ccf5VypHRlnEFKTATQ=; b=jc45e+6A/zuUnu4qAM+K//hWgE
	E9N1sk/0juSwXJqTsTLz50/u53NdXiwYxN2tu/uUiCQ1sVzxlYBPZzZhG1mySLmkrim8Gnjp2b7id
	a6Zj/qy5oWVR0k/I2mjIcnw2urVkRK2+FJOzVIof24hraUoYSc1s/CacudooSAovzV3c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPL9i-000000000LP-1pjg;
	Fri, 06 Nov 2026 14:43:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xPL9h-000000000LB-1Qal
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=78E49OBy2vOoRp7AN/TR4ZTGCJZbMDDSfbiqD0uAN1c=; b=Tg8sWNtRJoco9d+6uPQKMr8M6P
 cbqKOxBdiOIvO6ogVWSYftkExKhazXvrYaj4v4nltcpQZe3mvA6JqtFX9QvKOrhtzNkUCWGv2tniv
 NakgEafltEGDR+qXrGjBMAubdZlHszYuSCYPPL56NXeC/m0ry64kDZe5nsH/V7L89S8w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=78E49OBy2vOoRp7AN/TR4ZTGCJZbMDDSfbiqD0uAN1c=; b=EKnlN8c/o2ts6ICcxmZ3NnQU+e
 Yz8Ml6S06bL9CQh/VX7NoWm73XRwcws4DCZaSzRTVcwllyLy4j7ZvJTboW8JMa38rzGRl7KZXV/RK
 gYJe8nKC7vlDehytYoJkfwxbLJaCLF0qz3lKjlG8vu2mHjG/AYysIq8eaK/y3RxpflnU=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPL9d-0000000051W-2gbq
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:01 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106144251euoutp0124c3e0e8100b38fae754f436843806e8~le9Kc-C1K2317823178euoutp01Q;
 Fri,  6 Nov 2026 14:42:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261106144251euoutp0124c3e0e8100b38fae754f436843806e8~le9Kc-C1K2317823178euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793976171;
 bh=78E49OBy2vOoRp7AN/TR4ZTGCJZbMDDSfbiqD0uAN1c=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=M8gZZwbjD4LgP+xP0uC24mjXC9kKwoMA/TiWFSHNOnP9zE5gyBdPfBpVXF2Y7o78u
 JwPYDfW9yoAJKd7B7pt0Y/A1+ivUHknlVBTlWJNJjwfsurupjK6UuIo8GeqoOQqQpZ
 n79l67FhNKVWWq212/kD400VVKiW+DDI1gdDo6Ms=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261106144250eucas1p23dbd9566bcf265bb48728cedff315031~le9KDaSv51206712067eucas1p2W;
 Fri,  6 Nov 2026 14:42:50 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144249eusmtip1c345bf2ed8b7c6eeaaffcd2c9e7cf626~le9IhzIcG0491904919eusmtip1d;
 Fri,  6 Nov 2026 14:42:48 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 15:42:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261106-lz4-vendor-upstream-v2-2-ee04c3f0d7dc@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10729;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=BKqLz3nPV4nIxU4/LOt8w19Fm/2lu9lum9paP/eOwAI=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9fZ4iuFzskPBCtZnBN9LdLrLOYeBuFBe5Emr92Uuqm
 vX4hhXfO0pZGMQ4GGTFFFnObow2kvzH8LT8+ONfMHNYmUCGMHBxCsBELq5lZOh8PJFvteO7+ZP4
 xLVXTOmTahE0fHPxvebD+b9n3nRgsuFh+KeVqniopO3Uo1z3c6cOdG9pusOht23+pv3LtkrvWjF
 VqpIRAA==
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106144250eucas1p23dbd9566bcf265bb48728cedff315031
X-Msg-Generator: CA
X-RootMTR: 20261106144250eucas1p23dbd9566bcf265bb48728cedff315031
X-EPHeader: CA
X-CMS-RootMailID: 20261106144250eucas1p23dbd9566bcf265bb48728cedff315031
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144250eucas1p23dbd9566bcf265bb48728cedff315031@eucas1p2.samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xPL9d-0000000051W-2gbq
Subject: [f2fs-dev] [PATCH v2 02/15] lib/lz4: remove LZ4_decompress_fast()
 and its variants
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

LZ4_decompress_fast(), LZ4_decompress_fast_continue() and
LZ4_decompress_fast_usingDict() have no users left. Upstream has
deprecated all three since v1.9: they take only the decompressed size,
so a corrupt or malicious stream has nothing to stop the decoder from
reading past the end of its input.

Remove them, their exports and their declarations in <linux/lz4.h>,
along with the two helpers only they used. Doing it before lib/lz4 moves
to upstream LZ4 keeps them out of the glue that move adds.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 include/linux/lz4.h      | 81 ----------------------------------------------
 lib/lz4/lz4_decompress.c | 84 ------------------------------------------------
 2 files changed, 165 deletions(-)

diff --git a/include/linux/lz4.h b/include/linux/lz4.h
index ad6042a718b5428792b795db7a8d4ad44c24a985..0df69e2b1ad523c291e3a96ab5595df9239f7252 100644
--- a/include/linux/lz4.h
+++ b/include/linux/lz4.h
@@ -249,27 +249,6 @@ int LZ4_compress_destSize(const char *source, char *dest, int *sourceSizePtr,
  *	Decompression Functions
  **************************************************************************/
 
-/**
- * LZ4_decompress_fast() - Decompresses data from 'source' into 'dest'
- * @source: source address of the compressed data
- * @dest: output buffer address of the uncompressed data
- *	which must be already allocated with 'originalSize' bytes
- * @originalSize: is the original and therefore uncompressed size
- *
- * Decompresses data from 'source' into 'dest'.
- * This function fully respect memory boundaries for properly formed
- * compressed data.
- * It is a bit faster than LZ4_decompress_safe().
- * However, it does not provide any protection against intentionally
- * modified data stream (malicious input).
- * Use this function in trusted environment only
- * (data to decode comes from a trusted source).
- *
- * Return: number of bytes read from the source buffer
- *	or a negative result if decompression fails.
- */
-int LZ4_decompress_fast(const char *source, char *dest, int originalSize);
-
 /**
  * LZ4_decompress_safe() - Decompression protected against buffer overflow
  * @source: source address of the compressed data
@@ -561,44 +540,6 @@ int LZ4_decompress_safe_continue(LZ4_streamDecode_t *LZ4_streamDecode,
 	const char *source, char *dest, int compressedSize,
 	int maxDecompressedSize);
 
-/**
- * LZ4_decompress_fast_continue() - Decompress blocks in streaming mode
- * @LZ4_streamDecode: the 'LZ4_streamDecode_t' structure
- * @source: source address of the compressed data
- * @dest: output buffer address of the uncompressed data
- *	which must be already allocated with 'originalSize' bytes
- * @originalSize: is the original and therefore uncompressed size
- *
- * This decoding function allows decompression of multiple blocks
- * in "streaming" mode.
- * Previously decoded blocks *must* remain available at the memory position
- * where they were decoded (up to 64 KB)
- * In the case of a ring buffers, decoding buffer must be either :
- *    - Exactly same size as encoding buffer, with same update rule
- *      (block boundaries at same positions) In which case,
- *      the decoding & encoding ring buffer can have any size,
- *      including very small ones ( < 64 KB).
- *    - Larger than encoding buffer, by a minimum of maxBlockSize more bytes.
- *      maxBlockSize is implementation dependent.
- *      It's the maximum size you intend to compress into a single block.
- *      In which case, encoding and decoding buffers do not need
- *      to be synchronized, and encoding ring buffer can have any size,
- *      including small ones ( < 64 KB).
- *    - _At least_ 64 KB + 8 bytes + maxBlockSize.
- *      In which case, encoding and decoding buffers do not need to be
- *      synchronized, and encoding ring buffer can have any size,
- *      including larger than decoding buffer. W
- * Whenever these conditions are not possible, save the last 64KB of decoded
- * data into a safe buffer, and indicate where it is saved
- * using LZ4_setStreamDecode()
- *
- * Return: number of bytes decompressed into destination buffer
- *	(necessarily <= maxDecompressedSize)
- *	or a negative result in case of error
- */
-int LZ4_decompress_fast_continue(LZ4_streamDecode_t *LZ4_streamDecode,
-	const char *source, char *dest, int originalSize);
-
 /**
  * LZ4_decompress_safe_usingDict() - Same as LZ4_setStreamDecode()
  *	followed by LZ4_decompress_safe_continue()
@@ -623,28 +564,6 @@ int LZ4_decompress_safe_usingDict(const char *source, char *dest,
 	int compressedSize, int maxDecompressedSize, const char *dictStart,
 	int dictSize);
 
-/**
- * LZ4_decompress_fast_usingDict() - Same as LZ4_setStreamDecode()
- *	followed by LZ4_decompress_fast_continue()
- * @source: source address of the compressed data
- * @dest: output buffer address of the uncompressed data
- *	which must be already allocated with 'originalSize' bytes
- * @originalSize: is the original and therefore uncompressed size
- * @dictStart: pointer to the start of the dictionary in memory
- * @dictSize: size of dictionary
- *
- * This decoding function works the same as
- * a combination of LZ4_setStreamDecode() followed by
- * LZ4_decompress_fast_continue()
- * It is stand-alone, and doesn't need an LZ4_streamDecode_t structure.
- *
- * Return: number of bytes decompressed into destination buffer
- *	(necessarily <= maxDecompressedSize)
- *	or a negative result in case of error
- */
-int LZ4_decompress_fast_usingDict(const char *source, char *dest,
-	int originalSize, const char *dictStart, int dictSize);
-
 #define LZ4_DECOMPRESS_INPLACE_MARGIN(compressedSize)          (((compressedSize) >> 8) + 32)
 
 #ifndef LZ4_DISTANCE_MAX	/* history window size; can be user-defined at compile time */
diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 3a2cd9acada4a09ef70a344090d48167c46088a1..f89b0e547f2156990c16770f69f89e0d8b46156d 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -474,14 +474,6 @@ int LZ4_decompress_safe_partial(const char *src, char *dst,
 				      noDict, (BYTE *)dst, NULL, 0);
 }
 
-int LZ4_decompress_fast(const char *source, char *dest, int originalSize)
-{
-	return LZ4_decompress_generic(source, dest, 0, originalSize,
-				      endOnOutputSize, decode_full_block,
-				      withPrefix64k,
-				      (BYTE *)dest - 64 * KB, NULL, 0);
-}
-
 /* ===== Instantiate a few more decoding cases, used more than once. ===== */
 
 static int LZ4_decompress_safe_withPrefix64k(const char *source, char *dest,
@@ -517,17 +509,6 @@ static int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
 				      (const BYTE *)dictStart, dictSize);
 }
 
-static int LZ4_decompress_fast_extDict(const char *source, char *dest,
-				       int originalSize,
-				       const void *dictStart, size_t dictSize)
-{
-	return LZ4_decompress_generic(source, dest,
-				      0, originalSize,
-				      endOnOutputSize, decode_full_block,
-				      usingExtDict, (BYTE *)dest,
-				      (const BYTE *)dictStart, dictSize);
-}
-
 /*
  * The "double dictionary" mode, for use with e.g. ring buffers: the first part
  * of the dictionary is passed as prefix, and the second via dictStart + dictSize.
@@ -546,18 +527,6 @@ int LZ4_decompress_safe_doubleDict(const char *source, char *dest,
 				      (const BYTE *)dictStart, dictSize);
 }
 
-static FORCE_INLINE
-int LZ4_decompress_fast_doubleDict(const char *source, char *dest,
-				   int originalSize, size_t prefixSize,
-				   const void *dictStart, size_t dictSize)
-{
-	return LZ4_decompress_generic(source, dest,
-				      0, originalSize,
-				      endOnOutputSize, decode_full_block,
-				      usingExtDict, (BYTE *)dest - prefixSize,
-				      (const BYTE *)dictStart, dictSize);
-}
-
 /* ===== streaming decompression functions ===== */
 
 int LZ4_setStreamDecode(LZ4_streamDecode_t *LZ4_streamDecode,
@@ -636,45 +605,6 @@ int LZ4_decompress_safe_continue(LZ4_streamDecode_t *LZ4_streamDecode,
 	return result;
 }
 
-int LZ4_decompress_fast_continue(LZ4_streamDecode_t *LZ4_streamDecode,
-	const char *source, char *dest, int originalSize)
-{
-	LZ4_streamDecode_t_internal *lz4sd = &LZ4_streamDecode->internal_donotuse;
-	int result;
-
-	if (lz4sd->prefixSize == 0) {
-		assert(lz4sd->extDictSize == 0);
-		result = LZ4_decompress_fast(source, dest, originalSize);
-		if (result <= 0)
-			return result;
-		lz4sd->prefixSize = originalSize;
-		lz4sd->prefixEnd = (BYTE *)dest + originalSize;
-	} else if (lz4sd->prefixEnd == (BYTE *)dest) {
-		if (lz4sd->prefixSize >= 64 * KB - 1 ||
-		    lz4sd->extDictSize == 0)
-			result = LZ4_decompress_fast(source, dest,
-						     originalSize);
-		else
-			result = LZ4_decompress_fast_doubleDict(source, dest,
-				originalSize, lz4sd->prefixSize,
-				lz4sd->externalDict, lz4sd->extDictSize);
-		if (result <= 0)
-			return result;
-		lz4sd->prefixSize += originalSize;
-		lz4sd->prefixEnd  += originalSize;
-	} else {
-		lz4sd->extDictSize = lz4sd->prefixSize;
-		lz4sd->externalDict = lz4sd->prefixEnd - lz4sd->extDictSize;
-		result = LZ4_decompress_fast_extDict(source, dest,
-			originalSize, lz4sd->externalDict, lz4sd->extDictSize);
-		if (result <= 0)
-			return result;
-		lz4sd->prefixSize = originalSize;
-		lz4sd->prefixEnd = (BYTE *)dest + originalSize;
-	}
-	return result;
-}
-
 int LZ4_decompress_safe_usingDict(const char *source, char *dest,
 				  int compressedSize, int maxOutputSize,
 				  const char *dictStart, int dictSize)
@@ -693,26 +623,12 @@ int LZ4_decompress_safe_usingDict(const char *source, char *dest,
 		compressedSize, maxOutputSize, dictStart, dictSize);
 }
 
-int LZ4_decompress_fast_usingDict(const char *source, char *dest,
-				  int originalSize,
-				  const char *dictStart, int dictSize)
-{
-	if (dictSize == 0 || dictStart + dictSize == dest)
-		return LZ4_decompress_fast(source, dest, originalSize);
-
-	return LZ4_decompress_fast_extDict(source, dest, originalSize,
-		dictStart, dictSize);
-}
-
 #ifndef STATIC
 EXPORT_SYMBOL(LZ4_decompress_safe);
 EXPORT_SYMBOL(LZ4_decompress_safe_partial);
-EXPORT_SYMBOL(LZ4_decompress_fast);
 EXPORT_SYMBOL(LZ4_setStreamDecode);
 EXPORT_SYMBOL(LZ4_decompress_safe_continue);
-EXPORT_SYMBOL(LZ4_decompress_fast_continue);
 EXPORT_SYMBOL(LZ4_decompress_safe_usingDict);
-EXPORT_SYMBOL(LZ4_decompress_fast_usingDict);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("LZ4 decompressor");

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
