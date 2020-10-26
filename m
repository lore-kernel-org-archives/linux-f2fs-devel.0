Return-Path: <SRS0=JrMS=EB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB072C4363A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:02:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CB820708;
	Mon, 26 Oct 2020 23:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PEH/Rmp3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="aLfG5pAX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG5SdGun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CB820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kXBVr-0007CE-4x; Mon, 26 Oct 2020 23:02:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kXBVp-0007C2-5M
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=buCB+4RoMRIbdC0QeRyjEHgbWG3DCkz/Mz9ArEmit6s=; b=PEH/Rmp3ae3jmvoKJg0E2Z+qmR
 OEY3ssnoWJr0cd+PZ8l9RbhUBvnHxDd5A4GaqGZQtPVRUs12yOs1bA6LqhboGg2QhkmaOdtxv3By/
 yX/MW1VhaJ34iActqi7XAgg1/Va+Y7BsIYGu51I/T34XlwQ5MNuGRev15G9Zua818pYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=buCB+4RoMRIbdC0QeRyjEHgbWG3DCkz/Mz9ArEmit6s=; b=aLfG5pAXQM5OcDBXCRZFpVg8M6
 /YUVMTrUVCM4gRkq7r716qc4Pgq4rtBlrsyqeFMqaT2V0dihGyN6UgDZXk3dWzitOMnShyaTyFF8l
 97FdNiPMdyBQuzoBIvmioZFg7lbMcIsjnBuiAZQx5QtMzrPqL06Md+AEZS1D5VJfVR3Y=;
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kXBVd-00Ergh-Tj
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:02:49 +0000
Received: by mail-lf1-f66.google.com with SMTP id 126so3290132lfi.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2020 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=buCB+4RoMRIbdC0QeRyjEHgbWG3DCkz/Mz9ArEmit6s=;
 b=HG5SdGunBYRQfgKYvp3Owt306/Iw3uX8QNtG3mcJkbwuqdq3FidJzV8cRQVMz9/1Oq
 FVCxgOpX79UuAa1C2KGg0kSEipNo+tT/MFHlUi19ga98e1GQarIwTGsKNZaJWtVsON43
 gY2qxZEDXMVD7EBCuNi8OUZoE1RPwfx0cBYejOm1+YaBfMRyhwTIA4IigLDNFYcVs+9L
 259zIBq1Ib0ECnzkiBKcXoMDbboiJRQg2VgK9C+lSZm/2iTIOte386C8ip47cUFz75PK
 r7kBo4WATDSTbad4YQe0ia4OyVL/rw730qNW5InwOiGbyO0pSkxkPSYinQpQh21/Qzvk
 XD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=buCB+4RoMRIbdC0QeRyjEHgbWG3DCkz/Mz9ArEmit6s=;
 b=oBwxOZdDuBRkpMFquwQ4kbdAJ7FBvVPuzyxQsJCPvfwkQRZTgcZDnu15ZHxdFbpjnh
 8XTeQtRtT1NqVz4i/IaeqjiQpvNQGXOCZbC3YKPCJjI41IwfXgsx094Bw7+G0MoErySv
 ucEh6hB4L//kRCCGo28wIna3lpsImxPc0RMws52Bs/rNDObN7kFyZUTDzLINhMDvX3pJ
 An1X3dsRKZqaZnC68eFOSlHa5+xGrNr6b/s6t2V1IqWA8Pw+ibXXA71crD3SBh4y0IdL
 aCCfrI2bgZVvheaI5V3kaafQwbYZi9McgiVeYoWqEojO6zjmPO7RI7CI+N4h3jvnEJ2o
 CtDg==
X-Gm-Message-State: AOAM532uU9OSV+0s6YsAvJRoXPIOoA5ofYRP5/7wSfn/8QibcLBiQKUk
 jgs3OTzGDrRQ7u6TfCevUDmiZXYUzKaYlbbRaRs=
