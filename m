Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE7DC88E75
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 03:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ij6XM2bX8RkJDhDd/F9WNaGOYVhwWl3IpvcCj8KonhA=; b=eSgN3fvLU1LzAyjzz6dBr6bKxI
	INFVrOxN5MTYHdZHrdOB+hLXqeCZJ6HSLJ4El7xTSraW0Nj0pMEI8RcUhe/7osjLg0CvHBclyP7VK
	2yWi0p83CpSQks6dCMy3PW5zesPNRPsDtxuzXsi9uM70kj6ZX7k8SFh3dGQ1Kx/wRefI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6JbL-0000tQ-7s;
	Tue, 15 Sep 2026 03:12:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x6JbJ-0000t9-16
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 03:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M2tCHdZIjjAhok9Y+2fWM7TbhDmGMKqliTZKsP4FOss=; b=iQOo4Xqfh36u46pnQyEzhYiiZC
 j6WnvRokJSdHkJQRDBCgiZ0Dyf+oGJws+JGlRLtB8aFBrf3tnJuiFGxvzHXGj3uXryt9Uq+Yvi6Hq
 BK5bf36zky8nAMYfIaGMzCLSBVhrn1/HuyhShMEUX7nGL1soyBLg2blCFozbhwMPzNlU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M2tCHdZIjjAhok9Y+2fWM7TbhDmGMKqliTZKsP4FOss=; b=HhQYtMhAn6JmN9f6w7wJc7sL/i
 FhM+CN7/oC+xRFZap8l6xjCi0R141i1RBs9xHeOAkFwS412OvDcu63ICD6lJhNtssI4ISznvtNsRz
 Hi15Dd61zH06LqZ3mAw3lngkV/N2ec3HvvT/XilF9FR09xLaLDtjiGth/sFZyNQ7P3fI=;
Received: from mail-lf2-f12.google.com ([74.125.229.204])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6JbJ-0003UU-9I for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 03:12:53 +0000
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f13d76so3309455e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 20:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789441966; cv=none;
 d=google.com; s=arc-20260327;
 b=KtMdcsBDydvHgRgjavnBVyJYcODwcU6Q8K0ZTPfXzZFRUPXEuYIGY0rVf9N0yALG/P
 Gd9YsaJMeE94zfxCmsk7qbJ/WX0G0NARidgkB7pdAUvoQm+NkF/Zohc9VBmy9v/ILfDC
 JydKOLW+yQi+3tV1nRxXQW2OCrw3PdjQb4IX1SCO29pNL4UxNuOvO8CcP5ssJmB+tGNl
 eILFklEd/LR/06fbSwWYe6ImB8s6xwceF9INqHCHM264fdDbd81TtGtBtfa2GnCLAXgz
 QnfwWLDwl3vsERhaLm/Razymkwa0WkpajX0a1BqU9O8ARFeowVb9O2PaUDQ/4RDhLSqY
 jfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M2tCHdZIjjAhok9Y+2fWM7TbhDmGMKqliTZKsP4FOss=;
 fh=CMgloau/nlIoQyUG4W1jd3GGE9Z1a/S+cpQ4qcoQgZI=;
 b=cm34hrxoWaRCEsIiIuL33R+Q5MkhPo4dup9mKhRyJzCKKbfnYeptdFg1JwxsRuHkO2
 EHg2bDISKY15PEtLCMIWEEXJrgHuQWG3Dn6B9odGF1mRzgrP7lRy5RiRvkcA5Kfonw6U
 ffCzQboWCKYnuhnn4O4aeTHki3ncPhLOU4OVC3WHeuXS+GaKhwHuMHTt8bk75V4ZKuKV
 P2kPzRYIoraEEzBu9Ce2rTBQynDpR4wapUUXiG7IvZL/0Bq/F0K+umDZg+uY0WDrgalr
 QIO/0wKXLXwd7pmo5+6Oj+aNv/k1/m/ReV+kLxwG/XILpiJthuykKeh4QpYBbCj5zJA2
 OQPg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789441966; x=1790046766; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M2tCHdZIjjAhok9Y+2fWM7TbhDmGMKqliTZKsP4FOss=;
 b=DjQCpzf2c8du77lVTrBZMt+vTmovIeHbK+gu77Jxvc94Rj6edKk7PC38QOJeSWVBGl
 T47sVhIZCYxl+Jfl1UowhfvEiEvX0rdWZhwY/l1huamS5vjlc2pRF8sfet1j6hJdaHLr
 1oZ/80m89kqqw7fm1OY5eFgtvjcmXyJJt1JKhNNsNww5n5eL3qgvrQd/GruOhYVldwmR
 U50sD/Isf+Zu8bWkqh0An7791SwWjWdez5+dn77qWMfkBk9EIx/Y9FOP6ARazgk5G43B
 l1qHoZ9/XYZsX2qBKCmxeY0gLvUmf/43qxPy+ASyq2Go6VjXkxoUIGX9J9z6mgkk9UsN
 i40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789441966; x=1790046766;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M2tCHdZIjjAhok9Y+2fWM7TbhDmGMKqliTZKsP4FOss=;
 b=1qmVCIBRjHBLS1QP/pWDGdg8C7wbLfwmUs8Ips79miKis1XEMhzKYZR2nwAihafPwq
 tHwg+RxYSAsUBUDmrZWUHAg661xLYuJzHQxgdfvzSWxZ8apBW8YHooCalVWQUadhXcf4
 mmFD12JRSdJCgkDn8iboyLio9lZ46uvqVbkygd7YmRIgKMh6JGfyi4BsAFlZtFg6tqvv
 zOUgiKUeJuX9Zo1/WdFsCKNtE3we+F4UNM1L3rTo3nN2IW9pLaFxqyS02xPuvUPrEJtN
 ohzxKzA2FE3ygA3f/Dduq/4ea+5Mdt4JeddmHjSrsuQ7bd5K5p+N1+EpZfduGkB5id+M
 OX9A==
