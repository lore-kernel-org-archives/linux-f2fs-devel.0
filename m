Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3843CC46CD2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:02:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rSq0D-0007So-Jm;
	Thu, 25 Jan 2024 03:02:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1rSq0B-0007Si-IV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jan 2024 03:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WGiyAHud1zklxr4w5Cvq4HldX0ROxrGXkPXnV56dMB4=; b=K1I0J0SHsYNhV3augAjfYnWB9z
 kZ4RYv/4aKZYSc0LspzEX3NF/+Xw1QmBTuCOkQ6rXMmYNZUeIMJRg5oCRBVbAavL6++vkxMrsgdFs
 eXcCQh/isbZc604bB7hVvhIbOCTkrDm4LTAZfNgzXGS+U8/q7wmKzBvvQQnob9sFb7uY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WGiyAHud1zklxr4w5Cvq4HldX0ROxrGXkPXnV56dMB4=; b=AWFyWCukj9asuQXBAOhj9/TIyT
 Oz8oHNKRsmaN/8C2WGrEgUnTaQphiSdrxKkDprEdFgcpULChXm6UtrMZUeRU/uujpKZBds//tc/Nb
 3YI+k2irMSagVR5faTXHXZMIWkFFDedThck88SY48YsHlbL0jUly7CQSwKbx76W6LfIQ=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rSq04-0005V7-0a for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jan 2024 03:02:00 +0000
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-55ad2a47b7aso5666467a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Jan 2024 19:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706151710; x=1706756510; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGiyAHud1zklxr4w5Cvq4HldX0ROxrGXkPXnV56dMB4=;
 b=AZEqXGsV4a1ZW/iKtcEXxTuYubG/J6mffwJmhKp2MUlrj6B1b5Trs1/LpBW3oPcn8r
 L2VTXoPHFNrGl/QE+zb13Uie1HciN3OCKl13T/k76qNnl4QTmtPZ+BBdoRYvNcROnVFO
 9+x192+CR3Go4QwNT75CtKV6Mw0+3KWg3kU1gX1g7+V4ocZHKnNTygC5D7Zbya+621Gb
 9zX5Nhv0ThkYlbNcIBlcXodj0OiLS0BNgsp4vNgnZNMu/0nccW4Cm0tG/k+ZDUZMyoHM
 ysmtqYfhlv5PIWGnmzjJM9hfDwcJq26ly7xkunKj5Cl0y3SyFfSX9bWQ9zDUvVwa9mME
 Ji3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706151710; x=1706756510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGiyAHud1zklxr4w5Cvq4HldX0ROxrGXkPXnV56dMB4=;
 b=eL8p6x9dttRBfv0qi4rkbhiwcN2SnsA/36AASjnEIWL6MvfoMteU0zpbqPj8uh2KBz
 nxXWeplEaFh7S3+qxU7uvqo9IlUMLJO7/CREjOC/y1bgS0b/tbUk9sOOIGn/oC9xOd5h
 XCiLdzfqpdTiqU+VHAdTNhLCfm6Nno1zeqSFqXIppvkr54Xt/cNhX4d+LVy7vQSTdov3
 KAnH/Lasus0ngjZg3F5PkpjH31AtHfu9ULO5f3L4tZdJ6BWrFKoM7Y9zMLRhVdl4btfQ
 nnCT6JEI57QsjluowWsulD00fRheaSypAC6wu0UvOOnNJW+4urSfq43RjpjU0fofPQR9
 c6Jg==
X-Gm-Message-State: AOJu0YyWw0olT16CIA0vis/A3mnygnFNf6gQGl217EicQGtZ898gHgUF
 xElVHVK4A50so+GigMbgXlUfkUkBDgAm08KihjQiUvelmBoqypMJeYr5XjsC7UYaIShAcGPaO97
 2zxVd3sFyP69RHucj+G1w6xWFxEI=
X-Google-Smtp-Source: AGHT+IEnoFE7ytn/E8cRDRjQCSJsv0fMwsa6UB/wMFssFu0dpTGk7NCfLiIJVRNBUYrudDH8UDT6tYTKKpzjT82hHrg=
X-Received: by 2002:a05:6402:32f:b0:55c:972e:3e9c with SMTP id
 q15-20020a056402032f00b0055c972e3e9cmr101429edw.80.1706151709630; Wed, 24 Jan
 2024 19:01:49 -0800 (PST)
