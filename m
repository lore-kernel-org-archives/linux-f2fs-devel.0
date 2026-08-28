Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B25EC61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2H5stmmFnt+LFJGepBIevPWwWob/rVNSrm/Jwj4IpbI=; b=OhCeGW/u10AUJcxSo9QDOC7/sd
	2PtkADWTOToM4u7Qg3Hn9ghVpBn1Lmmtmkv5DKZVjXUNENVVntyLIi0OrIjpNLadI2EXpYLOWvxlr
	lpL5Sty9cK4509SeDoYcLkePfBUWmIAXrkbB+ojwNZZyrxbXGVgV3totMo1LuF9tPulQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wznL7-0005xG-4B;
	Fri, 28 Aug 2026 03:33:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wznKW-0005we-23
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 03:32:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5M8gbIUGJJBJHQvsJrS2ARyyI5Y6Y8eyeytRohiCL/k=; b=m1kDbjMQEuNM/FoKgbtVhGWQMk
 UGGEk1LyNUzWhYVwvIKMatOU74svEQhfqyqYoqybH05Wzcpslfjt6fWBlPsXqx8wbyuAcpNaGl3Jg
 qC240/2+D+W/Le/7cjkcBu0xTO5OrDIs8AqkxQ/XtfmSSr52kkO5QC4+c1x+eCFUlOLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5M8gbIUGJJBJHQvsJrS2ARyyI5Y6Y8eyeytRohiCL/k=; b=CI56fHHPGrtmtdOIvlmRjukaJn
 3xqt7jwIJOM9ELhiEe77uZ9skP3IT9xIvhIo9oQzchM21ZJcgaeE/RD0Vj99vi8pz4o6GF688vDtR
 h1CJYSgiuzre5aGZOIKImYKRE/Qo6L08au33tMOuGdcNQkCo5U4FTqgUbiqUtfuruqvk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wznKW-0006bO-7k for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 03:32:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91103601FD;
 Fri, 28 Aug 2026 03:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6399A1F000E9;
 Fri, 28 Aug 2026 03:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787887950;
 bh=5M8gbIUGJJBJHQvsJrS2ARyyI5Y6Y8eyeytRohiCL/k=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=W9HA3YYacD6eT0yJhBFSxQsc3yuNtYbY3SIVlhGlCsWLj5yX+ChnDjCQ8jCXYae1K
 WXP6AuriVti4Ku0H5KxSug1n+hfHXrMl5BP2+33iNG+mV2bolyjE2q7CRKYlA+aqTO
 +j0/2ZNXIjnYWHnWm6YSSpgdXsj9VUDAQJ9FnjDC2280AkFUMSXi4MjD9LG8YQyRPU
 U1CBmyNWcj9A3FP6wgEpIYaIQrl7aUr/QaHIYK0Z0Qs04W3r+u7SbTnrfyyRrQSWQP
 1FBGVYnkAK3P444u6RFAvt5bVUcS+1DlG/3HrHG01i2JBmO91Jmryhbj/TZEcbFrw9
 MA4wCr20NNnxQ==
Message-ID: <565c31ee-4677-4d16-bcc4-4754aa94d4ee@kernel.org>
Date: Fri, 28 Aug 2026 11:32:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-10-chao@kernel.org>
 <CACOAw_w+QMkTNK=McScLHh1gpm6UFjxLSnVxhFMsgsuArLA=qQ@mail.gmail.com>
 <8e02060f-6921-4d3c-abb2-cc36fe1e9594@kernel.org>
 <CACOAw_ySh3pW5tg7pa6r7Rr7tuqp9btPWvN-rrWN7mOpKcw3kQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_ySh3pW5tg7pa6r7Rr7tuqp9btPWvN-rrWN7mOpKcw3kQ@mail.gmail.com>
