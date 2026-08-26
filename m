Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BC6C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 02:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YyZwuU2WJ8wtvt+5kSB4xRO5cM+jUc78rTDJSWFKXLQ=; b=OpXth0CEkDaYVnV1sc+ZnGTguK
	m+VD4nIbr4PUDNXkBXMyvzC1Wz/+ma70frLj3q0j5UdUohjz4w81EpmMKgOZpML6ZWjqzYa+/pF1Z
	7P0RuiCym6fS9muZKL7DgkEODMVGCrITDe/vwAJLfm1Y4l0e9WBoj91kTNClAAaABx4w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz31Y-0001iW-BS;
	Wed, 26 Aug 2026 02:05:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wz31W-0001iO-TC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 02:05:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0J2waooAcSrRdur5SJvzaqNMAL4mN58Jutv5/mxzKrQ=; b=N7Bqxn2pLJSBUWgbJsVJYbGUhl
 5oiN8Hl6yCN2Q94iH+baX2c3KnQHQuqv8v11AwLhEh0s4CpJJr/YWGC2u05G8c/S4rqbx3MM7/AbP
 uROMBJvFwiUwvit3jQGrGLkheaGKqpRngk3xLyA/mHfDi4jcIjZ01bna+pJS6+5DDb2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0J2waooAcSrRdur5SJvzaqNMAL4mN58Jutv5/mxzKrQ=; b=bHuOZqe0cTJYi1sy62ln1X8571
 /wyAFOBYUR7neAlmvtvdKr7jzqHJsU8vMlv97Ynz1ROtTx+L/g7xANkH5MKgjFGhP1IghmtgB5I9o
 m1CuZfMnGLHFzajkNyyshNWdnGImrO+cqSNjGF4JV3Vr0HHbDQoVfVugw3+oSjJ/92ug=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz31U-0001X6-8M for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 02:05:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43445600C4;
 Wed, 26 Aug 2026 02:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D411F000E9;
 Wed, 26 Aug 2026 02:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787709946;
 bh=0J2waooAcSrRdur5SJvzaqNMAL4mN58Jutv5/mxzKrQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=gMJ/DCzAAwLNLbZPDsTVR3INdJHGzQFKHkz1IvJO4awCBPF45KE2Emoh+BBqjihsK
 Ez+UO3OOgc9MluNCTraLRynUc6YsDJltdSy+x93BxQjuXMSVzTKxdL3EAhNdAOfZ1Y
 Q9Su/msxntPvt1sTb8LNeH1zjJ5k8lv9gAO/qHPWPrBgsTNJf+VAJIHwguXRqwNLzV
 A7q5J3c8GLrZf+2wIxhnefRERsVcagtzhnJnrPLqlDVsgMVh248jGL5O6huuBT4zHO
 rRkOSu+4Tn4mO39D1Pzus9bxobgITliKBw8H/OT658iHGBMNmLSjb8q2OZYyJqLO7Z
 rGzs73dVttiWA==
Message-ID: <0702a9a1-6f69-4c7e-8ab7-809d04526ce4@kernel.org>
Date: Wed, 26 Aug 2026 10:05:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, Wenjie Qi <qwjhust@gmail.com>
References: <20260825083738.526423-1-qiwenjie@xiaomi.com>
 <CACOAw_y0FwrNasvN5jWv4QLuXnuDhKW3hoOc3NM8vdX6oOxXYg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_y0FwrNasvN5jWv4QLuXnuDhKW3hoOc3NM8vdX6oOxXYg@mail.gmail.com>
