From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: Remove the unused argument
 "sbi" of func destroy_fsync_dnodes()
Date: Thu, 27 Jun 2013 14:16:17 +0900
Message-ID: <1372310177.28480.82.camel@kjgkr>
References: <51CB9556.4040103@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Us4ZG-00047I-7N
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 05:16:26 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Us4ZD-0005kN-Sm for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 05:16:26 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MP1009VEDA99G80@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 14:16:14 +0900 (KST)
In-reply-to: <51CB9556.4040103@cn.fujitsu.com>
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

SGksCgpNZXJnZWQuIDopClRoYW5rcywKCjIwMTMtMDYtMjcgKOuqqSksIDA5OjI4ICswODAwLCBH
dSBaaGVuZzoKPiBBcyBkZXN0cm95X2ZzeW5jX2Rub2RlcygpIGlzIGEgc2ltcGxlIGxpc3QtY2xl
YW51cCBmdW5jLCBzbyBkZWxldGUgdGhlIHVudXNlZAo+IGFuZCB1bnJlbGF0ZWQgZjJmc19zYl9p
bmZvIGFyZ3VtZW50IG9mIGl0Lgo+IAo+IAo+IFNpZ25lZC1vZmYtYnk6IEd1IFpoZW5nIDxndXou
Zm5zdEBjbi5mdWppdHN1LmNvbT4KPiAtLS0KPiAgZnMvZjJmcy9yZWNvdmVyeS5jIHwgICAgNSAr
Ky0tLQo+ICAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9yZWNvdmVyeS5jIGIvZnMvZjJmcy9yZWNvdmVyeS5j
Cj4gaW5kZXggOWRiODIzOS4uZDU2ZDk1MSAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL3JlY292ZXJ5
LmMKPiArKysgYi9mcy9mMmZzL3JlY292ZXJ5LmMKPiBAQCAtMTkyLDggKzE5Miw3IEBAIG91dDoK
PiAgCXJldHVybiBlcnI7Cj4gIH0KPiAKPiAtc3RhdGljIHZvaWQgZGVzdHJveV9mc3luY19kbm9k
ZXMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+IC0JCQkJCXN0cnVjdCBsaXN0X2hlYWQgKmhl
YWQpCj4gK3N0YXRpYyB2b2lkIGRlc3Ryb3lfZnN5bmNfZG5vZGVzKHN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQpCj4gIHsKPiAgCXN0cnVjdCBmc3luY19pbm9kZV9lbnRyeSAqZW50cnksICp0bXA7Cj4g
Cj4gQEAgLTQzOCw3ICs0MzcsNyBAQCBpbnQgcmVjb3Zlcl9mc3luY19kYXRhKHN0cnVjdCBmMmZz
X3NiX2luZm8gKnNiaSkKPiAgCWVyciA9IHJlY292ZXJfZGF0YShzYmksICZpbm9kZV9saXN0LCBD
VVJTRUdfV0FSTV9OT0RFKTsKPiAgCUJVR19PTighbGlzdF9lbXB0eSgmaW5vZGVfbGlzdCkpOwo+
ICBvdXQ6Cj4gLQlkZXN0cm95X2ZzeW5jX2Rub2RlcyhzYmksICZpbm9kZV9saXN0KTsKPiArCWRl
c3Ryb3lfZnN5bmNfZG5vZGVzKCZpbm9kZV9saXN0KTsKPiAgCWttZW1fY2FjaGVfZGVzdHJveShm
c3luY19lbnRyeV9zbGFiKTsKPiAgCXNiaS0+cG9yX2RvaW5nID0gMDsKPiAgCWlmICghZXJyKQoK
LS0gCkphZWdldWsgS2ltClNhbXN1bmcKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5u
ZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IFdpbmRvd3M6CgpCdWlsZCBmb3IgV2luZG93cyBTdG9y
ZS4KCmh0dHA6Ly9wLnNmLm5ldC9zZnUvd2luZG93cy1kZXYyZGV2Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
