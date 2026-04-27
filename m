Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81060FF8860
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=udXs4TnBldCn3WWfpOlX/Xi2Rs5u8ajMhVv5rl9exqA=; b=jkD4Xd41fE4rx3AYD4AVrLfIIB
	TQpYyZ0ZmeLlY8XBclCAkMoSoQCNN9oMUwJt1b52G50Dk4PO2paegD6QcPhZUlS2JADY9yjRj0il6
	T3li1fNuLGFGzE6TdkKDWEX+vEzzLRbdAWZT5bgMzH0x282hQBr6+9Am4LM38TlhhQRw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHLdd-0000y8-Pd;
	Mon, 27 Apr 2026 13:04:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wHLdb-0000y1-OG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 13:04:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E2HCd8PPa/eyqaR8OgCAmZ78sa8kIlUHz9Iq+BnfnE4=; b=T0ktLLzsrKUXqG+UkOUrAb8Slu
 CX+E/NtrSpQFCqNMFPmbWw82aL7UMMiNePY95ptP8wZNx3ZuI6UbG7PkKUaZT/icsUKNXRRDTZSgp
 NLzJ8HyVkW4FxyTP745qzw3uHFIMb2ylViFWqrnaM4E4cqIqVcWycffD5BIA6sCrawG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E2HCd8PPa/eyqaR8OgCAmZ78sa8kIlUHz9Iq+BnfnE4=; b=L1NM3MygeLcnmaucnI2nYXYbNB
 n4pRb3znAJ6ZQSyQakHP69OKULYPFCwz40GXByEzPQeK5Jo9qHOuJUqg42JR35vyYzzaHO0HGTNO0
 ZfIVQjjO3kZ8uI/yE803eB0oG+i8YrIYdCjxD6dHKfooVHFUa1Iip/nWh+wHd1UkorL0=;
