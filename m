Return-Path: <SRS0=yuZv=U3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A49C4321A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:46:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFE52064A;
	Fri, 28 Jun 2019 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UIANiyvi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NgkFGlHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFE52064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hgs8x-0005q6-Od; Fri, 28 Jun 2019 14:46:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <arndbergmann@gmail.com>) id 1hgs8w-0005pn-P6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jun 2019 14:46:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ukm6QwjiR6v3c/fXg6msKYDD+XPWCXV7vWmtJTq9N64=; b=UIANiyviX0/GjxvmiDl6GsybKy
 BTBMt/wBaZxP31+bv8LkK4wYx9MgXiA04TWeVhtMPISNd+q3mCiUYyv3cfcmCTQoo0gSbDoZpJl9a
 xy6skaEOeueI8obvPw04xwzJ01BTR3qa9hxCDcj0SrVoSF043QjUzleNeLKSx2QhpmbQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ukm6QwjiR6v3c/fXg6msKYDD+XPWCXV7vWmtJTq9N64=; b=NgkFGlHvboQQvqCAKFgxN8efFR
 lYW5jpnILsCd46yZBamUbM4g1aUwvZxL5RyeWdriBjOQ1mKO7+3K8yq7LioHBC7pSP/5+BfFUuGBQ
 t86IkVLh8nA0DeJw1mBUNDWS0IRIp7CmLR6wpfBGlOTl2xoyadOY6d6zmD6sjeM3VNzo=;
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hgs9A-000XeF-VD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jun 2019 14:46:42 +0000
Received: by mail-qt1-f193.google.com with SMTP id d17so6541268qtj.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Jun 2019 07:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ukm6QwjiR6v3c/fXg6msKYDD+XPWCXV7vWmtJTq9N64=;
 b=eC2ydEEMllNsaVXKP/5JHmouDSXwXbXh9aTF8YC3KRE2L1lVVSxJL2GFG03dwlFHOI
 ucjOYzz8r2/gCGo7185TKoXeXh06VgVPbpCY7BSe9zm9/AY7rm5bZn8ARaIGpvrgfl0J
 6UVSPu5R8e3hBg+gspgdvzPrOmuUd1iBYFxGIkDRGTuYiifiUJiBGWjF4lFss+nxvBus
 G5gwYvKpFiNkhRT6lZdYC5K5a5vKZsQaXXcb7IUxm5zfm8yqu6dtbyXLVyAT7MMqB7b0
 +PQqWokHFu8x1L8xqzICN8l2EI7hdXOAqZvS4NL+JxclEpvCtPot7QKoN/Q50yHsnUzf
 8mNw==
X-Gm-Message-State: APjAAAWkcQ/cpFCx0KPjH5vXKfyci/bMmqAKaCWm6RHI17s2gopLnNXD
 OyOH68nLSRY1V2tQg63q/74PaI/ozh/QjhPqJqk=
X-Google-Smtp-Source: APXvYqxiaUSAuPM+A2aREImpYskXzz89M9yJIOi+OtsVZitkSsQckIsCjhrF38dp9elJ5g7LFRpNW3aVZW8X6qRP1qw=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr8545628qve.45.1561733194702; 
 Fri, 28 Jun 2019 07:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190628104007.2721479-1-arnd@arndb.de>
 <20190628124422.GA9888@infradead.org>
 <CAK8P3a1jwPQvX6f+eMZLdnF2ZawDB9obF3hjk2P9RJxDr6HUQA@mail.gmail.com>
 <20190628131738.GA994@infradead.org>
In-Reply-To: <20190628131738.GA994@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 28 Jun 2019 16:46:14 +0200
Message-ID: <CAK8P3a0t+vGge8uDOuwex6j+ddaUqovxCXoJOO8Ec3z6_brvsg@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1hgs9A-000XeF-VD
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix 32-bit linking
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
Cc: Eric Biggers <ebiggers@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wang Shilong <wangshilong1991@gmail.com>, "Linux F2FS DEV,
 Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Qiuyang Sun <sunqiuyang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 28, 2019 at 3:17 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jun 28, 2019 at 03:09:47PM +0200, Arnd Bergmann wrote:
> > I came across this on arm-nommu (which disables
> > CONFIG_CPU_SPECTRE) during randconfig testing.
> >
> > I don't see an easy way to add this in there, short of rewriting the
> > whole __get_user_err() function. Any suggestions?
>
> Can't we just fall back to using copy_from_user with a little wrapper
> that switches based on sizeof()?

I came up with something now. It's not pretty, but seems to satisfy the
compiler. Not a proper patch yet, but let me know if you find a bug.

This might contain a double uaccess_save_and_enable/uaccess_restore,
not sure how much we care about that.

     Arnd

index 7e0d2727c6b5..c21cdecadf26 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -307,6 +307,7 @@ static inline void set_fs(mm_segment_t fs)
 do {                                                                   \
        unsigned long __gu_addr = (unsigned long)(ptr);                 \
        unsigned long __gu_val;                                         \
+       unsigned long long __gu_val8;                                   \
        unsigned int __ua_flags;                                        \
        __chk_user_ptr(ptr);                                            \
        might_fault();                                                  \
@@ -315,10 +316,13 @@ do {
                         \
        case 1: __get_user_asm_byte(__gu_val, __gu_addr, err);  break;  \
        case 2: __get_user_asm_half(__gu_val, __gu_addr, err);  break;  \
        case 4: __get_user_asm_word(__gu_val, __gu_addr, err);  break;  \
+       case 8: __get_user_asm_dword(__gu_val8, __gu_addr, err);break;  \
        default: (__gu_val) = __get_user_bad();                         \
        }                                                               \
        uaccess_restore(__ua_flags);                                    \
-       (x) = (__typeof__(*(ptr)))__gu_val;                             \
+       (x) = __builtin_choose_expr(sizeof(*(ptr)) == 8,                \
+               (__typeof__(*(ptr)))__gu_val8,                          \
+               (__typeof__(*(ptr)))__gu_val);                          \
 } while (0)

 #define __get_user_asm(x, addr, err, instr)                    \
@@ -373,6 +377,8 @@ do {
                         \
        __get_user_asm(x, addr, err, ldr)
 #endif

+#define __get_user_asm_dword(x, addr, err)                     \
+       do { err = raw_copy_from_user(&x, (void __user *)addr, 8) ?
-EFAULT : 0; } while (0)

 #define __put_user_switch(x, ptr, __err, __fn)                         \
        do {                                                            \


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
