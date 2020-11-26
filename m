Return-Path: <SRS0=xRoo=FA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87024C63798
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Nov 2020 23:47:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D1C21D91;
	Thu, 26 Nov 2020 23:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="mkTQndk6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Zs8gb9Tr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmZCklVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D1C21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kiQz1-0007xN-8V; Thu, 26 Nov 2020 23:47:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kiQyz-0007tJ-GO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Nov 2020 23:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hgk+y3R/+wKHwY8AHHPwfYUtuRseW4QHOS+AXJzFHJc=; b=mkTQndk6/gnVJO0aijeORZJPyS
 uSX0SPRwjXilge50v9pOheiLWMfiIMEzW52Rf2DGnz3mlSJxLVUeqrCqRlvj/UgemeJFrIbZJZ5mp
 6RoWvxu4tFrwsW/MdIYYa3xswzi8lrGwZHkePHdqOhFguOS8ZYuOpOTCGAdLoyk2PNxY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hgk+y3R/+wKHwY8AHHPwfYUtuRseW4QHOS+AXJzFHJc=; b=Zs8gb9TrPchFZ24hI4k9VesFzy
 Qt5b9yMQkfaXf5C6vV3D7O4g/O2QMlzVu8uz+bHX+nFCu9SJ8L7KLnT8KrC+TafzkDnE14m69LRs4
 TJULgGW0Q3n2PJ9+QspnstShUaJk0RLPeAySxtz6N/P6wPsDfMCuVUM1b2sYscCDAyqw=;
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kiQym-0008Gd-TA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Nov 2020 23:47:25 +0000
Received: by mail-lj1-f196.google.com with SMTP id r18so4040727ljc.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2020 15:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hgk+y3R/+wKHwY8AHHPwfYUtuRseW4QHOS+AXJzFHJc=;
 b=UmZCklVE+6LJBZ0ksVoPTJGBuaE/NBsqmU1zhUV2JHO+B1a3YZprPMTxMvlFYLe585
 8phq9Up9vzDLmSOQwsIG1W+AxT4EyUf2qOm/wRGyf4WS+Q26VYwYp3rKHA3t0qOp2ZfE
 wZfH2QRJP1xMN1Mc8kgAd8naaakEi0S6S5At8gW5g+iZYYHtlIVeOeQy5YcdzDsPZHNw
 qGs11TL4maxG7T8+iBgl9Zf/xxKo4X2KJopi6ZGaV0jEzPH9yqojYS45ehjH+O3lMvIa
 pm1g3qUpd1nm1ZxSyoFELZw+5BItIOwHelBeDNijVZriJ7sSVJ63VuNHPKzWXF0DjV1E
 8B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hgk+y3R/+wKHwY8AHHPwfYUtuRseW4QHOS+AXJzFHJc=;
 b=okaEgtpUNanAtl6buJDkClaPi0Ft/LZ2MWnN+gDPSSkWJdWF5o1mgmiQKK7CcMmAaD
 2ABBS6PvfMUmpSEDQLsRgR1CW8eB1BRm0uSwsBoP4X1tB0Q0bfmLlfEWj62m2aTjUPJI
 gmbLyXS4CFX3q7ss7CgPbTwYtTOEJhpG9+cGfkMmhaxdU+hvk/lJLXVgJMitCPqMhA9Q
 cAfj2EHOk6Gwoi5drG7lglETUGmnc8VaWiHJDvl5gPjkZbTL0Hq+RtahYWn0gZm5J7yj
 sKNoUnXo3R5VMPpkZuo8eU0ilm03gYQROGmma+HTKCjr/U8vIdUNs0ohyzQBpD3oH0L3
 wlXg==
X-Gm-Message-State: AOAM532YynzcyW0NqCMvqxz0uyN/2gbDQktiLCj+cDDvb7myT24UrHyl
 R06mogRWwX9ZPT0BsbFXgRyGXcSdcblQZwrVLwQ=
