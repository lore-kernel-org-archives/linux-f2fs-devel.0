Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B1ED7B87
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P31syXPtbvDCC02vMScvS9N4VNFQPDxO/qF7aqL7Zzo=; b=VxE5UULxfJthNVxfvqufApLdpu
	fySaIKjEIxGdbTDhqYd2k8+muR0Lb73/yP8/m2ZsytYrX2DpRd3V60k89rhPppmsVSjZ4si1e4L34
	+AunKrQxzmUJljLB/EHQ5ijwA/cXN6Osg3hEJ/rGGy8lRG1VQ6IkKAhTSF72NytiB5Ho=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCZAr-0001AM-QJ;
	Tue, 14 Apr 2026 08:31:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wCZAq-0001AF-Cq
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Apr 2026 08:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cV9DLp4l3JrlTss6EAr06uzI+fszKqbGjN+oTlUEg5o=; b=EVnQdU87p8cmMCYciJULpv/9W4
 L8xHw2chzHe0MPlxvMKxAceE3LNWyjCD8BX4ySvbXfbak0eViGwk+/btw1bXukE9rh4QvIyHHw/9F
 w/l3vqvTBDDxk3tXxfy/mQczvTWkBthgevPhrVL5TJS36dY6DqD47rwOd4Hc3zWeGDDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cV9DLp4l3JrlTss6EAr06uzI+fszKqbGjN+oTlUEg5o=; b=fQ12CvwtjEQFRRtcGe3ynNGQLm
 AyVyesAN65l8XNN702xcjWtEuCS8LC0JCpGivmbzRKt6/KX/tsaewgNfs/0IVGZ2cNWDxzdjkJKO4
 isGaPl9kg+WA77SPqeycloaYEfEdP8+krMsA93fW9wtqvguM+KthN5eAoDEl9YQK+OaU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCZAp-0006EF-Ng for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Apr 2026 08:31:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1448660018;
 Tue, 14 Apr 2026 08:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01A0C2BCB3;
 Tue, 14 Apr 2026 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776155456;
 bh=Ju5r8Q7E3e4nXtTD+om2PyxyK405A6amSS29SKDra64=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=LkgMbr2MjpuokVHNPGey2QmdC439OQzPRFs32SqqIsgLOt5V7dgkTiY2g0M6PMW6K
 QSquEiOWK5KjPtsYoM7J9NvkJkcRC0ToEjpJr6+HqpsrYCem5E7+G1M2UKn/NQSS6c
 ChXUZ3Yeq+R7V3pFzTcNj73WZrPjBYI0IFck0WjLNAzKA9GPGz/XOvXPSSrB5SISh1
 MWnZca9zGDdx90bskV5fZzZa6Zg8xRBCIVI5XbwF6LvBnIk4nJr2wb7RI34Hlv+qgl
 q3Sm/2FWGGmJfi17f428U3vc9Coyzuo8ww0/CCTU+JvTuj/Z8vY3qWAj5/PF/XFrMY
 A6YuG23CWb/jQ==
Message-ID: <d66e9547-4bde-4373-bc9f-b8732e41fc3a@kernel.org>
Date: Tue, 14 Apr 2026 16:30:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260402114559.2030042-1-jinbaoliu365@gmail.com>
 <51500762-ec13-4e3e-93e6-80484a7a2a8b@kernel.org>
 <8d262230-2638-42f0-b2a9-d98dc233319e@gmail.com>
