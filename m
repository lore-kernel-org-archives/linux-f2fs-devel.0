Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E57DC52D7C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:31:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sdZp0-0006Pl-Uc;
	Mon, 12 Aug 2024 18:31:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1sdZow-0006Pb-QA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Aug 2024 18:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rQEBZGkTU3+P5f0XMzJctOCFdX96laEmkow/VkUsFIw=; b=a2PANdRAGpoSGyjeIAqTRtkdKi
 03tO1aIyCDNdo8zHGHByesbzj1R8BkT7W/B+yOUiWhGTddUCKKQCMavhVnG7XfC4hpFOS/Zafv3ob
 uouFe8N3xKr3rLkOZ4VxzsoEnkozAMc6JejnBftkUupxTYmGN0pMpTPJEvWH4NoxvXdU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rQEBZGkTU3+P5f0XMzJctOCFdX96laEmkow/VkUsFIw=; b=IvmpReDXk6kdoc+RBcdCviLukM
 I53WEC1zaumasUA1g3d+4HKfZ1rVWh5yVvp1VojQqSFpvxOKEurGgY8KDmfW7/fIBJ628I2V10qXq
 qAtbxE+CKKxkWKRS5NgREDrM3JnDZiI8lQKGGIE643B2ZFiIcfiAvwAoSsC1X4AIJplc=;
