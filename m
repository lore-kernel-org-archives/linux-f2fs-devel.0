Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303B4C98324
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PpZYqj4VezxJp3WGJpGbcjClQoTTyOKLwRi3SLqx2yg=; b=jWisKFqeWJUeeetxF75/pJ2NeT
	SUQ5CyRkx84bAajsWhA947teJi8fIpsqsk3ADHcFxfqiYK38HMXZ9ERnP9O39OL92/x9gPGs4GzmA
	1DBlmV/SjMNSG3zOkcXGsLXvAxx395Dvh/YEQJDir3LMJPAVPhb3CkQWAbFOQOLwcsK0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xA4T3-0007AB-E0;
	Fri, 25 Sep 2026 11:51:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xA4Sf-00079T-7f
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:51:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nO41lh/H4SzcoCdayvonqkq9okmqSnTubMvlLylaa1w=; b=LYETu43mAsNWXG9qKHD91DfU6D
 ayH+6KBNiO2wurzdyTveiCESZjmIYsX93V38SeCisxVwXrNujZgxgdnLcMvCNaSk97rD/+q+RLxnZ
 OUkxwpH8zDnk6Q5Cip64I1lixNj+U8+QThPJArpZfL4IOErrGX+40/jAaB4wMd2SIiyg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nO41lh/H4SzcoCdayvonqkq9okmqSnTubMvlLylaa1w=; b=XRy+SxCnIrF+ftmAiXbfym/Ksy
 JhT8tt1EaG8qRZ1vuHidmOJW1v4y3XbFrgFpfXNsUZmxHuH3cjS36ZslRAhUJ2Z77uxVoSNqqmWYa
 uS3JejR3PBJW5zFFwMx2L3gQCgSoqj2j4RAYmu/SUhm8IZZKBhB8CF0aHJ9dIHpxxmwY=;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA4SZ-0004ZZ-Lq for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:51:26 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260925113454euoutp029aba4d7652769b32aa244658574edba9~YjTFViDYa0681106811euoutp02X;
 Fri, 25 Sep 2026 11:34:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260925113454euoutp029aba4d7652769b32aa244658574edba9~YjTFViDYa0681106811euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790336094;
 bh=nO41lh/H4SzcoCdayvonqkq9okmqSnTubMvlLylaa1w=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=HT2us8FYPCD02Bqr6zxqNELSXegcdUB71/GiSE79vPh0ddbcgSd4gYAdoEzE+9FfU
 aXibiNf7aXZYzd8naEbWeqtRvgyMmH39N++134vhhtm7ENQIBAGk9Lb7PSqTDSnY5A
 fdjlRPG2x+BJwq2hJNUpKlor5WltkEwRd9KhMQsU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260925113454eucas1p1ffe6b62a29086943a60137ed7e1f42ef~YjTFCnGhF0249002490eucas1p1k;
 Fri, 25 Sep 2026 11:34:54 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260925113452eusmtip215fd236cce7ebc09bee5052a2af6141d~YjTDfNwYs0229302293eusmtip2L;
 Fri, 25 Sep 2026 11:34:52 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 25 Sep 2026 13:27:32 +0200
MIME-Version: 1.0
Message-Id: <20260925-lz4-vendor-upstream-v1-2-1c7ffbe21c4b@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2100;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=wMVojsfuYF9eT5q5rMs2c29qyYKzm0LcLr4isls1UTQ=;
 b=owEBbQGS/pANAwAKASw99I2nQptuAcsmYgBqtlxRhAkB7TyATBVr/4+ZvB5W43K313iDQp6Eo
 GaNSuSsmEuJATMEAAEKAB0WIQR2xBTdTO5XfoUTSOYsPfSNp0KbbgUCarZcUQAKCRAsPfSNp0Kb
 bqqICAChUCgNeDyv3RGoQ6NgJobTPJZsAhZENmNk+sFHRrRm6s6yXgvJuRHnzHz67u44q3G2aUJ
 /w62OUYZhnqPXdGHG01nPAl/of1ajK7KLqRJZtwlq76hT4q/T3bD7HTJyl07fgzoJcWA3FJeoQC
 1ODZi0rz3jnFdvvowe7eSTcTvlQ7A4X+H/saBtEhuoKsMAlE3scE8X1i/kj0dRRcx8yrOhXE433
 ExlndGyD/0UTmNLSkn9uACbJR7e7T83b1n4lRCzw5cW9WKelHdl7gxKHn3nCqO43ppJbweGga2A
 TmrhwDJsGXJ9NmpfsGfz7Gd6ImCi+0CtxVH3d3CbdbEGiCeL
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=76C414DD4CEE577E851348E62C3DF48DA7429B6E
X-CMS-MailID: 20260925113454eucas1p1ffe6b62a29086943a60137ed7e1f42ef
X-Msg-Generator: CA
X-RootMTR: 20260925113454eucas1p1ffe6b62a29086943a60137ed7e1f42ef
X-EPHeader: CA
X-CMS-RootMailID: 20260925113454eucas1p1ffe6b62a29086943a60137ed7e1f42ef
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113454eucas1p1ffe6b62a29086943a60137ed7e1f42ef@eucas1p1.samsung.com>
X-Headers-End: 1xA4SZ-0004ZZ-Lq
Subject: [f2fs-dev] [PATCH RFC 2/9] lib/lz4: backport upstream's
 -Wmissing-prototypes fix
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

v1.10.0 defines LZ4_loadDict_internal() in lz4.c and LZ4HC_searchExtDict()
in lz4hc.c with external linkage and no prototype, which the kernel's
-Wmissing-prototypes rejects. The first also prevents linking, since
lz4_compress.c and lz4_decompress.c both include lz4.c and would each
define it.

Neither can be forward declared static in lz4_deps.h like the other bare
helpers, because their signatures use types declared inside the .c files.

Take the two hunks of upstream commit 5ef1f16929b5
("fix -Wmissing-prototypes warnings") that apply to the files we vendor.
This is the only deviation from the tag, and goes away at the next
re-sync.

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
