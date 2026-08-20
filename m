Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC0AC5DF82
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=14D8HXGHMPjVrZGFUAUUdArHnuJCHLcYpHDd3GlQtKQ=; b=Nm0vDhZZpmeI0jFvZPul9MPuLn
	KEw15mBaN6TzFKi5zQrirxB3D6Seu7Q/8MYcfRNg78AlroXE3ePA/zy0fWrb0t28bMjLaeFfR5RLM
	m364/RBLraGPEmK+iqg7gX37iQniNtCYPvlyzIyIMavl3gc2FvG4TQGJA+nLbJbWNBGg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwx5F-0003S4-V7;
	Thu, 20 Aug 2026 07:21:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwx5E-0003Rn-90
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 07:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/fqovBIP09GTfmPeRatEDRe7nIZ9H7E/7p0NxkSlJGw=; b=KV54PheMR1yDatIbg13A2c+vSN
 EiaET/c4lj1tO9rfO0tIsLjCaGvayL84/v8ii/3nWCXn6asgvXqu61DpAVkbCIBwW0vhRx8/QYM51
 hIRgNYnQmtDEPX3O07uSd7Fg19L1USzzaOeudb0RZIr8N5nx3GzQ3YrZZMzcQesCrknc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/fqovBIP09GTfmPeRatEDRe7nIZ9H7E/7p0NxkSlJGw=; b=Lylpmw+7Y9ZiyiHsIWFQ/31OsC
 UORpGCmEEGWBRv5bfU0Zbe/5NVXgv6tJnalq7OBbCoDDGLn6Wf4NHTSUJdzkn92Ikqb2p9YvNnSIk
 O7weEC6RaeHdAQE2p8+EPXWG2fy0pb/aFuKiYO7jjd/LOOPDYkH4ACH1Tx/iJtLOH9vw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwx5D-0003dd-Ct for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 07:21:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C85B860AA9;
 Thu, 20 Aug 2026 07:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E401F000E9;
 Thu, 20 Aug 2026 07:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787210457;
 bh=/fqovBIP09GTfmPeRatEDRe7nIZ9H7E/7p0NxkSlJGw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=afRmFp+UkMwdTZvTFqW3g/F/TdnUJt6GVYLUtdEyw9yRVGEvwpWOW8GInBkxlwptV
 miE3ed/VI7UtSMssjx6AIBoNgadDpL+aNkcDCOWaAaAjTItrt3kHDqdZsp0YQEGq21
 l3XUY9p59PjZZ/WLOO2DLcWqnufGXqZbz3N1eZBNOviDnImWdlhc+cIpoqCxt1m3HX
 HHDd05eaqaTETBIpHwPHggzTws9J2ESQBa6bwzSKxrrbFN+5qdrdTOpm1hxYPUBbiM
 8LqvtLWfEMs+5nHjV1zMXRVcOKRKj5jCKgBLhZ5rrInE+nMjMgA/3+jT40QuuS7VKL
 xLT+Z4SiUWDyQ==
Message-ID: <746c8f52-cf7c-4f63-b2e1-36e0cad940a1@kernel.org>
Date: Thu, 20 Aug 2026 15:20:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260818170535.3190869-1-daeho43@gmail.com>
 <6b55a4e9-e4a0-421c-9bb6-98ffc2c915c9@kernel.org>
 <CACOAw_xSS78P_c8ZWXGDadxa+xFAVWWN0kAx1QMrujVuruBYsQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_xSS78P_c8ZWXGDadxa+xFAVWWN0kAx1QMrujVuruBYsQ@mail.gmail.com>
