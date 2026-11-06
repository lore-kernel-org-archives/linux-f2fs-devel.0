Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE250606A33C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K3QqhJB0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IqT2LZad;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YtTvZn+E;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=vQL1Kemy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ujzPV6exNU0Welj9uUhvjYS5vYs06zzflTpFGOUVndc=; b=K3QqhJB096vuJ09+WWRXSK7E1b
	I2DHypHFPrqQws2dARrK0GSi8uZ5hh6MnQhAZ0HAEppkRE6n3m3Ah5FnGka2TvVArtqPLntszjXdq
	mDNytAKUblKSessY3zq03E0oS0deug7npi/FseFhL5XtdD3C4C3rsjc9w7Ksj8TAyzsk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPL9v-000000006Zx-1pkM;
	Fri, 06 Nov 2026 14:43:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xPL9p-000000006YZ-1Lzf
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6rJNUO6E54sMvUs2WMIZbbBsdevweP1GURHzVXhYi9c=; b=IqT2LZadRzpA5MPlqE87bwNEch
 rBGEdupH9vE8tBqSgmoecfA4aVVK5O+33K35FCD3LqC3ofgP5l+50pSmTQCPqwW8qNuwKMony7Jn5
 o1tgg+9oAT30Ks1VZ5hnwgSL8u1WqUYbEtbjB4aa4SVm1US573/mqJd/RV2INaw8EdF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6rJNUO6E54sMvUs2WMIZbbBsdevweP1GURHzVXhYi9c=; b=YtTvZn+EH7w+sMVV9rDfIkt7CV
 oFD0Ezxh+atv0bIoU9HRdPpYAcK7nMbyCD/xPDaFu3qxBJRPK1GyagShV5l0QktCpK61WmSshmFpA
 zaD2fx0k6hjckP38Ld1Zrc485jxhFbov8xKyByeKAv5Q9Iz8mvo8ssB/1ZfbeqlzMKiM=;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPL9n-0000000051r-09ys
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:09 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106144300euoutp022fe9ba632879a263b59dd1be5c370c27~le9Tgddn21426614266euoutp02X;
 Fri,  6 Nov 2026 14:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261106144300euoutp022fe9ba632879a263b59dd1be5c370c27~le9Tgddn21426614266euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793976180;
 bh=6rJNUO6E54sMvUs2WMIZbbBsdevweP1GURHzVXhYi9c=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=vQL1KemyUL/i8iZISuvadb7LjWhfk9xrjaC2sDcM8Owe+O9RHy1wFufNoIOF94jcf
 p0JVcTX5g5tl+FMQDx9m1nv0Tf+LPOvYWUH9EP9PPWO7X7w1rERwDHFqKFiq4V0yTk
 PQ3uwEgwyYh+n8/Yo016rsYHh9MLBaxuU9NrIFjU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261106144259eucas1p27d26efbc44beac102c03ec07ebed4310~le9SqiDiy1206212062eucas1p2V;
 Fri,  6 Nov 2026 14:42:59 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144258eusmtip1a717ab7164c31bdd835911116d976388~le9RHsKmV0111901119eusmtip1_;
 Fri,  6 Nov 2026 14:42:58 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 15:42:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261106-lz4-vendor-upstream-v2-7-ee04c3f0d7dc@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=FeGwjLLCi9r5jO0sT4c2oOMQI6pybsCaTl5iiV1XLg0=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9fZ56U0Pa67C9pl5js81Djt4t++e+Y9b7J3lW8Y3NG
 r1sg6NpHaUsDGIcDLJiiixnN0YbSf5jeFp+/PEvmDmsTCBDGLg4BWAi79MZGWakV6Uz+5RNvHEk
 zKojQjHywl3bTtHiJs+mSS+WF12fZsHwTzdo44JtE7fGf1/aYSV3LyD68iubAoVt21jaD0zI/xv
 xkw8A
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106144259eucas1p27d26efbc44beac102c03ec07ebed4310
X-Msg-Generator: CA
X-RootMTR: 20261106144259eucas1p27d26efbc44beac102c03ec07ebed4310
X-EPHeader: CA
X-CMS-RootMailID: 20261106144259eucas1p27d26efbc44beac102c03ec07ebed4310
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144259eucas1p27d26efbc44beac102c03ec07ebed4310@eucas1p2.samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xPL9n-0000000051r-09ys
Subject: [f2fs-dev] [PATCH v2 07/15] lib/lz4: backport upstream's match
 length limit fix
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

v1.10.0 lets a match length's extension bytes run to four bytes before
the end of the block, which leaves room for only a token and three
literals where the format requires five. The fork rejected such blocks,
v1.10.0 decodes them: 1f 41 01 00 ff 00 30 7a 7a 7a decodes to 278
bytes instead of failing.

Upstream fixed this in 587ed9557708 ("add comments explaining
read_variable_length() ilimit bounds, fix match length limit"), on top
of a read_variable_length() rework v1.10.0 does not have. Both versions
accept the same final ip for a given limit, so change the limit at the
two match length call sites to iend - (1 + LASTLITERALS), as upstream
does. This is one byte stricter than the fork; no compressor produces
the blocks it newly rejects.

This goes away at the next re-sync.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 lib/lz4/upstream/lz4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lz4/upstream/lz4.c b/lib/lz4/upstream/lz4.c
index ee69d57aae112f4057c050bbdab4cc0f2d30f9d9..a45f3828141eec9baea59a5e97a3ff37d6474d6e 100644
--- a/lib/lz4/upstream/lz4.c
+++ b/lib/lz4/upstream/lz4.c
@@ -2120,7 +2120,7 @@ LZ4_decompress_generic(
             DEBUGLOG(7, "  match length token = %u (len==%u)", (unsigned)length, (unsigned)length+MINMATCH);
 
             if (length == ML_MASK) {
-                size_t const addl = read_variable_length(&ip, iend - LASTLITERALS + 1, 0);
+                size_t const addl = read_variable_length(&ip, iend - (1 + LASTLITERALS), 0);
                 if (addl == rvl_error) {
                     DEBUGLOG(5, "error reading long match length");
                     goto _output_error;
@@ -2338,7 +2338,7 @@ LZ4_decompress_generic(
 
     _copy_match:
             if (length == ML_MASK) {
-                size_t const addl = read_variable_length(&ip, iend - LASTLITERALS + 1, 0);
+                size_t const addl = read_variable_length(&ip, iend - (1 + LASTLITERALS), 0);
                 if (addl == rvl_error) { goto _output_error; }
                 length += addl;
                 if (unlikely((uptrval)(op)+length<(uptrval)op)) goto _output_error;   /* overflow detection */

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
