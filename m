Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A1DCD8CB2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tTRSxZTvD6UrS9akVDIYdoqxxWFLyPib0sPaUKlT0I0=; b=I4OBC5OU0qx68DrKj/WGDdX6Up
	4dyH3c7r2H5f+9DnxTTVhQTnpRnMOqy05dI4t2LhATKh3PzsGFKe3s7gyotY/JKS1Hi9gY0iUi4i6
	4fyN2AKwoFE0qd4hPWuoUgNqs2nKhqRYfSIzTd69FvwfFvslc5HdzDp0Md249msQjhC4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXGrq-0000YD-AP;
	Wed, 10 Jun 2026 11:13:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXGro-0000Xw-CV
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RgGWx+heAj+7S+ELvNVejwrAVzsVIXQkb484Oqk79Lc=; b=RsTFvz203biI5wUOq/rH5cucew
 OJmhSdUXYK+PM3wf9t6VgEethGW6iBorpRlNLSY//zqNzHXt7xFx0aGUWApU7RaOm6dwFvi8DYkV0
 KKHiEUpwM2bIL+lntGGp54Vem8IOlsi+VI9tl1IlPMNJrGbt4/5SV+DP4Em935b+hHN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RgGWx+heAj+7S+ELvNVejwrAVzsVIXQkb484Oqk79Lc=; b=L1kfz+Zy5eNz2PBeeFk9VBZiLa
 gXQap5JDjsnqla1cqA0Y3rYAA0m/Eza/lIF7FZQwxKwo5e/6RNmjQGXhTMdBGpxvpJkDeLwvg1GC3
 bcWeTlvD1Otj6D2qKBSoDUonpI1cgcnW0y7epgEae5d2N1+Xh5Qf+VwSDlRuMTC3cGgo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXGrn-0005Dq-1Q for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:13:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D83C360540;
 Wed, 10 Jun 2026 11:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E4D1F00893;
 Wed, 10 Jun 2026 11:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781089972;
 bh=RgGWx+heAj+7S+ELvNVejwrAVzsVIXQkb484Oqk79Lc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=HuiTBgSckLZuG5vLXqcSTnQOyO9rjv42gGQv2M7UCIFSGD6t05eyUWLOEtOCyoELA
 I6F4NtYeh5jU7CUgDP/oeCCr6sg/uX24yIC1L5BdVGX4+WI/DVV2ARYSnH80/bmxDD
 +4DUZKYl8vq76knX0OoaSmgWZFWlilNh1Uj8t6n32tiEHI5RlF/8xksK3VVBYsvPO3
 8+RdqT53g2Z7E6zG0n/EzXf9LLHxyvJutfFPu6eoxzPFepPncFfA+IDPzwThzqz18H
 7Tlp8rupL3cwVD6pEwQk6/bU0ynkTRX/ICpyG5bazhW0hm4TrBdBA+7CmkqtVf6TQ3
 LJ2bVKqNIdKGQ==
