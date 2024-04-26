Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36781C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:37:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s0I18-0005P0-1K;
	Fri, 26 Apr 2024 09:37:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s0I17-0005Ou-Bv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Apr 2024 09:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vDCJp1EFbT0oUoxHy5xbgqWzgY/qe/c4AqHj2Xw3lnk=; b=i0C6bgiRPUrJNiSB5N3x8mauWW
 g2OI/aWn/MSOFXlj95ncayvsyW9s51czUanDoYkH3ghffI+sclmdjt/FbWHodg38N7KUBt/iygADv
 bXSXqLM20fmq4dzK+wfO7yxA/CUPT56Zt21MqxIEBKiXTQUVXLxBIyGfmF33488ckGKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vDCJp1EFbT0oUoxHy5xbgqWzgY/qe/c4AqHj2Xw3lnk=; b=mL08TYnaA+Q1bDscAYaxs+FeCh
 KGY/akV1bCkO28Y80ruOxy7O6Fvz28TzfqinAhZJgXfyKlKagE9kUSpODeO9wvguD53CK7byEHI7p
 j99Z4hFlO+lupEdNUx/fTFW2yAKFDVQucKAK6m44chsFl82zP2wEcqYc8VqOscFGkAP0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s0I16-0005BD-Kg for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Apr 2024 09:37:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B21ED62015;
 Fri, 26 Apr 2024 09:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0886AC2BD10;
 Fri, 26 Apr 2024 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714124231;
 bh=P/GTw1XxjReEuD9Ww1RsUUzrNV6/qF1pdeMu8tj7+48=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Jr9lNuEOMS2DqrFPyu5S68MJZ5GqIrU58Lm1iTr7ajshWHlSGu4NSC7S+Wh7qgoLf
 nBiDDBAGM7uD1/N1uurBI18fqYwsCxShr/DPNAw27+eZfaWge+whlBUZKmQvoUMUuF
 z+/q4AwN0R1eUknJ2+T3+4oEcsQt+Nj5xHII/oA2K9O7fgo069jlMhfgvD2kPfFVDl
 sFFOnwBuBm+CsBXL+cQkrIpEA57IadsDMXRoBF3JKF/VggDDu64O02HdINKOrYt8GY
 +/q7rvkRZAp/WVrYm/BEAPP+1Z8Spv5lStRB+89Vl8ADJQieJ9Z6RCW1umZXCPlZn2
 mphuzlHKnrw5Q==
Message-ID: <235d9db4-2ca5-4d7a-bd2a-36f98d1880a9@kernel.org>
Date: Fri, 26 Apr 2024 17:37:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20240416072108.5819-1-chao@kernel.org>
 <20240416072108.5819-2-chao@kernel.org>
 <CAHJ8P3J4Z7QJ=kpd_Nt+TGX2ZD8HH5YQWmbPsbS7+DeN2NrxyA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3J4Z7QJ=kpd_Nt+TGX2ZD8HH5YQWmbPsbS7+DeN2NrxyA@mail.gmail.com>
