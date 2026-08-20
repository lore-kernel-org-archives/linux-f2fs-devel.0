Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D571C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0dmSSriZklcGB+mGeUnkEazlRxwjadzCqFnIhx5o6E=; b=Si33ZDuyhlhh7oHzTdM/xuIKwG
	v4O0B1xt4t04An1+E65tAzeuzoNoEuhLs+mGTI+UXpIaAp7M7po9Ea2SH+JUBwZwbyV/+l3ejwjEK
	uGNZTJIe1laNlEYKPg63hhm7+nB8Em+GqudHFRmu5A55uh2yI0E8xirtrz16VGxw23rk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wx9Pl-0000Br-Qd;
	Thu, 20 Aug 2026 20:31:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <christophe.jaillet@wanadoo.fr>) id 1wx9Pg-0000BQ-IC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 20:31:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lQ9GITxtGTDLs1lOxiVb1+LmfpQPj8GlM8s7QN3cng4=; b=G6v6TDhbub8USCPsbZLlfFeuBr
 2ko8hbPK20BC2xqtnD3yNUl3dUARaWb23gegnlIw+qUyT8yHqolC96QXrmS7UzkNBl5ITGOVV/yqt
 b+AhekTy7OKDQXhAQ5JVNtDDQNh4pZO6zmnWE1vrq9JcNRu+iAdGGAlZPV0UbNdBmuCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lQ9GITxtGTDLs1lOxiVb1+LmfpQPj8GlM8s7QN3cng4=; b=FAhgBDzX5YuMXBNvdfxFCr0OT/
 onP69G1Re53FgQASEsRJMLs+AMPoiveaMRDlLdx5dPvVqsUTNk6mqSXgvMMCGpm7t5mFEiChvfAY9
 b1L6DEjW9rePxcN7iC9FQ2AUSeumTeqLaS6ScVOZEAPrkb+GsZDujbDdKEjeIDtMEzsk=;
Received: from smtp-23.smtpout.orange.fr ([80.12.242.23]
 helo=smtp.smtpout.orange.fr)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx9Pb-0004dv-OR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 20:30:58 +0000
Received: from [IPV6:2a01:cb10:785:b00:6128:9b8c:c203:905]
 ([IPv6:2a01:cb10:785:b00:6128:9b8c:c203:905])
 by smtp.orange.fr with ESMTPSA
 id x9PUwFghKPd3Dx9PUw1Wf6; Thu, 20 Aug 2026 22:30:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1787257849;
 bh=lQ9GITxtGTDLs1lOxiVb1+LmfpQPj8GlM8s7QN3cng4=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=dIqC7yk6bV2qIlu+RsXbwEJBPlWZqQVJ4rAA/93vR/5NC5CDDlxYi0H2w/yVgniHV
 wg6IJ2qmtVZR2+AMPpD8lmc8uaJjYsON0YkF1L4oBhLooZvsHQJdHPeI57hp11BwRb
 p4ZuQHhAjuRh9lPjHWMlDyrZ9HLCIPhdtLoiRz3egu0duZH1EO/+hmq8A5oGhlXgst
 r8rCXqpvP1IwJK9YZyksaLZrPeW8Ykbg6uH8mVhBZCCcJnLPWDW/bhVm4uN5bzt31a
 xyen/apCAi/Gq9cQSU9K/2MCkAgmVu/5ledEw2nvVOGyhqepO3pqekqmJXEYcl++Wy
 nD/tp/jrfmQ8Q==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:6128:9b8c:c203:905]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Aug 2026 22:30:49 +0200
X-ME-IP: 2a01:cb10:785:b00:6128:9b8c:c203:905
Message-ID: <ccec912d-5d80-4f9d-bdb2-c07a16c72b46@wanadoo.fr>
Date: Thu, 20 Aug 2026 22:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260806014813.1587003-1-daeho43@gmail.com>
Content-Language: en-US, fr-FR
In-Reply-To: <20260806014813.1587003-1-daeho43@gmail.com>
X-Headers-End: 1wx9Pb-0004dv-OR
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: support dynamic reserve/release for
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
From: Christophe JAILLET via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

