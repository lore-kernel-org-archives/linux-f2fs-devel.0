Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224F5C2BA18
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jun 2024 07:12:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sKByX-0007x1-G0;
	Thu, 20 Jun 2024 07:12:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sKByW-0007wu-24
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Jun 2024 07:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vfjoR4fJAPGQg05gZLyuxVyPRwOVIgAknu6MEonY9Bs=; b=Qp/4DMy5aw1P9ynl8BWd3g7QGh
 IFGLmCa/jgF/TJLDk8+U4ri1NH5wqYy53iitBJ60cUkxO4bLg85EP60PfvxuE0HVjtqcFf1rYX8RE
 hZbOMMQ5dxau8/W5KSnQ0h7LwcEWIXDdZFfUWtbeqeJAo86bKExPspii/QDhiy9PWJ6c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vfjoR4fJAPGQg05gZLyuxVyPRwOVIgAknu6MEonY9Bs=; b=mVhyTBGvusHrEs46/LZUJ4+kjS
 zoiCyeflR8OAiOXUxCNBBBsHHC4v2ToZVJhA7WXhE6shMlhxkk1Xw/MFP+eYrs/9wd21acPSk6iLt
 dYcMF1hyg5lhB35BIRVj6nKNXTOZ+lkKJUpxNYjy2n3uhJbF1Ay51vQxqk+71X9LirYY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sKByW-00079T-GB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Jun 2024 07:12:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5E34E61FA8;
 Thu, 20 Jun 2024 07:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C36C2BD10;
 Thu, 20 Jun 2024 07:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718867566;
 bh=XdzO9QhZLuHvRTatrS4pMXGhXkG0g+xeQYypomttgJs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZBg9sJvNi03SfPMUyaA7rdqrJ1Lq/oyu6I0udFCYdwo+YrqGxl7PG5PRe1VgyuIPA
 ITgCUJ62dUXDofLH++QjSpL3UFi7K6r1nAE1S67ljFWX35NfQok+RgBQR1K8OzoTMe
 rUXj+/k76HnSA+G5H5z47UeuaSVHOWh0LYjhp5V1Ha8Lip52DNuBNevoNwVz38qkDN
 5oBlmxpu/KjOEGvnh99mTUfPvZyj/lu0jF/C2bIIDGuUMXqj+VFkMXcWXOFj66V+5A
 OBzhTsiDRE01M8NIxHUzbEgBZwXXnWMFIuWI5KZHGe9nfjRHURnZC06jdchHZrOBkq
 zpuis1h4shvkQ==
Message-ID: <e2371e59-7be5-40dc-9a2a-aef90ac93b18@kernel.org>
Date: Thu, 20 Jun 2024 15:12:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 Wenjie Cheng <cwjhust@gmail.com>
References: <2842767c-db80-407b-a5e5-2b9fa74b0d79@kernel.org>
 <20240614004841.103114-1-cwjhust@gmail.com>
 <CGME20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e@epcms2p1>
 <20240620055648epcms2p11b9914d40f560fb02fa241a7d2599298@epcms2p1>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240620055648epcms2p11b9914d40f560fb02fa241a7d2599298@epcms2p1>
