Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE16082BD1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L2J1L7As;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B6xqc5Uy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AvIJgp0I;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=iNy7LdYD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=o1K0kd6lbppqpoOD0JNxPr9WmPmLJIMYc0L1hanRbyo=; b=L2J1L7AsUHKe3TOulZULAllVMu
	ZOivfh65nZeRASUT54BHVY8WsCE37sDVX8UpORz2IncBqKh6A28bh2If7EgZa6ah2sBMdHncaUDlZ
	aY2zHhDulauf4ZY59VxMvmKFLFMDVbsoo2BYWmGmi8krruIMUCzw36FTOv9ZL+PZY2T8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPL9o-000000006Y3-1FIk;
	Fri, 06 Nov 2026 14:43:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xPL9l-000000006XV-0Dzp
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WSR+OYxGYuCEt4HZgWaGut42QNF8mF7rpyHwN5g0Fmw=; b=B6xqc5Uy+R+8nkhiQUlm/Yd7gB
 iYIjcL03IuBQgsqUHMy23KW3omuAVP0us/JXVkGq9rVmXPM7CsYxtt33uAtX5unrqKHlsZVwifxHe
 J1I5S3OjDDn/uZJgbYujs19DOndJAkbYF3KkNQIatU/iM5qID9qKBI+N4Ueq/UVCcLGU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WSR+OYxGYuCEt4HZgWaGut42QNF8mF7rpyHwN5g0Fmw=; b=AvIJgp0IwYLSmwQgO25n+AG2x+
 4lw28jNHSbk2xHCezxHmjcvyOi8K6hGHkpqE1JI13Mx2cTrTgNlNrswRcEZFtNlY4oJTq08JtWotT
 PyuBtH5EUTCcwomsO7PbeYFbqq9AhHuD4lgYs4WsL5vfuVWzL4PYBHeKdYtuG5DWNxMI=;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPL9j-0000000051n-3zYp
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:04 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106144257euoutp02f046c48219c70db95596d964730e31d9~le9QW44K01214112141euoutp025;
 Fri,  6 Nov 2026 14:42:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261106144257euoutp02f046c48219c70db95596d964730e31d9~le9QW44K01214112141euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793976177;
 bh=WSR+OYxGYuCEt4HZgWaGut42QNF8mF7rpyHwN5g0Fmw=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=iNy7LdYD9y3Ce85ur99gVOgP70PRAxMlKgJ50WH0DEUBnvXrShJMbvfe3bxA28980
 UAciP+g1AouqHElYOm5zofikYQj7Afh276F1w/Rk4NBMq/wRm6tm+0RcLd2EuCebCw
 IG4+EnibCn2k/wLwGCpIOYZjqtVBgcW3SMirHPT8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144256eucas1p1beb947272dc94f916c8c8131722a480d~le9Pd9eIp0320903209eucas1p1W;
 Fri,  6 Nov 2026 14:42:56 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144254eusmtip1291e4ba24e2a230c09af0eb481e22639~le9N6-Ryb0161401614eusmtip16;
 Fri,  6 Nov 2026 14:42:54 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 15:42:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261106-lz4-vendor-upstream-v2-5-ee04c3f0d7dc@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2114;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=8N9wzkj/hKUNj1BW6DsxrUcKBRzHlHt4de1GPUas8dA=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9fZ4aKBHw4KzylIunL5nMWL5nDtPGvfc/njCasV+lt
 GrWpcMX93eUsjCIcTDIiimynN0YbST5j+Fp+fHHv2DmsDKBDGHg4hSAiYSUMjKsiXqrvCj13sck
 jXdXYxcp/xC/+X8L552H1zvu7FxWvP6wLsP/nMgZJ7gTtqpMCPyt4XBn0/uNTa3qbC/maddKfOC
 7kveWFQA=
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106144256eucas1p1beb947272dc94f916c8c8131722a480d
X-Msg-Generator: CA
X-RootMTR: 20261106144256eucas1p1beb947272dc94f916c8c8131722a480d
X-EPHeader: CA
X-CMS-RootMailID: 20261106144256eucas1p1beb947272dc94f916c8c8131722a480d
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144256eucas1p1beb947272dc94f916c8c8131722a480d@eucas1p1.samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xPL9j-0000000051n-3zYp
Subject: [f2fs-dev] [PATCH v2 05/15] lib/lz4: backport upstream's
 -Wmissing-prototypes fix
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

v1.10.0 defines LZ4_loadDict_internal() in lz4.c and LZ4HC_searchExtDict()
in lz4hc.c with external linkage and no prototype, which the kernel's
-Wmissing-prototypes rejects. The first would also prevent linking once
lz4_compress.c and lz4_decompress.c both include lz4.c, later in this
series, since each would define it.

Neither can be forward declared static in the lz4_deps.h a later patch
adds, as the other bare helpers are, because their signatures use types
declared inside the .c files.

Take the two hunks of upstream commit 5ef1f16929b5
("fix -Wmissing-prototypes warnings") that apply to the files we vendor.
This goes away at the next re-sync.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 lib/lz4/upstream/lz4.c   | 2 +-
 lib/lz4/upstream/lz4hc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lz4/upstream/lz4.c b/lib/lz4/upstream/lz4.c
index a2f7abee19fb9a5c768f2a6c266acf5b571f0855..0d474be0236a698d297ab9a430f5082485eb3709 100644
--- a/lib/lz4/upstream/lz4.c
+++ b/lib/lz4/upstream/lz4.c
@@ -1584,7 +1584,7 @@ int LZ4_freeStream (LZ4_stream_t* LZ4_stream)
 
 typedef enum { _ld_fast, _ld_slow } LoadDict_mode_e;
 #define HASH_UNIT sizeof(reg_t)
-int LZ4_loadDict_internal(LZ4_stream_t* LZ4_dict,
+static int LZ4_loadDict_internal(LZ4_stream_t* LZ4_dict,
                     const char* dictionary, int dictSize,
                     LoadDict_mode_e _ld)
 {
diff --git a/lib/lz4/upstream/lz4hc.c b/lib/lz4/upstream/lz4hc.c
index 4d8c36a6978fcae09e4c4a936572b4b271513466..32b29f382268d961d65383b24c7225494d9044ad 100644
--- a/lib/lz4/upstream/lz4hc.c
+++ b/lib/lz4/upstream/lz4hc.c
@@ -360,7 +360,7 @@ typedef struct {
     int back;  /* negative value */
 } LZ4HC_match_t;
 
-LZ4HC_match_t LZ4HC_searchExtDict(const BYTE* ip, U32 ipIndex,
+static LZ4HC_match_t LZ4HC_searchExtDict(const BYTE* ip, U32 ipIndex,
         const BYTE* const iLowLimit, const BYTE* const iHighLimit,
         const LZ4HC_CCtx_internal* dictCtx, U32 gDictEndIndex,
         int currentBestML, int nbAttempts)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
