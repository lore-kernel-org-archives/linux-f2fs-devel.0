From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: allocate hot_data for atomic write
 more strictly
Date: Tue, 17 Apr 2018 09:14:22 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F056548373AE8@DGGEMA503-MBS.china.huawei.com>
References: <1523878456-5058-1-git-send-email-heyunlei@huawei.com>
 <16d8fe6b-5e48-2723-b7df-7f199ecb499c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f8MlO-0006cZ-H1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 09:18:58 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8MhB-00C1VS-Tf
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 09:18:58 +0000
In-Reply-To: <16d8fe6b-5e48-2723-b7df-7f199ecb499c@huawei.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Yuchao (T)" <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Zhangdianfang (Euler)" <zhangdianfang@huawei.com>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFl1Y2hhbyAoVCkNCj5TZW50
OiBUdWVzZGF5LCBBcHJpbCAxNywgMjAxOCA0OjMxIFBNDQo+VG86IGhleXVubGVpOyBqYWVnZXVr
QGtlcm5lbC5vcmc7IGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0DQo+Q2M6
IFdhbmdiaW50aWFuOyBaaGFuZ2RpYW5mYW5nIChFdWxlcikNCj5TdWJqZWN0OiBSZTogW2YyZnMt
ZGV2XVtQQVRDSF0gZjJmczogYWxsb2NhdGUgaG90X2RhdGEgZm9yIGF0b21pYyB3cml0ZSBtb3Jl
IHN0cmljdGx5DQo+DQo+T24gMjAxOC80LzE2IDE5OjM0LCBZdW5sZWkgSGUgd3JvdGU6DQo+PiBJ
ZiBhIGZpbGUgbm90IHNldCB0eXBlIGFzIGhvdCwgaGFzIGRpcnR5IHBhZ2VzIG1vcmUgdGhhbg0K
Pj4gdGhyZXNob2xkIDY0IGJlZm9yZSBzdGFydGluZyBhdG9taWMgd3JpdGUsIG1heSBiZSBsb3Nl
IGhvdA0KPj4gZmxhZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZdW5sZWkgSGUgPGhleXVubGVp
QGh1YXdlaS5jb20+DQo+PiAtLS0NCj4+ICBmcy9mMmZzL2ZpbGUuYyB8IDMgKy0tDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9mcy9mMmZzL2ZpbGUuYyBiL2ZzL2YyZnMvZmlsZS5jDQo+PiBpbmRleCA3OWVlZWQ1
Li5iZjYxZTIwIDEwMDY0NA0KPj4gLS0tIGEvZnMvZjJmcy9maWxlLmMNCj4+ICsrKyBiL2ZzL2Yy
ZnMvZmlsZS5jDQo+PiBAQCAtMTY4NSw3ICsxNjg1LDYgQEAgc3RhdGljIGludCBmMmZzX2lvY19z
dGFydF9hdG9taWNfd3JpdGUoc3RydWN0IGZpbGUgKmZpbHApDQo+PiAgCQlnb3RvIG91dDsNCj4+
DQo+PiAgCXNldF9pbm9kZV9mbGFnKGlub2RlLCBGSV9BVE9NSUNfRklMRSk7DQo+DQo+SG93IGFi
b3V0IG1vdmluZyB0aGlzIGJlbG93IGluY19zdGF0IHRhZz8gSWYgdGhlcmUgaXMgc3RpbGwgZGly
dHkgcGFnZSwgZm9yDQo+cmVjbGFpbSBwYXRoLCB3ZSBtYXkgcmVkaXJ0eSBwYWdlIHdpdGggYXRv
bWljIHdyaXRlIG1vZGUsIHdlIG5lZWQgdG8gYXZvaWQgdGhhdC4NCj4NCldpdGggaXSjrG1heWJl
IHN0aWxsIGhhcyBkaXJ0eSBwYWdlcyBhZnRlciBmaWxlbWFwX3dyaXRlX2FuZF93YWl0X3Jhbmdl
o6wNCndoaWNoIGFyZSBub3QgaW5tZW0gcGFnZXMgYW5kIG1heWJlIGFmZmVjdCBhdG9taWNpdHk/
DQoNClRoYW5rcy4NCg0KPj4gLQlzZXRfaW5vZGVfZmxhZyhpbm9kZSwgRklfSE9UX0RBVEEpOw0K
Pj4gIAlmMmZzX3VwZGF0ZV90aW1lKEYyRlNfSV9TQihpbm9kZSksIFJFUV9USU1FKTsNCj4NCj5E
aXR0by4NCj4NCj5UaGFua3MsDQo+DQo+Pg0KPj4gIAlpZiAoIWdldF9kaXJ0eV9wYWdlcyhpbm9k
ZSkpDQo+PiBAQCAtMTY5NywxMSArMTY5NiwxMSBAQCBzdGF0aWMgaW50IGYyZnNfaW9jX3N0YXJ0
X2F0b21pY193cml0ZShzdHJ1Y3QgZmlsZSAqZmlscCkNCj4+ICAJcmV0ID0gZmlsZW1hcF93cml0
ZV9hbmRfd2FpdF9yYW5nZShpbm9kZS0+aV9tYXBwaW5nLCAwLCBMTE9OR19NQVgpOw0KPj4gIAlp
ZiAocmV0KSB7DQo+PiAgCQljbGVhcl9pbm9kZV9mbGFnKGlub2RlLCBGSV9BVE9NSUNfRklMRSk7
DQo+PiAtCQljbGVhcl9pbm9kZV9mbGFnKGlub2RlLCBGSV9IT1RfREFUQSk7DQo+PiAgCQlnb3Rv
IG91dDsNCj4+ICAJfQ0KPj4NCj4+ICBpbmNfc3RhdDoNCj4+ICsJc2V0X2lub2RlX2ZsYWcoaW5v
ZGUsIEZJX0hPVF9EQVRBKTsNCj4+ICAJRjJGU19JKGlub2RlKS0+aW5tZW1fdGFzayA9IGN1cnJl
bnQ7DQo+PiAgCXN0YXRfaW5jX2F0b21pY193cml0ZShpbm9kZSk7DQo+PiAgCXN0YXRfdXBkYXRl
X21heF9hdG9taWNfd3JpdGUoaW5vZGUpOw0KPj4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNo
ZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3Mg
bW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9z
bGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
