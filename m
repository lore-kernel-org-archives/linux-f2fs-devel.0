Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC78C98321
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:To:In-Reply-To:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DSNBGNfwCe5wTf6QNvXzTmEP97U0kUYdUSnuWS6KO4Q=; b=LycqpEWFBYacptOEkUTHFiiyh3
	cVC0sil+6NgZupqCOK8kP3eMMgdCdjxt0ice+NM16BHKCFQ6ILnmHoKrfCb610FZrk0lyelZIgC+d
	x41hPpJyN0V/7/EDbc6Md2BrW4V9ZwLT+qiWN5QbyUKp2+TFnZ/iG+x4/wl33T9IXXT4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xA4Uj-0007E1-IU;
	Fri, 25 Sep 2026 11:53:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.wilczynski@samsung.com>) id 1xA4Ui-0007Du-0Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:53:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Cc:To:In-Reply-To:
 Message-Id:Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WzH5s2/5AfOfNeFo7Wg4h2yqgF9WIZbfEyb5dAI7fyY=; b=NY1eA6WEoK5eH+xNkyhI72O/La
 etXZJDrvRUl2g0bUmmq8z+2FBTIfoSNTDv8zP5I2G7H9KvtF6nFVVjoqiNPVSS+SkpcgIa4sFntAw
 kGkGXwpCcc0ALqIWYPGMPst1Om181rjq7iGkQWBJs5OQ5mMFQ3wBP7SsNaPmmKMCs8e4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=References:Content-Type:Cc:To:In-Reply-To:Message-Id:
 Content-Transfer-Encoding:MIME-Version:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WzH5s2/5AfOfNeFo7Wg4h2yqgF9WIZbfEyb5dAI7fyY=; b=czAFrccTm5k3lZyQR2o7oVyJsw
 ikCUzehtZBK8Ymz7+L8oJ7JNDXMCuxFU8dQaHg4oAx7IpehpUmeTT+eM97vJdLbXJ7iJXXeCZFfUe
 Z2yhN0VapVP+YJ6ZT93kJ0yrsj+IfFIQijlPe+wKMzQoQSfg5lRLo5gqAQnV816pOg38=;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA4Ud-0005qo-Sw for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:53:33 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260925113458euoutp01d467da499e745e411c5821d415b73bce~YjTIwg77i2944429444euoutp01J;
 Fri, 25 Sep 2026 11:34:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260925113458euoutp01d467da499e745e411c5821d415b73bce~YjTIwg77i2944429444euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790336098;
 bh=WzH5s2/5AfOfNeFo7Wg4h2yqgF9WIZbfEyb5dAI7fyY=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=houHxX7PbVwN2g2P/n+zyB12/B1SUvRiIKGJWbQgZ3w+6hwa0OKcCwPQ3ns7CXo76
 Zof5QFuEq3wdz54rxcRgVyjYCwLjQ47UrERZkWB/EiQcaljE9/2vZwvQTX5v2orQ/M
 LyMk4CxT5Nouc1SUmVcRTD/ac1jzUP7N41TUAUm0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260925113458eucas1p1fa17760e9d790d3108643ab7f54bc6a3~YjTIdxs2i0252502525eucas1p1j;
 Fri, 25 Sep 2026 11:34:58 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260925113456eusmtip2df82080405f06748f997023963072e06~YjTGvwV780094300943eusmtip2m;
 Fri, 25 Sep 2026 11:34:56 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 25 Sep 2026 13:27:34 +0200
MIME-Version: 1.0
Message-Id: <20260925-lz4-vendor-upstream-v1-4-1c7ffbe21c4b@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4459;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=I+Yu/LWSJmU4MmzceDodGClIT/ZpW+icynx2hHerReQ=;
 b=owEBbQGS/pANAwAKASw99I2nQptuAcsmYgBqtlxTD5NRGD88A9525xCQ4UbesjQ1pcT/PtAaW
 U/sTfCxR3WJATMEAAEKAB0WIQR2xBTdTO5XfoUTSOYsPfSNp0KbbgUCarZcUwAKCRAsPfSNp0Kb
 biMUB/4xsjsZLL0xQWBuB5jOOX6jYTeGTzPjXssVlKc1zPp3vsv0Rx5R23G90Ch8W/UCbyw5RHa
 NxwrOKr07DNF2crjMF9wVmv2Bzy3VXh5xoZeC6MOi4P6kXgKcfcOcUszZrTtPfsDH+q+YS9UZAs
 J1SzHKSNrONjQqv7C0sYcmwRKtHcArpTviKaOka1EfhhGZO1oqW1oWIktBdsXBoXGY69yVFbA1v
 P7h0kRLJk+nVOe3nG17jAiN1S0sTDhc98f0VhzxN90rdEgDVBrmReqAcDpqnfm/helCaChkrE9b
 A6WAMPQ0T4B34IUAECFWZfI0uS8y7c4tRXp4yIHC8JJa0M/e
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=76C414DD4CEE577E851348E62C3DF48DA7429B6E
X-CMS-MailID: 20260925113458eucas1p1fa17760e9d790d3108643ab7f54bc6a3
X-Msg-Generator: CA
X-RootMTR: 20260925113458eucas1p1fa17760e9d790d3108643ab7f54bc6a3
X-EPHeader: CA
X-CMS-RootMailID: 20260925113458eucas1p1fa17760e9d790d3108643ab7f54bc6a3
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113458eucas1p1fa17760e9d790d3108643ab7f54bc6a3@eucas1p1.samsung.com>
X-Headers-End: 1xA4Ud-0005qo-Sw
Subject: [f2fs-dev] [PATCH RFC 4/9] arch: boot: put the LZ4 freestanding
 headers on the decompressor path
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