X-Headers-End: 1wwx5D-0003dd-Ct
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid setting SBI_NEED_FSCK on
 transient resize failure with -EAGAIN
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8yMC8yNiAwMjoyMSwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gT24gVHVlLCBBdWcgMTgsIDIw
MjYgYXQgNzozNOKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+Cj4+IE9u
IDgvMTkvMjYgMDE6MDUsIERhZWhvIEplb25nIHdyb3RlOgo+Pj4gRnJvbTogRGFlaG8gSmVvbmcg
PGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPj4+Cj4+PiBXaGVuIGYyZnNfcmVzaXplX2ZzKCkgZmFp
bHMgZHVlIHRvIHRyYW5zaWVudCBsb2NrIGNvbnRlbnRpb24gb3IgcmV0cnlhYmxlCj4+PiBHQyBm
YWlsdXJlIGluIGZyZWVfc2VnbWVudF9yYW5nZSgpIHJldHVybmluZyAtRUFHQUlOLCBubyBmaWxl
c3lzdGVtCj4+PiBtZXRhZGF0YSBoYXMgYmVlbiBtb2RpZmllZCBvbi1kaXNrIHlldC4gVGhlIGZp
bGVzeXN0ZW0gcmVtYWlucyBjb21wbGV0ZWx5Cj4+PiBjb25zaXN0ZW50IGFuZCBjbGVhbi4KPj4K
Pj4gQW55IHdheSB0byBtYWtlIHN1cmUgRUFHQUlOIGlzIGZyb20gZnJlZV9zZWdtZW50X3Jhbmdl
KCksIGluIGNhc2Ugd2UgcmV0dXJuCj4+IEVBR0FJTiBmcm9tIDEpIGFueSBvdGhlciBwbGFjZXMg
dGhhdCB3ZSBtYXkgbWlzcyB0byBjaGVjayBub3cgb3IgMikgd2UgY2hhbmdlZAo+PiB0aGUgY29k
ZSB0byByZXR1cm4gRUFHQUlOIGluIGZ1dHVyZS4KPiAKPiBNYWtlcyBzZW5zZS4KPiAKPiBJbiBm
YWN0LCBpZiBmcmVlX3NlZ21lbnRfcmFuZ2UoKSBmYWlscyB3aXRoIEFOWSBlcnJvciAoZS5nLiwg
LUVBR0FJTiwKPiAtRU5PTUVNLCAtRVJFU1RBUlRTWVMsIGV0Yy4pLCBubyBvbi1kaXNrIHN1cGVy
YmxvY2sgb3IgZmlsZXN5c3RlbSBtZXRhZGF0YQo+IGhhcyBiZWVuIG1vZGlmaWVkIHlldCwgYW5k
IGZyZWVfc2VnbWVudF9yYW5nZSgpIHNhZmVseSByZXN0b3JlcyBhbGwgaW4tbWVtb3J5Cj4gY291
bnRlcnMgKE1BSU5fU0VDUywgZnJlZV9zZWN0aW9ucykgYmVmb3JlIHJldHVybmluZy4gVGhlcmVm
b3JlLCBzZXR0aW5nCj4gU0JJX05FRURfRlNDSyBpcyBub3QgbmVlZGVkIGZvciBhbGwgZXJyb3Jz
IG9jY3VycmluZyBpbiBmcmVlX3NlZ21lbnRfcmFuZ2UoKS4KClllYWgsIGJldHRlci4KCj4gCj4g
VG8gbWFrZSB0aGlzIGV4cGxpY2l0IGFuZCBkZWZlbnNpdmUgYWdhaW5zdCBhbnkgZnV0dXJlIGNo
YW5nZXMsIHdlIGNhbgo+IHNlcGFyYXRlIHRoZSBlcnJvciByZWNvdmVyeSBwYXRoIHdpdGggZGVk
aWNhdGVkIGxhYmVscyBhcyBmb2xsb3dzOgo+IAo+ICAgZXJyID0gZnJlZV9zZWdtZW50X3Jhbmdl
KHNiaSwgc2VjcywgZmFsc2UpOwo+ICAgaWYgKGVycikKPiAtIGdvdG8gcmVjb3Zlcl9vdXQ7Cj4g
KyBnb3RvIHJlY292ZXJfdXNlcl9ibG9ja3M7Cj4gCj4gICB1cGRhdGVfc2JfbWV0YWRhdGEoc2Jp
LCAtc2Vjcyk7Cj4gCj4gLi4uCj4gCj4gIHJlY292ZXJfb3V0Ogo+ICsgc2V0X3NiaV9mbGFnKHNi
aSwgU0JJX05FRURfRlNDSyk7Cj4gKyBmMmZzX2VycihzYmksICJyZXNpemVfZnMgZmFpbGVkLCBz
aG91bGQgcnVuIGZzY2sgdG8gcmVwYWlyISIpOwo+ICtyZWNvdmVyX3VzZXJfYmxvY2tzOgoKSG93
IGFib3V0IHRoaXM/CgpyZWNvdmVyX291dDoKCWlmIChlcnIpIHsKCQlmMmZzX2J1Z19vbihzYmks
IGVyciA9PSAtRUFHQUlOKTsKCQlzZXRfc2JpX2ZsYWcoc2JpLCBTQklfTkVFRF9GU0NLKTsKCQlm
MmZzX2VycihzYmksICJyZXNpemVfZnMgZmFpbGVkLCBzaG91bGQgcnVuIGZzY2sgdG8gcmVwYWly
ISIpOwoJfQoKcmVjb3Zlcl91c2VyX2Jsb2NrczoKClRoYW5rcywKCj4gICBjbGVhcl9zYmlfZmxh
ZyhzYmksIFNCSV9JU19SRVNJWkVGUyk7Cj4gICBpZiAoZXJyKSB7Cj4gLSBzZXRfc2JpX2ZsYWco
c2JpLCBTQklfTkVFRF9GU0NLKTsKPiAtIGYyZnNfZXJyKHNiaSwgInJlc2l6ZV9mcyBmYWlsZWQs
IHNob3VsZCBydW4gZnNjayB0byByZXBhaXIhIik7Cj4gLQo+ICAgc3Bpbl9sb2NrKCZzYmktPnN0
YXRfbG9jayk7Cj4gICBzYmktPnVzZXJfYmxvY2tfY291bnQgKz0gc2hydW5rX2Jsb2NrczsKPiAg
IHNwaW5fdW5sb2NrKCZzYmktPnN0YXRfbG9jayk7Cj4gCj4gVGhhbmtzLAo+IAo+Pgo+PiBUaGFu
a3MsCj4+Cj4+Pgo+Pj4gSG93ZXZlciwgdGhlIGN1cnJlbnQgZXJyb3IgcmVjb3ZlcnkgcGF0aCB1
bmNvbmRpdGlvbmFsbHkgc2V0cyB0aGUKPj4+IFNCSV9ORUVEX0ZTQ0sgZmxhZyBvbiBhbnkgZXJy
b3IsIGZvcmNpbmcgYW4gdW5uZWNlc3NhcnkgYW5kIHRpbWUtY29uc3VtaW5nCj4+PiBmc2NrLmYy
ZnMgcmVwYWlyIG9uIHRoZSBzdWJzZXF1ZW50IG1vdW50L3JlYm9vdC4KPj4+Cj4+PiBGaXggdGhp
cyBieSBndWFyZGluZyBzZXRfc2JpX2ZsYWcoc2JpLCBTQklfTkVFRF9GU0NLKSB3aXRoCj4+PiBg
aWYgKGVyciAhPSAtRUFHQUlOKWAsIGF2b2lkaW5nIGZhbHNlLXBvc2l0aXZlIGZpbGVzeXN0ZW0g
Y29ycnVwdGlvbgo+Pj4gZmxhZ3Mgb24gdHJhbnNpZW50IHJlc2l6ZSByZXRyaWVzLgo+Pj4KPj4+
IFNpZ25lZC1vZmYtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4+PiBT
aWduZWQtb2ZmLWJ5OiBTdW5taW4gSmVvbmcgPHNfbWluLmplb25nQHNhbXN1bmcuY29tPgo+Pj4g
LS0tCj4+PiAgZnMvZjJmcy9nYy5jIHwgNiArKysrLS0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9mcy9mMmZz
L2djLmMgYi9mcy9mMmZzL2djLmMKPj4+IGluZGV4IDE5MmIxNmFjMDJmOC4uNzg3MTMzZWUyZWIy
IDEwMDY0NAo+Pj4gLS0tIGEvZnMvZjJmcy9nYy5jCj4+PiArKysgYi9mcy9mMmZzL2djLmMKPj4+
IEBAIC0yNDQ2LDggKzI0NDYsMTAgQEAgaW50IGYyZnNfcmVzaXplX2ZzKHN0cnVjdCBmaWxlICpm
aWxwLCBfX3U2NCBibG9ja19jb3VudCkKPj4+ICByZWNvdmVyX291dDoKPj4+ICAgICAgIGNsZWFy
X3NiaV9mbGFnKHNiaSwgU0JJX0lTX1JFU0laRUZTKTsKPj4+ICAgICAgIGlmIChlcnIpIHsKPj4+
IC0gICAgICAgICAgICAgc2V0X3NiaV9mbGFnKHNiaSwgU0JJX05FRURfRlNDSyk7Cj4+PiAtICAg
ICAgICAgICAgIGYyZnNfZXJyKHNiaSwgInJlc2l6ZV9mcyBmYWlsZWQsIHNob3VsZCBydW4gZnNj
ayB0byByZXBhaXIhIik7Cj4+PiArICAgICAgICAgICAgIGlmIChlcnIgIT0gLUVBR0FJTikgewo+
Pj4gKyAgICAgICAgICAgICAgICAgICAgIHNldF9zYmlfZmxhZyhzYmksIFNCSV9ORUVEX0ZTQ0sp
Owo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGYyZnNfZXJyKHNiaSwgInJlc2l6ZV9mcyBmYWls
ZWQsIHNob3VsZCBydW4gZnNjayB0byByZXBhaXIhIik7Cj4+PiArICAgICAgICAgICAgIH0KPj4+
Cj4+PiAgICAgICAgICAgICAgIHNwaW5fbG9jaygmc2JpLT5zdGF0X2xvY2spOwo+Pj4gICAgICAg
ICAgICAgICBzYmktPnVzZXJfYmxvY2tfY291bnQgKz0gc2hydW5rX2Jsb2NrczsKPj4KCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1k
ZXZlbAo=
