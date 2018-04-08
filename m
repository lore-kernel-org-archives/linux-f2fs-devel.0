From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: stop issue discard if something
 wrong with f2fs
Date: Sun, 8 Apr 2018 09:19:40 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F056548361FDC@DGGEMA503-MBS.china.huawei.com>
References: <1523171471-538-1-git-send-email-heyunlei@huawei.com>
 <8ca9f7d4-d56a-7a1c-a245-a973bfe02649@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f56UV-0004Pj-HH
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 09:20:03 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f56UR-002sIt-Ca
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 09:20:03 +0000
In-Reply-To: <8ca9f7d4-d56a-7a1c-a245-a973bfe02649@huawei.com>
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFl1Y2hhbyAoVCkNCj5TZW50
OiBTdW5kYXksIEFwcmlsIDA4LCAyMDE4IDQ6MjYgUE0NCj5UbzogaGV5dW5sZWk7IGphZWdldWtA
a2VybmVsLm9yZzsgbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQNCj5DYzog
V2FuZ2JpbnRpYW4NCj5TdWJqZWN0OiBSZTogW2YyZnMtZGV2XVtQQVRDSCAxLzJdIGYyZnM6IHN0
b3AgaXNzdWUgZGlzY2FyZCBpZiBzb21ldGhpbmcgd3Jvbmcgd2l0aCBmMmZzDQo+DQo+T24gMjAx
OC80LzggMTU6MTEsIFl1bmxlaSBIZSB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggc3RvcCBkaXNjYXJk
IHRocmVhZCB0byBpc3N1ZSBkaXNjYXJkIGlvIGlmDQo+PiBzb21ldGhpbmcgd3Jvbmcgd2l0aCBm
MmZzLCB3aGljaCBpcyBzaW1pbGFyIHRvIGZzdHJpbS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZ
dW5sZWkgSGUgPGhleXVubGVpQGh1YXdlaS5jb20+DQo+PiAtLS0NCj4+ICBmcy9mMmZzL3NlZ21l
bnQuYyB8IDUgKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc2VnbWVudC5jIGIvZnMvZjJmcy9zZWdtZW50LmMNCj4+
IGluZGV4IDU4NTRjYzQuLmY3NWY1MDMgMTAwNjQ0DQo+PiAtLS0gYS9mcy9mMmZzL3NlZ21lbnQu
Yw0KPj4gKysrIGIvZnMvZjJmcy9zZWdtZW50LmMNCj4+IEBAIC0xNDEwLDYgKzE0MTAsMTEgQEAg
c3RhdGljIGludCBpc3N1ZV9kaXNjYXJkX3RocmVhZCh2b2lkICpkYXRhKQ0KPj4gIAkJCWNvbnRp
bnVlOw0KPj4gIAkJaWYgKGt0aHJlYWRfc2hvdWxkX3N0b3AoKSkNCj4+ICAJCQlyZXR1cm4gMDsN
Cj4+ICsJCWlmIChpc19zYmlfZmxhZ19zZXQoc2JpLCBTQklfTkVFRF9GU0NLKSkgew0KPj4gKwkJ
CWYyZnNfbXNnKHNiaS0+c2IsIEtFUk5fV0FSTklORywNCj4+ICsJCQkJIkZvdW5kIEZTIGNvcnJ1
cHRpb24sIHJ1biBmc2NrIHRvIGZpeC4iKTsNCj4NCj5fX2dldF9uYXRfYml0bWFwcyBjYW4gc2V0
IHRoaXMgZmxhZyBkdXJpbmcgbW91bnRpbmc/IHNvIGl0cyBtZWFuaW5nIGlzIG5vdCBvbmx5DQo+
aW5kaWNhdGUgdGhlIGltYWdlIGlzIGNvcnJ1cHRlZCBidXQgYWxzbyBtZWFuIHRoYXQgd2UgbmVl
ZCBydW4gZnNjayB0byByZWNvdmVyDQo+c3RhdHVzIGxpa2UgbmF0IGJpdG1hcHM/DQoNClllc6Os
bmF0IGJpdG1hcHMgd2lsbCBzZXQgU0JJX05FRURfRlNDSyBpbiB0d28gY2FzZXM6DQoNCmkuICAg
bm8gcGxhY2UgdG8gd3JpdGUgbmF0IGJpdHMgIChmc2NrIGFsc28gZmFpbGVkIHRvIHJlY292ZXIp
DQppaS4gICBtb3VudCBwcm9jZXNzIHdpdGggZmFpbGVkIGNwIHZlcnNpb24gdmVyaWZ5ICAgKHN1
ZGRlbiBwb3dlciBvZmYgb3Igc29tZSBodyByZWFzb25zKQ0KDQpDb3VsZCB3ZSBkbyByZWNvdmVy
IG5hdCBiaXRtYXBzIHN0YXR1cyBub3QgYnkgZnNjayBidXQga2VybmVsIHNlbGYgZHVyaW5nIG1v
dW50aW5nPw0KDQpPdGhlciBwbGFjZXMgc2V0IFNCSV9ORUVEX0ZTQ0sgZmxhZyBub3cgYWxsIGlu
ZGljYXRlIHRoZSBpbWFnZSBoYXMgc29tZXRoaW5nIHdyb25nLg0KDQpCVFcsIHNob3VsZCB3ZSBt
b3ZlIHRoZSBqdWRnbWVudCB0byBmdW5jdGlvbiBfX2lzc3VlX2Rpc2NhcmRfY21kIGluIG9yZGVy
IHRvIGNvdmVyIHVtb3VudCBwcm9jZXNzPw0KDQpUaGFua3MuDQoNCj4NCj5UaGFua3MsDQo+DQo+
PiArCQkJY29udGludWU7DQo+PiArCQl9DQo+Pg0KPj4gIAkJaWYgKGRjYy0+ZGlzY2FyZF93YWtl
KQ0KPj4gIAkJCWRjYy0+ZGlzY2FyZF93YWtlID0gMDsNCj4+DQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3
b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2Rt
Lmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo=