X-Google-Smtp-Source: ABdhPJxlHaGAp5V4BSaIpcRwt7a13CSTOH5HYz5vgkZWKYgcHCVw5sllwsvPwc5xU6/ZA8N8A3IonOhM433GwtqtxaY=
X-Received: by 2002:a19:f71a:: with SMTP id z26mr5691238lfe.90.1603753349569; 
 Mon, 26 Oct 2020 16:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201026041656.2785980-1-daeho43@gmail.com>
 <20201026190406.GL858@sol.localdomain>
In-Reply-To: <20201026190406.GL858@sol.localdomain>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 27 Oct 2020 08:02:18 +0900
Message-ID: <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1kXBVd-00Ergh-Tj
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: add
 F2FS_IOC_GET_COMPRESS_OPTION ioctl
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SSB0aG91Z2h0IEkgZ2F2ZSB0aGUgaW5mb3JtYXRpb24gYWJvdXQgdGhhdCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UuIElzCnRoaXMgbm90IGVub3VnaCBmb3IgeW91PwpBY3R1YWxseSwgdGhlcmUgaXMg
bm8gc3BhY2UgZm9yIEYyRlMgaW9jdGwgZG9jdW1lbnRhdGlvbiBub3cuIDooCgoyMDIw64WEIDEw
7JuUIDI37J28ICjtmZQpIOyYpOyghCA0OjA0LCBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5l
bC5vcmc+64uY7J20IOyekeyEsToKPgo+IE9uIE1vbiwgT2N0IDI2LCAyMDIwIGF0IDAxOjE2OjU1
UE0gKzA5MDAsIERhZWhvIEplb25nIHdyb3RlOgo+ID4gRnJvbTogRGFlaG8gSmVvbmcgPGRhZWhv
amVvbmdAZ29vZ2xlLmNvbT4KPiA+Cj4gPiBBZGRlZCBhIG5ldyBGMkZTX0lPQ19HRVRfQ09NUFJF
U1NfT1BUSU9OIGlvY3RsIHRvIGdldCBmaWxlIGNvbXByZXNzaW9uCj4gPiBvcHRpb24gb2YgYSBm
aWxlLgo+ID4KPiA+IHN0cnVjdCBmMmZzX2NvbXBfb3B0aW9uIHsKPiA+ICAgICB1OCBhbGdvcml0
aG07ICAgICAgICAgPT4gY29tcHJlc3Npb24gYWxnb3JpdGhtCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgID0+IDA6bHpvLCAxOmx6NCwgMjp6c3RkLCAzOmx6b3JsZQo+ID4gICAgIHU4IGxv
Z19jbHVzdGVyX3NpemU7ICA9PiBsb2cgc2NhbGUgY2x1c3RlciBzaXplCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgID0+IDIgfiA4Cj4gPiB9Owo+ID4KPiA+IHN0cnVjdCBmMmZzX2NvbXBf
b3B0aW9uIG9wdGlvbjsKPiA+Cj4gPiBpb2N0bChmZCwgRjJGU19JT0NfR0VUX0NPTVBSRVNTX09Q
VElPTiwgJm9wdGlvbik7Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogRGFlaG8gSmVvbmcgPGRhZWhv
amVvbmdAZ29vZ2xlLmNvbT4KPiA+IFJldmlld2VkLWJ5OiBFcmljIEJpZ2dlcnMgPGViaWdnZXJz
QGtlcm5lbC5vcmc+Cj4KPiBQbGVhc2UgZG9uJ3QgYWRkIFJldmlld2VkLWJ5IHVudGlsIGl0IGlz
IGV4cGxpY2l0bHkgZ2l2ZW4uCj4KPiBUaGUgYWN0dWFsIGNvZGUgbG9va3MgZmluZSwgYnV0IHRo
ZXJlJ3Mgc3RpbGwgbm8gbWVudGlvbiBvZiBkb2N1bWVudGF0aW9uLAo+IHRlc3RzLCBvciB1c2Ug
Y2FzZXMuCj4KPiAtIEVyaWMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
