From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v3 RESEND] f2fs: add bug_on when f2fs_gc even
 fails to get one victim
Date: Thu, 23 Nov 2017 21:05:12 +0800
Message-ID: <77657045-2bba-2c31-f668-de6351c3f342@kernel.org>
References: <1510880948-154538-1-git-send-email-yunlong.song@huawei.com>
 <ad823d10-ac5c-095d-2eb6-5f84c559a098@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eHrCD-00066a-0f
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Nov 2017 13:05:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eHrCB-0002Kh-23
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Nov 2017 13:05:36 +0000
In-Reply-To: <ad823d10-ac5c-095d-2eb6-5f84c559a098@huawei.com>
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

T24gMjAxNy8xMS8yMiAxMTo1MCwgWXVubG9uZyBTb25nIHdyb3RlOgo+IHBpbmcgYWdhaW4uLi4K
PiAKPiBPbiAyMDE3LzExLzE3IDk6MDksIFl1bmxvbmcgU29uZyB3cm90ZToKPj4gVGhpcyBjYW4g
aGVscCB0byBmaW5kIHBvdGVudGlhbCBidWdzIG9uIHNvbWUgY29ybmVyIGNhc2UuCgpDb3VsZCB5
b3UgdGVzdCB0aGlzIHBhdGNoIHdpdGggZnN0ZXN0IHN1aXQ/IGlmIHRoZXJlIGFyZSBhbnkgdGVz
dGNhc2VzCmNhbiB0cmlnZ2VyIHRoaXMgYnVnX29uLCBpdCB3aWxsIGJlIGJldHRlciB0byBmaXgg
dGhlbSBhbGwgdG9nZXRoZXIuCgpUaGFua3MsCgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBZdW5sb25n
IFNvbmcgPHl1bmxvbmcuc29uZ0BodWF3ZWkuY29tPgo+PiAtLS0KPj4gwqAgZnMvZjJmcy9nYy5j
IHwgMSArCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZnMvZjJmcy9nYy5jIGIvZnMvZjJmcy9nYy5jCj4+IGluZGV4IDVkNWJiYTQuLmM4OTEy
OGIgMTAwNjQ0Cj4+IC0tLSBhL2ZzL2YyZnMvZ2MuYwo+PiArKysgYi9mcy9mMmZzL2djLmMKPj4g
QEAgLTEwMzUsNiArMTAzNSw3IEBAIGludCBmMmZzX2djKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNi
aSwgYm9vbCBzeW5jLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBzdG9wOwo+PiDCoMKgwqDC
oMKgIH0KPj4gwqDCoMKgwqDCoCBpZiAoIV9fZ2V0X3ZpY3RpbShzYmksICZzZWdubywgZ2NfdHlw
ZSkpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGYyZnNfYnVnX29uKHNiaSwgIXRvdGFsX2ZyZWVkICYm
IGhhc19ub3RfZW5vdWdoX2ZyZWVfc2VjcyhzYmksIDAsIDApKTsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IC1FTk9EQVRBOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBzdG9wOwo+PiDC
oMKgwqDCoMKgIH0KPiAKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJh
bnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVj
aCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