lib/decompress_unlz4.c pulls lib/lz4/lz4_decompress.c into the pre-boot
decompressor on these five arches. A later patch makes that file include
the vendored LZ4 sources, which include ISO C headers that -nostdinc does
not provide, so put lib/lz4/freestanding on the include path first.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/arm/boot/compressed/Makefile    | 3 +++
 arch/mips/boot/compressed/Makefile   | 4 ++++
 arch/parisc/boot/compressed/Makefile | 3 +++
 arch/s390/boot/Makefile              | 3 +++
 arch/x86/boot/compressed/Makefile    | 3 +++
 5 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index e3f550d6285786c8405b16768255af87b4dc8222..c0418ef2618bbcbf18f905e619031c37661563ed 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -92,6 +92,9 @@ targets       := vmlinux vmlinux.lds piggy_data piggy.o \
 		 head.o $(OBJS)
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+# decompress_unlz4.c builds the vendored LZ4 sources, which include a few
+# ISO C headers -nostdinc drops.
+KBUILD_CFLAGS += -I$(srctree)/lib/lz4/freestanding
 
 ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
 	     -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index e0b8ec9a9516281933b6cc5b175e82f4013c2f54..b832b8a26f20073d817fb50bc4c8015de006b5e4 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -30,6 +30,10 @@ endif
 KBUILD_CFLAGS := $(KBUILD_CFLAGS) -D__KERNEL__ -D__DISABLE_EXPORTS \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull"
 
+# decompress_unlz4.c builds the vendored LZ4 sources, which include a few
+# ISO C headers -nostdinc drops.
+KBUILD_CFLAGS += -I$(srctree)/lib/lz4/freestanding
+
 KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 14eefb5ed5d1d781a4ee0cb2ef61ab86c905cc56..1d4a3e66e3503714c1f723dedb15598183ec8b0a 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -12,6 +12,9 @@ targets += $(OBJECTS) sizes.h
 
 KBUILD_CFLAGS := -D__KERNEL__ -O2 -DBOOTLOADER
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+# decompress_unlz4.c builds the vendored LZ4 sources, which include a few
+# ISO C headers -nostdinc drops.
+KBUILD_CFLAGS += -I$(srctree)/lib/lz4/freestanding
 KBUILD_CFLAGS += -fno-strict-aliasing
 KBUILD_CFLAGS += $(cflags-y) -fno-delete-null-pointer-checks -fno-builtin-printf
 KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 10b75e053a6f6bb9083548e8f82796f0aa9a9958..fd88523eb1102af1eb1f821e156b8faadb502879 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -21,6 +21,9 @@ KBUILD_AFLAGS := $(filter-out $(CC_FLAGS_MARCH),$(KBUILD_AFLAGS_DECOMPRESSOR))
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_MARCH),$(KBUILD_CFLAGS_DECOMPRESSOR))
 KBUILD_AFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
+# decompress_unlz4.c builds the vendored LZ4 sources, which include a few
+# ISO C headers -nostdinc drops.
+KBUILD_CFLAGS += -I$(srctree)/lib/lz4/freestanding
 KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 
 CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 06934f9691d6a9d6952532ae5f7d96f5858719dd..d200a0a4c28b9e7be1be45f603e625eb573d0220 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -30,6 +30,9 @@ KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -fno-jump-tables
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+# decompress_unlz4.c builds the vendored LZ4 sources, which include a few
+# ISO C headers -nostdinc drops.
+KBUILD_CFLAGS += -I$(srctree)/lib/lz4/freestanding
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
