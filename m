Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4049BC5478C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:34:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1regkX-0000wG-Vf;
	Mon, 26 Feb 2024 19:34:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1regkW-0000w5-Qk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 19:34:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OglrNgb8KxWqpi2oIRKvGycThhSHWIKrWgrygyi4MtM=; b=OWP+3YSFCERe3CbMDMqV+o/ZXA
 LRuG4XHtamv6LRg2sacZgGcHWYDtPvciKLvzhi+THdUtiTWuO7NSqjRtFBPAJbz3mXOnmBgvE0i2q
 +r9E5RJ5OcfFTKT8Sx7Gm/ORID9fQzaNZ1uuOUTDBUEZo1v4xvLVXss9uTbuJuIaS3Do=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OglrNgb8KxWqpi2oIRKvGycThhSHWIKrWgrygyi4MtM=; b=agC1LFZTQ3v6RIgSyxUatQoKbO
 0FVlXFeX2jtoZ49ZjjT7KzG/81oDafGb25Ez4veDvwwokVV7E+znNXPgh/+VmRlF6m72Auij2JHaQ
 s/c7pK9vJ2f5hy85a7Saser90iqO6idfAs6MKiGBE3Poszxjh1zhvzrtM1lts4xRSlvU=;
Received: from mail-ua1-f43.google.com ([209.85.222.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1regkS-0000eV-Tr for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 19:34:53 +0000
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-7d5bddb0f4cso1371853241.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Feb 2024 11:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708976078; x=1709580878; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OglrNgb8KxWqpi2oIRKvGycThhSHWIKrWgrygyi4MtM=;
 b=favueeFklakFfRGcVdDgmqFlQ/MZoWMqMoTdNt8Kn8HL1W6IJSklLVwVukLvxER/Ju
 s6Qh9sf2xZlf74oe5bDpT9/9m2Ge/ei9FTXz6NqL7lFoMBKyREzivgr8cBwFzAElJ/RQ
 MiFriQQ7QSU6sIiJUBhwDqKYWv+s3Mvry4gvY8ufmVWSl/iPzkb0sJdL7rIBz4TzMZRQ
 enKUdXVnqPfapamQw7Gq7GXe9Zz9mY2MFJJwJmG0/i76yYzpIWYd+kNupqIvXwohKL/Q
 7goB90CJAr3MXU2wan76zOaz8kFIL4BDeXzPaAKtZwJjPIJbVFYpn//wp03qT0JejQFu
 oR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708976078; x=1709580878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OglrNgb8KxWqpi2oIRKvGycThhSHWIKrWgrygyi4MtM=;
 b=aRZRIzIIsyRdTtgCceGXxWd6aLn36l8T8Gbq8pAytBl2Tl5wdPN+llYRYOEDJGvliO
 oYVCDyOq2/MDb3vSy8Mr/SdSznB5Dsxh3TduCszqO5Qu/L37yPp1Wy5g8UQH1/op2Rua
 YF/jb9oN07xc9cHETvpVCmFaGNuGOuUFEbO8hcmUl8vPKL04o0V/4SBW2h6O8qpOQPyt
 eoCzUov3o6s4WsxUfDTgY0a8fG2l+TKzkQNA9qvr3yBeC7DwnDPho4893DLYNEVECUsv
 2CS68RUxtCkVcqgmlZm2p3dcWZUQoqhLejqfB6i2c6QE9sXR2B1AG/bf9Ac/LaxSLq03
 3TkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLCR2sFU1tn9S8MmhtCZMVfr5kOH30muqFA/s2bY52NILQGfHLd+lbZnOCVJMQMjozZYwiOLjXx7O3HKuaofCyrq3M8QNVaZVBO4y1fxPw4SC87vq1Qg==
X-Gm-Message-State: AOJu0YzW81pNyajQjLdM1SVewKoRUb/UfOR1V79IGndW1u2DTM0S4xDc
 JL66fwnnGrTaWSMklFYDUtav7RVQ/IQ68c9QZxH5q27jbe0ZqKo7qKuC7De82RalQgoTa8lhcTE
 1zyD4VdEVc6Y9k3jNbN7cp1aO+kXmmzy9
X-Google-Smtp-Source: AGHT+IFRbmLcH3yDVMWlS4qRhMIzTge8OdpmN7IXcrrJAEBTH5t6Buk71GP4NesYll77VpA88EfVMoNzZG/5LoYJ3VA=
X-Received: by 2002:a1f:c784:0:b0:4c9:a9c9:4b3b with SMTP id
 x126-20020a1fc784000000b004c9a9c94b3bmr4166189vkf.9.1708976077978; Mon, 26
 Feb 2024 11:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-5-jaegeuk@kernel.org>
In-Reply-To: <20240223205535.307307-5-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 26 Feb 2024 11:34:27 -0800
Message-ID: <CACOAw_xdBY5Rg1J4jUTaH0UxVrdZ+CCVQj72q_cMxyCHuCTy_Q@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1regkS-0000eV-Tr
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: allow to mount if cap is 100
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBGZWIgMjMsIDIwMjQgYXQgMTI6NTbigK9QTSBKYWVnZXVrIEtpbSA8amFlZ2V1a0Br
ZXJuZWwub3JnPiB3cm90ZToKPgo+IERvbid0IGJsb2NrIG1vdW50aW5nIHRoZSBwYXJ0aXRpb24s
IGlmIGNhcCBpcyAxMDAlLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFlZ2V1ayBLaW0gPGphZWdldWtA
a2VybmVsLm9yZz4KPiAtLS0KPiAgZnMvZjJmcy9zZWdtZW50LmMgfCAzICsrKwo+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zZWdtZW50
LmMgYi9mcy9mMmZzL3NlZ21lbnQuYwo+IGluZGV4IDZkNTg2YWU4YjU1Zi4uZjExMzYxMTUyZDJh
IDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvc2VnbWVudC5jCj4gKysrIGIvZnMvZjJmcy9zZWdtZW50
LmMKPiBAQCAtOTA0LDYgKzkwNCw5IEBAIGludCBmMmZzX2Rpc2FibGVfY3BfYWdhaW4oc3RydWN0
IGYyZnNfc2JfaW5mbyAqc2JpLCBibG9ja190IHVudXNhYmxlKQo+ICB7Cj4gICAgICAgICBpbnQg
b3ZwX2hvbGVfc2VncyA9Cj4gICAgICAgICAgICAgICAgIChvdmVycHJvdmlzaW9uX3NlZ21lbnRz
KHNiaSkgLSByZXNlcnZlZF9zZWdtZW50cyhzYmkpKTsKPiArCj4gKyAgICAgICBpZiAoRjJGU19P
UFRJT04oc2JpKS51bnVzYWJsZV9jYXBfcGVyYyA9PSAxMDApCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiAwOwoKV2l0aCB0aGlzLCBmMmZzIHdpbGwgbm90IGV4ZWN1dGUgR0MuIFdoYXQgaXMgdGhp
cyAxMDAKdW51c2FibGVfY2FwX3BlcmMgdXNlZCBmb3I/Cgo+ICAgICAgICAgaWYgKHVudXNhYmxl
ID4gRjJGU19PUFRJT04oc2JpKS51bnVzYWJsZV9jYXApCj4gICAgICAgICAgICAgICAgIHJldHVy
biAtRUFHQUlOOwo+ICAgICAgICAgaWYgKGlzX3NiaV9mbGFnX3NldChzYmksIFNCSV9DUF9ESVNB
QkxFRF9RVUlDSykgJiYKPiAtLQo+IDIuNDQuMC5yYzAuMjU4Lmc3MzIwZTk1ODg2LWdvb2cKPgo+
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