Received: from smtp153-171.sina.com.cn ([61.135.153.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHLdX-0002CJ-O7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 13:04:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1777295071; bh=E2HCd8PPa/eyqaR8OgCAmZ78sa8kIlUHz9Iq+BnfnE4=;
 h=Message-ID:Date:Subject:From;
 b=bn6AjCSSInaihL0n9Vx73iIDTbLSoSC9EBixMVd03DFlKbUkLokXDyLI04rH8vNXH
 Z6wLknHf34XcTsgn2v1/IsJOl0GM+Tz0n6OxNQ66PCEVb4L8LtGnHwQQZtBuFWTH9c
 RO1WA+D+ok609zBF7nccHPaXofRJ+OnFF9TYRdQw=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
 by sina.com (10.54.253.34) with ESMTP
 id 69EF5ECF00004D4C; Mon, 27 Apr 2026 21:04:16 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 3110686291986
X-SMAIL-UIID: B0872C6E8D264607BEF976B6699FC3C1-20260427-210416-1
Message-ID: <d96abb88-b437-4eb8-a8d4-342154f346ba@sina.com>
Date: Mon, 27 Apr 2026 21:04:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260422073525.2063784-2-monty_pavel@sina.com>
 <206a897a-2860-40b5-bbb8-829954d7e568@kernel.org>
 <8f3dee76-6094-421f-bb32-a059815b405c@sina.com>
 <3550618a-4a16-4f1d-b8cb-4d7ff96f6ed7@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <3550618a-4a16-4f1d-b8cb-4d7ff96f6ed7@kernel.org>
X-Headers-End: 1wHLdX-0002CJ-O7
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix incorrect FI_NO_EXTENT handling in
 __destroy_extent_node()
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNC8yNy8yNiAxNTozOCwgQ2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCB3cm90ZToKPiBP
biA0LzI0LzI2IDE3OjQ1LCBZb25ncGVuZyBZYW5nIHdyb3RlOgo+Pgo+PiBPbiA0LzIyLzI2IDIw
OjMzLCBDaGFvIFl1IHZpYSBMaW51eC1mMmZzLWRldmVsIHdyb3RlOgo+Pj4gT24gNC8yMi8yMDI2
IDM6MzUgUE0sIFlvbmdwZW5nIFlhbmcgd3JvdGU6Cj4+Pj4gRnJvbTogeWFuZ3lvbmdwZW5nIDx5
YW5neW9uZ3BlbmdAeGlhb21pLmNvbT4KPj4+Pgo+Pj4+IFdoZW4gX19kZXN0cm95X2V4dGVudF9u
b2RlKCkgc2V0cyB0aGUgaW5vZGUgZmxhZyBGSV9OT19FWFRFTlQsIGl0IGRvZXMKPj4+PiBub3Qg
cmVzZXQgdGhlIGxlbmd0aCBvZiB0aGUgbGFyZ2VzdCBleHRlbnQgdG8gMCBhbmQgdXBkYXRlIHRo
ZSBpbm9kZQo+Pj4+IGZvbGlvLiBTaW5jZSBtb2RpZmljYXRpb25zIHRvIHRoZSBleHRlbnQgdHJl
ZSBhcmUgZGlzYWxsb3dlZCBhZnRlcndhcmQsCj4+Pj4gdGhlIGNhY2hlZCBsYXJnZXN0IGV4dGVu
dCBtYXkgYmVjb21lIHN0YWxlLiBUaGlzIGNhbiB0cmlnZ2VyIHRoZQo+Pj4+IGZvbGxvd2luZyBl
cnJvciBpbiB4ZnN0ZXN0cyBnZW5lcmljLzM4ODoKPj4+Pgo+Pj4+IEYyRlMtZnMgKGRtLTApOiBz
YW5pdHlfY2hlY2tfZXh0ZW50X2NhY2hlOiBpbm9kZSAoaW5vPTE3NjEpIGV4dGVudAo+Pj4+IGlu
Zm8gWzIyMDA1NywgNTcsIDZdIGlzIGluY29ycmVjdCwgcnVuIGZzY2sgdG8gZml4Cj4+Pj4KPj4+
PiBJbiB0aGUgZjJmc19kcm9wX2lub2RlIHBhdGgsIF9fZGVzdHJveV9leHRlbnRfbm9kZSgpIGRv
ZXMgbm90IG5lZWQgdG8KPj4+PiBndWFyYW50ZWUgdGhhdCBldC0+bm9kZV9jbnQgaXMgMCwgYmVj
YXVzZSBjb25jdXJyZW5jeSB3aXRoIHdyaXRlYmFjawo+Pj4+IGlzIGV4cGVjdGVkIGluIHRoaXMg
cGF0aCwgYW5kIHdyaXRlYmFjayBtYXkgdXBkYXRlIHRoZSBleHRlbnQgY2FjaGUuCj4+Pj4KPj4+
PiBUaGlzIHBhdGNoIHVwZGF0ZXMgX19kZXN0cm95X2V4dGVudF9ub2RlKCkgdG8gYXZvaWQgc2V0
dGluZyB0aGUgaW5vZGUKPj4+PiBmbGFnIEZJX05PX0VYVEVOVCwgYW5kIHRvIHJlbW92ZSB0aGUg
Y2hlY2sgemVybyBvZiBldC0+bm9kZV9jbnQuCj4+Pj4KPj4+PiBGaXhlczogZWQ3OGFlZWJlZjA1
ICgiZjJmczogZml4IG5vZGVfY250IHJhY2UgYmV0d2VlbiBleHRlbnQgbm9kZQo+Pj4+IGRlc3Ry
b3kgYW5kIHdyaXRlYmFjayIpCj4+Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPj4+PiBS
ZXBvcnRlZC1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgo+Pj4+IFN1Z2dlc3RlZC1ieTog
Q2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgo+Pj4+IFNpZ25lZC1vZmYtYnk6IHlhbmd5b25ncGVu
ZyA8eWFuZ3lvbmdwZW5nQHhpYW9taS5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqDCoCBmcy9mMmZzL2V4
dGVudF9jYWNoZS5jIHwgNCAtLS0tCj4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlv
bnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2V4dGVudF9jYWNoZS5jIGIvZnMv
ZjJmcy9leHRlbnRfY2FjaGUuYwo+Pj4+IGluZGV4IDg3MTY5ZmQyOWQ4OS4uM2FkYmVhZDI3OTUz
IDEwMDY0NAo+Pj4+IC0tLSBhL2ZzL2YyZnMvZXh0ZW50X2NhY2hlLmMKPj4+PiArKysgYi9mcy9m
MmZzL2V4dGVudF9jYWNoZS5jCj4+Pj4gQEAgLTY0NSwxNCArNjQ1LDEwIEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgX19kZXN0cm95X2V4dGVudF9ub2RlKHN0cnVjdAo+Pj4+IGlub2RlICppbm9kZSwK
Pj4+PiDCoMKgIMKgwqDCoMKgwqAgd2hpbGUgKGF0b21pY19yZWFkKCZldC0+bm9kZV9jbnQpKSB7
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVfbG9jaygmZXQtPmxvY2spOwo+Pj4+IC3C
oMKgwqDCoMKgwqDCoCBpZiAoIWlzX2lub2RlX2ZsYWdfc2V0KGlub2RlLCBGSV9OT19FWFRFTlQp
KQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNldF9pbm9kZV9mbGFnKGlub2RlLCBGSV9O
T19FWFRFTlQpOwo+Pj4KPj4+IFdlJ2QgYmV0dGVyIHJldmVydCBhbGwgY2hhbmdlIGxpbmVzIGlu
ICJmMmZzOiBmaXggbm9kZV9jbnQgcmFjZSBiZXR3ZWVuCj4+PiBleHRlbnQgbm9kZSBkZXN0cm95
IGFuZCB3cml0ZWJhY2siPwo+Pgo+PiBUaGUgb3RoZXJzIGFsbCBjaGVjayB3aGV0aGVyIEZJX05P
X0VYVEVOVCBpcyBzZXQuIFdoZW4gaXQgaXMgc2V0LAo+PiBpbnNlcnRpbmcgYW4gYWdlIGV4dGVu
dCBpcyBkaXNhbGxvd2VkLCBzbyBub3RoaW5nIHdhcyByZW1vdmVkLgo+IAo+IGRpZmYgLS1naXQg
YS9mcy9mMmZzL2V4dGVudF9jYWNoZS5jIGIvZnMvZjJmcy9leHRlbnRfY2FjaGUuYwo+IGluZGV4
IDg3MTY5ZmQyOWQ4OS4uMGVkODRjYzA2NWE3IDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZXh0ZW50
X2NhY2hlLmMKPiArKysgYi9mcy9mMmZzL2V4dGVudF9jYWNoZS5jCj4gQEAgLTExOSwxMCArMTE5
LDkgQEAgc3RhdGljIGJvb2wgX19tYXlfZXh0ZW50X3RyZWUoc3RydWN0IGlub2RlICppbm9kZSwK
PiBlbnVtIGV4dGVudF90eXBlIHR5cGUpCj4gwqDCoMKgwqDCoMKgwqAgaWYgKCFfX2luaXRfbWF5
X2V4dGVudF90cmVlKGlub2RlLCB0eXBlKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIGZhbHNlOwo+IAo+IC3CoMKgwqDCoMKgwqAgaWYgKGlzX2lub2RlX2ZsYWdfc2V0
KGlub2RlLCBGSV9OT19FWFRFTlQpKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBmYWxzZTsKPiAtCj4gwqDCoMKgwqDCoMKgwqAgaWYgKHR5cGUgPT0gRVhfUkVBRCkgewo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpc19pbm9kZV9mbGFnX3NldChpbm9k
ZSwgRklfTk9fRVhURU5UKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGZhbHNlOwoKVGhpcyBzaG91bGQgYmUgcmV2ZXJ0LiBUaGUgRVhfQkxP
Q0tfQUdFIGV4dGVudCB0cmVlIHR5cGUgd2FzIGFkZGVkIGxhdGVyCmFuZCBoYXMgbmV2ZXIgYmVl
biBnb3Zlcm5lZCBieSBGSV9OT19FWFRFTlQuIEFmdGVyIHJldmVydGluZyB0aGUgY29tbWl0CmVk
NzhhZWViZWYwNSwgaGF2aW5nIEZJX05PX0VYVEVOVCBzZXQgbm8gbG9uZ2VyIGltcGxpZXMgdGhh
dCB0aGUgaW5vZGUKbmVlZHMgdG8gYmUgZXZpY3RlZCwgc28gcmVqZWN0aW5nIHVwZGF0ZXMgdG8g
RVhfQkxPQ0tfQUdFIGV4dGVudHMgYmFzZWQKb24gdGhpcyBmbGFnIG5vIGxvbmdlciBtYWtlcyBz
ZW5zZS4gVGhlcmVmb3JlLCB0aGlzIHBhcnQgb2YgdGhlIGNoYW5nZQpzaG91bGQgYmUgZHJvcHBl
ZC4KCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpc19pbm9kZV9mbGFnX3Nl
dChpbm9kZSwgRklfQ09NUFJFU1NFRF9GSUxFKSAmJgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWYyZnNfc2JfaGFzX3Jl
YWRvbmx5KEYyRlNfSV9TQihpbm9kZSkpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+IAo+IC4uLgo+IAo+IEBAIC02OTEsMTIg
KzY4OCwxMiBAQCBzdGF0aWMgdm9pZCBfX3VwZGF0ZV9leHRlbnRfdHJlZV9yYW5nZShzdHJ1Y3QK
PiBpbm9kZSAqaW5vZGUsCj4gCj4gwqDCoMKgwqDCoMKgwqAgd3JpdGVfbG9jaygmZXQtPmxvY2sp
Owo+IAo+IC3CoMKgwqDCoMKgwqAgaWYgKGlzX2lub2RlX2ZsYWdfc2V0KGlub2RlLCBGSV9OT19F
WFRFTlQpKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVfdW5sb2NrKCZl
dC0+bG9jayk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+IC3CoMKg
wqDCoMKgwqAgfQoKVGhpcyBhbHNvIHNob3VsZCBiZSByZXZlcnQuIEFsbCBjYWxsZXJzIG9mIHRo
aXMgZnVuY3Rpb24gYWxyZWFkeSBpbnZva2UKX19tYXlfZXh0ZW50X3RyZWUoKSB0byB2ZXJpZnkg
d2hldGhlciBGSV9OT19FWFRFTlQgaXMgc2V0LiBTbywgdGhpcwpjaGVjayBhcmUgZGVhZCBjb2Rl
LgoKPiAtCj4gwqDCoMKgwqDCoMKgwqAgaWYgKHR5cGUgPT0gRVhfUkVBRCkgewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpc19pbm9kZV9mbGFnX3NldChpbm9kZSwgRklfTk9f
RVhURU5UKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB3cml0ZV91bmxvY2soJmV0LT5sb2NrKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0KPiArCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByZXYgPSBldC0+bGFyZ2Vz
dDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVpLmxlbiA9IDA7Cj4gCj4gSG1t
LCBJJ20gbm90IHN1cmUgSSB1bmRlcnN0b29kIHlvdSBjb3JyZWN0bHksIGlmIHlvdSB3YW50IHRv
IGtlZXAgYWJvdmUKPiBjb2Rlcywgd2hhdAo+IGFib3V0IGNoYW5naW5nIGluIGFub3RoZXIgcGF0
Y2ggdy8gY29ycmVjdCBjb21taXQgbWVzc2FnZT8KClllcywgSSBtZWFuIHRoYXQsIGJ1dCBJIHdh
cyBtaXN0YWtlbi4gSSdsbCBmaXggYWJvdmUgaXNzdWUgaW4gdjIgcGF0Y2guCgpUaGFua3MKWW9u
Z3BlbmcsCgo+IAo+IFRoYW5rcywKPiAKPiAKPj4KPj4gVGhhbmtzCj4+IFlvbmdwZW5nLAo+Pgo+
Pj4KPj4+IFRoYW5rcywKPj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm9kZV9jbnQgKz0g
X19mcmVlX2V4dGVudF90cmVlKHNiaSwgZXQsIG5yX3Nocmluayk7Cj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqAgd3JpdGVfdW5sb2NrKCZldC0+bG9jayk7Cj4+Pj4gwqDCoMKgwqDCoMKgIH0KPj4+
PiDCoMKgIC3CoMKgwqAgZjJmc19idWdfb24oc2JpLCBhdG9taWNfcmVhZCgmZXQtPm5vZGVfY250
KSk7Cj4+Pj4gLQo+Pj4+IMKgwqDCoMKgwqDCoCByZXR1cm4gbm9kZV9jbnQ7Cj4+Pj4gwqDCoCB9
Cj4+Pj4gwqDCoCAKPj4+Cj4+Pgo+Pj4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+PiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+Pj4g
TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPj4+IGh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKPj4KPiAKPiAK
PiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9saW51eC1mMmZzLWRldmVsCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
