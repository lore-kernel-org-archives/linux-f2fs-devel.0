Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B9EC3600C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Apr 2025 05:34:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u21b8-0007Lg-60;
	Tue, 08 Apr 2025 05:34:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <uplinkr@airmail.cc>) id 1u21b6-0007La-LP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Apr 2025 05:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
 From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IjPu3zHodm7e0INBj3J7/MKiAakRe7LSkUMO4SH1FOY=; b=kN3Cgn6VNLduD2ngTeY00cnZXb
 QKdK2woNHOOLqVdIRA5TWIEpJfSiM3lq6CGvh+8M+mPL/InAoavNvfwMi0ylrV6QM17+FeoSUJX9W
 W2PO82+DihBstsLc9Eiy2eHtNXQPvN+3lx+pDNml/SDcWvCmzOyJIh3s4qLcEAPce3lI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IjPu3zHodm7e0INBj3J7/MKiAakRe7LSkUMO4SH1FOY=; b=b7Wxkc7JzI03Cy2lvkskwJkNj7
 BPi4vkeNzv4rpkarSSdu5IAFH/oLFSC8s8bSmBPaAHdVmkLQWwZP7d5WjePH7vJr7dl/yojbURWN0
 0MhEv+bkePVJ/JF5UFm+tRu5fWy7cDmfMJybNinSZElQgGa5kZ8M9JibpgjTQ+LnVRIk=;
