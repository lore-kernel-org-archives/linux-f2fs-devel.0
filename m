Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5737DC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 01:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lgcxgpScgmoCtQrJ90dKpziicTjmUV4kNM4CjEZEbN4=; b=KRd+LUTLRG72EzkpL8PrYc9xV2
	4iKbOjin6niGRZQ78qfvvD2vVckNN6xPw7ltuenOlBtZHrgwbk6kiaY212ZC/7/bttebfu4xCIs4E
	AYF69yDZfCAhVkM8EP0CYjdtKSU9o6k616NDw9s7yjh1HUp+zgY8AJCgs2Z5XuR2W1SI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyfwg-000829-6R;
	Tue, 25 Aug 2026 01:27:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyfwe-000823-J5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 01:27:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M+Xl4sVRDzIEksh7IPs2vgHPZG7H1Ti4kamwZwxyyfY=; b=Svf8DdpZ19Z8FJJMQu4PJKXmOE
 mwHGlCgrKolmXv0oFrt47+i6ub6espRoFDhKsTUr5jTvayKf2NmIobx5yb31QklL14BrMuS0tGfdr
 Zg+/zhs1hRplQVujnPla6+oAfZ9ptG9bESC656AlslBGbcQcf+nocQx28T9oscxU1yTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M+Xl4sVRDzIEksh7IPs2vgHPZG7H1Ti4kamwZwxyyfY=; b=OEkdmhfWLNODzTCBT3IJ7TDnT0
 vEbqEK9r12Fu5d31YYsluDmDIah7nTykB1zqiw/XzTY5ObI3GmhaMRgrJEbsgVaVG+x6q2cHsBP7g
 DnKi9pS/A9RUr6qsp3UDxv0xhen8jDfPkeGq0o60u/vXrDwYweRNZHKxAZmBZDVTq/wg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyfwb-0002wI-71 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 01:27:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A7E76013A;
 Tue, 25 Aug 2026 01:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BAE1F000E9;
 Tue, 25 Aug 2026 01:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787621227;
 bh=M+Xl4sVRDzIEksh7IPs2vgHPZG7H1Ti4kamwZwxyyfY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=QymtTB3d1RRAcV9maY7grkB7Mkswf9VW4WLp7nR8FRptprmLXj/M62B3c4MefhmVX
 7/FkezZABro9XuyE6F0+mV5Y+pk4u+cegmVKGBVgu1kVcAQFNHNc0INvYr28AcT1dM
 0Ds408CmcmFitsCI0x2ngZDNVLCFQKVnGlGdl1jXY0Xrm9p1NLoVwkfBxSSSxAFoY7
 0GcZOnO/o1TiCGF4H/wj93UTleJgYZom7MSiEXKbN45MUpLzze90Y6nX5rOe6E+C4n
 ZY5DrQU64lxt4UHzApT1BxBpwBKq/Hq3xngZQ8rhsjZ8XRheMwCj0iqKU7p3xpZSrQ
 i80ERhzRyqppg==
Message-ID: <b3648fca-6b7f-47a4-8148-cb6748a57c46@kernel.org>
Date: Tue, 25 Aug 2026 09:27:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260818171412.3201082-1-daeho43@gmail.com>
 <2b2dc21a-a78d-416c-aa4f-7531c1b62321@kernel.org>
 <CACOAw_wb_CPopSxjptn7MTheojQfZdtPAKh_n4OyFg9hSUbcTw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_wb_CPopSxjptn7MTheojQfZdtPAKh_n4OyFg9hSUbcTw@mail.gmail.com>
