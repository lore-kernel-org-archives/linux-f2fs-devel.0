Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C1606EEA7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ESU3NTZ7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TjQzZ58d;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sq2huJuo;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=BwI5Raqt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=qR+7u+izSkLxzaWqpVTE7IF1uiazV6u6+v+ofJyktYg=; b=ESU3NTZ71s5rIYqSV/3mL2q1+9
	ZNQcQc24MAEl7ccDpGMHUjSN1iGt7Ug7dMm7zc5ItwMdMzUjpYBZd29bsL5dkmkW9iP2dnRkAkYpW
	4ooekOmSH9sdyS9MWA7Rtzusexlj8owgRLAVjzp2X8Qq9cbCgDGiVZdWT6/37dU6DMdg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPL9l-000000008QC-2hLc;
	Fri, 06 Nov 2026 14:43:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <m.wilczynski@samsung.com>) id 1xPL9j-000000008Q5-2vil
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rj8Y5qafYFutHkOlAoJ29LhMDQuxrVln4aCNYyECpsA=; b=TjQzZ58drxytB/ET/XzaTx33Fv
 BqJ/Gp0OptqQlG97vYBkoR+6GF1Gw9kNICXVotluxd1PHW1XIxUAc3ndfkYHFAt9A3iCtlrWIa9iw
 6hYzL8oRaFxGmUieu81yHleR2leHiIE2xyXIu2R9PI27TffQJVvf/pyNV/xdcrigp5uE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rj8Y5qafYFutHkOlAoJ29LhMDQuxrVln4aCNYyECpsA=; b=Sq2huJuojnR8EhpYNA2A/VmQQ9
 06KhUDCeYFCPLTHLQJnHBO8QrDqU39wzPUfDG2EPQjrExz4GlX7goHeOMc2ko7ysgrlPuDrZPcJKa
 tTb6PGm4ntxiZQ7Aqg3UGRYbhAgQtrjKARowDGzpUBtrpNbne6cVjYGYPls/G5MDjWa8=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPL9g-000000008VJ-2bnz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:43:03 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106144253euoutp01c796104744657935f58418ab7ccdf555~le9Ma35rb2317823178euoutp01R;
 Fri,  6 Nov 2026 14:42:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261106144253euoutp01c796104744657935f58418ab7ccdf555~le9Ma35rb2317823178euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793976173;
 bh=Rj8Y5qafYFutHkOlAoJ29LhMDQuxrVln4aCNYyECpsA=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=BwI5RaqtVBatHQ9FvOJ55uoIz+fe2relbWKFywd/iJ7UxbiAUExJDGgQBwVqMgvPP
 UdvBd8K2ekwzyndtRORpmlbATxLqEG3g6AEgKFZhuL/6kzMA4waA9KfpwPcfkUWCJj
 a5io1KFq5kFQHiWaTDkEAwAoTjw/BLEsdPnf7/6o=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261106144252eucas1p272c9e37d66ad385db070f941879aecb1~le9MI3J6I2474624746eucas1p2Q;
 Fri,  6 Nov 2026 14:42:52 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106144250eusmtip1dcd97a2c5f23d834ade7b24072cbbacb~le9KHGP180491304913eusmtip1T;
 Fri,  6 Nov 2026 14:42:50 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 15:42:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261106-lz4-vendor-upstream-v2-3-ee04c3f0d7dc@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=gf0d0kp9GnHtSKcTtEhuhYTslttbHXb7E32RSfsFkrk=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9fZ5ySyUrfX9+cLNFzLn3MVV/N4i6Nzut7uWYFaCyg
 Kc99EZURykLgxgHg6yYIsvZjdFGkv8YnpYff/wLZg4rE8gQBi5OAZhI/SSG/1kvExcURfNONrvu
 ra3M/fXc+ijtu01371vME1PUVXXQZ2dkOLuw/PC7Sw6c1RFJLws3fLXnv6L+4+/39Xt/Bfx8EiS
 lwg0A
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106144252eucas1p272c9e37d66ad385db070f941879aecb1
X-Msg-Generator: CA
X-RootMTR: 20261106144252eucas1p272c9e37d66ad385db070f941879aecb1
X-EPHeader: CA
X-CMS-RootMailID: 20261106144252eucas1p272c9e37d66ad385db070f941879aecb1
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144252eucas1p272c9e37d66ad385db070f941879aecb1@eucas1p2.samsung.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xPL9g-000000008VJ-2bnz
Subject: [f2fs-dev] [PATCH v2 03/15] zram: lz4hc: reset the dictionary
 stream once, not per page
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

With a dictionary, lz4hc_compress() calls LZ4_resetStreamHC() and then
LZ4_loadDictHC() for every page. LZ4_loadDictHC() re-initialises the
stream itself and keeps the level, so one reset at creation is enough.

The reset is cheap today, but upstream LZ4, which lib/lz4 moves to later
in this series, clears the whole 256K state in both calls. Reset once in
lz4hc_create() instead.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/block/zram/backend_lz4hc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index d8aa01bb258fec760b597a88296dfaa4e0049693..06286c805cf7c56bd760f460cc854dc4014f293b 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -72,6 +72,7 @@ static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 		zctx->cstrm = kzalloc_obj(*zctx->cstrm);
 		if (!zctx->cstrm)
 			goto error;
+		LZ4_resetStreamHC(zctx->cstrm, params->level);
 	}
 
 	return 0;
@@ -92,8 +93,7 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 				      req->dst_len, params->level,
 				      zctx->mem);
 	} else {
-		/* Cstrm needs to be reset */
-		LZ4_resetStreamHC(zctx->cstrm, params->level);
+		/* Reloading the dict resets cstrm and keeps its level */
 		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
 				     params->dict_sz);
 		if (ret != params->dict_sz)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
