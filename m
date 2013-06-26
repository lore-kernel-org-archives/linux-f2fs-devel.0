From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Remove the unused argument "sbi" of
 func destroy_fsync_dnodes()
Date: Thu, 27 Jun 2013 08:21:58 +0900
Message-ID: <1372288918.28480.81.camel@kjgkr>
References: <51CABB36.4060808@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Urz2M-0000XU-CJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Jun 2013 23:22:06 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Urz2I-0006jp-JO for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Jun 2013 23:22:06 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MP0003CJWWJPS80@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 08:21:55 +0900 (KST)
In-reply-to: <51CABB36.4060808@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGkgR3UsCgpDb3VsZCB5b3UgY2hlY2sgeW91ciBlbWFpbCBlbnZpcm9ubWVudD8KSSBjYW4ndCBt
ZXJnZSB5b3VyIHBhdGNoLCBzaW5jZSBhbGwgdGhlIGluZGVudGF0aW9ucyBjb25zaXN0IG9mIHdo
aXRlCnNwYWNlcy4KQW5kIGFsc28sIHBsZWFzZSBjaGVjayA4MCBjaGFyYWN0ZXJzIGxpbWl0IHBl
ciBsaW5lLgpUaGFua3MsCgoyMDEzLTA2LTI2ICjsiJgpLCAxNzo1OCArMDgwMCwgR3UgWmhlbmc6
Cj4gRGVzdHJveV9mc3luY19kbm9kZXMoKSBpcyBhIHNpbXBsZSBsaXN0LWNsZWFudXAgZnVuYywg
c28gZGVsZXRlIHRoZSB1bnVzZWQgYW5kIHVucmVsYXRlZCBmMmZzX3NiX2luZm8gYXJndW1lbnQg
b2YgaXQuCj4gCj4gCj4gU2lnbmVkLW9mZi1ieTogR3UgWmhlbmcgPGd1ei5mbnN0QGNuLmZ1aml0
c3UuY29tPgo+IC0tLQo+ICBmcy9mMmZzL3JlY292ZXJ5LmMgfCAgICA1ICsrLS0tCj4gIDEgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9mcy9mMmZzL3JlY292ZXJ5LmMgYi9mcy9mMmZzL3JlY292ZXJ5LmMKPiBpbmRleCA5ZGI4
MjM5Li5kNTZkOTUxIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvcmVjb3ZlcnkuYwo+ICsrKyBiL2Zz
L2YyZnMvcmVjb3ZlcnkuYwo+IEBAIC0xOTIsOCArMTkyLDcgQEAgb3V0Ogo+ICAgICAgICAgcmV0
dXJuIGVycjsKPiAgfQo+ICAKPiAtc3RhdGljIHZvaWQgZGVzdHJveV9mc3luY19kbm9kZXMoc3Ry
dWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQo+ICtzdGF0aWMgdm9pZCBkZXN0cm95X2Zz
eW5jX2Rub2RlcyhzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qg
ZnN5bmNfaW5vZGVfZW50cnkgKmVudHJ5LCAqdG1wOwo+ICAKPiBAQCAtNDM4LDcgKzQzNyw3IEBA
IGludCByZWNvdmVyX2ZzeW5jX2RhdGEoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQo+ICAgICAg
ICAgZXJyID0gcmVjb3Zlcl9kYXRhKHNiaSwgJmlub2RlX2xpc3QsIENVUlNFR19XQVJNX05PREUp
Owo+ICAgICAgICAgQlVHX09OKCFsaXN0X2VtcHR5KCZpbm9kZV9saXN0KSk7Cj4gIG91dDoKPiAt
ICAgICAgIGRlc3Ryb3lfZnN5bmNfZG5vZGVzKHNiaSwgJmlub2RlX2xpc3QpOwo+ICsgICAgICAg
ZGVzdHJveV9mc3luY19kbm9kZXMoJmlub2RlX2xpc3QpOwo+ICAgICAgICAga21lbV9jYWNoZV9k
ZXN0cm95KGZzeW5jX2VudHJ5X3NsYWIpOwo+ICAgICAgICAgc2JpLT5wb3JfZG9pbmcgPSAwOwo+
ICAgICAgICAgaWYgKCFlcnIpCgotLSAKSmFlZ2V1ayBLaW0KU2Ftc3VuZwoKCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IFdpbmRvd3M6CgpC
dWlsZCBmb3IgV2luZG93cyBTdG9yZS4KCmh0dHA6Ly9wLnNmLm5ldC9zZnUvd2luZG93cy1kZXYy
ZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
