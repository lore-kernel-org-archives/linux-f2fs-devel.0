Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28625C67861
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Apr 2024 02:11:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rtI0I-0001nO-Ju;
	Sun, 07 Apr 2024 02:11:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1rtI0H-0001nH-6d
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 02:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K/KhX0dE0EtRhHJL7uJ4XZgUbpZN9gfmBRKOnoxL+NY=; b=JwVszUqxBcbgx7gTXyL0iRHNEy
 g7xB69wrfG5dc4OBqXj15g1JbuqqqHtYOHuZSlnX0zz6ruRgUjsJJ0uy7VtEbzQ18jicQWdYnIdjY
 hi3Xj4W1Ew7uFJQTqsI2oJf1OyAN6JpEdn8dldG8Qr1esYS1ORN09PShDxhjs5Z5jAZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K/KhX0dE0EtRhHJL7uJ4XZgUbpZN9gfmBRKOnoxL+NY=; b=dMcMasfFpCBXm0JHoyYF4YrWxT
 KI5byiqITB80waEq6qiIW+uj8FLD1kvAluEU5WZqyk9I+MXsFRBsKC1zgBHoOYymhQLkmXmZx0LZT
 y0RQgyl77atnm9jrfpsBjb8T5o1VHFCVCfgJCn+xParH+IBiPb4AUWAXBDngg0AfP1NE=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rtI0C-0001bJ-Jz for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 02:11:29 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-33edbc5932bso2514146f8f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 06 Apr 2024 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712455873; x=1713060673; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/KhX0dE0EtRhHJL7uJ4XZgUbpZN9gfmBRKOnoxL+NY=;
 b=d/29C0eFB6s/gKhB/Ey3TYnZiSA0ClkyKo8wHaToUqDOQMqxtj0ky+04yohdP0a91v
 bLuHE0BsEXB/vJQF+5FyP0JGHN147GYhJcxo8kuevYWa71ISjiJqTlVUWbD2C7troDye
 3j/haEDrEAzpTyMX0kDFw3cgymUt6kwC6yF3zguqM1FE9ODySyzFiYDygHn9f6gvF+0m
 98Od/StvhXEuinjGmD5tq9EpoT/vFNZ+c4IFPfoId7uPTX44fqf+UVAy2Z63wYSqvxur
 qgUTP9ivj7g9/MKL7iqfDuDoG42Ur5PaCZHZlNB2zn7puHNNQCKPKkzsRO1wrgERX6s1
 Evjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712455873; x=1713060673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/KhX0dE0EtRhHJL7uJ4XZgUbpZN9gfmBRKOnoxL+NY=;
 b=BOP2CsfNACKJohnNNEK8njfb+iHllHGJPZ7k2iQwwoAsdizbqc7cL4/6UvUVMKM8Z1
 Mgkr1A+efhJUeE7PdB2kZixJX6rUmaQQRNZaIcRRHzy2ydhAeVKO8FSXfRfkZXqZlxYw
 jPJiO93KI6uDjnoCVUPAbuPPQ4lrOMcUTMJqmyCJXDlb5Re9HnmhOJXwXtxSmzC9Fxev
 J4YL83I2TZOt5/kijckeLHXmK0jXDac0O2K3cF5IEA0DNagJhs3sjAPQ/tneG5/PF2Ze
 06hHZirQyrkClzEFsqElYURyYBfi0oLNa4wLVaW7LBOm3qZKl8+Y1FWNZtc+gYV97K6a
 a+JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtXxR72TQ7cQEP8Use4+v/Q/SyTMeQ4R9MB9NqX0Ar3yjCBxB5RSDWhbBzwyX6j59AEGK5XR95YqFL/04uprIkAGskmTUZN0YOSWqCPHTdmJWZ6pMC7w==
X-Gm-Message-State: AOJu0YzDSxOzFwacn4IjQYiypgaTAJ2lcFSjUd7f0zVL9lMlA9+5fNhe
 dBM+C3HRkJ/QY9ICXACaAaB+BBeGdZxjTDUe+dmi5IYJn5GQ4YzVPvr+tw/qoIqbJQKQOSkniUR
 3gvTgcaGEn6H2CcVdtNEdvCSQdVc=
X-Google-Smtp-Source: AGHT+IED4Bbg+uo4kDv4OZPLlWb7h5V+M5g2fKRAH686W10d2St4Vdl1mOPGYwYWHzTAQ2nW7DIrgcpcOT9ED5gpmpA=
X-Received: by 2002:a5d:51c2:0:b0:341:e4f4:4399 with SMTP id
 n2-20020a5d51c2000000b00341e4f44399mr3912457wrv.68.1712455873210; Sat, 06 Apr
 2024 19:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240403142420.2042498-1-chao@kernel.org>
In-Reply-To: <20240403142420.2042498-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Sun, 7 Apr 2024 10:11:02 +0800
Message-ID: <CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rtI0C-0001bJ-Jz
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to relocate check condition in
 f2fs_fallocate()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBBcHIgMywgMjAyNCBhdCAxMDoyNuKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBjb21wcmVzcyBhbmQgcGluZmlsZSBmbGFnIHNob3VsZCBiZSBjaGVja2Vk