MIME-Version: 1.0
References: <1703502715-11936-1-git-send-email-zhiguo.niu@unisoc.com>
 <74243f43-c129-4530-970c-4de2afcd307e@kernel.org>
 <CAHJ8P3KmnN3rc5yXh2ecg21Eu61srUJsJP8=TbPxfSu4dY91EQ@mail.gmail.com>
 <b2a3268a-7087-4ff5-9148-dcbc7c95e2bb@kernel.org>
In-Reply-To: <b2a3268a-7087-4ff5-9148-dcbc7c95e2bb@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 25 Jan 2024 11:01:38 +0800
Message-ID: <CAHJ8P3+GeS4TSdwAPJ8dO_R08Vvi1iv_ua+9SU2JY5weuN4hKw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rSq04-0005V7-0a
Subject: Re: [f2fs-dev] [PATCH V1] f2fs: fix potentail deadloop issue in
 do_recover_data
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
Cc: jaegeuk@kernel.org, ke.wang@unisoc.com, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgQ2hhbywKCk9uIFdlZCwgSmFuIDI0LCAyMDI0IGF0IDEwOjU04oCvUE0gQ2hhbyBZdSA8Y2hh
b0BrZXJuZWwub3JnPiB3cm90ZToKPgo+IFpoaWd1bywKPm0KPiBDYW4geW91IHBsZWFzZSBjaGVj
ayBiZWxvdyB2ZXJzaW9uPyBJcyBpdCBmaW5lIHRvIHlvdT8KPgo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWYyZnMtZGV2ZWwvMjAyNDAxMjQxNDQ5MTUuMTk0NDUtMS1jaGFvQGtlcm5l
bC5vcmcKaXQgaXMgb2sgdG8gbWUgYW5kIG1vcmUgcmVhc29uYWJsZSB0aGFuIG15ICB2ZXJzaW9u
CnRoYW5rc34KPgo+IE9uIDIwMjQvMS8yMiAxMzo0NiwgWmhpZ3VvIE5pdSB3cm90ZToKPiA+IEhp
IENoYW8KPiA+Cj4gPiBPbiBNb24sIEphbiAyMiwgMjAyNCBhdCAxMTo0NuKAr0FNIENoYW8gWXUg
PGNoYW9Aa2VybmVsLm9yZz4gd3JvdGU6Cj4gPj4KPiA+PiBPbiAyMDIzLzEyLzI1IDE5OjExLCBa
aGlndW8gTml1IHdyb3RlOgo+ID4+PiBUaGVyZSBpcyBhIHBvdGVudGFpbCBkZWFkbG9vcCBpc3N1
ZSBpbiB0aGUgY29ybmVyIGNhc2Ugb2YKPiA+Pj4gQ09ORklHX0YyRlNfRkFVTFRfSU5KRUNUSU9O
IGlzIGVuYWJsZWQgYW5kIHRoZSByZXR1cm4gdmFsdWUKPiA+Pj4gb2YgZjJmc19yZXNlcnZlX25l
d19ibG9jayBpcyBlcnJvciBidXQgbm90IC1FTk9TUEMsIHN1Y2ggYXMKPiA+Pj4gdGhpcyBlcnJv
ciBjYXNlOgo+ID4+PiBpZiAodW5saWtlbHkoaXNfaW5vZGVfZmxhZ19zZXQoZG4tPmlub2RlLCBG
SV9OT19BTExPQykpKQo+ID4+PiAgICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOwo+ID4+Cj4g
Pj4gSSBkb24ndCBzZWUgYW55IHBhdGggdG8gdHJpZ2dlciB0aGlzIGVycm9yPyBhbSBJIG1pc3Np
bmcgc29tZXRoaW5nPwo+ID4+Cj4gPj4+IGJlc2lkZXMsIHRoZSBtYWlubHkgZXJyb3IgLUVOT1NQ
QyBoYXMgYmVlbiBoYW5kbGVkIGFzIGJ1ZyBvbiwKPiA+Pj4gc28gb3RoZXIgZXJyb3IgY2FzZXMg
Y2FuIGJlIHByb2Vjc3NlZCBub3JtYWxseSB3aXRob3V0IGxvb3BpbmcuCj4gPj4KPiA+PiBjb21t
aXQgOTc1NzU2YzQxMzMyYmM1ZTUyM2U5Zjg0MzI3MWVkNWFiNmFhYWFhYQo+ID4+IEF1dGhvcjog
SmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9yZz4KPiA+PiBEYXRlOiAgIFRodSBNYXkgMTkg
MTE6NTc6MjEgMjAxNiAtMDcwMAo+ID4+Cj4gPj4gICAgICAgZjJmczogYXZvaWQgRU5PU1BDIGZh
dWx0IGluIHRoZSByZWNvdmVyeSBwcm9jZXNzCj4gPj4KPiA+PiAgICAgICBUaGlzIHBhdGNoIGF2
b2lkcyBpbXBvc3NpYmxlIGVycm9yIGluamVjdGlvbiwgRU5PU1BDLCBkdXJpbmcgcmVjb3Zlcnkg
cHJvY2Vzcy4KPiA+Pgo+ID4+IFBsZWFzZSBjaGVjayBhYm92ZSBwYXRjaCwgSSBndWVzcyBpbnRl
bnRpb24gb2YgYWRkaW5nIHN1Y2ggbG9vcCBpcwo+ID4+IHRvIGF2b2lkIG1vdW50IGZhaWx1cmUg
ZHVlIHRvIGZhdWx0IGluamVjdGlvbiB3YXMgdHJpZ2dlcmVkIGluCj4gPj4gZjJmc19yZXNlcnZl
X25ld19ibG9jaygpLgo+ID4+Cj4gPj4gV2hhdCBhYm91dCBjaGFuZ2UgYXMgYmxldz8KPiA+PiAt
IGtlZXAgdGhlIGxvb3AgdG8gYXZvaWQgbW91bnQgZmFpbHVyZS4KPiA+PiAtIHJlbW92ZSBidWdf
b24oKSB0byBhdm9pZCBwYW5pYyBkdWUgdG8gZmF1bHQgaW5qZWN0aW9uIGVycm9yLgo+ID4+Cj4g
Pj4gI2RlZmluZSBERUZBVUxUX1JFVFJZX0NPVU5UICAgICAgICAgICAgIDgKPiA+Pgo+ID4+ICAg
ICAgICAgICAgICAgICAgZm9yIChsb29wcyA9IERFRkFVTFRfUkVUUllfQ09VTlQ7IGxvb3BzID4g
MDsgbG9vcHMtLSkgewo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBmMmZzX3Jl
c2VydmVfbmV3X2Jsb2NrKCZkbik7Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGlmICgh
ZXJyIHx8Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIUlTX0VOQUJMRUQo
Q09ORklHX0YyRlNfRkFVTFRfSU5KRUNUSU9OKSkKPiA+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsKPiA+PiAgICAgICAgICAgICAgICAgIH0KPiA+Cj4gPiBUaGFua3Mg
Zm9yIHlvdXIgZGV0YWlsZWQgZXhwbGFuYXRpb24gYW5kIEkgdW5kZXJzdGFuZC4KPiA+IEl0IHNl
ZW1zIHRoYXQgdGhlIG9yaWdpbmFsIHByb2Nlc3MgaXMgYWxzbyByZWFzb25hYmxlLAo+ID4gc28g
aXTigJlzIG9rYXkgdG8ga2VlcCBpdCBhcyBpdCBpcy4KPiA+Pgo+ID4+IFRoYW5rcywKPiA+Pgo+
ID4+Pgo+ID4+PiBGaXhlczogOTU2ZmExZGRjMTMyICgiZjJmczogZml4IHRvIGNoZWNrIHJldHVy
biB2YWx1ZSBvZiBmMmZzX3Jlc2VydmVfbmV3X2Jsb2NrKCkiKQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBaaGlndW8gTml1IDx6aGlndW8ubml1QHVuaXNvYy5jb20+Cj4gPj4+IC0tLQo+ID4+PiAgICBm
cy9mMmZzL3JlY292ZXJ5LmMgfCAyNiArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQo+ID4+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPiA+Pj4K
PiA+Pj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvcmVjb3ZlcnkuYyBiL2ZzL2YyZnMvcmVjb3Zlcnku
Ywo+ID4+PiBpbmRleCAyMTM4MWI3Li41ZDY1OGY2IDEwMDY0NAo+ID4+PiAtLS0gYS9mcy9mMmZz
L3JlY292ZXJ5LmMKPiA+Pj4gKysrIGIvZnMvZjJmcy9yZWNvdmVyeS5jCj4gPj4+IEBAIC03MTAs
MTUgKzcxMCwxMCBAQCBzdGF0aWMgaW50IGRvX3JlY292ZXJfZGF0YShzdHJ1Y3QgZjJmc19zYl9p
bmZvICpzYmksIHN0cnVjdCBpbm9kZSAqaW5vZGUsCj4gPj4+ICAgICAgICAgICAgICAgICAqLwo+
ID4+PiAgICAgICAgICAgICAgICBpZiAoZGVzdCA9PSBORVdfQUREUikgewo+ID4+PiAgICAgICAg
ICAgICAgICAgICAgICAgIGYyZnNfdHJ1bmNhdGVfZGF0YV9ibG9ja3NfcmFuZ2UoJmRuLCAxKTsK
PiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgIGRvIHsKPiA+Pj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZXJyID0gZjJmc19yZXNlcnZlX25ld19ibG9jaygmZG4pOwo+ID4+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZXJyID09IC1FTk9TUEMpIHsKPiA+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmMmZzX2J1Z19vbihzYmksIDEpOwo+
ID4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+PiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Cj4gPj4+IC0gICAgICAgICAgICAgICAgICAg
ICB9IHdoaWxlIChlcnIgJiYKPiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSVNf
RU5BQkxFRChDT05GSUdfRjJGU19GQVVMVF9JTkpFQ1RJT04pKTsKPiA+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgIGlmIChlcnIpCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICBlcnIgPSBmMmZz
X3Jlc2VydmVfbmV3X2Jsb2NrKCZkbik7Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICBpZiAo
ZXJyID09IC1FTk9TUEMpCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGYyZnNf
YnVnX29uKHNiaSwgMSk7Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICBlbHNlIGlmIChlcnIp
Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsKPiA+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+Pj4gICAgICAgICAgICAgICAgfQo+ID4+
PiBAQCAtNzI3LDE1ICs3MjIsMTAgQEAgc3RhdGljIGludCBkb19yZWNvdmVyX2RhdGEoc3RydWN0
IGYyZnNfc2JfaW5mbyAqc2JpLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAo+ID4+PiAgICAgICAgICAg
ICAgICBpZiAoZjJmc19pc192YWxpZF9ibGthZGRyKHNiaSwgZGVzdCwgTUVUQV9QT1IpKSB7Cj4g
Pj4+Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNyYyA9PSBOVUxMX0FERFIpIHsK
PiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG8gewo+ID4+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IGYyZnNfcmVzZXJ2ZV9uZXdfYmxvY2so
JmRuKTsKPiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZXJy
ID09IC1FTk9TUEMpIHsKPiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGYyZnNfYnVnX29uKHNiaSwgMSk7Cj4gPj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+Pj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB9Cj4gPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH0gd2hpbGUgKGVyciAmJgo+ID4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIElTX0VOQUJMRUQoQ09ORklHX0YyRlNfRkFVTFRfSU5KRUNUSU9OKSk7Cj4gPj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIpCj4gPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVyciA9IGYyZnNfcmVzZXJ2ZV9uZXdfYmxvY2soJmRuKTsKPiA+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVyciA9PSAtRU5PU1BDKQo+ID4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGYyZnNfYnVnX29uKHNiaSwgMSk7Cj4g
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKGVycikKPiA+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gPj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgfQo+ID4+PiAgICByZXRyeV9wcmV2OgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