X-Google-Smtp-Source: ABdhPJyRNLpKaqnV8O473Pl/YaIe0OR/eS2o+HSGUuD84MarnbDCD5StxxWczokLGXB+yMtV9I/q6Ok8wEfPj6Xqjns=
X-Received: by 2002:a05:651c:213:: with SMTP id
 y19mr2089989ljn.250.1606434418814; 
 Thu, 26 Nov 2020 15:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20201123031751.36811-1-daeho43@gmail.com>
 <20201123031751.36811-2-daeho43@gmail.com>
 <5b3cb83d-5d0f-c1ca-2cff-f28372dec48e@huawei.com>
 <CACOAw_xs0dizV_xg4-8ssC8wPRq8eXPw3QhHAFf3S-w3hp9jcg@mail.gmail.com>
 <X7/qr/kVxl3AO/PR@sol.localdomain>
In-Reply-To: <X7/qr/kVxl3AO/PR@sol.localdomain>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 27 Nov 2020 08:46:47 +0900
Message-ID: <CACOAw_xaJ6pfT_EDqCSaL8UnBVkktXK5N_GXuHT+xzu1ufVacg@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1kiQym-0008Gd-TA
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
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
Cc: kernel-team@android.com, Daeho Jeong <daehojeong@google.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbywKCkdvdCBpdH4KCkVyaWMsCgpBY3R1YWxseSwgSSB3YW50ZWQgdG8gZGV0b3VyIHRoZSBp
bnRlcm5hbCByZWFkYWhlYWQgbWVjaGFuaXNtIHVzaW5nCnBhZ2VfY2FjaGVfcmFfdW5ib3VuZGVk
KCkgdG8gZ2VuZXJhdGUgY2x1c3RlciBzaXplIGFsaWduZWQgcmVhZApyZXF1ZXN0cy4KQnV0LCBw
YWdlX2NhY2hlX2FzeW5jX3JlYWRhaGVhZCgpIG9yIHBhZ2VfY2FjaGVfc3luY19yZWFkYWhlYWQo
KSBjYW4KYmUgYWxzbyBnb29kIGVub3VnaCwgc2luY2UgdGhvc2UgY2FuIGNvbXBlbnNhdGUgZm9y
IHRoZSBtaXNhbGlnbmVkCnJlYWRzIHJlYWRpbmcgbW9yZSBwYWdlcyBpbiBhZHZhbmNlLgoKVGhh
bmtzLAoKMjAyMOuFhCAxMeyblCAyN+ydvCAo6riIKSDsmKTsoIQgMjo0OSwgRXJpYyBCaWdnZXJz
IDxlYmlnZ2Vyc0BrZXJuZWwub3JnPuuLmOydtCDsnpHshLE6Cj4KPiBPbiBUaHUsIE5vdiAyNiwg
MjAyMCBhdCAwMjowNDo0MVBNICswOTAwLCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IEVyaWMsCj4g
Pgo+ID4gZG9fcGFnZV9jYWNoZV9yYSgpIGlzIGRlZmluZWQgaW4gbW0vaW50ZXJuYWwuaCBmb3Ig
aW50ZXJuYWwgdXNlCj4gPiBiZXR3ZWVuIGluIG1tLCBzbyB3ZSBjYW5ub3QgdXNlIHRoaXMgb25l
IHJpZ2h0IG5vdy4KPiA+IFNvLCBJIHRoaW5rIHdlIGNvdWxkIHVzZSBwYWdlX2NhY2hlX3JhX3Vu
Ym91bmRlZCgpLCBiZWNhdXNlIHdlIGFscmVhZHkKPiA+IGNoZWNrIGlfc2l6ZSBib3VuZGFyeSBv
biBvdXIgb3duLgo+ID4gV2hhdCBkbyB5b3UgdGhpbms/Cj4KPiBXaGF0IGFib3V0IHBhZ2VfY2Fj
aGVfYXN5bmNfcmVhZGFoZWFkKCkgb3IgcGFnZV9jYWNoZV9zeW5jX3JlYWRhaGVhZCgpPwo+Cj4g
LSBFcmljCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bGludXgtZjJmcy1kZXZlbAo=
