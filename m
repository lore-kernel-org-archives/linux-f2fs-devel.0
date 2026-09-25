Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A410C9830D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grbE0tszRN8CmLL6DWlJTM6ZmBI3NdA19qEHQmfGju0=; b=NHQdCtEoVQjAN1IVPOLp9Sle8c
	82r7CAn64/B/sRWxQWEo+o3jEk6bdHLPSbZEviEGsqn0+FHfN5Zuw8u8xGPTEBYtnTdHVe66zRgU9
	VpAgsHOKkZtwY+atDNONJWoT0r7rFNoVIaMrlgXhPPPQwjBvKrHCXWtXjyOgMbW950qA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xA4Ug-0001v3-Ty;
	Fri, 25 Sep 2026 11:53:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xA4Ue-0001ul-Qb
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:53:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S49K85j/ZvrK/W5tbsPgMaqf5HArl0WY8MgmXfqSjYE=; b=huoehWalgRTOUxL11spf/flcff
 NshtqCVVP2mEh+uCfSN7LqVsbwu8n6hzdVZKUtgAngQL2+9KbKf9n9uTcl1BxG/yIP/Ek5EmUKICD
 RFtiNg5qc1nw5j5TfGAdBTEuEORo9KHeffq3k9s5q5j/fDCEE9JyuJsHWPsiokoMwhxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S49K85j/ZvrK/W5tbsPgMaqf5HArl0WY8MgmXfqSjYE=; b=Mhkb/0yKKYKgQQzk2/VIWpeePX
 RgDDn63P/gduisAj9ErDZDZf3F0c/JXxAVlHx2PFphrC78VcNCjAtXMa5YBlm3CrP+vmt1MsIAGd2
 rXkUXuGITj0Qshp3KSN1JeF9NNX2YT3fUhTkZ8UsmrSuvaoy3q1PswWsMbGMtCvpCeSw=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA4Ud-0005qp-TT for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:53:33 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260925113507euoutp01daa730f0f39de6635fc518f4b4a9ec40~YjTRcSGhe2944729447euoutp01C;
 Fri, 25 Sep 2026 11:35:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260925113507euoutp01daa730f0f39de6635fc518f4b4a9ec40~YjTRcSGhe2944729447euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790336107;
 bh=S49K85j/ZvrK/W5tbsPgMaqf5HArl0WY8MgmXfqSjYE=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=mOt3qitjpj5pAxYRQizgylohI0e3mwvMe2vxW5GemZrsIgDOkny7DVQgMgE2nlp4x
 G/O9NRejnVg0SqDGGQrZYqyBbW5rAzrhVCHUywIPaow8V7utrMWzIW/xwATgRhbWSc
 iJXJhvUDH9ECfm89ZNpb+APjWq7dqgOMxgyN4WRY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3~YjTRMNxi41965119651eucas1p2n;
 Fri, 25 Sep 2026 11:35:07 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260925113506eusmtip26a2ad976a305cfdc747b2ef9e46e892a~YjTPrStlK2286422864eusmtip2H;
 Fri, 25 Sep 2026 11:35:05 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 25 Sep 2026 13:27:39 +0200
MIME-Version: 1.0
Message-Id: <20260925-lz4-vendor-upstream-v1-9-1c7ffbe21c4b@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=rt909YVEPZ1UzsHEaHIBCQOzoDoXGfBwWN+W1Qjdjtg=;
 b=owEBbQGS/pANAwAKASw99I2nQptuAcsmYgBqtlxYQawZhtBMyHWo2fdtM9WSyTI6z7blyltQp
 5LXrnGur1+JATMEAAEKAB0WIQR2xBTdTO5XfoUTSOYsPfSNp0KbbgUCarZcWAAKCRAsPfSNp0Kb
 bkpbB/9W0LpEYkAF2WtEHR5F5L42+TTJZheHrKkTPNZapbxsmraB8fMMa3y8IMNzeHXU64R2/O0
 ROnewWnk2qtWN2ubm5vjY6PhzHk70+TcKirHYz2I/IIcE2z62ecej4Vwvzo0/uhDppFR6sMshd4
 zvuOEWMTRqp7ezgsWBdyyRKQMh94et9vNy9sHcu22idrG1QEPsUOTcER/zHCthL4sos6Ea9kT1p
 mioJSPJcZw8CH/0cxXUdWZ3ZZBLb2vRp5q53LdWH6E2ghNJ1p1j9ngRNKkfnRGX8KapYsKo+I9U
 pW3Q527eJAb5U3+mj0ahPudBOVHo/aZ9sKrtOnkpntW/Xwy9
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=76C414DD4CEE577E851348E62C3DF48DA7429B6E
X-CMS-MailID: 20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3
X-Msg-Generator: CA
X-RootMTR: 20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3
X-EPHeader: CA
X-CMS-RootMailID: 20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113507eucas1p2ddb94f2077b679426aa86dd1d492eaf3@eucas1p2.samsung.com>
X-Headers-End: 1xA4Ud-0005qp-TT
Subject: [f2fs-dev] [PATCH RFC 9/9] MAINTAINERS: add an entry for the LZ4
 compression library
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

lib/lz4/ has never had one: get_maintainer.pl returns only the LKML
fallback for every file in it, including include/linux/lz4.h, which eight
subsystems build against.

This matters more now than it did. With the previous patches lib/lz4 is
vendored upstream sources, and someone has to bump them to new upstream
releases and decide what the kernel-side glue may do. I am willing to do
that, so add myself as its maintainer.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b34aeb705cef654c720ca9f2ba223..989e1b5fab21432dd7042d1e60c4bbad85beb925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15606,6 +15606,12 @@ S:	Supported
 F:	drivers/net/pcs/pcs-lynx.c
 F:	include/linux/pcs-lynx.h
 
+LZ4 COMPRESSION LIBRARY
+M:	Michal Wilczynski <m.wilczynski@samsung.com>
+S:	Maintained
+F:	include/linux/lz4.h
+F:	lib/lz4/
+
 M68K ARCHITECTURE
 M:	Geert Uytterhoeven <geert@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