Content-Language: en-US
In-Reply-To: <8d262230-2638-42f0-b2a9-d98dc233319e@gmail.com>
X-Headers-End: 1wCZAp-0006EF-Ng
Subject: Re: [f2fs-dev] [PATCH] f2fs: Add trace_f2fs_fault_report
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
Cc: liujinbao1 <liujinbao1@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNC8xNC8yMDI2IDEwOjUzIEFNLCBsaXVqaW5iYW8xIHdyb3RlOgo+IAo+IOWcqCAyMDI2LzQv
MTMgMTc6NTQsIENoYW8gWXUg5YaZ6YGTOgo+PiBPbiA0LzIvMjAyNiA3OjQ1IFBNLCBsaXVqaW5i
YW8xIHdyb3RlOgo+Pj4gRnJvbTogbGl1amluYmFvMSA8bGl1amluYmFvMUB4aWFvbWkuY29tPgo+
Pj4KPj4+IEFkZCB0cmFjZV9mMmZzX2ZhdWx0X3JlcG9ydCB0byB0cmlnZ2VyIHJlcG9ydGluZyB1
cG9uIGYyZnNfYnVnX29uLAo+Pj4gbmVlZF9mc2NrLCBzdG9wX2NoZWNrcG9pbnQsIGFuZCBoYW5k
bGVfZWlvLiBTaW5jZSBmMmZzX2J1Z19vbiBhbmQKPj4+IG5lZWRfZnNjayBjYW4gYmUgdHJpZ2dl
cmVkIGluIGh1bmRyZWRzIG9mIHNjZW5hcmlvcywgZGVmaW5lIHNldF9zYmlfZmxhZwo+Pj4gYXMg
YSBtYWNybyB0byBoZWxwIGNhcHR1cmUgdGhlIGVmZmVjdGl2ZSBmYXVsdCBmdW5jdGlvbiBhbmQg
bGluZSBudW1iZXIuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogbGl1amluYmFvMSA8bGl1amluYmFv
MUB4aWFvbWkuY29tPgo+Pj4gLS0tCj4+PiDCoCBmcy9mMmZzL2NoZWNrcG9pbnQuY8KgwqDCoMKg
wqDCoMKgIHwgMTAgKysrKysrKysrKwo+Pj4gwqAgZnMvZjJmcy9mMmZzLmjCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDIwICsrKysrKysrKysrKysrKysrKystCj4+PiDCoCBpbmNsdWRlL3Ry
YWNlL2V2ZW50cy9mMmZzLmggfCAyMiArKysrKysrKysrKysrKysrKysrKysrCj4+PiDCoCAzIGZp
bGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZnMvZjJmcy9jaGVja3BvaW50LmMgYi9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+Pj4g
aW5kZXggNmRkMzliN2RlMTFhLi42OTg1NDBjMGY2MTkgMTAwNjQ0Cj4+PiAtLS0gYS9mcy9mMmZz
L2NoZWNrcG9pbnQuYwo+Pj4gKysrIGIvZnMvZjJmcy9jaGVja3BvaW50LmMKPj4+IEBAIC0yNCw2
ICsyNCw4IEBACj4+PiDCoCAjaW5jbHVkZSAiaW9zdGF0LmgiCj4+PiDCoCAjaW5jbHVkZSA8dHJh
Y2UvZXZlbnRzL2YyZnMuaD4KPj4+IMKgICtFWFBPUlRfVFJBQ0VQT0lOVF9TWU1CT0xfR1BMKGYy
ZnNfZmF1bHRfcmVwb3J0KTsKPj4KPj4gSSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGV4cG9ydCB0
aGlzIGluIHVwc3RyZWFtLgo+Pgo+IG9rCj4+PiArCj4+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQg
Z2V0X2xvY2tfZWxhcHNlZF90aW1lKHN0cnVjdCBmMmZzX3RpbWVfc3RhdCAqdHMpCj4+PiDCoCB7
Cj4+PiDCoMKgwqDCoMKgIHRzLT50b3RhbF90aW1lID0ga3RpbWVfZ2V0KCk7Cj4+PiBAQCAtMjMy
LDkgKzIzNCwxNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZjJmc191bmxvY2tfYWxsKHN0cnVjdCBm
MmZzX3NiX2luZm8gKnNiaSkKPj4+IMKgIHN0YXRpYyBzdHJ1Y3Qga21lbV9jYWNoZSAqaW5vX2Vu
dHJ5X3NsYWI7Cj4+PiDCoCBzdHJ1Y3Qga21lbV9jYWNoZSAqZjJmc19pbm9kZV9lbnRyeV9zbGFi
Owo+Pj4gwqAgK3ZvaWQgZjJmc19mYXVsdF9yZXBvcnQodW5zaWduZWQgaW50IGVycl9jb2RlLCBj
b25zdCBjaGFyICpmdW5jLCB1bnNpZ25lZCBpbnQgZGF0YSkKPj4+ICt7Cj4+PiArwqDCoMKgIHRy
YWNlX2YyZnNfZmF1bHRfcmVwb3J0KGVycl9jb2RlLCBmdW5jLCBkYXRhKTsKPj4+ICt9Cj4+Cj4+
IFdoYXQgZG8geW91IHRoaW5rIGp1c3QgY2FsbGluZyB0cmFjZV9mMmZzX2ZhdWx0X3JlcG9ydCgp
IGRpcmVjdGx5Pwo+Pgo+IEl0IGRvZXNuJ3QgcXVpdGUgd29yaywgYmVjYXVzZSB0cmFjZV9mMmZz
X2ZhdWx0X3JlcG9ydCBuZWVkcyB0byBiZSB1c2VkIGluIGYyZnMuaCwKCkFscmlnaHQsCgpUaGFu
a3MsCgo+IAo+IGFuZCBpdCdzIG5vdCBwb3NzaWJsZSB0byBpbmNsdWRlIDx0cmFjZS9ldmVudHMv
ZjJmcy5oPiBpbiBmMmZzLmguCj4gCj4+PiArCj4+PiDCoCB2b2lkIGYyZnNfc3RvcF9jaGVja3Bv
aW50KHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgYm9vbCBlbmRfaW8sCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBjaGFyIHJl
YXNvbikKPj4+IMKgIHsKPj4+ICvCoMKgwqAgaWYgKHJlYXNvbiAhPSBTVE9QX0NQX1JFQVNPTl9T
SFVURE9XTikKPj4+ICvCoMKgwqDCoMKgwqDCoCBmMmZzX2ZhdWx0X3JlcG9ydChSRVBPUlRfRkFV
TFRfU1RPUF9DUCwgX19mdW5jX18sIHJlYXNvbik7Cj4+PiArCj4+PiDCoMKgwqDCoMKgIGYyZnNf
YnVpbGRfZmF1bHRfYXR0cihzYmksIDAsIDAsIEZBVUxUX0FMTCk7Cj4+PiDCoMKgwqDCoMKgIGlm
ICghZW5kX2lvKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGYyZnNfZmx1c2hfbWVyZ2VkX3dyaXRl
cyhzYmkpOwo+Pj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZjJmcy5oIGIvZnMvZjJmcy9mMmZzLmgK
Pj4+IGluZGV4IGJiMzRlODY0ZDBlZi4uYWMyZmE0YjZiZDM3IDEwMDY0NAo+Pj4gLS0tIGEvZnMv
ZjJmcy9mMmZzLmgKPj4+ICsrKyBiL2ZzL2YyZnMvZjJmcy5oCj4+PiBAQCAtOTcsNiArOTcsMTUg
QEAgZXh0ZXJuIGNvbnN0IGNoYXIgKmYyZnNfZmF1bHRfbmFtZVtGQVVMVF9NQVhdOwo+Pj4gwqAg
I2RlZmluZSBERUZBVUxUX0ZBSUxVUkVfUkVUUllfQ09VTlTCoMKgwqDCoMKgwqDCoCAxCj4+PiDC
oCAjZW5kaWYKPj4+IMKgICtlbnVtIHsKPj4+ICvCoMKgwqAgUkVQT1JUX0ZBVUxUX05FRURfRlND
SywKPj4+ICvCoMKgwqAgUkVQT1JUX0ZBVUxUX1BBR0VfRUlPLAo+Pj4gK8KgwqDCoCBSRVBPUlRf
RkFVTFRfU1RPUF9DUCwKPj4+ICvCoMKgwqAgUkVQT1JUX0ZBVUxUX01BWCwKPj4+ICt9Owo+Pj4g
Kwo+Pj4gK3ZvaWQgZjJmc19mYXVsdF9yZXBvcnQodW5zaWduZWQgaW50IGVycl9jb2RlLCBjb25z
dCBjaGFyICpmdW5jLCB1bnNpZ25lZCBpbnQgZGF0YSk7Cj4+PiArCj4+PiDCoCAvKgo+Pj4gwqDC
oCAqIEZvciBtb3VudCBvcHRpb25zCj4+PiDCoMKgICovCj4+PiBAQCAtMjI3NSwxMSArMjI4NCwx
OCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfc2JpX2ZsYWdfc2V0KHN0cnVjdCBmMmZzX3NiX2lu
Zm8gKnNiaSwgdW5zaWduZWQgaW50IHR5cGUpCj4+PiDCoMKgwqDCoMKgIHJldHVybiB0ZXN0X2Jp
dCh0eXBlLCAmc2JpLT5zX2ZsYWcpOwo+Pj4gwqAgfQo+Pj4gwqAgLXN0YXRpYyBpbmxpbmUgdm9p
ZCBzZXRfc2JpX2ZsYWcoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCB1bnNpZ25lZCBpbnQgdHlw
ZSkKPj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19zZXRfc2JpX2ZsYWcoc3RydWN0IGYyZnNfc2Jf
aW5mbyAqc2JpLCB1bnNpZ25lZCBpbnQgdHlwZSkKPj4+IMKgIHsKPj4+IMKgwqDCoMKgwqAgc2V0
X2JpdCh0eXBlLCAmc2JpLT5zX2ZsYWcpOwo+Pj4gwqAgfQo+Pj4gwqAgKyNkZWZpbmUgc2V0X3Ni
aV9mbGFnKHNiaSwgdHlwZSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gK2Rv
IHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XAo+Pj4gK8KgwqDCoCBfX3NldF9zYmlfZmxhZyhzYmksIHR5cGUpO8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXAo+Pj4gK8KgwqDCoCBpZiAoKHR5cGUpID09IFNCSV9ORUVEX0ZTQ0spwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcCj4+PiArwqDCoMKgwqDCoMKgwqAgZjJmc19mYXVsdF9yZXBvcnQoUkVQ
T1JUX0ZBVUxUX05FRURfRlNDSywgX19mdW5jX18sIF9fTElORV9fKTvCoMKgwqAgXAo+Pj4gK30g
d2hpbGUgKDApCj4+PiArCj4+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgY2xlYXJfc2JpX2ZsYWco
c3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCB1bnNpZ25lZCBpbnQgdHlwZSkKPj4+IMKgIHsKPj4+
IMKgwqDCoMKgwqAgY2xlYXJfYml0KHR5cGUsICZzYmktPnNfZmxhZyk7Cj4+PiBAQCAtNTA2NCw2
ICs1MDgwLDggQEAgc3RhdGljIGlubGluZSB2b2lkIGYyZnNfaGFuZGxlX3BhZ2VfZWlvKHN0cnVj
dCBmMmZzX3NiX2luZm8gKnNiaSwKPj4+IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KGYyZnNfY3Bf
ZXJyb3Ioc2JpKSkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4gwqAgK8KgwqDC
oCBmMmZzX2ZhdWx0X3JlcG9ydChSRVBPUlRfRkFVTFRfUEFHRV9FSU8sIF9fZnVuY19fLCB0eXBl
KTsKPj4KPj4gV2UgaGF2ZSBjaGFuZ2VkIHRvIGNhbGwgZjJmc19zdG9wX2NoZWNrcG9pbnQoKSBk
aXJlY3RseSBpbiBmMmZzX2hhbmRsZV9wYWdlX2VpbygpLAo+PiBzbyBpdCdzIHJlZHVuZGFudCBo
ZXJlPwo+Pgo+IFllcwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCBpZiAob2ZzID09IHNiaS0+cGFnZV9l
aW9fb2ZzW3R5cGVdKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNiaS0+cGFnZV9laW9f
Y250W3R5cGVdKysgPT0gTUFYX1JFVFJZX1BBR0VfRUlPKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2V0X2NrcHRfZmxhZ3Moc2JpLCBDUF9FUlJPUl9GTEFHKTsKPj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9mMmZzLmggYi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9m
MmZzLmgKPj4+IGluZGV4IDkzNjRlNjc3NTU2Mi4uMDM5YzY5NWM0NWE4IDEwMDY0NAo+Pj4gLS0t
IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvZjJmcy5oCj4+PiArKysgYi9pbmNsdWRlL3RyYWNlL2V2
ZW50cy9mMmZzLmgKPj4+IEBAIC0yNTgyLDYgKzI1ODIsMjggQEAgREVGSU5FX0VWRU5UKGYyZnNf
cHJpb3JpdHlfdXBkYXRlLCBmMmZzX3ByaW9yaXR5X3Jlc3RvcmUsCj4+PiDCoMKgwqDCoMKgIFRQ
X0FSR1Moc2JpLCBsb2NrX25hbWUsIGlzX3dyaXRlLCBwLCBvcmlnX3ByaW8sIG5ld19wcmlvKQo+
Pj4gwqAgKTsKPj4+IMKgICtUUkFDRV9FVkVOVChmMmZzX2ZhdWx0X3JlcG9ydCwKPj4+ICsKPj4+
ICvCoMKgwqAgVFBfUFJPVE8odW5zaWduZWQgaW50IGVycl9jb2RlLCBjb25zdCBjaGFyICpmdW5j
LCB1bnNpZ25lZCBpbnQgZGF0YSksCj4+PiArCj4+PiArwqDCoMKgIFRQX0FSR1MoZXJyX2NvZGUs
IGZ1bmMsIGRhdGEpLAo+Pj4gKwo+Pj4gK8KgwqDCoCBUUF9TVFJVQ1RfX2VudHJ5KAo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIF9fZmllbGQodW5zaWduZWQgaW50LCBlcnJfY29kZSkKPj4+ICvCoMKgwqDC
oMKgwqDCoCBfX3N0cmluZyhmdW5jLCBmdW5jKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIF9fZmllbGQo
dW5zaWduZWQgaW50LCBkYXRhKQo+Pj4gK8KgwqDCoCApLAo+Pj4gKwo+Pj4gK8KgwqDCoCBUUF9m
YXN0X2Fzc2lnbigKPj4+ICvCoMKgwqDCoMKgwqDCoCBfX2VudHJ5LT5lcnJfY29kZSA9IGVycl9j
b2RlOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIF9fYXNzaWduX3N0cihmdW5jLCBmdW5jKTsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBfX2VudHJ5LT5kYXRhID0gZGF0YTsKPj4+ICvCoMKgwqAgKSwKPj4+ICsK
Pj4+ICvCoMKgwqAgVFBfcHJpbnRrKCJlcnJfY29kZT0ldSBmdW5jPSVzIGRhdGE9JXUiLAo+Pgo+
PiBEbyB3ZSBuZWVkIGRldiBpbmZvcm1hdGlvbj8KPiBZZXMsIHdlIG5lZWQuCj4+Cj4+IFRoYW5r
cywKPj4KPj4+ICvCoMKgwqDCoMKgwqDCoCBfX2VudHJ5LT5lcnJfY29kZSwgX19nZXRfc3RyKGZ1
bmMpLCBfX2VudHJ5LT5kYXRhKQo+Pj4gKyk7Cj4+PiArCj4+PiDCoCAjZW5kaWYgLyogX1RSQUNF
X0YyRlNfSCAqLwo+Pj4gwqAgwqDCoCAvKiBUaGlzIHBhcnQgbXVzdCBiZSBvdXRzaWRlIHByb3Rl
Y3Rpb24gKi8KPj4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo=