TGUgMDYvMDgvMjAyNiDDoCAwMzo0OCwgRGFlaG8gSmVvbmcgYSDDqWNyaXTCoDoKPiBGcm9tOiBE
YWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+IAo+IFRoaXMgcGF0Y2ggYWRkcyBh
IGR5bmFtaWMgbWFuYWdlbWVudCBmZWF0dXJlIHRvIHRoZSBleGlzdGluZyBkZXZpY2UKPiBhbGlh
c2luZyBmdW5jdGlvbmFsaXR5LiBJdCBhbGxvd3MgdXNlcnMgdG8gZHluYW1pY2FsbHkgcmVzZXJ2
ZSBvcgo+IHJlbGVhc2Ugc3BlY2lmaWMgZGV2aWNlcyBmcm9tIHRoZSBmaWxlc3lzdGVtJ3MgZnJl
ZSBwb29sIGF0IHJ1bnRpbWUKPiB0aHJvdWdoIG5ldyBpb2N0bHMuCj4gCj4gVG8gc3VwcG9ydCB0
aGlzLCB0aHJlZSBuZXcgaW9jdGxzIGFyZSBpbnRyb2R1Y2VkOgo+IC0gRjJGU19JT0NfUkVTRVJW
RV9ERVZfQUxJQVM6IFRoaXMgcmVjbGFpbXMgdGhlIHNwYWNlIG9jY3VwaWVkIGJ5IGEKPiAgICBk
ZXZpY2UgYWxpYXNpbmcgZmlsZS4gSXQgZmlyc3QgcGVyZm9ybXMgYSBjYXBhY2l0eSBjaGVjaywg
cmVzZXRzIEdDCj4gICAgdmljdGltIGluZm9ybWF0aW9uIGZvciB0aGUgdGFyZ2V0IHJhbmdlLCBt
YXJrcyB0aGUgc2VnbWVudHMgYXMgaW4tdXNlCj4gICAgdG8gcHJldmVudCBuZXcgYWxsb2NhdGlv
bnMsIGFuZCB0aGVuIHRyaWdnZXJzIEdDIHRvIG1pZ3JhdGUgZXhpc3RpbmcKPiAgICB2YWxpZCBk
YXRhIG91dCBvZiB0aGUgcmFuZ2UuIEZpbmFsbHksIGl0IHJlc2VydmVzIHRoZXNlIGJsb2NrcyBp
biB0aGUKPiAgICBTSVQgdG8gZWZmZWN0aXZlbHkgZXhjbHVkZSB0aGUgZGV2aWNlIGZyb20gdGhl
IHVzYWJsZSBjYXBhY2l0eS4KPiAKPiAtIEYyRlNfSU9DX1JFTEVBU0VfREVWX0FMSUFTOiBUaGlz
IHJlbGVhc2VzIHRoZSByZXNlcnZlZCBzcGFjZSBvZiBhCj4gICAgcHJldmlvdXNseSByZXNlcnZl
ZCBkZXZpY2UgYWxpYXNpbmcgZmlsZS4gSXQgdHJ1bmNhdGVzIHRoZSBibG9ja3MKPiAgICBhc3Nv
Y2lhdGVkIHdpdGggdGhlIGZpbGUsIHdoaWNoIG1ha2VzIHRoZW0gYXZhaWxhYmxlIGZvciBnZW5l
cmFsCj4gICAgZmlsZXN5c3RlbSBhbGxvY2F0aW9uIGFnYWluLgo+IAo+IC0gRjJGU19JT0NfR0VU
X0RFVl9BTElBU19TVEFUVVM6IFRoaXMgcmV0cmlldmVzIHRoZSBjdXJyZW50IGFsaWFzaW5nCj4g
ICAgc3RhdHVzIG9mIGEgZGV2aWNlIGFsaWFzaW5nIGZpbGUsIHJldHVybmluZyB3aGV0aGVyIHRo
ZSBmaWxlIGlzCj4gICAgcmVsZWFzZWQgKGluYWN0aXZlIGFsaWFzKSBvciByZXNlcnZlZCAoYWN0
aXZlIGFsaWFzLCB3aXRoIGJsb2Nrcwo+ICAgIGZ1bGx5IGFsbG9jYXRlZCBvbiB0aGUgZGV2aWNl
KS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29t
PgoKSGksCgp0aGlzIHBhdGNoIGhhcyBhbHJlYWR5IHJlYWNoZWQgLW5leHQsIGJ1dCAyIGNvbW1l
bnRzIGJlbG93LCBzaG91bGQgdGhleSAKbWFrZSBhbnkgc2Vuc2UuCgo+IGRpZmYgLS1naXQgYS9m
cy9mMmZzL25hbWVpLmMgYi9mcy9mMmZzL25hbWVpLmMKPiBpbmRleCBjYWMwM2I4ZTkxYTEuLjhj
M2I1Nzk4N2Y2YyAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL25hbWVpLmMKPiArKysgYi9mcy9mMmZz
L25hbWVpLmMKPiBAQCAtNDI1LDYgKzQyNSw5IEBAIHN0YXRpYyBpbnQgZjJmc19saW5rKHN0cnVj
dCBkZW50cnkgKm9sZF9kZW50cnksIHN0cnVjdCBpbm9kZSAqZGlyLAo+ICAgCWlmICghZjJmc19p
c19jaGVja3BvaW50X3JlYWR5KHNiaSkpCj4gICAJCXJldHVybiAtRU5PU1BDOwo+ICAgCj4gKwlp
ZiAoSVNfREVWSUNFX0FMSUFTSU5HKGlub2RlKSkKPiArCQlyZXR1cm4gLUVQRVJNOwo+ICsKPiAg
IAllcnIgPSBmc2NyeXB0X3ByZXBhcmVfbGluayhvbGRfZGVudHJ5LCBkaXIsIGRlbnRyeSk7Cj4g
ICAJaWYgKGVycikKPiAgIAkJcmV0dXJuIGVycjsKPiBAQCAtNTY4LDYgKzU3MSw5IEBAIHN0YXRp
YyBpbnQgZjJmc191bmxpbmsoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRy
eSkKPiAgIAo+ICAgCXRyYWNlX2YyZnNfdW5saW5rX2VudGVyKGRpciwgZGVudHJ5KTsKPiAgIAo+
ICsJaWYgKElTX0RFVklDRV9BTElBU0lORyhpbm9kZSkpCj4gKwkJcmV0dXJuIC1FUEVSTTsKPiAr
CgpCYXNlZCBvbiBzdXJyb3VuZGluZyBnb3RvLCBzaG91bGQgdGhpcyBvbmUgYmU6CiAgICBlcnIg
PSAtRVBFUk0KICAgIGdvdG8gb3V0Owo/Cgo+ICAgCWlmICh1bmxpa2VseShmMmZzX2NwX2Vycm9y
KHNiaSkpKSB7Cj4gICAJCWVyciA9IC1FSU87Cj4gICAJCWdvdG8gb3V0Owo+IEBAIC05NDYsNiAr
OTUyLDkgQEAgc3RhdGljIGludCBmMmZzX3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwg
c3RydWN0IGlub2RlICpvbGRfZGlyLAo+ICAgCWJvb2wgb2xkX2lzX2RpciA9IFNfSVNESVIob2xk
X2lub2RlLT5pX21vZGUpOwo+ICAgCWludCBlcnI7Cj4gICAKPiArCWlmIChJU19ERVZJQ0VfQUxJ
QVNJTkcob2xkX2lub2RlKSkKPiArCQlyZXR1cm4gLUVQRVJNOwo+ICsKPiAgIAlpZiAodW5saWtl
bHkoZjJmc19jcF9lcnJvcihzYmkpKSkKPiAgIAkJcmV0dXJuIC1FSU87Cj4gICAJaWYgKCFmMmZz
X2lzX2NoZWNrcG9pbnRfcmVhZHkoc2JpKSkKPiBAQCAtMTAxNiw2ICsxMDI1LDggQEAgc3RhdGlj
IGludCBmMmZzX3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpv
bGRfZGlyLAo+ICAgCX0KPiAgIAo+ICAgCWlmIChuZXdfaW5vZGUpIHsKPiArCQlpZiAoSVNfREVW
SUNFX0FMSUFTSU5HKG5ld19pbm9kZSkpCj4gKwkJCXJldHVybiAtRVBFUk07CgpCYXNlZCBvbiBz
dXJyb3VuZGluZyBnb3RvLCBzaG91bGQgdGhpcyBvbmUgYmU6CiAgICBlcnIgPSAtRVBFUk0KICAg
IGdvdG8gb3V0X2RpcjsKPwoKPiAgIAo+ICAgCQllcnIgPSAtRU5PVEVNUFRZOwo+ICAgCQlpZiAo
b2xkX2lzX2RpciAmJiAhZjJmc19lbXB0eV9kaXIobmV3X2lub2RlKSkKPiBAQCAtMTE0Myw2ICsx
MTU0LDkgQEAgc3RhdGljIGludCBmMmZzX2Nyb3NzX3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9k
aXIsIHN0cnVjdCBkZW50cnkgKm9sZF9kZW50cnksCj4gICAJaW50IG9sZF9ubGluayA9IDAsIG5l
d19ubGluayA9IDA7Cj4gICAJaW50IGVycjsKPiAgIAo+ICsJaWYgKElTX0RFVklDRV9BTElBU0lO
RyhvbGRfaW5vZGUpIHx8IElTX0RFVklDRV9BTElBU0lORyhuZXdfaW5vZGUpKQo+ICsJCXJldHVy
biAtRVBFUk07Cj4gKwo+ICAgCWlmICh1bmxpa2VseShmMmZzX2NwX2Vycm9yKHNiaSkpKQo+ICAg
CQlyZXR1cm4gLUVJTzsKPiAgIAlpZiAoIWYyZnNfaXNfY2hlY2twb2ludF9yZWFkeShzYmkpKQpb
Li4uXQoKQ0oKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9saW51eC1mMmZzLWRldmVsCg==
