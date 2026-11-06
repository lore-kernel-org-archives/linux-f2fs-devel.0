Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6E6082BEA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=4Gnb47AzFpGewI0/b3xJinL/wWb+dE89D8OnvN9T8Cs=; b=cHvigIrNVhyubRVqPsdJoFl0gG
	AZ9F9Ni1Ous4hclK6xFpQcXpPaIVaFHDYOiq3fgDRTaXyzNXvgS0jUsxeMu7qveEkQ+i0QmuN1j2a
	3AwyhnpnMCxxu3QNFpbjs3VjMZ3m2ZTdMGMeJ2Lwob7je+MRl39DQfrGUjL8OfLv3weM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPL9p-000000000MD-3Cdu;
	Fri, 06 Nov 2026 14:43:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xPL9n-000000000M2-3Mg9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pvazUZ8GwALVMPvikyd9HIyqQPGJP1xRnMR9Mkuuq5g=; b=f3qlyDAGtFNcMil0PKyd+9DD66
 EZTsyFDOSI/RW0UWbqiiantMJ7M1dnNs0i+xSJn//4gBhkwVw+sgAaHunHOvrLc4GGOnZNm8Q5mMM
 bdL4oDx7CXfDEB6W+Rz5nyFly0ea8tyaV+qVL0PPxFqHfuM5CdIJohMdGfOecPZAFzDs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pvazUZ8GwALVMPvikyd9HIyqQPGJP1xRnMR9Mkuuq5g=; b=Ju+1B28tH6l4koJapWu7Smqchr
 nVYLyShAFnM6tMrMWlBglFsjwx4S7bpvuTxVqK/De/4rT6WfEzNt+jqqu/qFLs0vuhqc+fh6aoCkZ
 g9phqyLxzMUSEXT84xR8wBphB5XP+SCJqU+CuDLqmHDzj8R/9VFUER6oMJrIFAfgbhes=;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPL9l-000000008VP-0SZ7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:05 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106144258euoutp024896c522eb7cece168675d99790d92fb~le9RabMVi1397013970euoutp02a;
 Fri,  6 Nov 2026 14:42:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261106144258euoutp024896c522eb7cece168675d99790d92fb~le9RabMVi1397013970euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793976178;
 bh=pvazUZ8GwALVMPvikyd9HIyqQPGJP1xRnMR9Mkuuq5g=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=Tuy1y/iMSKfBZwuXZQwMW5l8JCrFtBgAguab+c2GbqsJNFIR57SDJeNDcX97g+P9g
 UNkpn0TBtxGRr8tKaA3EYg9/BKL1oM+tZbNb1JrubHXRqM5KrxvNvsZIaYpZRMY7Bp
 FwekHtiiyhhfFmokD43m3dKmeTG3+Sw3fJxH88Uo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144258eucas1p1f59ead3e337482e074bfb26f4553e70d~le9RDuTy80320903209eucas1p1Z;
 Fri,  6 Nov 2026 14:42:58 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144256eusmtip19a7550efce2282b6115acdd561526f25~le9Pf0jgn2998329983eusmtip12;
 Fri,  6 Nov 2026 14:42:56 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 15:42:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261106-lz4-vendor-upstream-v2-6-ee04c3f0d7dc@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=YYDQiSfMdDchGst9Ca1G0wxCAGDujriJSlg8sDF+9gg=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9fZ6q4zL/9pVfolPi++x/a854xv96Q0qw1tHIG7dN/
 d9s+CMn2FHKwiDGwSArpshydmO0keQ/hqflxx//gpnDygQyhIGLUwAmEu/J8FcgbHruVENh070C
 inX9/h83PHhopfZcV2vr2U+3j85Ov6LLyPDoh9E2Lsvd3AFusSk2P5k4bKxM2O79qPE7VDht27M
 XvqwA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106144258eucas1p1f59ead3e337482e074bfb26f4553e70d
X-Msg-Generator: CA
X-RootMTR: 20261106144258eucas1p1f59ead3e337482e074bfb26f4553e70d
X-EPHeader: CA
X-CMS-RootMailID: 20261106144258eucas1p1f59ead3e337482e074bfb26f4553e70d
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144258eucas1p1f59ead3e337482e074bfb26f4553e70d@eucas1p1.samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xPL9l-000000008VP-0SZ7
Subject: [f2fs-dev] [PATCH v2 06/15] lib/lz4: backport upstream's aarch64
 fast decode loop enablement
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v1.10.0 leaves LZ4_FAST_DEC_LOOP off for aarch64 built with clang, after
a slowdown reported on some Android phones in 2019 (upstream PR #707).
An arm64 kernel built with clang therefore decodes with the slower loop.

Upstream has since enabled it for all aarch64, in three unreleased
commits:

commit 0aa33884faf5 ("[LZ4] Limit disabling LZ4_FAST_DEC_LOOP to aarch64+clang+android")
commit 51f8af506b4a ("Fix missing endif")
commit ed86bc1ed802 ("AArch64: Enable LZ4_FAST_DEC_LOOP for Android")

Arm measured +3.5% to +15.6% on Cortex-A510 to X4 with clang. Take the
lz4.c hunks of all three. This goes away at the next re-sync.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 lib/lz4/upstream/lz4.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/lz4/upstream/lz4.c b/lib/lz4/upstream/lz4.c
index 0d474be0236a698d297ab9a430f5082485eb3709..ee69d57aae112f4057c050bbdab4cc0f2d30f9d9 100644
--- a/lib/lz4/upstream/lz4.c
+++ b/lib/lz4/upstream/lz4.c
@@ -478,12 +478,7 @@ static const int      dec64table[8] = {0, 0, 0, -1, -4,  1, 2, 3};
 #ifndef LZ4_FAST_DEC_LOOP
 #  if defined __i386__ || defined _M_IX86 || defined __x86_64__ || defined _M_X64
 #    define LZ4_FAST_DEC_LOOP 1
-#  elif defined(__aarch64__) && defined(__APPLE__)
-#    define LZ4_FAST_DEC_LOOP 1
-#  elif defined(__aarch64__) && !defined(__clang__)
-     /* On non-Apple aarch64, we disable this optimization for clang because
-      * on certain mobile chipsets, performance is reduced with clang. For
-      * more information refer to https://github.com/lz4/lz4/pull/707 */
+#  elif defined(__aarch64__)
 #    define LZ4_FAST_DEC_LOOP 1
 #  else
 #    define LZ4_FAST_DEC_LOOP 0

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
