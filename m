From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: add bug_on when f2fs_gc even fails to
 get one victim
Date: Fri, 13 Oct 2017 20:24:15 +0800
Message-ID: <d171c827-9a6d-2c45-75cb-352658f04652@kernel.org>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
 <7a3f0052-86e0-4e46-c89b-048d6137b820@kernel.org>
 <ec42530e-ec96-65dd-64c3-9cc1e42d0ef7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e2z1T-0004U0-Gq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 12:25:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e2z1S-0001R4-5T
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 12:25:03 +0000
In-Reply-To: <ec42530e-ec96-65dd-64c3-9cc1e42d0ef7@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

T24gMjAxNy8xMC8xMyAxOToyMCwgWXVubG9uZyBTb25nIHdyb3RlOgo+IFllcCwgYm90aCBhcmUg
T0ssIHNpbmNlIEkgZG8gbm90IGNhcmUgaXQgaXMgZm9yZWdyb3VuZCBvciBiYWNrZ3JvdW5kLiBI
ZXJlIGl0IGp1c3QgbmVlZHMgdG8gZG8gZ2MuCgpCdXQgeW91IG9ubHkgc2V0IG5lZWRfZ2MgYXMg
dHJ1ZSBmb3IgZm9yZWdyb3VuZCBHQyBjYXNlLgoKVGhhbmtzLAoKPiAKPiBPbiAyMDE3LzEwLzEz
IDE5OjA5LCBDaGFvIFl1IHdyb3RlOgo+PiBPbiAyMDE3LzEwLzExIDIxOjUxLCBZdW5sb25nIFNv
bmcgd3JvdGU6Cj4+PiBUaGlzIGNhbiBoZWxwIHVzIHRvIGRlYnVnIG9uIHNvbWUgY29ybmVyIGNh
c2UuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWXVubG9uZyBTb25nIDx5dW5sb25nLnNvbmdAaHVh
d2VpLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZnMvZjJmcy9nYy5jIHwgNiArKysrKy0KPj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZnMvZjJmcy9nYy5jIGIvZnMvZjJmcy9nYy5jCj4+PiBpbmRleCAxOTdlYmY0Li45
NjA1MDNlIDEwMDY0NAo+Pj4gLS0tIGEvZnMvZjJmcy9nYy5jCj4+PiArKysgYi9mcy9mMmZzL2dj
LmMKPj4+IEBAIC05ODYsNiArOTg2LDcgQEAgaW50IGYyZnNfZ2Moc3RydWN0IGYyZnNfc2JfaW5m
byAqc2JpLCBib29sIHN5bmMsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmlsaXN0ID0gTElTVF9I
RUFEX0lOSVQoZ2NfbGlzdC5pbGlzdCksCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmlyb290ID0g
UkFESVhfVFJFRV9JTklUKEdGUF9OT0ZTKSwKPj4+IMKgwqDCoMKgwqAgfTsKPj4+ICvCoMKgwqAg
Ym9vbCBuZWVkX2djID0gZmFsc2U7Cj4+IEhvdyBhYm91dCBjaGFuZ2luZyB2YXJpYWJsZSBuYW1l
IHRvIG5lZWRfZmdnYyBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5Pwo+Pgo+PiBUaGFua3MsCj4+Cj4+
PiDCoCDCoMKgwqDCoMKgIHRyYWNlX2YyZnNfZ2NfYmVnaW4oc2JpLT5zYiwgc3luYywgYmFja2dy
b3VuZCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2V0X3BhZ2VzKHNi
aSwgRjJGU19ESVJUWV9OT0RFUyksCj4+PiBAQCAtMTAxOCw4ICsxMDE5LDEwIEBAIGludCBmMmZz
X2djKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgYm9vbCBzeW5jLAo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBzdG9wOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+IC3CoMKgwqDCoMKg
wqDCoCBpZiAoaGFzX25vdF9lbm91Z2hfZnJlZV9zZWNzKHNiaSwgMCwgMCkpCj4+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKGhhc19ub3RfZW5vdWdoX2ZyZWVfc2VjcyhzYmksIDAsIDApKSB7Cj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnY190eXBlID0gRkdfR0M7Cj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBuZWVkX2djID0gdHJ1ZTsKPj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+PiDC
oMKgwqDCoMKgIH0KPj4+IMKgIMKgwqDCoMKgwqAgLyogZjJmc19iYWxhbmNlX2ZzIGRvZXNuJ3Qg
bmVlZCB0byBkbyBCR19HQyBpbiBjcml0aWNhbCBwYXRoLiAqLwo+Pj4gQEAgLTEwMjgsNiArMTAz
MSw3IEBAIGludCBmMmZzX2djKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgYm9vbCBzeW5jLAo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gc3RvcDsKPj4+IMKgwqDCoMKgwqAgfQo+Pj4gwqDC
oMKgwqDCoCBpZiAoIV9fZ2V0X3ZpY3RpbShzYmksICZzZWdubywgZ2NfdHlwZSkpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBmMmZzX2J1Z19vbihzYmksICF0b3RhbF9mcmVlZCAmJiBuZWVkX2djKTsK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAtRU5PREFUQTsKPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIHN0b3A7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+Cj4+IC4KPj4KPiAKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25l
IG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBo
dHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