X-Forwarded-Encrypted: i=1;
 AKwUvByZaur+5YURNBFUK37Xzp1guYzadBZWTHbZhOFEyi5UQlAZJ4AGIV+xjizS2NwAY9YM+0L+qzMjlffA8LLxCe62@lists.sourceforge.net
X-Gm-Message-State: AFuF++lqRVUGDgASGir+fshc+kD+d9qNkH1RS+PoMx8nNoyA4POZ70jf
 IhAT/9gT4UgeFWql6X3bMp5KtJcS5oqONWacXkEWhvgU3QFnwHzsp7LQkDVEfQ+qxPlqef9qtpF
 mP8anrtq07EOIC99wXWwn173k5CuWqgMebOSP
X-Gm-Gg: AYBFou2waUrdws6DDxF3fkjCMCQOtGI7tNxJya+l/bkOB+I2OS5M4XHNPNWnop4gVoO
 loAKo2B1gByliMC8aFUL2g+dctwqwTrQMtmNawRFkjp86PRgnOKbOF5OX36iTgi3la6Aj927YYG
 YIz8oqK8re3uUwS2bPfQV1AtU782JP4+xiCV7Tq/hRdg1g2KT6MNVLLIh+jQYWAZ6vvRlUtZxso
 1By+eVBFuREqjIAsEBKsFXYso30osnRoDCbw+nd5uQgEDWMkBOb8bA08mOicZlrmvSU38QyRPfY
 whNNo5jdTaOjZmKV/W3i4IFe3+DyJk/l+Z6PbpR2T4igl0S6XanbINa5x+XsHME0/7jnNpZo7t3
 9KuSDHpypLI7LIIunkKQroCj2qPnID8xikzrhDJXe8fpi
X-Received: by 2002:a05:651c:1443:b0:3a5:ba1e:8b05 with SMTP id
 38308e7fff4ca-3a5c885b0b7mr7130051fa.1.1789441966150; Mon, 14 Sep 2026
 20:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_xEPkZWv5zbWQiG6_stjaDZ8MJPtQ64_mwpJeviSDLCLg@mail.gmail.com>
 <20260915020152.1085430-1-ke.li11@transsion.com>