IGFmdGVyIGlub2RlIGxvY2sgaGVsZCB0bwo+IGF2b2lkIHJhY2UgY29uZGl0aW9uLCBmaXggaXQu
Cj4KPiBGaXhlczogNGM4ZmY3MDk1YmVmICgiZjJmczogc3VwcG9ydCBkYXRhIGNvbXByZXNzaW9u
IikKPiBGaXhlczogNWZlZDBiZTg1ODNmICgiZjJmczogZG8gbm90IGFsbG93IHBhcnRpYWwgdHJ1
bmNhdGlvbiBvbiBwaW5uZWQgZmlsZSIpCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0Br
ZXJuZWwub3JnPgo+IC0tLQo+ICBmcy9mMmZzL2ZpbGUuYyB8IDIwICsrKysrKysrKysrLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZmlsZS5jIGIvZnMvZjJmcy9maWxlLmMKPiBpbmRleCAx
NDhiZmUzZWZmZGYuLjgzYTgwN2UyNWUzMSAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL2ZpbGUuYwo+
ICsrKyBiL2ZzL2YyZnMvZmlsZS5jCj4gQEAgLTE4MjAsMTUgKzE4MjAsNiBAQCBzdGF0aWMgbG9u
ZyBmMmZzX2ZhbGxvY2F0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50IG1vZGUsCj4gICAgICAgICAg
ICAgICAgIChtb2RlICYgKEZBTExPQ19GTF9DT0xMQVBTRV9SQU5HRSB8IEZBTExPQ19GTF9JTlNF
UlRfUkFOR0UpKSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+Cj4gLSAg
ICAgICAvKgo+IC0gICAgICAgICogUGlubmVkIGZpbGUgc2hvdWxkIG5vdCBzdXBwb3J0IHBhcnRp
YWwgdHJ1bmNhdGlvbiBzaW5jZSB0aGUgYmxvY2sKPiAtICAgICAgICAqIGNhbiBiZSB1c2VkIGJ5
IGFwcGxpY2F0aW9ucy4KPiAtICAgICAgICAqLwo+IC0gICAgICAgaWYgKChmMmZzX2NvbXByZXNz
ZWRfZmlsZShpbm9kZSkgfHwgZjJmc19pc19waW5uZWRfZmlsZShpbm9kZSkpICYmCj4gLSAgICAg
ICAgICAgICAgIChtb2RlICYgKEZBTExPQ19GTF9QVU5DSF9IT0xFIHwgRkFMTE9DX0ZMX0NPTExB
UFNFX1JBTkdFIHwKPiAtICAgICAgICAgICAgICAgICAgICAgICBGQUxMT0NfRkxfWkVST19SQU5H
RSB8IEZBTExPQ19GTF9JTlNFUlRfUkFOR0UpKSkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1F
T1BOT1RTVVBQOwo+IC0KPiAgICAgICAgIGlmIChtb2RlICYgfihGQUxMT0NfRkxfS0VFUF9TSVpF
IHwgRkFMTE9DX0ZMX1BVTkNIX0hPTEUgfAo+ICAgICAgICAgICAgICAgICAgICAgICAgIEZBTExP
Q19GTF9DT0xMQVBTRV9SQU5HRSB8IEZBTExPQ19GTF9aRVJPX1JBTkdFIHwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBGQUxMT0NfRkxfSU5TRVJUX1JBTkdFKSkKPiBAQCAtMTgzNiw2ICsxODI3
LDE3IEBAIHN0YXRpYyBsb25nIGYyZnNfZmFsbG9jYXRlKHN0cnVjdCBmaWxlICpmaWxlLCBpbnQg
bW9kZSwKPgo+ICAgICAgICAgaW5vZGVfbG9jayhpbm9kZSk7Cj4KPiArICAgICAgIC8qCj4gKyAg
ICAgICAgKiBQaW5uZWQgZmlsZSBzaG91bGQgbm90IHN1cHBvcnQgcGFydGlhbCB0cnVuY2F0aW9u
IHNpbmNlIHRoZSBibG9jawo+ICsgICAgICAgICogY2FuIGJlIHVzZWQgYnkgYXBwbGljYXRpb25z
Lgo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAoKGYyZnNfY29tcHJlc3NlZF9maWxlKGlub2Rl
KSB8fCBmMmZzX2lzX3Bpbm5lZF9maWxlKGlub2RlKSkgJiYKPiArICAgICAgICAgICAgICAgKG1v
ZGUgJiAoRkFMTE9DX0ZMX1BVTkNIX0hPTEUgfCBGQUxMT0NfRkxfQ09MTEFQU0VfUkFOR0UgfAo+
ICsgICAgICAgICAgICAgICAgICAgICAgIEZBTExPQ19GTF9aRVJPX1JBTkdFIHwgRkFMTE9DX0ZM
X0lOU0VSVF9SQU5HRSkpKSB7Cj4gKyAgICAgICAgICAgICAgIHJldCA9IC1FT1BOT1RTVVBQOwo+
ICsgICAgICAgICAgICAgICBnb3RvIG91dDsKPiArICAgICAgIH0KPiArCkRlYXIgQ2hhbywKSSBz
ZWUgIHRoZSBqdWRnbWVudCBjb2RlICJpZighZjJmc19jb21wcmVzc2VkX2ZpbGUoaW5vZGUpKSIg
YWxzbyBpcwpiZWZvcmUgaW5vZGVfbG9jayBpbiBmdW5jdGlvbnMKZjJmc19pb2NfZGVjb21wcmVz
c19maWxlL2YyZnNfaW9jX2NvbXByZXNzX2ZpbGUvZjJmc19yZXNlcnZlX2NvbXByZXNzX2Jsb2Nr
cy9mMmZzX3JlbGVhc2VfY29tcHJlc3NfYmxvY2tzLgpzaG91bGQgdGhleSBhcmUgY2hhbmdlZCB0
b2dldGhlcj8KdGhhbmtz77yBCj4gICAgICAgICByZXQgPSBmaWxlX21vZGlmaWVkKGZpbGUpOwo+
ICAgICAgICAgaWYgKHJldCkKPiAgICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gLS0KPiAyLjQw
LjEKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