Message-ID: <64e16f06-e7de-404f-9424-bedb9067d90f@kernel.org>
Date: Wed, 10 Jun 2026 19:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260526034439.1017521-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260526034439.1017521-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wXGrn-0005Dq-1Q
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid cp_wait use-after-free in
 f2fs_write_end_io()
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNS8yNi8yNiAxMTo0NCwgV2VuamllIFFpIHdyb3RlOgo+IGYyZnNfd3JpdGVfZW5kX2lvKCkg
ZGVjcmVtZW50cyB0aGUgd3JpdGViYWNrIHBhZ2UgY291bnRlciBiZWZvcmUgd2FraW5nCj4gc2Jp
LT5jcF93YWl0IGZvciB0aGUgbGFzdCBGMkZTX1dCX0NQX0RBVEEgY29tcGxldGlvbi4KPiAKPiBU
aGF0IGRlY3JlbWVudCBjYW4gZHJvcCB0aGUgRjJGU19XQl9DUF9EQVRBIGNvdW50IHRvIHplcm8u
IEl0IGNhbiB1bmJsb2NrCj4gYSBjb25jdXJyZW50IHVubW91bnQgcGF0aCB3YWl0aW5nIGluIGYy
ZnNfd2FpdF9vbl9hbGxfcGFnZXMoKS4gVW5tb3VudCBjYW4KPiB0aGVuIGNvbnRpbnVlIHRocm91
Z2ggZjJmc19wdXRfc3VwZXIoKSBhbmQgZnJlZSBzYmkgd2hpbGUgdGhlIGVuZF9pbwo+IGNhbGxi
YWNrIGlzIHN0aWxsIGFib3V0IHRvIGV2YWx1YXRlIHdxX2hhc19zbGVlcGVyKCkgYW5kIHdha2Vf
dXAoKSBvbgo+IHNiaS0+Y3Bfd2FpdC4KPiAKPiBDb21taXQgMmQ5YzRhNGVkNGVlICgiZjJmczog
Zml4IFVBRiBjYXVzZWQgYnkgZGVjcmVtZW50aW5nCj4gc2JpLT5ucl9wYWdlc1tdIGluIGYyZnNf
d3JpdGVfZW5kX2lvKCkiKSBmaXhlZCBvbmUgcG9zdC1kZWNyZW1lbnQgc2JpCj4gYWNjZXNzIGJ5
IG1vdmluZyB0aGUgd2FybS1ub2RlLWxpc3QgaGFuZGxpbmcgYmVmb3JlIGRlY19wYWdlX2NvdW50
KCkuIFRoZQo+IGNvbXByZXNzZWQgd3JpdGViYWNrIHBhdGggZm9sbG93cyB0aGUgc2FtZSBydWxl
IGFuZCBkb2N1bWVudHMgdGhhdAo+IHNiaSBhY2Nlc3NlcyBtdXN0IGhhcHBlbiBiZWZvcmUgZGVj
X3BhZ2VfY291bnQoKSBjYW4gZHJvcCB0aGUKPiBGMkZTX1dCX0NQX0RBVEEgY291bnQgdG8gemVy
by4KPiAKPiBVc2UgYXRvbWljX2RlY19hbmRfbG9ja19pcnFzYXZlKCkgZm9yIEYyRlNfV0JfQ1Bf
REFUQSBjb21wbGV0aW9ucyBzbyB0aGUKPiB6ZXJvIHRyYW5zaXRpb24gaXMgc2VyaWFsaXplZCB3
aXRoIGNwX3dhaXQubG9jay4gV2hlbiB0aGUgY291bnQgcmVhY2hlcwo+IHplcm8sIHdha2Ugd2Fp
dGVycyB3aGlsZSBob2xkaW5nIHRoZSBzYW1lIGxvY2suCj4gCj4gSW4gZjJmc193YWl0X29uX2Fs
bF9wYWdlcygpLCBwcmVwYXJlIHRoZSB3YWl0ZXIgYW5kIHJlY2hlY2sgdGhlIHBhZ2UgY291bnQK
PiB3aGlsZSBob2xkaW5nIGNwX3dhaXQubG9jayBiZWZvcmUgc2xlZXBpbmcuIFRoaXMga2VlcHMg
dGhlIHdha2V1cCB2aXNpYmxlCj4gdG8gd2FpdGVycyB3aXRob3V0IHJlcXVpcmluZyB0aGUgZW5k
X2lvIGNhbGxiYWNrIHRvIGFjY2VzcyBzYmkgYWZ0ZXIgdGhlCj4gRjJGU19XQl9DUF9EQVRBIGNv
dW50IGhhcyByZWFjaGVkIHplcm8uIEl0IGFsc28gYXZvaWRzIGEgbWlzc2VkIHdha2V1cCB0aGF0
Cj4gd291bGQgb3RoZXJ3aXNlIG1ha2UgdGhlIHdhaXRlciBzbGVlcCB1bnRpbCBERUZBVUxUX1ND
SEVEVUxFX1RJTUVPVVQuCj4gCj4gRml4ZXM6IGNlMjczOWU0ODJiYyAoImYyZnM6IGZpeCB0byBh
dm9pZCBVQUYgaW4gZjJmc193cml0ZV9lbmRfaW8oKSIpCj4gQ2M6IHN0YWJsZUBrZXJuZWwub3Jn
Cj4gU2lnbmVkLW9mZi1ieTogV2VuamllIFFpIDxxaXdlbmppZUB4aWFvbWkuY29tPgo+IC0tLQo+
ICBmcy9mMmZzL2NoZWNrcG9pbnQuYyB8IDIwICsrKysrKysrKysrKysrKysrKy0tCj4gIGZzL2Yy
ZnMvZGF0YS5jICAgICAgIHwgMjUgKysrKysrKysrKysrKysrKystLS0tLS0tLQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9mcy9mMmZzL2NoZWNrcG9pbnQuYyBiL2ZzL2YyZnMvY2hlY2twb2ludC5jCj4gaW5kZXgg
YzAwYTZiNmViY2JkLi5iMTZkMmQzMGVjNmEgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9jaGVja3Bv
aW50LmMKPiArKysgYi9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+IEBAIC0xNDk3LDI0ICsxNDk3LDQw
IEBAIHN0YXRpYyB2b2lkIHVuYmxvY2tfb3BlcmF0aW9ucyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpz
YmkpCj4gIAlmMmZzX3VubG9ja19hbGwoc2JpKTsKPiAgfQo+ICAKPiArc3RhdGljIGJvb2wgZjJm
c19wcmVwYXJlX2NwX3dhaXQoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+ICsJCQkJIHN0cnVj
dCB3YWl0X3F1ZXVlX2VudHJ5ICp3YWl0LCBpbnQgdHlwZSkKPiArewo+ICsJdW5zaWduZWQgbG9u
ZyBmbGFnczsKPiArCWJvb2wgd2FpdF9tb3JlOwo+ICsKPiArCXByZXBhcmVfdG9fd2FpdCgmc2Jp
LT5jcF93YWl0LCB3YWl0LCBUQVNLX1VOSU5URVJSVVBUSUJMRSk7Cj4gKwlzcGluX2xvY2tfaXJx
c2F2ZSgmc2JpLT5jcF93YWl0LmxvY2ssIGZsYWdzKTsKPiArCXdhaXRfbW9yZSA9IGdldF9wYWdl
cyhzYmksIHR5cGUpOwo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2JpLT5jcF93YWl0Lmxv
Y2ssIGZsYWdzKTsKPiArCj4gKwlyZXR1cm4gd2FpdF9tb3JlOwo+ICt9Cj4gKwo+ICB2b2lkIGYy
ZnNfd2FpdF9vbl9hbGxfcGFnZXMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBpbnQgdHlwZSkK
PiAgewo+ICAJREVGSU5FX1dBSVQod2FpdCk7Cj4gIAo+ICAJZm9yICg7Oykgewo+IC0JCWlmICgh
Z2V0X3BhZ2VzKHNiaSwgdHlwZSkpCj4gKwkJaWYgKCFmMmZzX3ByZXBhcmVfY3Bfd2FpdChzYmks
ICZ3YWl0LCB0eXBlKSkKPiAgCQkJYnJlYWs7Cj4gIAo+ICAJCWlmICh1bmxpa2VseShmMmZzX2Nw
X2Vycm9yKHNiaSkgJiYKPiAgCQkJIWlzX3NiaV9mbGFnX3NldChzYmksIFNCSV9JU19DTE9TRSkp
KQo+ICAJCQlicmVhazsKPiArCQlmaW5pc2hfd2FpdCgmc2JpLT5jcF93YWl0LCAmd2FpdCk7Cj4g
IAo+ICAJCWlmICh0eXBlID09IEYyRlNfRElSVFlfTUVUQSkKPiAgCQkJZjJmc19zeW5jX21ldGFf
cGFnZXMoc2JpLCBMT05HX01BWCwgRlNfQ1BfTUVUQV9JTyk7Cj4gIAkJZWxzZSBpZiAodHlwZSA9
PSBGMkZTX1dCX0NQX0RBVEEpCj4gIAkJCWYyZnNfc3VibWl0X21lcmdlZF93cml0ZShzYmksIERB
VEEpOwo+ICAKPiAtCQlwcmVwYXJlX3RvX3dhaXQoJnNiaS0+Y3Bfd2FpdCwgJndhaXQsIFRBU0tf
VU5JTlRFUlJVUFRJQkxFKTsKPiArCQlpZiAoIWYyZnNfcHJlcGFyZV9jcF93YWl0KHNiaSwgJndh
aXQsIHR5cGUpKQo+ICsJCQlicmVhazsKPiAgCQlpb19zY2hlZHVsZV90aW1lb3V0KERFRkFVTFRf
U0NIRURVTEVfVElNRU9VVCk7Cj4gIAl9Cj4gIAlmaW5pc2hfd2FpdCgmc2JpLT5jcF93YWl0LCAm
d2FpdCk7Cj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMKPiBp
bmRleCBkODNhMjE5OThlYzIuLmQ5MmYwYjcwYmEyZiAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL2Rh
dGEuYwo+ICsrKyBiL2ZzL2YyZnMvZGF0YS5jCj4gQEAgLTM5MiwxNSArMzkyLDI0IEBAIHN0YXRp
YyB2b2lkIGYyZnNfd3JpdGVfZW5kX2lvKHN0cnVjdCBiaW8gKmJpbykKPiAgCQlpZiAoZjJmc19p
bl93YXJtX25vZGVfbGlzdChmb2xpbykpCj4gIAkJCWYyZnNfZGVsX2ZzeW5jX25vZGVfZW50cnko
c2JpLCBmb2xpbyk7Cj4gIAo+IC0JCWRlY19wYWdlX2NvdW50KHNiaSwgdHlwZSk7Cj4gKwkJaWYg
KHR5cGUgPT0gRjJGU19XQl9DUF9EQVRBKSB7Cj4gKwkJCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4g
IAo+IC0JCS8qCj4gLQkJICogd2Ugc2hvdWxkIGFjY2VzcyBzYmkgYmVmb3JlIGZvbGlvX2VuZF93
cml0ZWJhY2soKSB0bwo+IC0JCSAqIGF2b2lkIHJhY2luZyB3LyBraWxsX2YyZnNfc3VwZXIoKQo+
IC0JCSAqLwo+IC0JCWlmICh0eXBlID09IEYyRlNfV0JfQ1BfREFUQSAmJiAhZ2V0X3BhZ2VzKHNi
aSwgdHlwZSkgJiYKPiAtCQkJCXdxX2hhc19zbGVlcGVyKCZzYmktPmNwX3dhaXQpKQo+IC0JCQl3
YWtlX3VwKCZzYmktPmNwX3dhaXQpOwo+ICsJCQkvKgo+ICsJCQkgKiBIb2xkIGNwX3dhaXQubG9j
ayBhY3Jvc3MgdGhlIHplcm8gdHJhbnNpdGlvbiBhbmQgdGhlCj4gKwkJCSAqIHdha2V1cCBzbyBm
MmZzX3dhaXRfb25fYWxsX3BhZ2VzKCkgY2Fubm90IG1pc3MgaXQgb3IKPiArCQkJICogZnJlZSBz
YmkgYmVmb3JlIHRoaXMgY2FsbGJhY2sgc3RvcHMgdG91Y2hpbmcgY3Bfd2FpdC4KPiArCQkJICov
Cj4gKwkJCWlmIChhdG9taWNfZGVjX2FuZF9sb2NrX2lycXNhdmUoJnNiaS0+bnJfcGFnZXNbdHlw
ZV0sCj4gKwkJCQkJCQkmc2JpLT5jcF93YWl0LmxvY2ssCj4gKwkJCQkJCQlmbGFncykpIHsKCgkJ
aWYgKGF0b21pY19kZWNfcmV0dXJuKCZzYmktPm5yX3BhZ2VzW3R5cGVdKSAmJgoJCQkJd3FfaGFz
X3NsZWVwZXIoJnNiaS0+Y3Bfd2FpdCnvvIkKCQkJd2FrZV91cCgmc2JpLT5jcF93YWl0KTsKCklz
IGl0IGVub3VnaCB0byBzb2x2ZSB0aGUgaXNzdWU/CgpUaGFua3MsCgo+ICsJCQkJd2FrZV91cF9s
b2NrZWQoJnNiaS0+Y3Bfd2FpdCk7Cj4gKwkJCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzYmkt
PmNwX3dhaXQubG9jaywKPiArCQkJCQkJICAgICAgIGZsYWdzKTsKPiArCQkJfQo+ICsJCX0gZWxz
ZSB7Cj4gKwkJCWRlY19wYWdlX2NvdW50KHNiaSwgdHlwZSk7Cj4gKwkJfQo+ICAKPiAgCQlmb2xp
b19jbGVhcl9mMmZzX2djaW5nKGZvbGlvKTsKPiAgCQlmb2xpb19lbmRfd3JpdGViYWNrKGZvbGlv
KTsKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
