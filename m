Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CA5E67493
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Nov 2024 03:28:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t6iKh-0007ap-3G;
	Fri, 01 Nov 2024 03:28:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1t6iKg-0007ab-3N
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Nov 2024 03:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R69u2hyNlfGyaoatpAfniwK8rUiF2rXsD+XRzHGuSwU=; b=Qxatpy6s0f/2/Putrh3yOjYtkH
 +ogEwp6vYNYhd85YvS4tRktbKqjk6l5GiL9WMvmWGQu0pH2+NFAv/mDovq0gO1hp/zoKce1NeGdFe
 i41g192OXp84bthTDIPcahPThmwbD9elMebclWEie1w2eeCHuWxaLB9iH0S1w/eh7E9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R69u2hyNlfGyaoatpAfniwK8rUiF2rXsD+XRzHGuSwU=; b=YvzXo8kqYripX0lCzenXz0YQ7y
 8ydn3NioK95Q/vp4fEUBL3ftieBlXRfLMdljya/13bkjrWvyje03q3RvsLa4grL5yxN7Se/+RZmxt
 /3sW5qjhSoWpXys34qgxz2JPpJD+a07jkSgZPXMME633MdGZ4fISpO6oX+kTNvFf6lEg=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1t6iKf-0005Dc-BK for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Nov 2024 03:28:18 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-43160c5bad8so1733095e9.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 31 Oct 2024 20:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730431686; x=1731036486; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R69u2hyNlfGyaoatpAfniwK8rUiF2rXsD+XRzHGuSwU=;
 b=QfW9dttg2zpoMMJNtTXuamf9IAEtYlaiu/B1I09HGTH6iqHBPfc53Pz7dTgFsYUE5t
 B2J3/TxYg8A++LyEYmobDL6K0C9SJZhgBboxHumAuuf1mQoER95BfRT7JU9g2C/6/Jdy
 NII9ieJz6v2kGJe58gILwfh4UAcJpvk0f8lzka2tQ6vRzg+xpSjlGuwYBfrFXeFgDyZR
 iwRtBksSkd4okyEQzATvJYMUYefKRYE4CTOVVVJsK1vkw1kUAp5oDnKR9E1WoWizbK6E
 c3tgzE4yj3KsvsSVEg4Ccr5Bav5F0215820yHy6XRUHvUcp01e0JDDl7W99k+/STFdrZ
 r19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730431686; x=1731036486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R69u2hyNlfGyaoatpAfniwK8rUiF2rXsD+XRzHGuSwU=;
 b=iaZWiPliskxfFIo61xuOqTeLqfJEuOFwO3ErdNN6drkXT0VDi0n2JzsqouT1QKv+rx
 wIFD8ka2Lu4xNKb9unm+NzGpvdXIhEwt+7JdEktm+DI2dN/nvESggLS1r9ZgTOms2c8g
 P6TxpoaxAXFH+ntbUFMyFqi3VLVvdMHz1Oh9AvLIb+f90KTTvz1hGwiU0zEWrOzWrU+w
 BwoSQeMNRqcXCIRYRbrfwyJY/Frl8VwikcO/X3s3v7vLArpxwmPxUxNmz/GlSzGHtxqF
 F0scuaPzSvmM2ns/e4RxzlLjMx3kerFvDOBsIAb+5GPtrd4qOGBWzz4lGRenl3hozBJ3
 wPPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0sRloN9If92jQH2snWrIxTv3w2LPalzpjdbGR2uf56Vxhpu6AZ5ZX13BqZHaB+fvjCBHbTWqTcg/L4m6SoeZh@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwZMA+FAzq93znuAGhbp7+vHQD2mURscLDefwfNATp0w6OfS1O8
 1SRh+Q+92vp3k+Tctl5DBXh3G2EitumZ8dP+QVeDMJ+lG37/Hrm3P2i3s+FlUqDt6MmFJItr8ah
 i2LouaYL0YSNpchKQ/0hDmzT756dL+j5T
X-Google-Smtp-Source: AGHT+IFWLFV4lDauR2C969+HY4kc7dpyP0D2vWx1p98BhFczoh9gS9oRbhT+EdPhMXeniKq8vgqte3kz8rR4HUj9znI=
X-Received: by 2002:a05:6000:401f:b0:37d:4ca3:310f with SMTP id
 ffacd0b85a97d-3806125dea6mr7442966f8f.12.1730431685362; Thu, 31 Oct 2024
 20:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
 <1730354393-19672-2-git-send-email-zhiguo.niu@unisoc.com>
 <bf348748-46ba-47dd-a12d-5111be2df95e@kernel.org>