X-Headers-End: 1wz31U-0001X6-8M
Subject: Re: [f2fs-dev] [PATCH] f2fs: propagate resizable_tail_secno mount
 option
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8yNS8yNiAyMzo0OCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gT24gVHVlLCBBdWcgMjUsIDIw
MjYgYXQgMTo0MuKAr0FNIFdlbmppZSBRaSA8cXdqaHVzdEBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+
PiBNb3VudCBwYXJzaW5nIHN0b3JlcyByZXNpemFibGVfdGFpbF9zZWNubyBpbiBGMkZTX0NUWF9J
TkZPKGN0eCksCj4+IGJ1dCBpdCBkb2VzIG5vdCBtYXJrIHRoZSBvcHRpb24gaW4gY3R4LT5zcGVj
X21hc2suIEFzIGEKPj4gcmVzdWx0LCBmMmZzX2FwcGx5X29wdGlvbnMoKSBuZXZlciBjb3BpZXMg
dGhlIHZhbHVlIGludG8KPj4gRjJGU19PUFRJT04oc2JpKSwgc28gYWRqdXN0X3Bpbm5lZF9hcmVh
X2JvdW5kYXJ5KCkgaWdub3Jlcwo+PiB0aGUgcmVxdWVzdGVkIHRhaWwgcmVzZXJ2YXRpb24uCj4+
Cj4+IFNldCB0aGUgbWlzc2luZyBzcGVjX21hc2sgYml0IGFuZCBwcm9wYWdhdGUgdGhlIHBhcnNl
ZCB2YWx1ZQo+PiB0aHJvdWdoIGYyZnNfYXBwbHlfb3B0aW9ucygpLgo+Pgo+PiBGaXhlczogZDg3
NDViYTI2MGFiICgiZjJmczogc3VwcG9ydCByZXNpemFibGUgdGFpbCBzZWN0aW9uIGFuZCB1bmlm
eSBwaW5uZWQgYWxsb2NhdGlvbiIpCj4+IFNpZ25lZC1vZmYtYnk6IFdlbmppZSBRaSA8cWl3ZW5q
aWVAeGlhb21pLmNvbT4KPj4gLS0tCj4+IFFFTVUgdmFsaWRhdGlvbiBzdW1tYXJ5Ogo+PiAtIHBs
YWluIG1vdW50IHJlcG9ydGVkIGBwaW5uZWRfYXJlYV9tYXhfc2Vjbm89NTAyYAo+PiAtIGAtbyBy
ZXNpemFibGVfdGFpbF9zZWNubz0xYCByZXBvcnRlZCBgcGlubmVkX2FyZWFfbWF4X3NlY25vPTUw
MWAKPj4gLSBib3VuZGVkIGZpbGwgc3RheWVkIHdpdGhpbiB0aGUgcmVkdWNlZCBib3VuZGFyeSB0
aHJvdWdoIHRoZSBmaXJzdAo+PiAgIGBGQUxMT0NfUkVUPS0xIEVSUk5PPTI4YAo+Pgo+PiAgZnMv
ZjJmcy9zdXBlci5jIHwgNSArKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zdXBlci5jIGIvZnMvZjJmcy9zdXBlci5jCj4+
IGluZGV4IGMxZTMxNTI4MmVjLi42MjM4ZGZlNmY0ZSAxMDA2NDQKPj4gLS0tIGEvZnMvZjJmcy9z
dXBlci5jCj4+ICsrKyBiL2ZzL2YyZnMvc3VwZXIuYwo+PiBAQCAtNDA2LDYgKzQwNiw3IEBAIHN0
YXRpYyBtYXRjaF90YWJsZV90IGYyZnNfY2hlY2twb2ludF90b2tlbnMgPSB7Cj4+ICAjZGVmaW5l
IEYyRlNfU1BFQ19lcnJvcnMgICAgICAgICAgICAgICAgICAgICAgICgxIDw8IDIzKQo+PiAgI2Rl
ZmluZSBGMkZTX1NQRUNfbG9va3VwX21vZGUgICAgICAgICAgICAgICAgICAoMSA8PCAyNCkKPj4g
ICNkZWZpbmUgRjJGU19TUEVDX3Jlc2VydmVfbm9kZSAgICAgICAgICAgICAgICAgKDEgPDwgMjUp
Cj4+ICsjZGVmaW5lIEYyRlNfU1BFQ19yZXNpemFibGVfdGFpbF9zZWNubyAgICAgICAgIEJJVCgy
NikKPj4KPj4gIHN0cnVjdCBmMmZzX2ZzX2NvbnRleHQgewo+PiAgICAgICAgIHN0cnVjdCBmMmZz
X21vdW50X2luZm8gaW5mbzsKPj4gQEAgLTEyNTAsNiArMTI1MSw3IEBAIHN0YXRpYyBpbnQgZjJm
c19wYXJzZV9wYXJhbShzdHJ1Y3QgZnNfY29udGV4dCAqZmMsIHN0cnVjdCBmc19wYXJhbWV0ZXIg
KnBhcmFtKQo+PiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4+ICAgICAgICAgY2FzZSBPcHRfcmVz
aXphYmxlX3RhaWxfc2Vjbm86Cj4+ICAgICAgICAgICAgICAgICBGMkZTX0NUWF9JTkZPKGN0eCku
cmVzaXphYmxlX3RhaWxfc2Vjbm8gPSByZXN1bHQudWludF8zMjsKPj4gKyAgICAgICAgICAgICAg
IGN0eC0+c3BlY19tYXNrIHw9IEYyRlNfU1BFQ19yZXNpemFibGVfdGFpbF9zZWNubzsKPj4gICAg
ICAgICAgICAgICAgIGJyZWFrOwo+PiAgICAgICAgIH0KPj4gICAgICAgICByZXR1cm4gMDsKPj4g
QEAgLTE3NzksNiArMTc4MSw5IEBAIHN0YXRpYyB2b2lkIGYyZnNfYXBwbHlfb3B0aW9ucyhzdHJ1
Y3QgZnNfY29udGV4dCAqZmMsIHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCj4+ICAgICAgICAgICAg
ICAgICBGMkZTX09QVElPTihzYmkpLmVycm9ycyA9IEYyRlNfQ1RYX0lORk8oY3R4KS5lcnJvcnM7
Cj4+ICAgICAgICAgaWYgKGN0eC0+c3BlY19tYXNrICYgRjJGU19TUEVDX2xvb2t1cF9tb2RlKQo+
PiAgICAgICAgICAgICAgICAgRjJGU19PUFRJT04oc2JpKS5sb29rdXBfbW9kZSA9IEYyRlNfQ1RY
X0lORk8oY3R4KS5sb29rdXBfbW9kZTsKPj4gKyAgICAgICBpZiAoY3R4LT5zcGVjX21hc2sgJiBG
MkZTX1NQRUNfcmVzaXphYmxlX3RhaWxfc2Vjbm8pCj4+ICsgICAgICAgICAgICAgICBGMkZTX09Q
VElPTihzYmkpLnJlc2l6YWJsZV90YWlsX3NlY25vID0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBGMkZTX0NUWF9JTkZPKGN0eCkucmVzaXphYmxlX3RhaWxfc2Vjbm87Cj4gCj4g
SGkgV2VuamllLAo+IAo+IFRoZSBvcmlnaW5hbCBwYXRjaCBpcyBzdGlsbCB1bmRlciByZXZpZXcu
IElmIHlvdSBmb3VuZCBhbiBpc3N1ZSBvcgo+IGhhdmUgZmVlZGJhY2ssIHBsZWFzZSByZXBseSB3
aXRoIGEgcmV2aWV3IGNvbW1lbnQgb24gdGhlIG9yaWdpbmFsCj4gcGF0Y2ggdGhyZWFkIGluc3Rl
YWQuCj4gCj4gQWxzbywgaWYgdGhpcyBwYXRjaCB3YXMgYXV0by1nZW5lcmF0ZWQgYnkgQUksIHBs
ZWFzZSBhZGp1c3QgeW91cgo+IHN5c3RlbSBhY2NvcmRpbmdseS4KCkhpIFdlbmppZSwKCkkgYWdy
ZWUgdy8gRGFlaG8sIHBsZWFzZSBhZGp1c3QgcG9saWN5IHRvIGdpdmUgY29tbWVudCBvbiBwZW5k
aW5nIHBhdGNoCnJhdGhlciB0aGFuIGp1c3QgcGF0Y2hpbmcgdy8gYSBuZXcgb25lLgoKVGhhbmtz
LAoKPiAKPiBUaGFua3MsCj4gCj4+Cj4+ICAgICAgICAgZjJmc19hcHBseV9jb21wcmVzc2lvbihm
Yywgc2IpOwo+PiAgICAgICAgIGYyZnNfYXBwbHlfdGVzdF9kdW1teV9lbmNyeXB0aW9uKGZjLCBz
Yik7Cj4+Cj4+IGJhc2UtY29tbWl0OiBkODc0NWJhMjYwYWJiY2FmNzVmZDQ1ODg4MTM4MTAxOWFi
M2M1YzA3Cj4+IC0tCj4+IDIuNDMuMAo+Pgo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+PiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+
PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+PiBodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2
ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2
ZWwK
