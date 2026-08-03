Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37562C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfdByv6RAqr8DIX+Dk7YuCipsaIffJDbdUarXknVfDs=; b=TIIojituRT+0kx3dzwZcXTnCEu
	WNwlevEfFHKcCatZ3Ik0TmhvfgAt5p/fD1HChOxVwoWiICLSRomH/FFWMC9pUxoJpcSvk/1xbgqWt
	NFOpsNncVkuy5ssyDaxcQ8tH5w5YwWnWPFMsCbLwn/OTYfmZdnZKsVCRTa17e1y1dkkg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqo9i-0003Jj-8i;
	Mon, 03 Aug 2026 08:36:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqo9g-0003Jb-HT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FGeNdIe/XlPML0vwrVFuLZojrUjeDbNjmTXqptBRXPc=; b=mQkDdwOjKBFBXS/z8eb1gx5TXm
 WRTVyqehlvnYixlB3uMrK07faQ4jm0icwEu7mu6mg6OvtyQiO1Du2jELEv26R8O8qb/SFi/Z8iVPm
 zEqSm4cQEj4cwFcAKhVx40dAELO3UDRj7DWpjojJB3HnjFQGIALASFwy/sF7zR9GIXP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FGeNdIe/XlPML0vwrVFuLZojrUjeDbNjmTXqptBRXPc=; b=Z+1hdnmK51IB4P14cwFivlx67K
 GZI//YAB/2Wo+0wFjtqva7r7cn+dxM52FdhlbqfB+ptpZ8BPiEVnjta0LZg1OqTGjoU+59wDwXYob
 3fynEW7RM6mb5a6jy1KqAlfPaiT2Dsc+mC7NA21snmQP02q9TE1EBxb+qjBk+DxKdydg=;
