From: Dongho Sim <dh.sim@samsung.com>
Subject: [PATCH v2] Remove an unnecessary line in
	allocate_data_block.
Date: Wed, 30 Jul 2014 03:54:50 +0000 (GMT)
Message-ID: <10988262.79501406692489974.JavaMail.weblogic@epml07>
Reply-To: dh.sim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dh.sim@samsung.com>) id 1XCKyi-00064S-DI
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Jul 2014 03:55:00 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XCKyg-0000W7-AD
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Jul 2014 03:55:00 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N9I008KZAVESR80@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Jul 2014 12:54:50 +0900 (KST)
MIME-version: 1.0
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkuIFRoZXJlIHdhcyBhbiB1bm5lY2Vzc2FyeSBsaW5lIGluIGZ1bmN0aW9uLCBhbGxvY2F0ZV9k
YXRhX2Jsb2NrLg0KDQpJbiB0aGlzIGZ1bmN0aW9uLCB3ZSBhbHJlYWR5IGNob29zZWQgb2xkIGN1
cnNlZyhZKSBhbmQgdGhlbiB3ZSBhbHdheXMgYWxsb2NhdGUgbmV3IGFkZHJlc3Mo4oiIWSkgZnJv
bSBpdC4NCkFmdGVyIHRoYXQgd2UgY2FsbCByZWZyZXNoX3NpdF9lbnRyeShzYmksIG9sZF9ibGth
ZGRyLCAqbmV3X2Jsa2FkZHIpLg0KSW4gdGhhdCBmdW5jdGlvbiwgd2UgY2FsbCBsb2NhdGVkX2Rp
cnR5X3NlZ21lbnQgd2l0aCBvbGQgc2VnKFgpIGFuZCBvbGQgY3Vyc2VnKFkpLg0KDQpTbywgYmVj
YXVzZSB3ZSd2ZSBkb25lIGFib3V0IG9sZCBjdXJzZWcoWSksIA0KY2FsbGluZyBsb2NhdGVfZGly
dHlfc2VnbWVudChzYmksIG9sZF9jdXJzZWdubykgYWdhaW4gaXMgcmVkdW5kYW50Lg0KDQpUaGFu
a3MuIDotKQ0KDQoNClNpZ25lZC1vZmYtYnk6IERvbmdobyBTaW0gPGRoLnNpbUBzYW1zdW5nLmNv
bT4NCi0tLQ0KIGZzL2YyZnMvc2VnbWVudC5jIHwgMyAtLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBk
ZWxldGlvbnMoLSkNCmRpZmYgLS1naXQgYS9mcy9mMmZzL3NlZ21lbnQuYyBiL2ZzL2YyZnMvc2Vn
bWVudC5jDQppbmRleCA4YTZlNTdkLi43YWY0YThkIDEwMDY0NA0KLS0tIGEvZnMvZjJmcy9zZWdt
ZW50LmMNCisrKyBiL2ZzL2YyZnMvc2VnbWVudC5jDQpAQCAtOTczLDE0ICs5NzMsMTIgQEAgdm9p
ZCBhbGxvY2F0ZV9kYXRhX2Jsb2NrKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgc3RydWN0IHBh
Z2UgKnBhZ2UsDQogew0KICBzdHJ1Y3Qgc2l0X2luZm8gKnNpdF9pID0gU0lUX0koc2JpKTsNCiAg
c3RydWN0IGN1cnNlZ19pbmZvICpjdXJzZWc7DQotIHVuc2lnbmVkIGludCBvbGRfY3Vyc2Vnbm87
DQogDQogIGN1cnNlZyA9IENVUlNFR19JKHNiaSwgdHlwZSk7DQogDQogIG11dGV4X2xvY2soJmN1
cnNlZy0+Y3Vyc2VnX211dGV4KTsNCiANCiAgKm5ld19ibGthZGRyID0gTkVYVF9GUkVFX0JMS0FE
RFIoc2JpLCBjdXJzZWcpOw0KLSBvbGRfY3Vyc2Vnbm8gPSBjdXJzZWctPnNlZ25vOw0KIA0KICAv
Kg0KICAgKiBfX2FkZF9zdW1fZW50cnkgc2hvdWxkIGJlIHJlc2lkZWQgdW5kZXIgdGhlIGN1cnNl
Z19tdXRleA0KQEAgLTEwMDEsNyArOTk5LDYgQEAgdm9pZCBhbGxvY2F0ZV9kYXRhX2Jsb2NrKHN0
cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgc3RydWN0IHBhZ2UgKnBhZ2UsDQogICAqIHNpbmNlIFNT
UiBuZWVkcyBsYXRlc3QgdmFsaWQgYmxvY2sgaW5mb3JtYXRpb24uDQogICAqLw0KICByZWZyZXNo
X3NpdF9lbnRyeShzYmksIG9sZF9ibGthZGRyLCAqbmV3X2Jsa2FkZHIpOw0KLSBsb2NhdGVfZGly
dHlfc2VnbWVudChzYmksIG9sZF9jdXJzZWdubyk7DQogDQogIG11dGV4X3VubG9jaygmc2l0X2kt
PnNlbnRyeV9sb2NrKTsNCiANCi0tIA0KMS45LjEKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkluZnJh
Z2lzdGljcyBQcm9mZXNzaW9uYWwKQnVpbGQgc3R1bm5pbmcgV2luRm9ybXMgYXBwcyB0b2RheSEK
UmVib290IHlvdXIgV2luRm9ybXMgYXBwbGljYXRpb25zIHdpdGggb3VyIFdpbkZvcm1zIGNvbnRy
b2xzLiAKQnVpbGQgYSBicmlkZ2UgZnJvbSB5b3VyIGxlZ2FjeSBhcHBzIHRvIHRoZSBmdXR1cmUu
Cmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD0xNTM4NDUwNzEm
aXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