Received: from mail.cock.li ([37.120.193.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u21ap-0003j5-OX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Apr 2025 05:34:08 +0000
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
 t=1744090424; bh=Hd/1DbR+t0DPnXDq1t3YHyQT4v+iefX7ky68BAfojzU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=a6Grw5Llvm/6ep1EWvnK2kj14Vh6Tq5/JuhCsKnbUt8mgm3NAFGvOeeJoRFRj04ma
 xtao4JSnyhzcL93PyOzQbBd2wjXfP8DeFbtWSsPzn0d1XTlJqE8mVqX8n79tyqi4vG
 bh6oGZtalf7pYl4c0Z1KMpTV3gr6a3ApQ9jfcOt/8qudNf6yU5ZVOnycs+7Oo18D/5
 8hus2RZ/a4o1IErwbjGBKnFbFcXYF1ZDAzYHIz7wWgaDq1TpsyilyVCL0Nh/ve/NRK
 S4XwHKClR9ilx7pxwiEfKdbKyjjfnOTA76krHmDCUgksdafSUt++OWMOfQj/s1wOi6
 /Z+6t+DxmiMsA==
Date: Tue, 08 Apr 2025 08:33:44 +0300
To: Juhyung Park <qkrwngud825@gmail.com>
In-Reply-To: <CAD14+f1CYZ-OyKg36b_=VPmbBK0LSiieq1pgtXUy4OV2+KrR_g@mail.gmail.com>
References: <88f281ff9ff9b1fb899c92d6b32f52b7@airmail.cc>
 <CAD14+f1CYZ-OyKg36b_=VPmbBK0LSiieq1pgtXUy4OV2+KrR_g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <df195511b5d2de48f9cba16f6573310c@airmail.cc>
X-Sender: uplinkr@airmail.cc
X-Headers-End: 1u21ap-0003j5-OX
Subject: Re: [f2fs-dev] Resize metadata corruption
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
From: uplinkr--- via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: uplinkr@airmail.cc
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGVsbG8gZXZlcnlvbmUsCgpJIGhhdmUgYWxzbyBkZWNpZGVkIHRvIHRha2UgYSBsb29rIGF0IHRo
ZSBwYXJ0aXRpb24gd2l0aCBkYXRhIHJlY292ZXJ5IAp0b29scyBzdWNoIGFzIFBob3RvcmVjLiBJ
dCBzZWVtcyBhbGwgbXkgZGF0YSBpcyBpbnRhY3QhIEFzIHN1Y2gsIEkgd2FzIApjb25zaWRlcmlu
ZyBhbiBhbHRlcm5hdGUgZGF0YSByZWNvdmVyeSBzb2x1dGlvbi4KCkp1ZGdpbmcgYnkgRjJGUydz
IGRvY3VtZW50YXRpb24sIGl0IGlzIGJsb2NrcyB3aG8ga2VlcCB0cmFjayBvZiB0aGVpciAKcGF0
aCByYXRoZXIgdGhhbiB0aGUgY2hlY2twb2ludC4gSWYgSSBjb3VsZCBleHBvcnQgYWxsIGRpcmVj
dG9yeSBhbmQgCmZpbGUgbmFtZXMsIHBlcmhhcHMgSSBjb3VsZCByZWNvdmVyIG15IGRhdGEgbWFu
dWFsbHkuIElzIHRoaXMgdGhlIApzaW1wbGVyIHNvbHV0aW9uLCBvciBzaG91bGQgZnNjayBiZSBl
eHBsaWNpdGx5IHBhdGNoZWQgdG8gcmVzb2x2ZSBib3RoIAp0aGUgY29ycnVwdGlvbiByZWNvdmVy
eSBmYWlsdXJlIGFuZCByZXNpemUgYmxvY2sgbWlzYWxpZ25tZW50PwoKVGhhbmtzLgoKT24gMjAy
NS0wNC0wNiAxMTozMCwgSnVoeXVuZyBQYXJrIHdyb3RlOgo+IEhpIGFsbCwKPiAKPiBJIGFsc28g
ZW5jb3VudGVyZWQgc29tZXRoaW5nIHNpbWlsYXIgYSB3aGlsZSBiYWNrIHdpdGggcmVzaXppbmcg
YnV0Cj4gZGlkbid0IHJlcG9ydCBpdCBhbmQganVzdCBtYW51YWxseSBtaWdyYXRlZCB0aGUgZmls
ZXMuCj4gSSBhc3Npc3RlZCBoaW0gdG8gZW5zdXJlIHVzaW5nIHRoZSBsYXRlc3Qga2VybmVsL2Yy
ZnMtdG9vbHMsIGJ1dCBoaXMKPiBtZXRhZGF0YSBzZWVtcyBwcmV0dHkgYmFkIHJpZ2h0IG5vdyBh
bmQgSSBzdWdnZXN0ZWQgaGltIHRvIGFzayB0aGUKPiBtYWlsaW5nIGxpc3QgZGlyZWN0bHkuCj4g
Cj4gVGhlIFVSTCB0aGVyZSBzaG91bGQgYmUgaHR0cHM6Ly9hcnRlcjk3LmNvbS8uZjJmcy0yMDI1
MDQwNi9mc2NrLmxvZyAsCj4gYSBsaXR0bGUgdHlwbyB0aGVyZS4KPiAKPiBDYW4gd2UgaGF2ZSBz
b21lIHNvcnQgb2YgQ0kvYXV0b21hdGVkIHRlc3RpbmcgZm9yIHRoZSByZXNpemluZyBhcyB3ZWxs
Pwo+IAo+IFRoYW5rcy4KPiAKPiBPbiBTdW4sIEFwciA2LCAyMDI1IGF0IDE6MjbigK9BTSB1cGxp
bmtyLS0tIHZpYSBMaW51eC1mMmZzLWRldmVsCj4gPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0PiB3cm90ZToKPj4gCj4+IEhlbGxvIGV2ZXJ5b25lLAo+PiAKPj4gSSBhbSBo
YXZpbmcgdHJvdWJsZSB3aXRoIEYyRlMuIFNwZWNpZmljYWxseSwgSSBiZWxpZXZlIG1ldGFkYXRh
IGdvdAo+PiBjb3JydXB0ZWQgd2hlbiBJIHJlc2l6ZWQgaXQuIEkgaGF2ZSBhIDUxMiBHQiBkcml2
ZS4gTXkgRjJGUyBwYXJ0aXRpb24KPj4gd2FzIGFwcHJveGltYXRlbHkgbG9jYXRlZCBvbiAzNjkt
NDk3IEdCICgxMjggR0Igc2l6ZSkuIFVzaW5nIEdQYXJ0ZWQsIAo+PiBJCj4+IHJlc2l6ZWQgaXQg
dG8gMC41LTQ5NyBHQi4gV2hpbGUgdGhlIHBhcnRpdGlvbiByZXNpemluZyB3ZW50IHRocm91Z2gK
Pj4gc3VjY2Vzc2Z1bGx5LCBmaWxlc3lzdGVtIHJlc2l6aW5nIGluaXRpYWxseSBmYWlsZWQgd2l0
aCAiTW91bnQgdW5jbGVhbgo+PiBpbWFnZSB0byByZXBsYXkgbG9nIi4gSSBoYXZlIGRvbmUgdGhh
dCBhbmQgcmV0cmllZCByZXNpemluZy4KPj4gCj4+IEFmdGVyd2FyZHMsIGhvd2V2ZXIsIGZzY2sg
c3RhcnRlZCBnaXZpbmcgb3V0IGEgbG90IG9mIGVycm9ycywgYXQgb25lCj4+IHBvaW50IGl0IGFz
a2VkIGlmIEkgd2lzaGVkIHRvIHJlc3RvcmUgbG9zdCBkYXRhLCB3aGljaCBJIGFncmVlZCB0by4g
Cj4+IExvZ3MKPj4gc3BlY2lmaWVkIGEgbG90IG9mIG15IGZpbGVzICh3aGljaCBJIGNvdWxkIHRl
bGwgYnkgZmlsZW5hbWVzKSBhbmQKPj4gbWlkLXdheSB0aHJvdWdoIHRoZSBwcm9jZXNzLCBpdCBz
ZWdmYXVsdGVkLiBOb3csIHdoZW4gSSBydW4gZnNjaywgbm8KPj4gZmlsZXMgYXJlIGFza2VkIHRv
IGJlIHJlc3RvcmVkLCBhbmQgaXQgY29tcGxldGVzIHN1Y2Nlc3NmdWxseS4gCj4+IEhvd2V2ZXIs
Cj4+IHdoZW4gSSBhdHRlbXB0IHRvIG1vdW50IGl0LCBJIGdldCBhbiBlcnJvciBzYXlpbmcgIlN0
cnVjdHVyZSBuZWVkcwo+PiBjbGVhbmluZyIuCj4+IAo+PiBDb3VsZCBzb21lb25lIGhlbHAgbWUg
cmVzdG9yZSBteSBtZXRhZGF0YSAoYXQgbGVhc3QsIGxvbmcgZW5vdWdoIHRvCj4+IGV4dHJhY3Qg
bXkgZmlsZXMpPyBUaGFua3MuCj4+IAo+PiBkbWVzZyBsb2dzOgo+PiAKPj4gWyAgIDk2LjE4NDEy
N10gRjJGUy1mcyAobnZtZTBuMXA1KTogTWlzbWF0Y2ggdmFsaWQgYmxvY2tzIDc2OSB2cy4gNjgK
Pj4gWyAgIDk2LjE4ODA1MF0gRjJGUy1mcyAobnZtZTBuMXA1KTogRmFpbGVkIHRvIGluaXRpYWxp
emUgRjJGUyBzZWdtZW50Cj4+IG1hbmFnZXIgKC0xMTcpCj4+IAo+PiBmc2NrLmYyZnMgLS1kcnkt
cnVuIC1kIDMgbG9nczogCj4+IGh0dHBzOi8vYXJ0ZXIuY29tLy5mMmZzLTIwMjUwNDA2L2ZzY2su
bG9nCj4+IAo+PiAKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPj4gTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
