From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: move dir data flush to write
 checkpoint process
Date: Tue, 6 Nov 2018 11:19:17 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F056548DF9E50@dggemm530-mbx.china.huawei.com>
References: <1541471129-25373-1-git-send-email-heyunlei@huawei.com>
 <9645a434-87e9-bf24-7ad8-a908f7b479a7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1gJzOh-0002Zk-GP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Nov 2018 11:19:51 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gJzOR-002Xul-IP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Nov 2018 11:19:51 +0000
In-Reply-To: <9645a434-87e9-bf24-7ad8-a908f7b479a7@huawei.com>
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
To: "Yuchao (T)" <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>
Cc: "miaoxie (A)" <miaoxie@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFl1Y2hhbyAoVCkNCj5TZW50
OiBUdWVzZGF5LCBOb3ZlbWJlciAwNiwgMjAxOCA1OjIwIFBNDQo+VG86IGhleXVubGVpOyBqYWVn
ZXVrQGtlcm5lbC5vcmc7IGNoYW9Aa2VybmVsLm9yZw0KPkNjOiBsaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldDsgbWlhb3hpZSAoQSkNCj5TdWJqZWN0OiBSZTogW2YyZnMtZGV2
XVtQQVRDSF0gZjJmczogbW92ZSBkaXIgZGF0YSBmbHVzaCB0byB3cml0ZSBjaGVja3BvaW50IHBy
b2Nlc3MNCj4NCj4NCj4NCj5PbiAyMDE4LzExLzYgMTA6MjUsIFl1bmxlaSBIZSB3cm90ZToNCj4+
IFRoaXMgcGF0Y2ggbW92ZSBkaXIgZGF0YSBmbHVzaCB0byB3cml0ZSBjaGVja3BvaW50IHByb2Nl
c3MsIGJ5DQo+PiBkb2luZyB0aGlzLCBpdCBtYXkgcmVkdWNlIHNvbWUgdGltZSBmb3IgZGlyIGZz
eW5jLg0KPj4NCj4+IHByZToNCj4+IAktZjJmc19kb19zeW5jX2ZpbGUgZW50ZXINCj4+IAkJLWZp
bGVfd3JpdGVfYW5kX3dhaXRfcmFuZ2UgIDwtIGZsdXNoICYgd2FpdA0KPj4gCQktd3JpdGVfY2hl
Y2twb2ludA0KPj4gCQkJLWRvX2NoZWNrcG9pbnQJICAgIDwtIHdhaXQgYWxsDQo+PiAJLWYyZnNf
ZG9fc3luY19maWxlIGV4aXQNCj4+DQo+PiBub3c6DQo+PiAJLWYyZnNfZG9fc3luY19maWxlIGVu
dGVyDQo+PiAJCS13cml0ZV9jaGVja3BvaW50DQo+PiAJCQktYmxvY2tfb3BlcmF0aW9ucyAgIDwt
IGZsdXNoIGRpciAmIG5vIHdhaXQNCj4+IAkJCS1kb19jaGVja3BvaW50CSAgICA8LSB3YWl0IGFs
bA0KPj4gCS1mMmZzX2RvX3N5bmNfZmlsZSBleGl0DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWXVu
bGVpIEhlIDxoZXl1bmxlaUBodWF3ZWkuY29tPg0KPj4gLS0tDQo+PiAgZnMvZjJmcy9maWxlLmMg
fCAzICsrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYw0KPj4gaW5kZXggODhiMTI0
Ni4uOWVhZjA3ZiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2YyZnMvZmlsZS5jDQo+PiArKysgYi9mcy9m
MmZzL2ZpbGUuYw0KPj4gQEAgLTIxNiw2ICsyMTYsOSBAQCBzdGF0aWMgaW50IGYyZnNfZG9fc3lu
Y19maWxlKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgc3RhcnQsIGxvZmZfdCBlbmQsDQo+Pg0K
Pj4gIAl0cmFjZV9mMmZzX3N5bmNfZmlsZV9lbnRlcihpbm9kZSk7DQo+Pg0KPj4gKwlpZiAoU19J
U0RJUihpbm9kZS0+aV9tb2RlKSkNCj4+ICsJCWdvdG8gZ29fd3JpdGU7DQo+DQo+Tm90IHN1cmUs
IHdpbGwgd2Ugc2tpcCBjYWxsaW5nIGYyZnNfd3JpdGVfaW5vZGUgZHVlIHRvIHRoaXMgY2hlY2s/
IHNvIHdlDQo+d2lsbCBtaXNzIHNvbWUgbWV0YWRhdGEgdXBkYXRlIGNhY2hlZCBpbiBpbm9kZSBj
YWNoZT8NCg0KSGVyZaOsbmV3IGNoZWNrcG9pbnQgd2lsbCB1cGRhdGUgYWxsIGRpcnR5IGlub2Rl
cyBtZXRhZGF0YSBmcm9tIGlub2RlIGNhY2hlIHRvIGlub2RlIHBhZ2Wjvw0KT3IgbWF5YmUgd2Ug
anVzdCBza2lwIGZpbGVfd3JpdGVfYW5kX3dhaXRfcmFuZ2UgYWN0aW9uIGZvciBJIGZvdW5kIGl0
IHdpbGwgYWx3YXlzIHdyaXRlIGEgY2hlY2twb2ludA0KZXZlbiB0aGUgZGlyIGlzIGNsZWFuLg0K
DQpBbmQgdGhlbiwgSSB0ZXN0IHRoZSBvcmlnaW5hbCBjb2Rlo7oNCg0KTWtkaXIgIEENClN5bmMg
QQ0KV2hpbGUgdHJ1ZQ0KCUZzeW5jIEENCg0KRXZlcnl0aW1lIGZzeW5jIHRoZSBjbGVhbiBkaXJl
Y3RvcnkgQaOsZjJmcyB3aWxsIHdyaXRlIGEgbmV3IGNoZWNrcG9pbnQgYWxzby4gDQoNClRoYW5r
cy4NCj4NCj5UaGFua3MsDQo+DQo+PiArDQo+PiAgCS8qIGlmIGZkYXRhc3luYyBpcyB0cmlnZ2Vy
ZWQsIGxldCdzIGRvIGluLXBsYWNlLXVwZGF0ZSAqLw0KPj4gIAlpZiAoZGF0YXN5bmMgfHwgZ2V0
X2RpcnR5X3BhZ2VzKGlub2RlKSA8PSBTTV9JKHNiaSktPm1pbl9mc3luY19ibG9ja3MpDQo+PiAg
CQlzZXRfaW5vZGVfZmxhZyhpbm9kZSwgRklfTkVFRF9JUFUpOw0KPj4NCg0KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFp
bGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