X-Headers-End: 1wyfwb-0002wI-71
Subject: Re: [f2fs-dev] [PATCH] f2fs: accurately adjust free_sections during
 free_segment_range
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8yNS8yNiAwOToyMSwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gT24gTW9uLCBBdWcgMjQsIDIw
MjYgYXQgNjowNeKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+Cj4+IE9u
IDgvMTkvMjYgMDE6MTQsIERhZWhvIEplb25nIHdyb3RlOgo+Pj4gRnJvbTogRGFlaG8gSmVvbmcg
PGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPj4+Cj4+PiBJbiBmcmVlX3NlZ21lbnRfcmFuZ2UoKSwg
TUFJTl9TRUNTKHNiaSkgaXMgdGVtcG9yYXJpbHkgcmVkdWNlZCBieSBgc2Vjc2AKPj4+IHdoaWxl
IHZhbGlkIGJsb2NrcyBpbiB0aGUgdHJ1bmNhdGVkIHJhbmdlIGFyZSBldmFjdWF0ZWQgYnkgR0Mu
Cj4+Pgo+Pj4gSG93ZXZlciwgaWYgYW55IHNlY3Rpb25zIHdpdGhpbiB0aGUgdHJ1bmNhdGVkIHJh
bmdlIHdlcmUgYWxyZWFkeSBmcmVlLAo+Pj4gZmFpbGluZyB0byBkZWR1Y3QgdGhlbSBmcm9tIEZS
RUVfSShzYmkpLT5mcmVlX3NlY3Rpb25zIGxlYWRzIHRvIGFuCj4+PiBvdmVyLWVzdGltYXRpb24g
b2YgYXZhaWxhYmxlIHNwYWNlIGluIHRoZSByZWR1Y2VkIG1haW4gYXJlYSwgY2F1c2luZwo+Pj4g
aW5jb25zaXN0ZW50IGZyZWUgc2VjdGlvbiBhY2NvdW50aW5nLgo+Pj4KPj4+IEZpeCB0aGlzIGJ5
IGNhbGN1bGF0aW5nIHRoZSBudW1iZXIgb2YgYWxyZWFkeS1mcmVlIHNlY3Rpb25zIGluIHRoZQo+
Pj4gdHJ1bmNhdGVkIHJhbmdlIHVuZGVyIHNlZ21hcF9sb2NrLCBkZWR1Y3RpbmcgdGhlbSBmcm9t
IGZyZWVfc2VjdGlvbnMgdXBvbgo+Pj4gZW50ZXJpbmcgZnJlZV9zZWdtZW50X3JhbmdlKCksIGFu
ZCByZXN0b3JpbmcgdGhlbSB1bmRlciBzZWdtYXBfbG9jayBvbiBleGl0Lgo+Pgo+PiBJIHRoaW5r
IHdlIG5lZWQgdG8gY2hhbmdlIGNvbW1pdCBtZXNzYWdlIGEgYml0IHRvIHJlZmxlY3QgcmVhbCBp
c3N1ZXM/Cj4+Cj4+IEZpeGVzIGFuZCBDYyBzdGFibGUgbGluZSBoZXJlLgo+Pgo+Pj4KPj4+IFNp
Z25lZC1vZmYtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTdW5taW4gSmVvbmcgPHNfbWluLmplb25nQHNhbXN1bmcuY29tPgo+Pj4gLS0t
Cj4+PiAgICBmcy9mMmZzL2djLmMgfCAxNSArKysrKysrKysrKysrKy0KPj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdp
dCBhL2ZzL2YyZnMvZ2MuYyBiL2ZzL2YyZnMvZ2MuYwo+Pj4gaW5kZXggNzg3MTMzZWUyZWIyLi5m
M2E2ZmM2ZDA4YWUgMTAwNjQ0Cj4+PiAtLS0gYS9mcy9mMmZzL2djLmMKPj4+ICsrKyBiL2ZzL2Yy
ZnMvZ2MuYwo+Pj4gQEAgLTIyMDAsOCArMjIwMCw5IEBAIGludCBmMmZzX2djX3JhbmdlKHN0cnVj
dCBmMmZzX3NiX2luZm8gKnNiaSwKPj4+ICAgIHN0YXRpYyBpbnQgZnJlZV9zZWdtZW50X3Jhbmdl
KHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBpbnQgc2VjcywgYm9vbCBkcnlfcnVuKQo+Pj4gICAgewo+Pj4gLSAgICAg
dW5zaWduZWQgaW50IG5leHRfaW51c2UsIHN0YXJ0LCBlbmQ7Cj4+PiArICAgICB1bnNpZ25lZCBp
bnQgc2Vjbm8sIG5leHRfaW51c2UsIHN0YXJ0LCBlbmQsIGVuZF9zZWNubzsKPj4+ICAgICAgICBz
dHJ1Y3QgY3BfY29udHJvbCBjcGMgPSB7IENQX1JFU0laRSwgMCwgMCwgMCB9Owo+Pj4gKyAgICAg
dW5zaWduZWQgaW50IGZyZWVkX3NlY3MgPSAwOwo+Pj4gICAgICAgIGludCBnY19tb2RlLCBnY190
eXBlOwo+Pj4gICAgICAgIGludCBlcnIgPSAwOwo+Pj4gICAgICAgIGludCB0eXBlOwo+Pj4gQEAg
LTIyMTAsNiArMjIxMSw3IEBAIHN0YXRpYyBpbnQgZnJlZV9zZWdtZW50X3JhbmdlKHN0cnVjdCBm
MmZzX3NiX2luZm8gKnNiaSwKPj4+ICAgICAgICBNQUlOX1NFQ1Moc2JpKSAtPSBzZWNzOwo+Pj4g
ICAgICAgIHN0YXJ0ID0gTUFJTl9TRUNTKHNiaSkgKiBTRUdTX1BFUl9TRUMoc2JpKTsKPj4+ICAg
ICAgICBlbmQgPSBNQUlOX1NFR1Moc2JpKSAtIDE7Cj4+PiArICAgICBlbmRfc2Vjbm8gPSBHRVRf
U0VDX0ZST01fU0VHKHNiaSwgZW5kKTsKPj4+Cj4+PiAgICAgICAgbXV0ZXhfbG9jaygmRElSVFlf
SShzYmkpLT5zZWdsaXN0X2xvY2spOwo+Pj4gICAgICAgIGZvciAoZ2NfbW9kZSA9IDA7IGdjX21v
ZGUgPCBNQVhfR0NfUE9MSUNZOyBnY19tb2RlKyspCj4+PiBAQCAtMjIyMSw2ICsyMjIzLDE0IEBA
IHN0YXRpYyBpbnQgZnJlZV9zZWdtZW50X3JhbmdlKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwK
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgc2JpLT5uZXh0X3ZpY3RpbV9zZWdbZ2NfdHlwZV0g
PSBOVUxMX1NFR05POwo+Pj4gICAgICAgIG11dGV4X3VubG9jaygmRElSVFlfSShzYmkpLT5zZWds
aXN0X2xvY2spOwo+Pj4KPj4+ICsgICAgIHNwaW5fbG9jaygmRlJFRV9JKHNiaSktPnNlZ21hcF9s
b2NrKTsKPj4+ICsgICAgIGZvciAoc2Vjbm8gPSBNQUlOX1NFQ1Moc2JpKTsgc2Vjbm8gPD0gZW5k
X3NlY25vOyBzZWNubysrKSB7Cj4+PiArICAgICAgICAgICAgIGlmICghdGVzdF9iaXQoc2Vjbm8s
IEZSRUVfSShzYmkpLT5mcmVlX3NlY21hcCkpCj4+PiArICAgICAgICAgICAgICAgICAgICAgZnJl
ZWRfc2VjcysrOwo+Pj4gKyAgICAgfQo+Pj4gKyAgICAgRlJFRV9JKHNiaSktPmZyZWVfc2VjdGlv
bnMgLT0gZnJlZWRfc2VjczsKPj4+ICsgICAgIHNwaW5fdW5sb2NrKCZGUkVFX0koc2JpKS0+c2Vn
bWFwX2xvY2spOwo+Pj4gKwo+Pgo+PiBCZWZvcmUgZjJmc19nY19yYW5nZQo+PiAwLi44OSBoYXZl
IDEwIGRpcnR5L2Z1bGwgc2VjdGlvbnMsIDgwIGZyZWUgc2VjdGlvbnMuCj4+IDkwLi45OSBoYXZl
IDUgZGlydHkgc2VjdGlvbnMsIDUgZnJlZSBzZWN0aW9ucy4KPj4KPj4gRlJFRV9JKHNiaSktPmZy
ZWVfc2VjdGlvbnMgLT0gZnJlZWRfc2VjczsKPj4gZnJlZV9zZWN0aW9ucyA9IDg1IC0gNSA9IDgw
Cj4+Cj4+IEFmdGVyIGYyZnNfZ2NfcmFuZ2UKPj4gMC4uODkgaGF2ZSAxMyBkaXJ0eS9mdWxsIHNl
Y3Rpb25zLCA3NyBmcmVlIHNlY3Rpb25zLgo+PiA5MC4uOTkgaGF2ZSAxMCBmcmVlIHNlY3Rpb25z
Lgo+PiBmcmVlX3NlY3Rpb25zID0gNzcgKC5mcmVlX3NlY3Rpb25zKSArIDEwIChzZWNzKSA9IDg3
Cj4+Cj4+PiAgICAgICAgLyogTW92ZSBvdXQgY3Vyc2VncyBmcm9tIHRoZSB0YXJnZXQgcmFuZ2Ug
Ki8KPj4+ICAgICAgICBmb3IgKHR5cGUgPSBDVVJTRUdfSE9UX0RBVEE7IHR5cGUgPCBOUl9DVVJT
RUdfVFlQRTsgdHlwZSsrKSB7Cj4+PiAgICAgICAgICAgICAgICBlcnIgPSBmMmZzX2FsbG9jYXRl
X3NlZ21lbnRfZm9yX3Jlc2l6ZShzYmksIHR5cGUsIHN0YXJ0LCBlbmQpOwo+Pj4gQEAgLTIyNDUs
NiArMjI1NSw5IEBAIHN0YXRpYyBpbnQgZnJlZV9zZWdtZW50X3JhbmdlKHN0cnVjdCBmMmZzX3Ni
X2luZm8gKnNiaSwKPj4+ICAgICAgICAgICAgICAgIGYyZnNfYnVnX29uKHNiaSwgMSk7Cj4+PiAg
ICAgICAgfQo+Pj4gICAgb3V0Ogo+Pj4gKyAgICAgc3Bpbl9sb2NrKCZGUkVFX0koc2JpKS0+c2Vn
bWFwX2xvY2spOwo+Pj4gKyAgICAgRlJFRV9JKHNiaSktPmZyZWVfc2VjdGlvbnMgKz0gZnJlZWRf
c2VjczsKPj4KPj4gU28sIHNob3VsZG4ndCBiZT8KPj4gRlJFRV9JKHNiaSktPmZyZWVfc2VjdGlv
bnMgKz0gc2VjczsKPiAKPiBEdXJpbmcgZjJmc19nY19yYW5nZSgpLCB3aGVuIHRoZSBkaXJ0eSBz
ZWN0aW9ucyBpbiA5MC4uOTkgYXJlIGNsZWFuZWQgYW5kCj4gZnJlZWQsIGBfX3NldF90ZXN0X2Fu
ZF9mcmVlKClgIGlzIGludm9rZWQgZm9yIHRob3NlIHNlY3Rpb25zLCB3aGljaAo+IGF1dG9tYXRp
Y2FsbHkgaW5jcmVtZW50cyBgRlJFRV9JKHNiaSktPmZyZWVfc2VjdGlvbnNgIGZvciBlYWNoIG5l
d2x5Cj4gZnJlZWQgc2VjdGlvbj8KCkFoLCBJIHNlZSwgdGhhbmtzIGZvciBjb3JyZWN0aW5nIG1l
LiA6KQoKVGhhbmtzLAoKPiAKPj4KPj4gVGhhbmtzLAo+Pgo+Pj4gKyAgICAgc3Bpbl91bmxvY2so
JkZSRUVfSShzYmkpLT5zZWdtYXBfbG9jayk7Cj4+PiAgICAgICAgTUFJTl9TRUNTKHNiaSkgKz0g
c2VjczsKPj4+ICAgICAgICByZXR1cm4gZXJyOwo+Pj4gICAgfQo+PgoKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