Received: from mail-vk1-f181.google.com ([209.85.221.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sdZow-0003J7-3W for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Aug 2024 18:31:06 +0000
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-4f6be9d13cdso1506565e0c.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Aug 2024 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723487455; x=1724092255; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQEBZGkTU3+P5f0XMzJctOCFdX96laEmkow/VkUsFIw=;
 b=D0eYmSdZh+XIdndzKJ09X5O+t6IL2GopcsV7TBoY7XB9MpLaUU+q5HmDYBRnWdOPeL
 SL3jtqUuEwjezTrnmz0CJehpCUDYkw+zJ4xDUr6U1Akvs3a67f5h5LcKKBy94nGos8rb
 KS3sZ3AZPo2M+kGZFd4XnN+NCJQNANg3onCUMaEyPJ27ZwfR/VGDSA4Uuqe6dTXtI7o+
 WiFwR+lkpAdnlIvJI07ELRQISerctA56nuEqPgPBjlgsUeDQsSmcH02xnrG/P6bM8xHl
 rcHJuY0b4xHHNLMIgPRDwHDJstNBh3Q6Q2+Ap1b/xarlPOsY6vX/3RWzYemjc9Fi+qA5
 hYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723487455; x=1724092255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQEBZGkTU3+P5f0XMzJctOCFdX96laEmkow/VkUsFIw=;
 b=TxreBclhqsI2ovGJA7LpFGeiIyYcjbhbK0JEujoSwt7UBBYdAWXNgG5sPRtjxy3g1u
 RLFEPW0DYkedJo4DtK80Wa1FWGUh30o6Xr2/jNBptaZ+fpj+GLlJPbPQLNiZH2sImIO/
 NPTWP/45zcejjrwUfvpGoooXZHrMQpkIQQulMysU1nilp2Ry/tG+UXOz5g6ZWmz+TGdo
 Mfpf0NJa0UgQ5LD5AbEJ2wZPhS9YK5heh9LR8Gj+MWTCqkoOOZm4ifBCaLJvOOw4iMTR
 gSdR83qo//QuduDzoH+9pSMQwFJBwMeeByvBzPljg7e8MSuC2sWHWww1dTt4BjMeFIOK
 /1WQ==
X-Gm-Message-State: AOJu0YyiTZkIcsQmmLomna/Ocr19RRC+Cw17s+eySfzQ5TXyKY1oxaHN
 gdFqBrdkERs+ABOEkkbgrCI2avwU8uUlHzy4l6OBNQv4j/M1l/C26IGngQa+IGuu70BdSjRiIcq
 7JaJqGwTHsgXyJzssSv/fqWBpL/Ixqg==
X-Google-Smtp-Source: AGHT+IH55uBZ2+SRiKsRd4KeMQ/48O2OtTDjtowt0eIYUnuM3Dp48UiTjKcu4Bi/yxxKspY9ygBlyoXqmyevinZG26Q=
X-Received: by 2002:a05:6122:1d4e:b0:4f2:ea44:fd2b with SMTP id
 71dfb90a1353d-4fabed8a7cfmr1471491e0c.0.1723487455011; Mon, 12 Aug 2024
 11:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240808205732.292600-1-jaegeuk@kernel.org>
In-Reply-To: <20240808205732.292600-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 12 Aug 2024 11:30:43 -0700
Message-ID: <CACOAw_w0Dyn4T-r00=XrvGO0ZvWCVPv9wPQis9mz-9NXoqwmPA@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1sdZow-0003J7-3W
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: don't finish zones if it's not
 open
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBBdWcgOCwgMjAyNCBhdCAxOjU54oCvUE0gSmFlZ2V1ayBLaW0gPGphZWdldWtAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBTaG91bGQgZmluaXNoIHpvbmVzIGlmIHRoZXkgYXJlIG9wZW4u
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgo+IC0t
LQo+ICBpbmNsdWRlL2YyZnNfZnMuaCAgIHwgMiArKwo+ICBsaWIvbGliZjJmc196b25lZC5jIHwg
NSArKystLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2YyZnNfZnMuaCBiL2luY2x1ZGUvZjJmc19mcy5o
Cj4gaW5kZXggM2Y1NTgzZDE4MzI5Li4xNWExYzgyYWUxOGYgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVk
ZS9mMmZzX2ZzLmgKPiArKysgYi9pbmNsdWRlL2YyZnNfZnMuaAo+IEBAIC0xNzQyLDYgKzE3NDIs
OCBAQCBibGtfem9uZV9jb25kX3N0cihzdHJ1Y3QgYmxrX3pvbmUgKmJsa3opCj4gICAqIEhhbmRs
ZSBrZXJuZWwgem9uZSBjYXBhY2l0eSBzdXBwb3J0Cj4gICAqLwo+ICAjZGVmaW5lIGJsa196b25l
X2VtcHR5KHopICAgICAgKGJsa196b25lX2NvbmQoeikgPT0gQkxLX1pPTkVfQ09ORF9FTVBUWSkK
PiArI2RlZmluZSBibGtfem9uZV9vcGVuKHopICAgICAgIChibGtfem9uZV9jb25kKHopID09IEJM
S19aT05FX0NPTkRfSU1QX09QRU4gfHwgIFwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBibGtfem9uZV9jb25kKHopID09IEJMS19aT05FX0NPTkRfRVhQX09QRU4pCj4gICNkZWZp
bmUgYmxrX3pvbmVfc2VjdG9yKHopICAgICAoeiktPnN0YXJ0Cj4gICNkZWZpbmUgYmxrX3pvbmVf
bGVuZ3RoKHopICAgICAoeiktPmxlbgo+ICAjZGVmaW5lIGJsa196b25lX3dwX3NlY3Rvcih6KSAg
KHopLT53cAo+IGRpZmYgLS1naXQgYS9saWIvbGliZjJmc196b25lZC5jIGIvbGliL2xpYmYyZnNf
em9uZWQuYwo+IGluZGV4IDIyMWQ3ZDEzMzdjNy4uODliYTVhZDczYTc2IDEwMDY0NAo+IC0tLSBh
L2xpYi9saWJmMmZzX3pvbmVkLmMKPiArKysgYi9saWIvbGliZjJmc196b25lZC5jCj4gQEAgLTUx
Myw3ICs1MTMsNyBAQCBpbnQgZjJmc19maW5pc2hfem9uZShpbnQgaSwgdm9pZCAqYmxrem9uZSkK
PiAgICAgICAgIHN0cnVjdCBibGtfem9uZV9yYW5nZSByYW5nZTsKPiAgICAgICAgIGludCByZXQ7
Cj4KPiAtICAgICAgIGlmICghYmxrX3pvbmVfc2VxKGJsa3opIHx8IGJsa196b25lX2VtcHR5KGJs
a3opKQo+ICsgICAgICAgaWYgKCFibGtfem9uZV9zZXEoYmxreikgfHwgIWJsa196b25lX29wZW4o
YmxreikpCgpEb24ndCB3ZSBuZWVkIHRvIGNoZWNrIGJsa196b25lX2VtcHR5KCkgYW55bW9yZT8K
Cj4gICAgICAgICAgICAgICAgIHJldHVybiAwOwo+Cj4gICAgICAgICAvKiBOb24gZW1wdHkgc2Vx
dWVudGlhbCB6b25lOiBmaW5pc2ggKi8KPiBAQCAtNTIyLDcgKzUyMiw4IEBAIGludCBmMmZzX2Zp
bmlzaF96b25lKGludCBpLCB2b2lkICpibGt6b25lKQo+ICAgICAgICAgcmV0ID0gaW9jdGwoZGV2
LT5mZCwgQkxLRklOSVNIWk9ORSwgJnJhbmdlKTsKPiAgICAgICAgIGlmIChyZXQgIT0gMCkgewo+
ICAgICAgICAgICAgICAgICByZXQgPSAtZXJybm87Cj4gLSAgICAgICAgICAgICAgIEVSUl9NU0co
ImlvY3RsIEJMS0ZJTklTSFpPTkUgZmFpbGVkOiBlcnJubz0lZFxuIiwgZXJybm8pOwo+ICsgICAg
ICAgICAgICAgICBFUlJfTVNHKCJpb2N0bCBCTEtGSU5JU0haT05FIGZhaWxlZDogZXJybm89JWQs
IHN0YXR1cz0lc1xuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBlcnJubywgYmxrX3pvbmVf
Y29uZF9zdHIoYmxreikpOwo+ICAgICAgICAgfQo+Cj4gICAgICAgICByZXR1cm4gcmV0Owo+IC0t
Cj4gMi40Ni4wLjc2LmdlNTU5YzRiZjFhLWdvb2cKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1k
ZXZlbAo=
