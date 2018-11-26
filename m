From: Perfect Gentleman <perfect007gentleman@gmail.com>
Subject: Re: Bug in f2fs-tools-1.12.0
Date: Mon, 26 Nov 2018 18:11:23 +0700
Message-ID: <0417cc7e-b1ba-cc3d-e5f6-bbb989000faa@GMail.com>
References: <e8884c8d-9009-cb70-bdf1-73fc38e83abc@GMail.com>
 <c5b93b62-37df-a351-7dc5-e1c0f26b5813@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <perfect007gentleman@gmail.com>) id 1gREns-0005De-KZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 11:11:48 +0000
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gREnc-0005O3-Am
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 11:11:47 +0000
Received: by mail-lf1-f67.google.com with SMTP id b20so13181579lfa.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Nov 2018 03:11:32 -0800 (PST)
In-Reply-To: <c5b93b62-37df-a351-7dc5-e1c0f26b5813@huawei.com>
Content-Language: ru-RU
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

SGkgQ2hhbwoKV2hhdCBwYXRjaCBkbyB5b3UgbWVhbj8KClJlZGFyZHMKClAuUy4gSXQncyByZXBs
eSB0byBhbGwgOikKCk9uIDExLzI2LzE4IDU6NTIgUE0sIENoYW8gWXUgd3JvdGU6Cj4gSGkgUGVy
ZmVjdCBHZW50bGVtYW4sCj4KPiBUaGFua3MgZm9yIHRoZSByZXBvcnQuCj4KPiBPbiAyMDE4LzEx
LzI1IDEzOjI0LCBQZXJmZWN0IEdlbnRsZW1hbiB3cm90ZToKPj4gSGkgZjJmcy10ZWFtLAo+Pgo+
PiB0aGVyZSBpcyBidWc6IGZzY2suZjJmcyBjYW5ub3QgY2hlY2sgcmVhZC1vbmx5IGZpbGVzeXN0
ZW0uIEJ1dCAxLjExLjAKPj4gY2FuIGRvIHRoYXQuCj4+Cj4+IGZzY2vCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8SW5mbzogRml4IHRoZSByZXBvcnRlZCBjb3JydXB0aW9uLgo+PiBmc2NrwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfEluZm86IE1vdW50ZWQgZGV2aWNlIQo+PiBmc2NrwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfEluZm86IENoZWNrIEZTIG9ubHkgZHVlIHRvIFJPCj4+
IGZzY2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8RXJyb3I6IEZhaWxlZCB0byBvcGVuIHRo
ZSBkZXZpY2UhCj4gSSBndWVzcyB0aGlzIGlzIGR1ZSB0byBiZWxvdyBjb21taXQsIHdoaWNoIHN0
b3Agb3BlbmluZyBkZXZpY2UgaW4KPiBmMmZzLXRvb2xzIGlmIHRoZSBkZXZpY2UgaGFzIGFscmVh
ZHkgYmVlbiBvcGVuZWQgYnkgb3RoZXIgb25lLCBsaWtlIG1vdW50Lgo+Cj4gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvamFlZ2V1ay9mMmZzLXRvb2xzLmdp
dC9jb21taXQvP2g9ZGV2LXRlc3QmaWQ9ZWI5ZDgwMzdlZDNiMzdhNjQ3ZDUxNDQ3MGYxYTFkZjkx
ZGFlZGI2NAo+Cj4gSSB0cmllZCBlMmZzcHJvZ3MsIHcvbyAtZiBvcHRpb24sIHRoZSByZXN1bHQg
aXMgdGhlIHNhbWU6Cj4KPiBmc2NrIDEuNDQuNCAoMTgtQXVnLTIwMTgpCj4gZTJmc2NrIDEuNDQu
NCAoMTgtQXVnLTIwMTgpCj4gL2Rldi96cmFtMCBpcyBtb3VudGVkLgo+IGUyZnNjazogQ2Fubm90
IGNvbnRpbnVlLCBhYm9ydGluZy4KPgo+IEJ1dCBzdGlsbCB3ZSBjYW4gdHJpZ2dlciBmb3JjZWQg
ZnNjay5leHQ0IGJ5IHVzaW5nIC1mIG9wdGlvbi4KPgo+IENvdWxkIHlvdSBoYXZlIGEgdHJ5IHdp
dGggZm9sbG93aW5nIHBhdGNoPwo+Cj4gW1BBVENIXSBmc2NrLmYyZnM6IGFsbG93IHRvIGZzY2sg
cmVhZG9ubHkgaW1hZ2Ugdy8gLWYgb3B0aW9uCj4KPiBUaGFua3MsCj4KPj4gZnNja8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgKiBGaWxlc3lzdGVtcyBjb3VsZG4ndCBiZSBmaXhlZAo+PiAg
IMKgWyAhISBdCj4+IGZzY2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8ICogRVJST1I6IGZz
Y2sgZmFpbGVkIHRvIHN0YXJ0Cj4+Cj4+IFJlZ2FyZHMsCj4+IEFsZXgKPj4KPj4KPj4KPj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKPj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKPj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo+PgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