X-Headers-End: 1sKByW-00079T-GB
Subject: Re: [f2fs-dev] (2) [PATCH] Revert "f2fs: use flush command instead
 of FUA for zoned device"
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
Cc: "qwjhust@gmail.com" <qwjhust@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC82LzIwIDEzOjU2LCBEYWVqdW4gUGFyayB3cm90ZToKPiBIaSBDaGFvLAo+IAo+PiBK
YWVnZXVrLAo+Pgo+PiBRdW90ZWQgY29tbWl0IG1lc3NhZ2UgZnJvbSBjb21taXQgYzU1MGUyNWJj
YTY2ICgiZjJmczogdXNlIGZsdXNoIGNvbW1hbmQKPj4gaW5zdGVhZCBvZiBGVUEgZm9yIHpvbmVk
IGRldmljZSIpCj4+ICIKPj4gVGhlIGJsb2NrIGxheWVyIGZvciB6b25lZCBkaXNrIGNhbiByZW9y
ZGVyIHRoZSBGVUEnZWQgSU9zLiBMZXQncyB1c2UgZmx1c2gKPj4gY29tbWFuZCB0byBrZWVwIHRo
ZSB3cml0ZSBvcmRlci4KPj4gIgo+Pgo+PiBJdCBzZWVtcyBtcS1kZWFkbGluZSB1c2UgZmlmbyBx
dWV1ZSBhbmQgbWFrZSBxdWV1ZSBkZXB0aCBvZiB6b25lIGRldmljZQo+PiBhcyAxIHRvIElPIG9y
ZGVyLCBzbyB3aHkgRlVBJ2VkIHdyaXRlIG5vZGUgSU9zIGNhbiBiZSByZW9yZGVyZWQgYnkgYmxv
Y2sKPj4gbGF5ZXI/Cj4gCj4gV2hpbGUgb3RoZXIgd3JpdGVzIGFyZSBhbGlnbmVkIGJ5IHRoZSBt
cS1kZWFkbGluZSwgd3JpdGUgd2l0aCBGVUEgaXMgbm90IHBhc3NlZAo+IHRvIHRoZSBzY2hlZHVs
ZXIgYnV0IGhhbmRsZWQgYXQgdGhlIGJsb2NrIGxheWVyLgoKSGkgRGFlanVuLAoKSUlVQywgZG8g
eW91IG1lYW4gd3JpdGUgdy8gRlVBIG1heSBiZSBoYW5kbGVkIGRpcmVjdGx5IGluIGJlbG93IHBh
dGg/CgotIGJsa19tcV9zdWJtaXRfYmlvCiAgLSBvcF9pc19mbHVzaCAmJiBibGtfaW5zZXJ0X2Zs
dXNoCgpUaGFua3MsCgo+IAo+IFRoYW5rcywKPiBEYWVqdW4KPiAKPj4KPj4gVGhhbmtzLAo+Pgo+
PiBPbiAyMDI0LzYvMTQgODo0OCwgV2VuamllIENoZW5nIHdyb3RlOgo+Pj4gVGhpcyByZXZlcnRz
IGNvbW1pdCBjNTUwZTI1YmNhNjYwZWQyNTU0Y2JiNDhkMzJiODJkMGJiOThlNGIxLgo+Pj4KPj4+
IENvbW1pdCBjNTUwZTI1YmNhNjYwZWQyNTU0Y2JiNDhkMzJiODJkMGJiOThlNGIxICgiZjJmczog
dXNlIGZsdXNoCj4+PiBjb21tYW5kIGluc3RlYWQgb2YgRlVBIGZvciB6b25lZCBkZXZpY2UiKSB1
c2VkIGFkZGl0aW9uYWwgZmx1c2gKPj4+IGNvbW1hbmQgdG8ga2VlcCB3cml0ZSBvcmRlci4KPj4+
Cj4+PiBTaW5jZSBDb21taXQgZGQyOTFkNzdjYzkwZWI2YTg2ZTk4NjBiYThlNmUzOGVlYmQ1N2Qx
MiAoImJsb2NrOgo+Pj4gSW50cm9kdWNlIHpvbmUgd3JpdGUgcGx1Z2dpbmciKSBoYXMgZW5hYmxl
ZCB0aGUgYmxvY2sgbGF5ZXIgdG8KPj4+IGhhbmRsZSB0aGlzIG9yZGVyIGlzc3VlLCB0aGVyZSBp
cyBubyBuZWVkIHRvIHVzZSBmbHVzaCBjb21tYW5kLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFdl
bmppZSBDaGVuZyA8Y3dqaHVzdEBnbWFpbC5jb20+Cj4+PiAtLS0KPj4+ICDCoCBmcy9mMmZzL2Zp
bGUuYyAzICstLQo+Pj4gIMKgIGZzL2YyZnMvbm9kZS5jIDIgKy0KPj4+ICDCoCAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYwo+Pj4gaW5kZXggZWFlMmU3OTA4MDcy
Li5mMDhlNjIwOGUxODMgMTAwNjQ0Cj4+PiAtLS0gYS9mcy9mMmZzL2ZpbGUuYwo+Pj4gKysrIGIv
ZnMvZjJmcy9maWxlLmMKPj4+IEBAIC0zNzIsOCArMzcyLDcgQEAgc3RhdGljIGludCBmMmZzX2Rv
X3N5bmNfZmlsZShzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IHN0YXJ0LCBsb2ZmX3QgZW5kLAo+
Pj4gIMKgIMKgIMKgIMKgIMKgIMKgZjJmc19yZW1vdmVfaW5vX2VudHJ5KHNiaSwgaW5vLCBBUFBF
TkRfSU5PKTsKPj4+ICDCoCDCoCDCoCDCoCDCoCDCoGNsZWFyX2lub2RlX2ZsYWcoaW5vZGUsIEZJ
X0FQUEVORF9XUklURSk7Cj4+PiAgwqAgZmx1c2hfb3V0Ogo+Pj4gLSDCoCDCoCDCoCDCoGlmICgo
IWF0b21pYyAmJiBGMkZTX09QVElPTihzYmkpLmZzeW5jX21vZGUgIT0gRlNZTkNfTU9ERV9OT0JB
UlJJRVIpCj4+PiAtIMKgIMKgIMKgIMKgwqAgwqAgKGF0b21pYyAmJiAhdGVzdF9vcHQoc2JpLCBO
T0JBUlJJRVIpICYmIGYyZnNfc2JfaGFzX2Jsa3pvbmVkKHNiaSkpKQo+Pj4gKyDCoCDCoCDCoCDC
oGlmICghYXRvbWljICYmIEYyRlNfT1BUSU9OKHNiaSkuZnN5bmNfbW9kZSAhPSBGU1lOQ19NT0RF
X05PQkFSUklFUikKPj4+ICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IGYyZnNf
aXNzdWVfZmx1c2goc2JpLCBpbm9kZS0+aV9pbm8pOwo+Pj4gIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KCFyZXQpIHsKPj4+ICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGYyZnNfcmVtb3ZlX2lu
b19lbnRyeShzYmksIGlubywgVVBEQVRFX0lOTyk7Cj4+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9u
b2RlLmMgYi9mcy9mMmZzL25vZGUuYwo+Pj4gaW5kZXggMTQ0ZjlmOTY2NjkwLi5jNDVkMzQxZGNm
NmUgMTAwNjQ0Cj4+PiAtLS0gYS9mcy9mMmZzL25vZGUuYwo+Pj4gKysrIGIvZnMvZjJmcy9ub2Rl
LmMKPj4+IEBAIC0xNjMxLDcgKzE2MzEsNyBAQCBzdGF0aWMgaW50IF9fd3JpdGVfbm9kZV9wYWdl
KHN0cnVjdCBwYWdlICpwYWdlLCBib29sIGF0b21pYywgYm9vbCAqc3VibWl0dGVkLAo+Pj4gIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byByZWRpcnR5X291dDsKPj4+ICDCoCDCoCDC
oCDCoCDCoCDCoH0KPj4+ICAgCj4+PiAtIMKgIMKgIMKgIMKgaWYgKGF0b21pYyAmJiAhdGVzdF9v
cHQoc2JpLCBOT0JBUlJJRVIpICYmICFmMmZzX3NiX2hhc19ibGt6b25lZChzYmkpKQo+Pj4gKyDC
oCDCoCDCoCDCoGlmIChhdG9taWMgJiYgIXRlc3Rfb3B0KHNiaSwgTk9CQVJSSUVSKSkKPj4+ICDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZpby5vcF9mbGFncyA9IFJFUV9QUkVGTFVTSCBS
RVFfRlVBOwo+Pj4gICAKPj4+ICDCoCDCoCDCoCDCoCDCoCDCoC8qIHNob3VsZCBhZGQgdG8gZ2xv
YmFsIGxpc3QgYmVmb3JlIGNsZWFyaW5nIFBBR0VDQUNIRSBzdGF0dXMgKi8KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
