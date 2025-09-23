Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB83BCAC5A7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Sep 2025 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8McG0gP/TL2Wia1RENX0w3puDeKdZCDKbYAsGWCpY7E=; b=ZgQIGtAtHGs3/PYn63Eri+vyOu
	vp1iDrl/7v3/ZWGefRHl3NrKD/NZlFBBILLwrBNimF552SHMSBX5aTcu27c9SXro7IeYaGkJPmUZq
	jrF5EWlAgQldxeQB0whhIEtComHeTlXKiQ9bBqlD428vt1RQ62pJSqZgKMi8IoWPYvv8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v0wku-0006Pt-0w;
	Tue, 23 Sep 2025 06:44:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1v0wks-0006Pm-L9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Sep 2025 06:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OI6EJzUKnRax3h23rIpXTzDZoINQdfv1ssrqGHKR0xc=; b=fpyxuu3PNAZaG8g/4xpoiQiqNe
 UN7KqiWYGqHDKI2jAyFZIcGsElIHcYfiUhkAW1xx0nS5M8CDVvU0HINcYLrhyDyNQkyIRbv31z2/u
 +3W9QhXb4d75yjZoEDfIy+DRczBh7yAiUyvUkJSj+kmyP9eJEPXUvGCG9XXemhOHDH9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OI6EJzUKnRax3h23rIpXTzDZoINQdfv1ssrqGHKR0xc=; b=D6DTXbGfsL/tVNMbrSBAK3Jnf4
 X17SSfMHJ2DDsNlNoBbcmULsJQEhSuXae4cHc9lnx3nbb8jF5mMhHn9ErPhaYa8SCv7p1494OlraD
 +Z5YhM2w1Impn4BADmsAZTjozdbX0oR4CepMwS0r1vHL1GGBfH3b3DJtasj4AIH6pI8M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v0wkr-00018e-Ud for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Sep 2025 06:44:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5166960277;
 Tue, 23 Sep 2025 06:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D928FC4CEF7;
 Tue, 23 Sep 2025 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758609831;
 bh=WI+kDG0NBORR0mxqib21mmZ3G6zmcmkGVUr+Cua6OwA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=rLzxBodVlb5Dgqb5oDjWe+3JPhr19sb0jTaAKZHS2xKZQXmDaz7laeVruHSOcg2mo
 QTGa8itrh6LZsG64jjjJt7Ovhg+aTU3u5UaGVrEmA0k1eDNkyOcfnHyKblc1+zy30g
 NWUqa9beOMA1qngB8YZ65eajTe2ZQyBkgcP4iRnfVnMC49Vz5dT2nvatGz5pgOs/kN
 Je3lTO8amgzh1KHhJQQlqbl8YzEBK/QxcI/CobkF4N7X3QpJyOohs8kOIVGVHxqYH0
 XbYvIVZcQuhfpCzYzEA5UkgwcTyq+nnve/Fq0kHyVXY8f9KPgMQF/kAWLuaDUaS83I
 fpmF+z9tA6pqQ==
Message-ID: <21aefe8c-b737-41ea-9efc-9390b6a23c76@kernel.org>
Date: Tue, 23 Sep 2025 14:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250909134418.502922-1-liaoyuanhong@vivo.com>
 <20250909134418.502922-3-liaoyuanhong@vivo.com>
 <b42b161d-cd5d-45dc-8e84-c2b28eb632e5@kernel.org>
 <a508b9b8-3c81-4a2c-a525-baac822563b3@vivo.com>
 <22d9f9d1-1db0-4bad-a782-212ab3da630e@kernel.org>
 <3cd3bfb5-857f-4b61-a1c1-55805bed4609@vivo.com>
 <b7b20efb-8cdc-4cf0-a057-d4d41ae66aba@kernel.org>
 <c2c7fbdb-f71c-46aa-a47d-8bd4bec688d4@vivo.com>
