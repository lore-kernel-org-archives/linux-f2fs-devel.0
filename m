Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2B1C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1ZCtNlFLAMLFpVh6goUljM9QJO9W+ACe/095nipdHI=; b=LSX/wYnRU8f7DedCksNrxflqoI
	8Gupos8Iz4ddfsPm8zjYddXay18XW14Yw35qhE/MBGlTOHaO072XxWBA/xuq8AvOo0QqQ6rqk/85n
	siK7AN3LAqFhpAgKIHPyKyj+Owsa8Ktl3M74SMl+UyRXOk9VYk0gHZz/O++BXEiJqTF4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wp7SR-0006cF-VE;
	Wed, 29 Jul 2026 16:48:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wp7Rz-0006bu-Lr
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:48:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wbE/HHXqrknyfciJTbHonlTVVSwQ8XK+Z7Va6NzB/wQ=; b=jcmxyQvU7c3muArcPFriO0q+ZL
 dPITLwh67XcEnQTryPsF+2GfjBBJFp0AOIAlmNRrBt7lJNPdH2CYeihO8UtjTgcsRQgBsyNpsZccn
 AAE0NeuCS8YYT1uxf0Ft0IkKzUGvbhpomaRjNb/ab2hmcJPOg1FfBgYeJm6xYjzHpZ40=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wbE/HHXqrknyfciJTbHonlTVVSwQ8XK+Z7Va6NzB/wQ=; b=SQCaALXykaLzPFYRN/ThA3IKir
 mahLde9A6ATsVQTXQmbpiz7r6pe+GOX28gL9TtyKp48f0aujQUi6f7/oYEnAVQoJXO1rdCHgjuPJH
 xT9mWQeZkqwYzuNAosp0ylcUCPtSBs+5ZM1CkJcsnywfGLzzx3o+4y0Oi4aDS1q3Mqto=;
