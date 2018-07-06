From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Re: Bug report: some new bugs found by fuzzing
Date: Fri, 6 Jul 2018 13:01:48 +0000
Message-ID: <A1987FDB-513F-4FA7-9119-3C08BE72BE2C@gatech.edu>
References: <B655752F-CBBA-4D7D-B504-E1E21378429A@gatech.edu>
 <7f5282db-2bb6-b808-679b-620957185945@huawei.com>
 <0C7436B3-FE05-4999-A163-89F9851ADC00@gatech.edu>
 <62019555-437e-b94d-1962-86bcee7e43f3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fbQN3-0000ft-4Y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 13:01:57 +0000
Received: from mail-sn1nam01on0090.outbound.protection.outlook.com
 ([104.47.32.90] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fbQN1-00BKQw-7o
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 13:01:57 +0000
In-Reply-To: <62019555-437e-b94d-1962-86bcee7e43f3@huawei.com>
Content-Language: en-US
Content-ID: <0C4DDEF92585004587A6722300123079@namprd07.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

TXkgZnV6emVyIHN0aWxsIHJhbmRvbWx5IGZ1enplcyB0aGUgYnl0ZXMgaW4gdGhlIGltYWdlLCBi
dXQgd2hhdGV2ZXIgaXQgd3JpdGVzLA0KaXQgd2lsbCBmaXggdGhlIGNoZWNrc3VtIGluIENQIGJs
b2NrcyBhZnRlcndhcmRzLiBGMkZTIG9ubHkgaGFzIENSQyBjaGVjayBpbiBDUCwgc28NCml0IGlz
IG5vdCB2ZXJ5IGhhcmQgZm9yIG1lIHRvIHN0dWR5IHRoZSBleGlzdGVkIGNvZGUgYW5kIGRvIHRo
aXMuIEkganVzdCB3YW50IHRvIHRvdWNoIG1vcmUNCmNvZGUgYnkgcGFzc2luZyBDUkMgY2hlY2tz
Lg0KDQpUaGFua3MsDQpXZW4NCg0KPiBPbiBKdWwgNiwgMjAxOCwgYXQgMzowMCBBTSwgQ2hhbyBZ
dSA8eXVjaGFvMEBodWF3ZWkuY29tPiB3cm90ZToNCj4gDQo+IEhpIFdlbg0KPiANCj4gT24gMjAx
OC83LzYgOTozMCwgWHUsIFdlbiB3cm90ZToNCj4+IFRoYW5rcyB2ZXJ5IG11Y2ghIEkgd291bGQg
bGlrZSB0byBwcm92aWRlIGFueSBmdXJ0aGVyIGhlbHAgb3IgdGVzdGluZy4NCj4gDQo+IEkgZm91
bmQgc29tZXRoaW5nIGludGVyZXN0aW5nLCBvdXIga2V5IG1ldGFkYXRhIGluIGNoZWNrcG9pbnQg
cGFjayBoYXMgYWxyZWFkeQ0KPiBiZWVuIHByb3RlY3RlZCBieSBjaGVja3N1bSwgaW4gaW1hZ2Ug
eW91IGF0dGFjaGVkLCB0aGUgdmFsdWUgb2YgY2hlY2tzdW0gaXMNCj4gY29ycmVjdCwgYnV0IHN0
aWxsIHNvbWUga2V5IG1ldGFkYXRhJ3MgdmFsdWUgYXJlIGNvcnJ1cHRlZCwgc28gSSBndWVzcyBm
dXp6aW5nDQo+IHdpbGwgaW5qZWN0IGVycm9yIGRhdGEgaW4gdG9vbHMgbGlrZSBta2ZzLmYyZnMs
IGlzIHRoYXQgY29ycmVjdD8NCj4gDQo+IFRoYW5rcywNCj4gDQo+PiANCj4+IC1XZW4NCj4+IA0K
Pj4+IE9uIEp1bCA1LCAyMDE4LCBhdCA5OjEzIFBNLCBDaGFvIFl1IDx5dWNoYW8wQGh1YXdlaS5j
b20+IHdyb3RlOg0KPj4+IA0KPj4+IEhpIFdlbiwNCj4+PiANCj4+PiBPbiAyMDE4LzcvNiAzOjE5
LCBYdSwgV2VuIHdyb3RlOg0KPj4+PiBEZWFyIEYyRlMgZGV2ZWxvcGVycywNCj4+Pj4gDQo+Pj4+
IEJ5IGZ1enppbmcsIEkgZmluZCBzb21lIG5ldyBpc3N1ZXMgaW4gTGludXggZjJmcyBrZXJuZWwg
bW9kdWxlLiBIZXJlIGFyZSB0aGUgbGlua3Mgb24gQnVnemlsbGEsDQo+Pj4+IA0KPj4+PiAyMDA0
MTkJTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIF9fcmVtb3ZlX2RpcnR5X3NlZ21lbnQoKSB3
aGVuIG1vdW50aW5nIGFuIGYyZnMgaW1hZ2UNCj4+Pj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwu
b3JnL3Nob3dfYnVnLmNnaT9pZD0yMDA0MTkNCj4+Pj4gDQo+Pj4+IDIwMDQyMQlCdWZmZXIgb3Zl
cnJ1biBpbiBmMmZzX3RydW5jYXRlX2lubGluZV9pbm9kZSgpIHdoZW4gdW1vdW50aW5nIGFuIGYy
ZnMgaW1hZ2UNCj4+Pj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0yMDA0MjENCj4+Pj4gDQo+Pj4+IDIwMDQyMwlPdXQtb2YtYm91bmQgYWNjZXNzIGluIGYyZnNf
Z2V0X2Rub2RlX29mX2RhdGEoKSB3aGVuIG9wZXJhdGluZyBmaWxlIG9uIGFuIGYyZnMgaW1hZ2UN
Cj4+Pj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDA0MjMN
Cj4+Pj4gDQo+Pj4+IDIwMDQyNQlJbnZhbGlkIG1lbW9yeSBhY2Nlc3MgaW4gZjJmc19maW5kX3Rh
cmdldF9kZW50cnkoKSB3aGVuIG9wZXJhdGluZyBmaWxlcyBvbiBhbiBmMmZzIGltYWdlDQo+Pj4+
IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAwNDI1DQo+Pj4+
IA0KPj4+PiBSZWdhcmRpbmcgbXkgdGVzdGluZywgdGhleSBjYW4gYWxsIGJlIHJlcHJvZHVjZWQg
dy8gQ2hhb+KAmXMgZjJmcy1kZXYgYnJhbmNoLiBUaGFua3MhDQo+Pj4gDQo+Pj4gQWxyaWdodCwg
SSB3aWxsIGRpZyBpbnRvIHRoZXNlIGlzc3VlcyBpbiB0aGVzZSBkYXlzLCBvbmNlIEkgaGF2ZSBz
b2x1dGlvbiwgd2lsbA0KPj4+IGxldCB5b3Uga25vdy4NCj4+PiANCj4+PiBUaGFua3MsDQo+Pj4g
DQo+Pj4+IA0KPj4+PiAtV2VuDQo+PiANCj4gDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVj
ayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1v
c3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xh
c2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