Received: from mail-lf1-f45.google.com ([209.85.167.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqo9j-0001FI-Ao for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:36:16 +0000
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b2a4359d16so2805182e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 01:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785746169; cv=none;
 d=google.com; s=arc-20260327;
 b=TucPH3gNm2NYwS4YHkyT6jRpDPsqB5ZLOvOLd7QqHHSC/Ll14RdYLeidzHo9gjeCq9
 wZYmXqSpdDuMoKNUzZIUiZ4vtR/TwJu/vFRTn/DUxRFI4c5mCuF2YraaMkQaTRCXtvZ7
 KihXcJHIwiDlxYAvbJvjHsJzzElNPCd35erxnjSBz2oZq1vaga7sgmIX2obiC9sRa6nW
 EgQF3ioNOoA+b8XrtbauhKZqKqYH0YV2rY2x5ndd6PiSxrfJlrFiYDhJoElNcxBF8WxO
 JfnzJjmTezTvom+zenuZ58Dx6l2PUZfjkjDwUxTXBWqPjtxKqQ2RADm+ba4X+pdWiKEt
 KKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FGeNdIe/XlPML0vwrVFuLZojrUjeDbNjmTXqptBRXPc=;
 fh=Iitlk98HftbcV0gQnxJphyxnNMwGI5AytHogosCfLbw=;
 b=baEZfZJgmvU40NPOfcEM7tMTss3x/m+dxPlwEPAiU3qbp7MbzpWppK1aCDu/9YioUD
 86RadxIQhEBSj2zIx1eZnptthUkqqA/57grvSDFPeHF3oTLhGXC56T6AmCxYCeXz75zE
 bxK+vhhPKNLopaOhxwP2JaOmuN5Zu4q2a9IZdih/HYpjNKx8uuf4aS2Pez01McH/ms20
 J/BbPzFPGDGPYtpK0khHs8UN0llwqJvAaiCPQpD0QzGZsFXrOCkRntGJRepzqQ5Ushtj
 kBziZfoxp+coS6vXEJY3PKu5daz10MrRPBqKrxp2WmkzmFQ9VsThPzmkjjJgSe9zz6yc
 amug==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785746169; x=1786350969; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FGeNdIe/XlPML0vwrVFuLZojrUjeDbNjmTXqptBRXPc=;
 b=NVlOTg8hqaYvuIcSd72EnnpNVX9LQ52MNqW2jmwecVDCQtIOQ4euDj2hs5nAqfJJF0
 aGIbbETPLViQM92sX1w13mXEWVvY85IvLv26JBfcpIyy0Qs441y3USTBBdMV7qUsP8F5
 36gY25ZaGEe9nZg+WiKJZJ0vNxY+TpBiVm3PUeu7go5YQvqyCqi9IzWAxQNtOx7SX6pv
 ZQN8nZv8ju+fQ2srg/yvBerizK8dFIl47HsetyAPaD2FY929mf2W1QQp8KgF9Azlus8Q
 ulO7NVjhDH6jxLdF4tQpU/ZeckrcsgxrhkTigo4LJ4u/GZBQ7q4e1vXm4jgtknANPsPi
 Sbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785746169; x=1786350969;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FGeNdIe/XlPML0vwrVFuLZojrUjeDbNjmTXqptBRXPc=;
 b=e+0CpBkNfEqY1AcD+3HnHAf8fYwQjBMGEkOUNS/NbeR+IezpMRjAEqxfwmYOWYwS0q
 j2kM/Tx0xAO1vW053d/KhklHPow6Zq2nNAnvCfwSiGDQCJ8TixhEnt145ufxv/Mz31OI
 sXk97VrZZEcGKqD4O0UVJsv80Ve3t7iP1BtD30drYu5wcsEF0V/dB0Rruf30cSgUVSsJ
 rEJVh+rfAPcFpDGb1BV9vBULhoupZvWCpl84joYWNU91fisQ/qhADkFZlTsFDtEP0XIG
 uduGp/V9BUPfBg2chw1rBzYmZ7vD+ZTE6m3DEn6T7e77BoxNoqwO3BRHXfsrmJ8o7H0F
 H41g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYKAch3ApP9oXGTbY05JOJj1x7EmrJK7eOh9/LeN07tn4OSx1j2Mv1Do1bX1aEyt+DC4DaJ0kwUQqA35n9cShQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyhy+hMsHS/yT5lg1YYIMJ/JrNvxj7dcloqCOTbckF/sALF0IHA
 4ONeUWcGD1lV5wU03diwQebKlR7E0RXFHa/2Ov4kjd1+vZj5UOnk5JNyk6M0EVCFiL3zYVSvjUR
 1p21pL8m8E2zbPX3+CDKMyqVdPnMhQxZtPawxR+0=
X-Gm-Gg: AR+sD105pfR7zj5pzI66IJDfAe42qA8Jruo2pKLIwb2bp3LIoGWl6feufOkwFnycNTB
 emQ7qmEb3CmlkUi3ILTs5B1ZgBobURLmd52qT3qlD7HXV0YYfRK42HSg90mMwAWm4DWgbvwIna6
 LcUpsgqu7dVZvPQVOroJdchcfg385xU3zccJp/015PfmqVKBfukKHqg9yVsSDd4lPAxhA/s+qFA
 tX6FMHlkaLwBuELmwr8yDrvWJXE34RqyIHCA5JAMU4qY8wbHkNG6ES3a7X0wC/4YucVAnRafsxP
 5iXdzp4UMlIrPHOVtPSlIgUVfpOKdK4IXIvD9outyTUKsw==
X-Received: by 2002:a05:6512:1387:b0:5b1:5829:b8ca with SMTP id
 2adb3069b0e04-5b2e4f3b602mr1945257e87.26.1785746168768; Mon, 03 Aug 2026
 01:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260723133617.3841286-1-qiwenjie@xiaomi.com>
 <f0eb26ed-c624-47d0-9450-6e6e014bbcd7@kernel.org>
In-Reply-To: <f0eb26ed-c624-47d0-9450-6e6e014bbcd7@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 3 Aug 2026 16:35:57 +0800
X-Gm-Features: AUfX_mxiBPV4cJClJAq-wD5Nmia7k3cNI-0QqxvmRb9ssj_j9cvx6GY2Phn_GoA
Message-ID: <CAGFpFsRbS9duXvmV5R8f1FGC5v2es3j1=MzNYk5feCtGMCdUXw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wqo9j-0001FI-Ao
Subject: Re: [f2fs-dev] [PATCH] f2fs: keep pinned fallocate failures
 section-aligned
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
Cc: jaegeuk@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBZZXMuIEkgdXNlZCBhIGJsb2NrLWFsbG9jYXRpb24gZmF1bHQgaW5qZWN0aW9uIHJlcHJvZHVj
ZXIuCgogIE15IHJlcHJvZHVjZXIgdXNlcyBGMkZTIEZBVUxUX0JMT0NLIGluamVjdGlvbiBpbiB0
aGUgZjJmc19tYXBfYmxvY2tzKCkKICBwYXRoLiBHdWVzdCBzdGVwcyB3ZXJlOgoKICAxLiBtb3Vu
dCAvZGV2L3ZkYgogIDIuIGNyZWF0ZSBhIHBpbm5lZCBmaWxlCiAgMy4gc2V0IGluamVjdF90eXBl
PTEyOCAoRkFVTFRfQkxPQ0spCiAgNC4gc2V0IGluamVjdF9yYXRlPTI1NyBhbmQgcnVuOgogICAg
IC9tZWRpYS9yZXByb19mMmZzX3BpbmZpbGVfZmF1bHQgZmFsbG9jIC9tbnQvZjJmcy9waW5maWxl
IDIwOTcxNTIKCiAgT24gdGhlIG9sZCBjb2RlIHRoaXMgcmV0dXJucyAtRU5PU1BDLCBidXQgdGhl
IGZpbGUgaXMgbGVmdCBhczoKICAgIFNJWkU9MTA0ODU3NiBCTE9DS1M9MjA0OAoKICBTbyB0aGUg
ZmFpbHVyZSBoYXBwZW5lZCBpbiB0aGUgbWlkZGxlIG9mIGEgMk1pQiBzZWN0aW9uLCBhbmQgdGhl
IHBpbm5lZAogIGZpbGUgd2FzIGxlZnQgc2VjdGlvbi11bmFsaWduZWQuCgpPbiBNb24sIEF1ZyAz
LCAyMDI2IGF0IDM6MjTigK9QTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4g
T24gNy8yMy8yNiAyMTozNiwgV2VuamllIFFpIHdyb3RlOgo+ID4gUGlubmVkIGZhbGxvY2F0ZSBh
bGxvY2F0ZXMgb25lIHNlY3Rpb24gYXQgYSB0aW1lLiBJZiBmMmZzX21hcF9ibG9ja3MoKQo+ID4g
ZmFpbHMgYWZ0ZXIgYWxsb2NhdGluZyBwYXJ0IG9mIHRoZSBjdXJyZW50IHNlY3Rpb24sIHRoZSBl
cnJvciBwYXRoIHN0aWxsCj4gPiBhZGRzIHRoZSBwYXJ0aWFsIGxlbmd0aCB0byBleHBhbmRlZCBh
bmQgY2xlYXJzIEZBRFZJU0VfVFJVTkNfQklULiBBIGZhaWxlZAo+ID4gZmFsbG9jYXRlIGNhbiB0
aGVuIGxlYXZlIGEgcGlubmVkIGZpbGUgd2l0aCBhIG5vbi1zZWN0aW9uLWFsaWduZWQgc2l6ZS4K
Pgo+IERvIHlvdSBoYXZlIGEgcmVwcm9kdWNlcj8gbWF5YmUgaW5qZWN0IG1lbW9yeSBhbGxvY2F0
aW9uIGZhaWx1cmU/Cj4KPiBUaGFua3MsCj4KPiA+Cj4gPiBDb3VudCBvbmx5IGNvbXBsZXRlIHNl
Y3Rpb25zIG9uIGZhaWx1cmUgYW5kIGtlZXAgRkFEVklTRV9UUlVOQ19CSVQgc2V0Cj4gPiB1bnRp
bCB0aGUgZmFpbGVkIHNlY3Rpb24gcHJlYWxsb2NhdGlvbiBoYXMgYmVlbiByZW1vdmVkLgo+ID4K
PiA+IEZpeGVzOiBmNWE1M2VkY2YwMWUgKCJmMmZzOiBzdXBwb3J0IGFsaWduZWQgcGlubmVkIGZp
bGUiKQo+ID4gQ2M6IHN0YWJsZUBrZXJuZWwub3JnCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW5qaWUg
UWkgPHFpd2VuamllQHhpYW9taS5jb20+Cj4gPiAtLS0KPiA+ICAgZnMvZjJmcy9maWxlLmMgfCAx
NyArKysrKysrKysrKysrKy0tLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9m
cy9mMmZzL2ZpbGUuYwo+ID4gaW5kZXggYzU0ODk3YTI1OTgxLi44M2FmNzNmMzgzMWUgMTAwNjQ0
Cj4gPiAtLS0gYS9mcy9mMmZzL2ZpbGUuYwo+ID4gKysrIGIvZnMvZjJmcy9maWxlLmMKPiA+IEBA
IC0xOTY2LDExICsxOTY2LDEyIEBAIHN0YXRpYyBpbnQgZjJmc19leHBhbmRfaW5vZGVfZGF0YShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qgb2Zmc2V0LAo+ID4KPiA+ICAgICAgICAgICAgICAg
bWFwLm1fc2VnX3R5cGUgPSBDVVJTRUdfQ09MRF9EQVRBX1BJTk5FRDsKPiA+ICAgICAgICAgICAg
ICAgZXJyID0gZjJmc19tYXBfYmxvY2tzKGlub2RlLCAmbWFwLCBGMkZTX0dFVF9CTE9DS19QUkVf
RElPKTsKPiA+IC0gICAgICAgICAgICAgZmlsZV9kb250X3RydW5jYXRlKGlub2RlKTsKPiA+ICsg
ICAgICAgICAgICAgaWYgKCFlcnIpCj4gPiArICAgICAgICAgICAgICAgICAgICAgZmlsZV9kb250
X3RydW5jYXRlKGlub2RlKTsKPiA+Cj4gPiAgICAgICAgICAgICAgIGYyZnNfdXBfd3JpdGUoJnNi
aS0+cGluX3NlbSk7Cj4gPgo+ID4gLSAgICAgICAgICAgICBleHBhbmRlZCArPSBtYXAubV9sZW47
Cj4gPiArICAgICAgICAgICAgIGV4cGFuZGVkICs9IGVyciA/IHJvdW5kZG93bihtYXAubV9sZW4s
IHNlY19ibGtzKSA6IG1hcC5tX2xlbjsKPiA+ICAgICAgICAgICAgICAgc2VjX2xlbiAtPSBtYXAu
bV9sZW47Cj4gPiAgICAgICAgICAgICAgIG1hcC5tX2xibGsgKz0gbWFwLm1fbGVuOwo+ID4gICAg
ICAgICAgICAgICBpZiAoIWVyciAmJiBzZWNfbGVuKQo+ID4gQEAgLTE5ODYsNyArMTk4Nyw3IEBA
IHN0YXRpYyBpbnQgZjJmc19leHBhbmRfaW5vZGVfZGF0YShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBs
b2ZmX3Qgb2Zmc2V0LAo+ID4gICAgICAgICAgICAgICBwZ29mZl90IGxhc3Rfb2ZmOwo+ID4KPiA+
ICAgICAgICAgICAgICAgaWYgKCFleHBhbmRlZCkKPiA+IC0gICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gZXJyOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ID4KPiA+ICAg
ICAgICAgICAgICAgbGFzdF9vZmYgPSBwZ19zdGFydCArIGV4cGFuZGVkIC0gMTsKPiA+Cj4gPiBA
QCAtMjAwNCw2ICsyMDA1LDE2IEBAIHN0YXRpYyBpbnQgZjJmc19leHBhbmRfaW5vZGVfZGF0YShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qgb2Zmc2V0LAo+ID4gICAgICAgICAgICAgICAgICAg
ICAgIGYyZnNfaV9zaXplX3dyaXRlKGlub2RlLCBuZXdfc2l6ZSk7Cj4gPiAgICAgICB9Cj4gPgo+
ID4gK291dDoKPiA+ICsgICAgIGlmIChlcnIgJiYgZjJmc19pc19waW5uZWRfZmlsZShpbm9kZSkg
JiYgZmlsZV9zaG91bGRfdHJ1bmNhdGUoaW5vZGUpKSB7Cj4gPiArICAgICAgICAgICAgIGYyZnNf
ZG93bl93cml0ZSgmRjJGU19JKGlub2RlKS0+aV9nY19yd3NlbVtXUklURV0pOwo+ID4gKyAgICAg
ICAgICAgICBmaWxlbWFwX2ludmFsaWRhdGVfbG9jayhpbm9kZS0+aV9tYXBwaW5nKTsKPiA+ICsg
ICAgICAgICAgICAgaWYgKCFmMmZzX3RydW5jYXRlKGlub2RlKSkKPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBmaWxlX2RvbnRfdHJ1bmNhdGUoaW5vZGUpOwo+ID4gKyAgICAgICAgICAgICBmaWxl
bWFwX2ludmFsaWRhdGVfdW5sb2NrKGlub2RlLT5pX21hcHBpbmcpOwo+ID4gKyAgICAgICAgICAg
ICBmMmZzX3VwX3dyaXRlKCZGMkZTX0koaW5vZGUpLT5pX2djX3J3c2VtW1dSSVRFXSk7Cj4gPiAr
ICAgICB9Cj4gPiArCj4gPiAgICAgICByZXR1cm4gZXJyOwo+ID4gICB9Cj4gPgo+CgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZl
bCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZl
bAo=