X-Headers-End: 1wznKW-0006bO-7k
Subject: Re: [f2fs-dev] [PATCH v3 09/12] f2fs: cache: use compress cache
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8yOC8yNiAwMToyMCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gT24gV2VkLCBBdWcgMjYsIDIw
MjYgYXQgODoyNOKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+Cj4+IE9u
IDgvMjcvMjYgMDQ6MDQsIERhZWhvIEplb25nIHdyb3RlOgo+Pj4+IC1zdGF0aWMgdm9pZCBmMmZz
X3RydW5jYXRlX2NhY2hlKHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9jayAqZW50cnksCj4+Pj4gK3Zv
aWQgZjJmc190cnVuY2F0ZV9jYWNoZShzdHJ1Y3QgZjJmc19jYWNoZWRfYmxvY2sgKmVudHJ5LAo+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGRyb3BfZGly
dHkpCj4+Pgo+Pj4gLT4gX19mMmZzX3RydW5jYXRlX2NhY2hlKCkgd2l0aG91dCBsb2NraW5nPwo+
PiBPciwgSSBndWVzcyB5b3UgbWVhbiB3ZSBuZWVkIGEgY2xlYW51cCBoZXJlPwo+Pgo+PiBXaGF0
IGFib3V0Ogo+Pgo+PiB2b2lkIGYyZnNfdHJ1bmNhdGVfY2FjaGUoc3RydWN0IGYyZnNfY2FjaGVk
X2Jsb2NrICplbnRyeSwgYm9vbCBkcm9wX2RpcnR5KQo+PiB7Cj4+ICAgICAgICAgaWYgKCFlbnRy
eS0+Y2FjaGUpCj4+ICAgICAgICAgICAgICAgICByZXR1cm47Cj4+ICAgICAgICAgZjJmc19kb190
cnVuY2F0ZV9jYWNoZShlbnRyeSwgZHJvcF9kaXJ0eSk7Cj4+IH0KPj4KPj4gc3RhdGljIHZvaWQg
ZjJmc190cnVuY2F0ZV9jYWNoZV9sb2NrZWQoc3RydWN0IGYyZnNfY2FjaGVkX2Jsb2NrICplbnRy
eSwgYm9vbCBkcm9wX2RpcnR5KQo+PiB7Cj4+ICAgICAgICAgZjJmc19sb2NrX2NhY2hlKGVudHJ5
KTsKPj4gICAgICAgICBmMmZzX3RydW5jYXRlX2NhY2hlKGVudHJ5LCBkcm9wX2RpcnR5KTsKPj4g
ICAgICAgICBmMmZzX3VubG9ja19jYWNoZShlbnRyeSk7Cj4+IH0KPj4KPj4gZjJmc190cnVuY2F0
ZV9jYWNoZSgpIHdhcyBleHBvcnRlZCBmb3IgdXNpbmcgaW4gb3RoZXIgLmMgZmlsZSwgaW4gdGhl
IG1lYW50aW1lLAo+PiBzdGF0aWMgZjJmc190cnVuY2F0ZV9jYWNoZV9sb2NrZWQoKSBjYW4gYmUg
dXNlZCBpbnNpZGUgY2FjaGUuYy4KPiAKPiBTcGxpdHRpbmcgdGhlbSBpbnRvIHR3byBoZWxwZXJz
IChvbmUgd2l0aCBsb2NraW5nLCBvbmUgd2l0aG91dCkgbWFrZXMKPiB0b3RhbCBzZW5zZS4KPiAK
PiBIb3dldmVyLCBpbiB0aGUgTGludXgga2VybmVsIGNvbnZlbnRpb24sIGhhdmluZyBgX2xvY2tl
ZGAgb3IgYF9fYAo+IHVzdWFsbHkgaW5kaWNhdGVzIHRoYXQgdGhlIGNhbGxlciBpcyBleHBlY3Rl
ZCB0byBBTFJFQURZIGhvbGQgdGhlIGxvY2sKPiAoZS5nLiBgX19saXN0X2FkZCgpYCwgYF9fZm9s
aW9fbWFya19kaXJ0eSgpYCkuCj4gCj4gSWYgYW4gZXhwb3J0ZWQgZnVuY3Rpb24gaXMgbmFtZWQg
YGYyZnNfdHJ1bmNhdGVfY2FjaGUoKWAgd2l0aG91dCBgX19gLAo+IGNhbGxlcnMgd291bGQgbmF0
dXJhbGx5IGFzc3VtZSBpdCBoYW5kbGVzIGxvY2tpbmcgaW50ZXJuYWxseS4KPiAKPiBTbyBJJ2Qg
c3VnZ2VzdCBmb2xsb3dpbmcgdGhlIHN0YW5kYXJkIGtlcm5lbCBwYXR0ZXJuOgo+IAo+IC8qIENh
bGxlciBtdXN0IGhvbGQgZjJmc19sb2NrX2NhY2hlKGVudHJ5KSAqLwo+IHZvaWQgX19mMmZzX3Ry
dW5jYXRlX2NhY2hlKHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9jayAqZW50cnksIGJvb2wgZHJvcF9k
aXJ0eSkKPiB7Cj4gaWYgKCFlbnRyeS0+Y2FjaGUpCj4gcmV0dXJuOwo+IGYyZnNfZG9fdHJ1bmNh
dGVfY2FjaGUoZW50cnksIGRyb3BfZGlydHkpOwo+IH0KPiAKPiAvKiBTYWZlIHdyYXBwZXIgdGhh
dCBhY3F1aXJlcyBlbnRyeSBsb2NrIGludGVybmFsbHkgKi8KPiB2b2lkIGYyZnNfdHJ1bmNhdGVf
Y2FjaGUoc3RydWN0IGYyZnNfY2FjaGVkX2Jsb2NrICplbnRyeSwgYm9vbCBkcm9wX2RpcnR5KQo+
IHsKPiBmMmZzX2xvY2tfY2FjaGUoZW50cnkpOwo+IF9fZjJmc190cnVuY2F0ZV9jYWNoZShlbnRy
eSwgZHJvcF9kaXJ0eSk7Cj4gZjJmc191bmxvY2tfY2FjaGUoZW50cnkpOwo+IH0KPiAKPiBUaGVu
IGNvbXByZXNzLmMgKHdoaWNoIGFscmVhZHkgaG9sZHMgdGhlIGxvY2sgdG8gY2hlY2sgZW50cnkt
PmlubykgY2FuCj4gY2FsbCBgX19mMmZzX3RydW5jYXRlX2NhY2hlKClgLCB3aGlsZSBvdGhlciBj
YWxsZXJzIGNhbiBzYWZlbHkgdXNlCj4gYGYyZnNfdHJ1bmNhdGVfY2FjaGUoKWAuCgpPa2F5LCBJ
IHNlZS4KCk15IGNvbmNlcm4gaXMgcHJldmlvdXNseSB3ZSBkb24ndCBleHBvcnQgX19mMmZzIGZ1
bmN0aW9ucyBpbiAqLmgsIHNlZSBmMmZzLmgsCmJ1dCBzaW5jZSBpdCBoYXMgImYyZnMiIGtleXdv
cmQgaW4gcHJlZml4LCBzbyBpdCB3b24ndCBwb2xsdXRlIGdsb2JhbCBuYW1lIHNwYWNlLApzbyBJ
IGd1ZXNzIGl0J3MgZmluZSwgYW55d2F5LCBsZXQgbWUgdXBkYXRlLgoKVGhhbmtzLAoKPiAKPiBX
aGF0IGRvIHlvdSB0aGluaz8KPiAKPiBUaGFua3MsCj4gCj4+Cj4+IFRoYW5rcywKCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZl
bCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZl
bAo=