X-Headers-End: 1s0I16-0005BD-Kg
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: remove unnecessary block size
 check in init_f2fs_fs()
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC80LzE2IDE5OjEyLCBaaGlndW8gTml1IHdyb3RlOgo+IE9uIFR1ZSwgQXByIDE2LCAy
MDI0IGF0IDM6MjLigK9QTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBB
ZnRlciBjb21taXQgZDdlOWE5MDM3ZGUyICgiZjJmczogU3VwcG9ydCBCbG9jayBTaXplID09IFBh
Z2UgU2l6ZSIpLAo+PiBGMkZTX0JMS1NJWkUgZXF1YWxzIHRvIFBBR0VfU0laRSwgcmVtb3ZlIHVu
bmVjZXNzYXJ5IGNoZWNrIGNvbmRpdGlvbi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8
Y2hhb0BrZXJuZWwub3JnPgo+PiAtLS0KPj4gICBmcy9mMmZzL3N1cGVyLmMgfCA2IC0tLS0tLQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZnMv
ZjJmcy9zdXBlci5jIGIvZnMvZjJmcy9zdXBlci5jCj4+IGluZGV4IDZkMWU0ZmM2MjllMi4uMzJh
YTZkNmZhODcxIDEwMDY0NAo+PiAtLS0gYS9mcy9mMmZzL3N1cGVyLmMKPj4gKysrIGIvZnMvZjJm
cy9zdXBlci5jCj4+IEBAIC00OTMzLDEyICs0OTMzLDYgQEAgc3RhdGljIGludCBfX2luaXQgaW5p
dF9mMmZzX2ZzKHZvaWQpCj4+ICAgewo+PiAgICAgICAgICBpbnQgZXJyOwo+Pgo+PiAtICAgICAg
IGlmIChQQUdFX1NJWkUgIT0gRjJGU19CTEtTSVpFKSB7Cj4+IC0gICAgICAgICAgICAgICBwcmlu
dGsoIkYyRlMgbm90IHN1cHBvcnRlZCBvbiBQQUdFX1NJWkUoJWx1KSAhPSBCTE9DS19TSVpFKCVs
dSlcbiIsCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEFHRV9TSVpFLCBGMkZT
X0JMS1NJWkUpOwo+PiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4+IC0gICAgICAg
fQo+PiAtCj4+ICAgICAgICAgIGVyciA9IGluaXRfaW5vZGVjYWNoZSgpOwo+PiAgICAgICAgICBp
ZiAoZXJyKQo+PiAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsKPiBEZWFyIENoYW8sCj4gCj4g
Q2FuIHlvdSBoZWxwIG1vZGlmeSB0aGUgZm9sbG93aW5nICBjb21tZW50IG1zZyB0b2dldGhlciB3
aXRoIHRoaXMgcGF0Y2g/Cj4gVGhleSBhcmUgYWxzbyByZWxhdGVkIHRvIGNvbW1pdCBkN2U5YTkw
MzdkZTIgKCJmMmZzOiBTdXBwb3J0IEJsb2NrCj4gU2l6ZSA9PSBQYWdlIFNpemUiKS4KPiBJZiB5
b3UgdGhpbmsgdGhlcmUgaXMgYSBtb3JlIHN1aXRhYmxlIGRlc2NyaXB0aW9uLCBwbGVhc2UgaGVs
cCBtb2RpZnkKPiBpdCBkaXJlY3RseS4KClpoaWd1bywKCkkgbWlzc2VkIHRvIHJlcGx5IHRoaXMs
IEkgZ3Vlc3MgeW91IGNhbiB1cGRhdGUKImYyZnM6IGZpeCBzb21lIGFtYmlndW91cyBjb21tZW50
cyIuCgo+IHRoYW5rc++8gQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2YyZnNfZnMu
aCBiL2luY2x1ZGUvbGludXgvZjJmc19mcy5oCj4gaW5kZXggYTM1NzI4Ny4uMjQxZTdiMTggMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9mMmZzX2ZzLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4
L2YyZnNfZnMuaAo+IEBAIC0zOTQsNyArMzk0LDggQEAgc3RydWN0IGYyZnNfbmF0X2Jsb2NrIHsK
PiAKPiAgIC8qCj4gICAgKiBGMkZTIHVzZXMgNCBieXRlcyB0byByZXByZXNlbnQgYmxvY2sgYWRk
cmVzcy4gQXMgYSByZXN1bHQsIHN1cHBvcnRlZCBzaXplIG9mCj4gLSAqIGRpc2sgaXMgMTYgVEIg
YW5kIGl0IGVxdWFscyB0byAxNiAqIDEwMjQgKiAxMDI0IC8gMiBzZWdtZW50cy4KPiArICogZGlz
ayBpcyAxNiBUQiBmb3IgYSA0SyBwYWdlIHNpemUgYW5kIDY0IFRCIGZvciBhIDE2SyBwYWdlIHNp
emUgYW5kIGl0IGVxdWFscwoKZGlzayBpcyAxNiBUQiBmb3IgNEsgc2l6ZSBibG9jayBhbmQgNjQg
VEIgZm9yIDE2SyBzaXplIGJsb2NrIGFuZCBpdCBlcXVhbHMKdG8gKDEgPDwgMzIpIC8gNTEyIHNl
Z21lbnRzLgoKI2RlZmluZSBGMkZTX01BWF9TRUdNRU5UICAgICAgIAkJKCgxIDw8IDMyKSAvIDUx
MikKClRoYW5rcywKCj4gKyAqIHRvIDE2ICogMTAyNCAqIDEwMjQgLyAyIHNlZ21lbnRzLgo+ICAg
ICovCj4gICAjZGVmaW5lIEYyRlNfTUFYX1NFR01FTlQgICAgICAgKCgxNiAqIDEwMjQgKiAxMDI0
KSAvIDIpCj4gCj4gQEAgLTQyNCw4ICs0MjUsMTAgQEAgc3RydWN0IGYyZnNfc2l0X2Jsb2NrIHsK
PiAgIC8qCj4gICAgKiBGb3Igc2VnbWVudCBzdW1tYXJ5Cj4gICAgKgo+IC0gKiBPbmUgc3VtbWFy
eSBibG9jayBjb250YWlucyBleGFjdGx5IDUxMiBzdW1tYXJ5IGVudHJpZXMsIHdoaWNoIHJlcHJl
c2VudHMKPiAtICogZXhhY3RseSBvbmUgc2VnbWVudCBieSBkZWZhdWx0LiBOb3QgYWxsb3cgdG8g
Y2hhbmdlIHRoZSBiYXNpYyB1bml0cy4KPiArICogT25lIHN1bW1hcnkgYmxvY2sgd2l0aCA0S0Ig
c2l6ZSBjb250YWlucyBleGFjdGx5IDUxMiBzdW1tYXJ5IGVudHJpZXMsIHdoaWNoCj4gKyAqIHJl
cHJlc2VudHMgZXhhY3RseSBvbmUgc2VnbWVudCB3aXRoIDJNQiBzaXplLgo+ICsgKiBTaW1pbGFy
bHksIGluIHRoZSBjYXNlIG9mIDE2ayBibG9jayBzaXplLCBpdCByZXByZXNlbnRzIG9uZQo+IHNl
Z21lbnQgd2l0aCA4TUIgc2l6ZS4KPiArICogTm90IGFsbG93IHRvIGNoYW5nZSB0aGUgYmFzaWMg
dW5pdHMuCj4gICAgKgo+ICAgICogTk9URTogRm9yIGluaXRpYWxpemluZyBmaWVsZHMsIHlvdSBt
dXN0IHVzZSBzZXRfc3VtbWFyeQo+ICAgICoKPiBAQCAtNTU2LDYgKzU1OSw3IEBAIHN0cnVjdCBm
MmZzX3N1bW1hcnlfYmxvY2sgewo+IAo+ICAgLyoKPiAgICAqIHNwYWNlIHV0aWxpemF0aW9uIG9m
IHJlZ3VsYXIgZGVudHJ5IGFuZCBpbmxpbmUgZGVudHJ5ICh3L28gZXh0cmEKPiByZXNlcnZhdGlv
bikKPiArICogd2hlbiBibG9jayBzaXplIGlzIDRLQi4KPiAKPiAKPiAKPj4gLS0KPj4gMi40MC4x
Cj4+Cj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4+IExpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cj4+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