Received: from mail-lf1-f49.google.com ([209.85.167.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp7Ry-0003du-06 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:48:09 +0000
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5b2a4359d16so1173927e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 09:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785343680; cv=none;
 d=google.com; s=arc-20260327;
 b=U3EY8iPLyy4vMGGh+8BpJw3TJZWOoKGsn54TimoT1xFfWtVdh/Jsdmbbj/AGOPWbR+
 5nenzav4ke4eQfpgElfNOwwVqrR5orZpbGLk3TlKz75cAQjex2g0UfM3z84aCgP5QWG4
 19FXqgAj1wXWk86P422v7/6lTOXGDO/PHMjRUr5AfxVkbQaBmy3+KTiNSIslpactfuw6
 yT7kq62kMNcUXga8wlLRImpZpMlpcJERIXHqrW0whqTv66/a6ckf/rMFTw9zbtl2pCQ1
 U67xLTDhZisw7DOFqdkORr+OS9RF7LkNBkIyOA3nxz7+AwRAgWObVMPxhtEQ9KpKBjcl
 sMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wbE/HHXqrknyfciJTbHonlTVVSwQ8XK+Z7Va6NzB/wQ=;
 fh=RSj4nr1iD3zBpe2Y7On8Fx7CE4d8f6Xtv/FcvBoda34=;
 b=H1U4opjCQhl1FZnTXGHLf27oTpHtAPjaH3/3DTvG7ppE/X4EBMlfxgBhCMu3no//yQ
 CHCyQTMiMcjxYJPlTlVxOeBlQ4PRiPHY1lKxZt5w9mJ0s05E9K2oXbqPQxXhtSTeDI2F
 gi2nW+2bTmHaEMLq6co0Opm9TnM1zC4ReJCNDPJywwc3/7ir0eL2vnCIhlhOoicEzFUN
 kA+vtm9qz0taLMbxa1uUG8cBdmyCmvs703yIRnmtHhzCnpZUd97kRFUege9OKgYJYhln
 0Pf2XZ7++p5xcg/8J3X8a81GoSK0ALXFs1gM8chYGAhty4D2bAxcDU10exNAfG7mzrBe
 feqw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785343680; x=1785948480; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wbE/HHXqrknyfciJTbHonlTVVSwQ8XK+Z7Va6NzB/wQ=;
 b=irgf1J+7xl0oQ/mKsPtP6GGhCF1mMpwzPci8zHHjAMz6daEmBLz4EH5S1fWMwZgovK
 yKod1on4kBU0kIZeSJq4CKhKY6Pwl5+sLi8SU9qkmxO/jdxiX651D+z6h4QEkuVSK0Gu
 e7Xa0zmqNvYBow1qqQAO4jN3ty8xclaGhZqRipsU8TXC4Lj8qKvQJkFg/JwlL3IrFFR3
 CQWB1vf02dd9JuYL3Z8WtyCfH/7+GGs1FydYuWWqtTFOSkLALXs39QDB21c3+fNe7dOq
 Eusc3KhIhAUY+eoN4G7TA5AIEsiO5kTxVyOJTGc7MVI8QeOybERiKjeyF/X7tl51RoKY
 N0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785343680; x=1785948480;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wbE/HHXqrknyfciJTbHonlTVVSwQ8XK+Z7Va6NzB/wQ=;
 b=DygJ2GOpQ8Wi9w6LztIdM5hY51U9MYjKc3NtI4sH+hOea+REvNFkYsTgehILFKv/SF
 p5ELoTI8W6zgQsLv9mDnUtu38IJBFMwoSHGfsuj0zIbi3AVoG5KNGCCYkYPpwzfme6rj
 YbJx4JoU7WHtGybWKBQGQVpGYtcai3bw3q2k5vOa4RtTjE1M2gn834Uq7fr53GCcDGdd
 RorM1Cv0zXUhdjfGF2naumZjZFYDGigSrgpZ+Cv572Uw8cIywELdVVuFZ3KWJ7vTgxCV
 +p25g8gfdGT/VngbZMKJkFNExkIeaSB7bhoQXxFJVlVUtOLV9aFg3m5tx7V4ZmfqoVx7
 xuRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro78KAkimKvKVT4OXMhFt/CVU2KfG880/umM2WMLgO95oHXH1hGCEfujjSYhlK7ySMWFVaKL7qVCGVOkA9yD0wl@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxPI4svrFkPRXMh22OiuuF6TE0Sv2oENwhSX0rPuifREy7pn252
 KzPXV5xVHhuTDvtaGHGwaoKgmKlg0zl9l4USjKcvdXMIoJW5Vk3HHiOasXorozR2eZGvK051js0
 m3Rv+tmcGdsHws7PIzB21p6nkqM9fflE=
X-Gm-Gg: AR+sD13JG2VDnBcBTIsZRN6y4b82rldhoAZk1x43mePnu44ZnvKCDHU5kbKLG0gfrFH
 R9o5HK7gXYXcncrZgm8sK5f1jbe1iU3OixTynnKkwtyfoo2ONZvr6JQEY9XhBW/ZeJfBt012NdO
 SRlu/utGkZRRkp1VBFCptXtatcZmlwRmLdUMvgEFZeN6P9IrYkq7jSjQ09+klSUV5O1F20W8mpH
 NfhaisXURbglCdS8u7z8GTT+Mc1ighJ/pXl5JUxBJrZd2O2+8LkT3Tfk/sv82EkaetnUIyGNDEm
 ccJWN3G02ddAUa9UXlY+X4MQLrqTLiZdWB8mODYmuM5OZ/E7938jNZWCWzdv3SUijvhhV+1iwYL
 2OR+Jvw+cRiW5veTt9J76COFIQqn3MglV
X-Received: by 2002:a05:6512:1324:b0:5b2:9f9c:4634 with SMTP id
 2adb3069b0e04-5b2d0253d83mr1742905e87.45.1785343679473; Wed, 29 Jul 2026
 09:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260723202008.2581659-1-daeho43@gmail.com>
 <f643492e-b31d-48d4-a721-329c62db42d3@kernel.org>
In-Reply-To: <f643492e-b31d-48d4-a721-329c62db42d3@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 29 Jul 2026 09:47:46 -0700
X-Gm-Features: AUfX_mz3U4FZgIFrWGqSp9zd9zELSVEN0rXYDAp1qCKj1k2w-iDEyAfFlQbm9JY
Message-ID: <CACOAw_yL9ZaJyY5sG6qycYVTADcKPkH0dKJsiQPwO1WH3iDjLw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wp7Ry-0003du-06
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: support dynamic reserve/release for
 device aliasing
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

T24gV2VkLCBKdWwgMjksIDIwMjYgYXQgNDo0NOKAr0FNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiA3LzI0LzI2IDA0OjIwLCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IEZy
b206IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gPgo+ID4gVGhpcyBwYXRj
aCBhZGRzIGEgZHluYW1pYyBtYW5hZ2VtZW50IGZlYXR1cmUgdG8gdGhlIGV4aXN0aW5nIGRldmlj
ZQo+ID4gYWxpYXNpbmcgZnVuY3Rpb25hbGl0eS4gSXQgYWxsb3dzIHVzZXJzIHRvIGR5bmFtaWNh
bGx5IHJlc2VydmUgb3IKPiA+IHJlbGVhc2Ugc3BlY2lmaWMgZGV2aWNlcyBmcm9tIHRoZSBmaWxl
c3lzdGVtJ3MgZnJlZSBwb29sIGF0IHJ1bnRpbWUKPiA+IHRocm91Z2ggbmV3IGlvY3Rscy4KPiA+
Cj4gPiBUbyBzdXBwb3J0IHRoaXMsIHRocmVlIG5ldyBpb2N0bHMgYXJlIGludHJvZHVjZWQ6Cj4g
PiAtIEYyRlNfSU9DX1JFU0VSVkVfREVWX0FMSUFTOiBUaGlzIHJlY2xhaW1zIHRoZSBzcGFjZSBv
Y2N1cGllZCBieSBhCj4gPiAgIGRldmljZSBhbGlhc2luZyBmaWxlLiBJdCBmaXJzdCBwZXJmb3Jt
cyBhIGNhcGFjaXR5IGNoZWNrLCByZXNldHMgR0MKPiA+ICAgdmljdGltIGluZm9ybWF0aW9uIGZv
ciB0aGUgdGFyZ2V0IHJhbmdlLCBtYXJrcyB0aGUgc2VnbWVudHMgYXMgaW4tdXNlCj4gPiAgIHRv
IHByZXZlbnQgbmV3IGFsbG9jYXRpb25zLCBhbmQgdGhlbiB0cmlnZ2VycyBHQyB0byBtaWdyYXRl
IGV4aXN0aW5nCj4gPiAgIHZhbGlkIGRhdGEgb3V0IG9mIHRoZSByYW5nZS4gRmluYWxseSwgaXQg
cmVzZXJ2ZXMgdGhlc2UgYmxvY2tzIGluIHRoZQo+ID4gICBTSVQgdG8gZWZmZWN0aXZlbHkgZXhj
bHVkZSB0aGUgZGV2aWNlIGZyb20gdGhlIHVzYWJsZSBjYXBhY2l0eS4KPiA+Cj4gPiAtIEYyRlNf
SU9DX1JFTEVBU0VfREVWX0FMSUFTOiBUaGlzIHJlbGVhc2VzIHRoZSByZXNlcnZlZCBzcGFjZSBv
ZiBhCj4gPiAgIHByZXZpb3VzbHkgcmVzZXJ2ZWQgZGV2aWNlIGFsaWFzaW5nIGZpbGUuIEl0IHRy
dW5jYXRlcyB0aGUgYmxvY2tzCj4gPiAgIGFzc29jaWF0ZWQgd2l0aCB0aGUgZmlsZSwgd2hpY2gg
bWFrZXMgdGhlbSBhdmFpbGFibGUgZm9yIGdlbmVyYWwKPiA+ICAgZmlsZXN5c3RlbSBhbGxvY2F0
aW9uIGFnYWluLgo+ID4KPiA+IC0gRjJGU19JT0NfR0VUX0RFVl9BTElBU19TVEFUVVM6IFRoaXMg
cmV0cmlldmVzIHRoZSBjdXJyZW50IGFsaWFzaW5nCj4gPiAgIHN0YXR1cyBvZiBhIGRldmljZSBh
bGlhc2luZyBmaWxlLCByZXR1cm5pbmcgd2hldGhlciB0aGUgZmlsZSBpcwo+ID4gICByZWxlYXNl
ZCAoaW5hY3RpdmUgYWxpYXMpIG9yIHJlc2VydmVkIChhY3RpdmUgYWxpYXMsIHdpdGggYmxvY2tz
Cj4gPiAgIGZ1bGx5IGFsbG9jYXRlZCBvbiB0aGUgZGV2aWNlKS4KPgo+IEhpIERhZWhvLAo+Cj4g
QlRXLCBjb3VsZCB5b3UgcGxlYXNlIGNvbnNpZGVyIHRvIGRvIHNvbWUgY292ZXJhZ2UgdGVzdCB0
byBwcmV2ZW50IGZyb20KPiBzdWZmZXJpbmcgcG90ZW50aWFsIGNvcnJ1cHRpb24uCj4KPiBlLmcu
Ogo+IDEuIGNhbGwgaW9jdGxzIGluIGxvdyBzdG9yYWdlIGVudmlyb25tZW50Cj4gMi4gcmFjZSB3
LyBjaGVja3BvaW50PXtkaXNhYmxlLGVuYWJsZX0KPiAzLiBpbmplY3RpbmcgZmF1bHRzIGluIG5l
dyBpb2N0bHMgKyByYW5kb20gc2h1dGRvd24KPgo+IFRvIHZlcmlmeSBpZiBmaWxlc3lzdGVtIG9y
IGRldmljZSBhbGlhcyBmaWxlIGlzIGNvcnJ1cHRlZCwgaXQgbmVlZHMgdG8KPiBjYWxsIGZzY2sg
YWZ0ZXIgdGhlIHRlc3RjYXNlLCBhbmQgZmluZCBhIHdheSB0byB2ZXJpZnkgd2hldGhlciBkZXZp
Y2UgYWxpYXMKPiBzdGF0dXMgaXMgYXMgZXhwZWN0ZWQgb3Igbm90Lgo+Cj4gUGxlYXNlIHNoYXJp
bmcgeW91ciB0aG91Z2h0cyBhYm91dCB0aGlzLiA6KQoKVGhhbmtzIGZvciB0aGUgZ3JlYXQgc3Vn
Z2VzdGlvbnMhCgpDdXJyZW50bHksIG15IGludGVybmFsIHRlc3QgY2FzZSBjb3ZlcnM6CgoxLiBQ
aW5uZWQgZmlsZSBhbGxvY2F0aW9uIGV4Y2x1c2lvbiB2ZXJpZmljYXRpb24gYWdhaW5zdCByZXNl
cnZlZApkZXZpY2UgYWxpYXNpbmcgcmFuZ2UuCjIuIFN0cmVzcyB0ZXN0IHVuZGVyIGZzc3RyZXNz
ICsgY29uY3VycmVudCBDUC9zeW5jICsgYXN5bmNocm9ub3VzIFNQTwooU3VkZGVuIFBvd2VyIE9m
Zikgc2h1dGRvd25zLCBmb2xsb3dlZCBieSBmc2NrICYga2VybmVsIHBhbmljIGNoZWNrcy4KMy4g
RU5PU1BDIGVycm9yIHJvbGxiYWNrIHZlcmlmaWNhdGlvbiB3aGVuIHN0b3JhZ2UgaXMgMTAwJSBm
dWxsLgoKQmFzZWQgb24geW91ciBmZWVkYmFjaywgSSBhZ3JlZSB3ZSBzaG91bGQgZXhwYW5kIHRo
ZSB0ZXN0IGNvdmVyYWdlLiBJCndpbGwgZW5oYW5jZSB0aGUgdGVzdCBjYXNlIChvciBhZGQgc3Vi
LXRlc3RzKSB0byBjb3ZlcjoKMS4gUmFjZSBjb25kaXRpb24gdGVzdGluZyBiZXR3ZWVuIG5ldyBp
b2N0bHMgYW5kCmNoZWNrcG9pbnQ9e2Rpc2FibGUsZW5hYmxlfSByZW1vdW50cywgdmVyaWZ5aW5n
IC1FSU5WQUwgcmVzcG9uc2VzCmR1cmluZyBjaGVja3BvaW50PWRpc2FibGUuCjIuIEVuYWJsaW5n
IEYyRlMgZmF1bHQgaW5qZWN0aW9uIHRvIG5ldyBpb2N0bHMuCgpUaGFua3MhCgoKPgo+IFRoYW5r
cywKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mMmZzLWRldmVsCg==