In-Reply-To: <bf348748-46ba-47dd-a12d-5111be2df95e@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 1 Nov 2024 11:27:53 +0800
Message-ID: <CAHJ8P3+VY6RYgrCPJRSjJp82qJaYGUyqR3vV3OGRO_Q774qxxw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1t6iKf-0005Dc-BK
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix to adjust appropriate length
 for fiemap
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 jaegeuk@kernel.org, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiDkuo4yMDI05bm0MTHmnIgx5pel5ZGo5LqUIDEwOjM2
5YaZ6YGT77yaCj4KPiBPbiAyMDI0LzEwLzMxIDEzOjU5LCBaaGlndW8gTml1IHdyb3RlOgo+ID4g
SWYgdXNlciBnaXZlIGEgZmlsZSBzaXplIGFzICJsZW5ndGgiIHBhcmFtZXRlciBmb3IgZmllbWFw
Cj4gPiBvcGVyYXRpb25zLCBidXQgdGhpcyBzaXplIGlzIG5vbi1ibG9jayBzaXplIGFsaWduZWQs
Cj4gPiBpdCB3aWxsIHNob3cgMiBzZWdtZW50cyBmaWVtYXAgcmVzdWx0cyBldmVuIHRoaXMgd2hv
bGUgZmlsZQo+ID4gaXMgY29udGlndW91cyBvbiBkaXNrLCBzdWNoIGFzIHRoZSBmb2xsb3dpbmcg
cmVzdWx0cywgcGxlYXNlCj4gPiBub3RlIHRoYXQgdGhpcyBmMmZzX2lvIGhhcyBiZWVuIG1vZGlm
aWVkIGZvciB0ZXN0aW5nLgo+ID4KPiA+ICAgLi9mMmZzX2lvIGZpZW1hcCAwIDE5MzA0IHlsb2cv
YW5hbHl6ZXIucHkKPiA+IEZpZW1hcDogb2Zmc2V0ID0gMCBsZW4gPSAxOTMwNAo+ID4gICAgICAg
ICAgbG9naWNhbCBhZGRyLiAgICBwaHlzaWNhbCBhZGRyLiAgIGxlbmd0aCAgICAgICAgICAgZmxh
Z3MKPiA+IDAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDIwYmFhMDAwIDAwMDAwMDAw
MDAwMDQwMDAgMDAwMDEwMDAKPiA+IDEgICAgICAgMDAwMDAwMDAwMDAwNDAwMCAwMDAwMDAwMDIw
YmFlMDAwIDAwMDAwMDAwMDAwMDEwMDAgMDAwMDEwMDEKPiA+Cj4gPiBhZnRlciB0aGlzIHBhdGNo
Ogo+ID4gICAuL2YyZnNfaW8gZmllbWFwIDAgMTkzMDQgeWxvZy9hbmFseXplci5weQo+ID4gRmll
bWFwOiBvZmZzZXQgPSAwIGxlbiA9IDE5MzA0Cj4gPiAgICAgICBsb2dpY2FsIGFkZHIuICAgIHBo
eXNpY2FsIGFkZHIuICAgbGVuZ3RoICAgICAgICAgICBmbGFncwo+ID4gMCAgICAgMDAwMDAwMDAw
MDAwMDAwMCAwMDAwMDAwMDMxNWYzMDAwIDAwMDAwMDAwMDAwMDUwMDAgMDAwMDEwMDAKPgo+IFdo
eSBpcyBGSUVNQVBfRVhURU5UX0xBU1QgbWlzc2luZyBpbiAjMCBleHRlbnQ/IEFzIHdlIGNhbiBz
ZWUgaXQKPiBpbiAjMSBleHRlbnQgYmVmb3JlIHlvdXIgY2hhbmdlLgpIaSBDaGFvLApmb3Igbm9y
bWFsIGZpZW1hcCwgd2UganVzdCAgY2FuIHRhZyAgRklFTUFQX0VYVEVOVF9MQVNUIGluIHRoZSBm
b2xsb3dpbmc6CgovKiBIT0xFICovCmlmICghY29tcHJfY2x1c3RlciAmJiAhKG1hcC5tX2ZsYWdz
ICYgRjJGU19NQVBfRkxBR1MpKSB7CnN0YXJ0X2JsayA9IG5leHRfcGdvZnM7CgppZiAoYmxrc190
b19ieXRlcyhpbm9kZSwgc3RhcnRfYmxrKSA8IGJsa3NfdG9fYnl0ZXMoaW5vZGUsCm1heF9pbm9k
ZV9ibG9ja3MoaW5vZGUpKSkKZ290byBwcmVwX25leHQ7CgpmbGFncyB8PSBGSUVNQVBfRVhURU5U
X0xBU1Q7Cn0KYnV0IGFmdGVyIHRoaXMgcGF0Y2gsIGlmIGZpbGUgbGVuZ3RoID0gMTkzMDQsIGJs
ayBsZW4gPTUocGFnZSBzaXplPTQwOTYpLAphbmQgZjJmc19tYXBfYmxvY2tzIHdpbGwgcnVuIG9u
Y2UgaWYgdGhlIGZpbGUgaXMgIGNvbnRpZ3VvdXMgb24gZGlzaywKYW5kIHdpbGwgdGFnCkYyRlNf
TUFQX0ZMQUdTIHRvIG1hcC5tX2ZsYWdzLCBzbyB0aGUgZm9sbG93aW5nIGNhc2Ugd2lsbCBub3Qg
cnVuLgp0aGVuCgppZiAoc2l6ZSkgewpmbGFncyB8PSBGSUVNQVBfRVhURU5UX01FUkdFRDsKaWYg
KElTX0VOQ1JZUFRFRChpbm9kZSkpCmZsYWdzIHw9IEZJRU1BUF9FWFRFTlRfREFUQV9FTkNSWVBU
RUQ7CgpyZXQgPSBmaWVtYXBfZmlsbF9uZXh0X2V4dGVudChmaWVpbmZvLCBsb2dpY2FsLApwaHlz
LCBzaXplLCBmbGFncyk7CnRyYWNlX2YyZnNfZmllbWFwKGlub2RlLCBsb2dpY2FsLCBwaHlzLCBz
aXplLCBmbGFncywgcmV0KTsKaWYgKHJldCkKZ290byBvdXQ7CnNpemUgPSAwOwp9CmZpZW1hcF9m
aWxsX25leHRfZXh0ZW50IHdpbGwgcmV0dXJuIDEsIHRoZW4gZ28gb3V0ICwgdGhpcyBmaWVtYXAg
ZmxvdyBmaW5pc2hlcy4KCj4KPiAxICAgICAgIDAwMDAwMDAwMDAwMDQwMDAgMDAwMDAwMDAyMGJh
ZTAwMCAwMDAwMDAwMDAwMDAxMDAwIDAwMDAxMDAxCmJ1dCBiYWNrIHRvIHRoaXMgY2FzZSwgYmVj
YXVzZQoKbmV4dDoKbWVtc2V0KCZtYXAsIDAsIHNpemVvZihtYXApKTsKbWFwLm1fbGJsayA9IHN0
YXJ0X2JsazsKbWFwLm1fbGVuID0gYnl0ZXNfdG9fYmxrcyhpbm9kZSwgbGVuKTsKbWFwLm1fbmV4
dF9wZ29mcyA9ICZuZXh0X3Bnb2ZzOwptYXAubV9zZWdfdHlwZSA9IE5PX0NIRUNLX1RZUEU7Cgpt
YXAubV9sZW4gd2lsbCBub3QgIHJlZHVjZSB0aGUgcGFydCB0aGF0IGhhcyBiZWVkIG1hcGVkIGV2
ZW4gbWFwLm1fbGJrCmhhcyBjaGFuZ2VkLApmb3IgZXhhbXBsZSwgaWYgZmlsZSBsZW5ndGggPSAx
OTMwNCwgYmVmb3JlIHBhdGNoLCBtYXAubV9sZW49NCwKYWZ0ZXIgb25jZSBmMmZzX21hcF9ibG9j
aywgIG1hcC5tX2xiaz00LCBtYXAubV9sZW4gc3RpbGwgPTQsIHNvCnRoZXJlIHdpbGwgYmUgIkhP
TEUiIGNhc2UgaW4gdGhlIGZvbGxvdy11cCBmMmZzX21hcF9ibG9jawpzbyBpdCB3aWxsIGxvb3Ag
dW50aWwgc3RhcnRfYmxrIHJlYWNoZXMgdGhlIG1heGJ5dGVzLgovKiBIT0xFICovCmlmICghY29t
cHJfY2x1c3RlciAmJiAhKG1hcC5tX2ZsYWdzICYgRjJGU19NQVBfRkxBR1MpKSB7CnN0YXJ0X2Js
ayA9IG5leHRfcGdvZnM7CgppZiAoYmxrc190b19ieXRlcyhpbm9kZSwgc3RhcnRfYmxrKSA8IGJs
a3NfdG9fYnl0ZXMoaW5vZGUsCm1heF9pbm9kZV9ibG9ja3MoaW5vZGUpKSkKZ290byBwcmVwX25l
eHQ7CgpmbGFncyB8PSBGSUVNQVBfRVhURU5UX0xBU1Q7Cn0KCnRoZXJlIGlzIGFub3RoZXIgY2Fz
ZSBiZWZvcmUgdGhpcyBwYXRjaCwgZmlsZSBzaXplID0gNSBibG9ja3MsIGlmIHdlCnBhc3MgdGhl
IGxlbiBub3QKZ3JlYXRlciB0aGFuIG9yIGVxdWFsIHRvIDXvvIwgaXQgd2lsbCBub3QgdGFnIEZJ
RU1BUF9FWFRFTlRfTEFTVAoKICMgLi9mMmZzX2lvX25ldyBmaWVtYXAgMCA0IGZpbGUuYXBrCkZp
ZW1hcDogb2Zmc2V0ID0gMCBsZW4gPSA0CiAgICAgICAgbG9naWNhbCBhZGRyLiAgICBwaHlzaWNh
bCBhZGRyLiAgIGxlbmd0aCAgICAgICAgICAgZmxhZ3MKMCAgICAgICAwMDAwMDAwMDAwMDAwMDAw
IDAwMDAwMDA3MGUwOGYwMDAgMDAwMDAwMDAwMDAwNDAwMCAwMDAwMTAwOAoKYnV0IGlmIGxlbiBl
cXVhbCBvciBncmVhdGVyIHRoYW4gNSwgICBpdCB3aWxsIHRhZyBGSUVNQVBfRVhURU5UX0xBU1QK
ICMgLi9mMmZzX2lvX25ldyBmaWVtYXAgMCA1IGZpbGUuYXBrCkZpZW1hcDogb2Zmc2V0ID0gMCBs
ZW4gPSA1CiAgICAgICAgbG9naWNhbCBhZGRyLiAgICBwaHlzaWNhbCBhZGRyLiAgIGxlbmd0aCAg
ICAgICAgICAgZmxhZ3MKMCAgICAgICAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDA3MGUwOGYwMDAg
MDAwMDAwMDAwMDAwNDAwMCAwMDAwMTAwOAoxICAgICAgIDAwMDAwMDAwMDAwMDQwMDAgMDAwMDAw
MDcwZTA5MDAwMCAwMDAwMDAwMDAwMDAxMDAwIDAwMDAxMDAxCnRoYW5rcyEKPgo+IFRoYW5rcywK
Pgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFpoaWd1byBOaXUgPHpoaWd1by5uaXVAdW5pc29jLmNv
bT4KPiA+IC0tLQo+ID4gZjJmc19pbyBoYXMgYmVlbiBtb2RpZmllZCBmb3IgdGVzdGluZywgdGhl
IGxlbmd0aCBmb3IgZmllbWFwIGlzCj4gPiByZWFsIGZpbGUgc2l6ZSwgbm90IGJsb2NrIG51bWJl
cgo+ID4gLS0tCj4gPiAgIGZzL2YyZnMvZGF0YS5jIHwgNCArKy0tCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBh
L2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMKPiA+IGluZGV4IDkwZmE4YWIuLjhjOWJi
NDIgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9mMmZzL2RhdGEuYwo+ID4gKysrIGIvZnMvZjJmcy9kYXRh
LmMKPiA+IEBAIC0xOTY2LDggKzE5NjYsOCBAQCBpbnQgZjJmc19maWVtYXAoc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IGZpZW1hcF9leHRlbnRfaW5mbyAqZmllaW5mbywKPiA+ICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIG91dDsKPiA+ICAgICAgIH0KPiA+Cj4gPiAtICAgICBpZiAoYnl0
ZXNfdG9fYmxrcyhpbm9kZSwgbGVuKSA9PSAwKQo+ID4gLSAgICAgICAgICAgICBsZW4gPSBibGtz
X3RvX2J5dGVzKGlub2RlLCAxKTsKPiA+ICsgICAgIGlmIChsZW4gJiAoYmxrc190b19ieXRlcyhp
bm9kZSwgMSkgLSAxKSkKPiA+ICsgICAgICAgICAgICAgbGVuID0gcm91bmRfdXAobGVuLCBibGtz
X3RvX2J5dGVzKGlub2RlLCAxKSk7Cj4gPgo+ID4gICAgICAgc3RhcnRfYmxrID0gYnl0ZXNfdG9f
Ymxrcyhpbm9kZSwgc3RhcnQpOwo+ID4gICAgICAgbGFzdF9ibGsgPSBieXRlc190b19ibGtzKGlu
b2RlLCBzdGFydCArIGxlbiAtIDEpOwo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