Content-Language: en-US
In-Reply-To: <c2c7fbdb-f71c-46aa-a47d-8bd4bec688d4@vivo.com>
X-Headers-End: 1v0wkr-00018e-Ud
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: Enhance the subsequent logic of
 valid_thresh_ratio to prevent unnecessary background GC
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOS8yMC8yNSAxMDo0OSwgTGlhbyBZdWFuaG9uZyB3cm90ZToKPiAKPiBPbiA5LzE4LzIwMjUg
MTA6MTYgQU0sIENoYW8gWXUgd3JvdGU6Cj4+IE9uIDkvMTcvMjUgMTY6MTMsIExpYW8gWXVhbmhv
bmcgd3JvdGU6Cj4+PiBPbiA5LzE3LzIwMjUgMzo1NyBQTSwgQ2hhbyBZdSB3cm90ZToKPj4+PiBP
biA5LzE3LzI1IDE1OjA4LCBMaWFvIFl1YW5ob25nIHdyb3RlOgo+Pj4+PiBPbiA5LzE1LzIwMjUg
NDozNiBQTSwgQ2hhbyBZdSB3cm90ZToKPj4+Pj4+IE9uIDkvOS8yNSAyMTo0NCwgTGlhbyBZdWFu
aG9uZyB3cm90ZToKPj4+Pj4+PiBXaGVuIHRoZSBwcm9wb3J0aW9uIG9mIGRpcnR5IHNlZ21lbnRz
IHdpdGhpbiBhIHNlY3Rpb24gZXhjZWVkcyB0aGUKPj4+Pj4+PiB2YWxpZF90aHJlc2hfcmF0aW8s
IHRoZSBnY19jb3N0IG9mIHRoYXQgc2VjdGlvbiBpcyBzZXQgdG8gVUlOVF9NQVgsCj4+Pj4+Pj4g
aW5kaWNhdGluZyB0aGF0IHRoZXNlIHNlY3Rpb25zIHNob3VsZCBub3QgYmUgcmVsZWFzZWQuIEhv
d2V2ZXIsIGlmIGFsbAo+Pj4+Pj4+IHNlY3Rpb24gY29zdHMgd2l0aGluIHRoZSBzY2FubmluZyBy
YW5nZSBvZiBnZXRfdmljdGltKCkgYXJlIFVJTlRfTUFYLAo+Pj4+Pj4+IGJhY2tncm91bmQgR0Mg
d2lsbCBzdGlsbCBvY2N1ci4gQWRkIGEgY29uZGl0aW9uIHRvIHByZXZlbnQgdGhpcyBzaXR1YXRp
b24uCj4+Pj4+PiBGb3IgdGhpcyBjYXNlLCBmMmZzX2dldF92aWN0aW0oKSB3aWxsIHJldHVybiAw
LCBhbmQgZjJmc19nYygpIHdpbGwgdXNlIHVuY2hhbmdlZAo+Pj4+Pj4gc2Vnbm8gZm9yIEdDPwo+
Pj4+Pj4KPj4+Pj4+IFRoYW5rcywKPj4+Pj4gWW91J3JlIHJpZ2h0LCBzZWdubyB3b24ndCB1cGRh
dGUgaW4gdGhpcyBzY2VuYXJpbywgYW5kIHRoaXMgcGF0Y2ggZmVhdHVyZSBpcyByZWR1bmRhbnQu
Cj4+Pj4gT2gsIEkgbWVhbnQsIGlmIGYyZnNfZ2V0X3ZpY3RpbSgpIGZhaWxzIHRvIHNlbGVjdCBh
IHZhbGlkIHZpY3RpbSBkdWUgdG8gdGhlIHJlYXNvbiB5b3UKPj4+PiBkZXNjcmliZWQsIGYyZnNf
Z2V0X3ZpY3RpbSgpIHdpbGwgcmV0dXJuIDAsIGFuZCBmMmZzX2djKCkgd2lsbCBtaWdyYXRlIHNl
Z21lbnQgI05VTExfU0VHTk8/Cj4+Pj4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8KPj4+Pgo+
Pj4+IFRoYW5rcywKPj4+IFllcy4gSW4gdGhpcyBzY2VuYXJpbywgc2luY2UgaXQgd29uJ3QgZW50
ZXIgdGhlfHAubWluX2Nvc3QgPiBjb3N0fGNvbmRpdGlvbix8cC5taW5fc2Vnbm98d2lsbCByZXRh
aW4gaXRzIGluaXRpYWwgdmFsdWV8fHxOVUxMX1NFR05PfC4gVGhpcyBpcyBjb25zaXN0ZW50IHdp
dGggd2hhdCB5b3UgZGVzY3JpYmVkLgo+PiBEbyB5b3UgaGF2ZSBhIHNjcmlwdCB0byByZXByb2R1
Y2UgdGhpcyBidWc/Cj4+Cj4+IFRoYW5rcywKPiAKPiBJIGRpZG4ndCBleHBsYWluIGl0IGNsZWFy
bHkuIFdoYXQgSSBtZWFuIGlzIHRoYXQgdGhpcyBwYXRjaCBpcyByZWR1bmRhbnQsIHRoZSBvcmln
aW5hbCBjb2RlIGlzIGZpbmUuCgpPaCwgSSBzZWUuIEkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtIGlu
IGYyZnNfZ2V0X3ZpY3RpbSgpIGFzIHdlbGwuCgpUaGFua3MsCgo+IAo+IAo+IFRoYW5rcywKPiAK
PiBMaWFvCj4gCj4+Pgo+Pj4gVGhhbmtzLAo+Pj4KPj4+IExpYW8KPj4+Cj4+Pj4+IFRoYW5rcywK
Pj4+Pj4KPj4+Pj4gTGlhbwo+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExpYW8gWXVhbmhv
bmcgPGxpYW95dWFuaG9uZ0B2aXZvLmNvbT4KPj4+Pj4+PiAtLS0KPj4+Pj4+PiDCoMKgwqAgZnMv
ZjJmcy9nYy5jIHwgNSArKysrKwo+Pj4+Pj4+IMKgwqDCoCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspCj4+Pj4+Pj4KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9nYy5jIGIvZnMv
ZjJmcy9nYy5jCj4+Pj4+Pj4gaW5kZXggNGE4YzA4Zjk3MGUzLi5mZmMzMTg4NDE2ZjQgMTAwNjQ0
Cj4+Pj4+Pj4gLS0tIGEvZnMvZjJmcy9nYy5jCj4+Pj4+Pj4gKysrIGIvZnMvZjJmcy9nYy5jCj4+
Pj4+Pj4gQEAgLTkzNiw2ICs5MzYsMTEgQEAgaW50IGYyZnNfZ2V0X3ZpY3RpbShzdHJ1Y3QgZjJm
c19zYl9pbmZvICpzYmksIHVuc2lnbmVkIGludCAqcmVzdWx0LAo+Pj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIH0KPj4+Pj4+PiDCoMKgwqAgK8Kg
wqDCoCBpZiAoZjJmc19zYl9oYXNfYmxrem9uZWQoc2JpKSAmJiBwLm1pbl9jb3N0ID09IFVJTlRf
TUFYKSB7Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IC1FTk9EQVRBOwo+Pj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4+Pj4+PiArwqDCoMKgIH0KPj4+Pj4+PiArCj4+Pj4+
Pj4gwqDCoMKgwqDCoMKgwqAgLyogZ2V0IHZpY3RpbSBmb3IgR0NfQVQvQVRfU1NSICovCj4+Pj4+
Pj4gwqDCoMKgwqDCoMKgwqAgaWYgKGlzX2F0Z2MpIHsKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGxvb2t1cF92aWN0aW1fYnlfYWdlKHNiaSwgJnApOwoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