In-Reply-To: <20260915020152.1085430-1-ke.li11@transsion.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 14 Sep 2026 20:12:32 -0700
X-Gm-Features: AcwNN1UVOfxPwCxaA4elE-wMJke9B0gn8ogNRqb-xwes4SHyhs0D2y0F1wrDquI
Message-ID: <CACOAw_wRYcgKhDe_KfEQUoYWrFOe2cm-ux92ZdiL=-SzH3FXeg@mail.gmail.com>
To: =?UTF-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
X-Headers-End: 1x6JbJ-0003UU-9I
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: multi-device expandable storage
 support
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBTZXAgMTQsIDIwMjYgYXQgNzowMuKAr1BNIOadjuePgjExIDxrZS5saTExQHRyYW5z
c2lvbi5jb20+IHdyb3RlOgo+Cj4gSGkgRGFlaG8sCj4KPiBUaGFua3MgZm9yIHRoZSBmb2xsb3ct
dXAuIExldCBtZSBjbGFyaWZ5IHRoZSByZWFsIHByb2R1Y3Rpb24gdXNlIGNhc2UuCj4KPiAxLiBQ
cm9kdWN0aW9uIHNjZW5hcmlvCj4KPiBPbiBvdXIgQW5kcm9pZCBkZXZpY2VzLCAvZGF0YSBpcyBG
MkZTLCBhbmQgc3lzdGVtIGltYWdlcyBsaXZlIGluIHRoZSBzdXBlcgo+IHBhcnRpdGlvbi4gQXMg
T1RBIHBheWxvYWRzIGdyb3csIHRoZSBleGlzdGluZyBzdXBlciBzaXplIGNhbiBiZWNvbWUKPiBp
bnN1ZmZpY2llbnQgZm9yIGEgc3VjY2Vzc2Z1bCB1cGRhdGUuIFRvIG1ha2UgT1RBIHN1Y2NlZWQs
IHdlIG5lZWQgYSB3YXkgdG8KPiBkeW5hbWljYWxseSBtb3ZlIGNhcGFjaXR5IGZyb20gdXNlcmRh
dGEgdG8gc3VwZXIgd2hlbiByZXF1aXJlZC4KPgo+IFRvIHN1cHBvcnQgdGhhdCwgd2hlbiB0aGlz
IHNvbHV0aW9uIGlzIGludGVncmF0ZWQgd2UgY2hhbmdlIHRoZSBwYXJ0aXRpb24KPiB0YWJsZSBh
bmQgaW50cm9kdWNlIGFuIGV4cGFuZCBwYXJ0aXRpb24sIHdoaWNoIGlzIG1vdW50ZWQgYXMgYSBz
ZWNvbmRhcnkKPiBkZXZpY2Ugb2YgL2RhdGEuIFNvIGZyb20gdGhhdCBwb2ludCBvbiwgL2RhdGEg
aXMgYSBtdWx0aS1kZXZpY2UgRjJGUyBsYXlvdXQKPiBieSBkZXNpZ246IHByaW1hcnkgdXNlcmRh
dGEgKyBleHBhbmQuCj4KPiBUaGUgcnVudGltZSBmbG93IGlzOgo+Cj4gICBhLiAvZGF0YSBpcyBt
b3VudGVkIGFzIG11bHRpLWRldmljZSB3aXRoIHRoZSBleHBhbmQgcGFydGl0aW9uIGF0dGFjaGVk
IGFzCj4gICAgICB0aGUgc2Vjb25kYXJ5IGRldmljZS4KPiAgIGIuIFdoZW4gYW4gT1RBIG5lZWRz
IGEgbGFyZ2VyIHN1cGVyLCB1c2Vyc3BhY2Ugc2hyaW5rcyBGMkZTIGFuZCByZWNsYWltcwo+ICAg
ICAgY2FwYWNpdHkgZnJvbSB0aGUgZXhwYW5kIHNpZGUuCj4gICBjLiBUaGUgcmVjbGFpbWVkIHNw
YWNlIGlzIG1lcmdlZCBpbnRvIHRoZSBzdXBlciBwYXJ0aXRpb24uCj4gICBkLiBBZnRlciByZWNs
YWltLCAvZGF0YSBtdXN0IHJlbW91bnQgY2xlYW5seS4gSWYgdGhlIGV4cGFuZCBkZXZpY2UgaGFz
IGJlZW4KPiAgICAgIGZ1bGx5IHJlY2xhaW1lZCwgL2RhdGEgcmV0dXJucyB0byBzaW5nbGUtZGV2
aWNlIGFuZCBtdXN0IG5vdCBzdGlsbAo+ICAgICAgcmVmZXJlbmNlIHRoZSBvbGQgZXhwYW5kIHBh
dGggaW4gdGhlIG9uLWRpc2sgc3VwZXJibG9jay4KPgo+IDIuIFdoeSBub3QgYSBmaXhlZCBtdWx0
aS1kZXZpY2Ugc2V0dXAgb3IgZXhpc3RpbmcgbWVjaGFuaXNtcz8KPgo+IC0gRml4ZWQgbXVsdGkt
ZGV2aWNlOgo+ICAgUGVybWFuZW50bHkga2VlcGluZyBleHBhbmQgYXR0YWNoZWQgd291bGQgbGVh
dmUgdGhhdCBjYXBhY2l0eSBpbnNpZGUKPiAgIC9kYXRhLiBGb3IgT1RBIHdlIG5lZWQgdG8gdGFr
ZSBzcGFjZSBvdXQgb2YgdXNlcmRhdGEgYW5kIGdpdmUgaXQgdG8KPiAgIHN1cGVyLiBBIGZpeGVk
IG11bHRpLWRldmljZSBsYXlvdXQgY2Fubm90IHNhdGlzZnkgdGhhdC4KPgo+IC0gcmVzaXphYmxl
X3RhaWxfc2Vjbm86Cj4gICBJdCBoZWxwcyBrZWVwIHBpbm5lZCBhbGxvY2F0aW9ucyBvdXQgb2Yg
YSBzaHJpbmthYmxlIHRhaWwgYW5kIG1ha2VzCj4gICBvbmxpbmUgc2hyaW5rIHNhZmVyLiBUaGF0
IGlzIHVzZWZ1bCwgYW5kIHdlIGNhbiB1c2UgaXQgdG9nZXRoZXIgd2l0aAo+ICAgcmVzaXplLiBC
dXQgaXQgZG9lcyBub3QgY292ZXIgdGhlIGV4cGFuZC1kZXZpY2UgbGlmZWN5Y2xlIGluIHRoaXMg
T1RBCj4gICBmbG93OiBhZnRlciBleHBhbmQgaXMgZnVsbHkgcmVjbGFpbWVkIGZvciBzdXBlciwg
RjJGUyBtdXN0IGRyb3AgdGhhdAo+ICAgc2Vjb25kYXJ5IGRldmljZSBhbmQgY2xlYXIgaXRzIG9u
LWRpc2sgcGF0aDsgb3RoZXJ3aXNlIHRoZSBuZXh0IC9kYXRhCj4gICBtb3VudCBzdGlsbCB0cmll
cyB0byBvcGVuIGEgYmxvY2sgZGV2aWNlIHRoYXQgaGFzIGFscmVhZHkgYmVlbiByZWFzc2lnbmVk
Cj4gICB0byBzdXBlci4KPgo+IC0gZGV2aWNlIGFsaWFzaW5nOgo+ICAgQWxpYXNpbmcgcmVzZXJ2
ZXMvcmVsZWFzZXMgYSByYW5nZSB0aGF0IHJlbWFpbnMgaW4gdGhlIGZpbGVzeXN0ZW0KPiAgIGFk
ZHJlc3Mgc3BhY2UuIE91ciBleHBhbmQgcGFydGl0aW9uIGlzIGEgcmVhbCBzZWNvbmRhcnkgYmxv
Y2sgZGV2aWNlIGluCj4gICB0aGUgcGFydGl0aW9uIHRhYmxlLCBhdHRhY2hlZCB0byAvZGF0YSBz
byBpdHMgY2FwYWNpdHkgY2FuIGxhdGVyIGJlCj4gICBwaHlzaWNhbGx5IHJlcHVycG9zZWQgZm9y
IHN1cGVyLiBBZnRlciByZWNsYWltLCBpdCBtdXN0IG5vIGxvbmdlciBiZQo+ICAgcmVmZXJlbmNl
ZCBieSB0aGUgRjJGUyBzdXBlcmJsb2NrLgo+Cj4gVGhhdCBpcyB3aHkgdGhlIHR3byBrZXJuZWwg
Y2hhbmdlcyBhcmUgbmVlZGVkIGZvciB0aGlzIE9UQSBmbG93Ogo+Cj4gLSBhbGxvY19wcmltYXJ5
OiB3aGlsZSBleHBhbmQgaXMgYXR0YWNoZWQsIGtlZXAgd2FybS9jb2xkL3BpbiBhbGxvY2F0aW9u
Cj4gICBvbiB0aGUgcHJpbWFyeSB1c2VyZGF0YSBkZXZpY2UsIHNvIGV4cGFuZCBjYXBhY2l0eSBj
YW4gbGF0ZXIgYmUgZW1wdGllZAo+ICAgYW5kIGdpdmVuIHRvIHN1cGVyLgo+IC0gcmVzaXplIGRy
b3AtbGFzdC1zZWNvbmRhcnk6IGFmdGVyIGEgZmluYWwgc2hyaW5rIHRoYXQgcmVtb3ZlcyB0aGUg
ZXhwYW5kCj4gICBkZXZpY2UsIGNsZWFyIGl0cyBzdXBlcmJsb2NrIHBhdGggYW5kIGRldGFjaCBG
REVWW10sIHNvIC9kYXRhIGNhbiByZW1vdW50Cj4gICBhcyBzaW5nbGUtZGV2aWNlIGFmdGVyIHRo
ZSBzcGFjZSBoYXMgYmVlbiBtb3ZlZCB0byBzdXBlci4KCkhpIEtlIExpLAoKVGhhbmtzIGZvciBl
eHBsYWluaW5nIHRoZSBkZXRhaWxlZCBwcm9kdWN0aW9uIHNjZW5hcmlvLgoKUmVnYXJkaW5nIHRo
ZSBsaWZlY3ljbGUgY29tcGxleGl0eSBvZiBhdHRhY2hpbmcgYW5kIGRldGFjaGluZyBhCnNlY29u
ZGFyeSBkZXZpY2U6IHdoYXQgYXJlIHlvdXIgdGhvdWdodHMgb24gYWNoaWV2aW5nIHRoZSBleGFj
dCBzYW1lCnJlc3VsdCB1c2luZyBhIHNpbmdsZS1kZXZpY2UgL2RhdGEgc2V0dXAgd2l0aCByZXNp
emFibGVfdGFpbF9zZWNubyBhbmQKc3RhbmRhcmQgcmVzaXplPwoKSWYgd2Uga2VlcCAvZGF0YSBh
cyBhIHNpbmdsZSBibG9jayBkZXZpY2UgYW5kIGRlc2lnbmF0ZSB0aGUgdGFpbApzZWN0aW9uICh0
aGUgc3BhY2UgdGhhdCBtYXkgYmUgcmVjbGFpbWVkIGZvciBzdXBlcikgdXNpbmcKcmVzaXphYmxl
X3RhaWxfc2Vjbm8sIHBpbm5lZCBhbmQgaGVhdnkgZGF0YSBhbGxvY2F0aW9ucyB3aWxsIG5hdHVy
YWxseQpzdGF5IG91dCBvZiB0aGF0IHJlZ2lvbi4gV2hlbiBhbiBPVEEgdXBkYXRlIG5lZWRzIHNw
YWNlIGZvciBzdXBlciwgd2UKY2FuIHNpbXBseSBwZXJmb3JtIGFuIG9ubGluZSBzaHJpbmsgd2l0
aCByZXNpemUuCgpUaGlzIGFwcHJvYWNoIHNlZW1zIGxpa2UgaXQgY291bGQgZWxpbWluYXRlIHRo
ZSBuZWVkIGZvcgphdHRhY2hpbmcvZGV0YWNoaW5nIHNlY29uZGFyeSBibG9jayBkZXZpY2VzLCBj
bGVhcmluZyBvbi1kaXNrCnN1cGVyYmxvY2sgcGF0aHMsIGFuZCBpbnRyb2R1Y2luZyBhbGxvY19w
cmltYXJ5LCB3aGlsZSBhY2NvbXBsaXNoaW5nCnRoZSBleGFjdCBzYW1lIGdvYWwuIFdvdWxkIHRo
aXMgc2luZ2xlLWRldmljZSBhcHByb2FjaCBmaXQgeW91cgpwcm9kdWN0aW9uIHVzZSBjYXNlPwoK
VGhhbmtzLAoKRGFlaG8KCj4KPiBUaGFua3MsCj4gS2UgTGkKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
