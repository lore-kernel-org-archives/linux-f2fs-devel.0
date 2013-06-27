From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Remove the unused argument "sbi" of
	func destroy_fsync_dnodes()
Date: Thu, 27 Jun 2013 09:12:16 +0800
Message-ID: <51CB9170.3000507@cn.fujitsu.com>
References: <51CABB36.4060808@cn.fujitsu.com> <1372288918.28480.81.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1Us0o5-0001Oh-K9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 01:15:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Us0o3-0003KF-Dt for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 01:15:29 +0000
In-Reply-To: <1372288918.28480.81.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

T24gMDYvMjcvMjAxMyAwNzoyMSBBTSwgSmFlZ2V1ayBLaW0gd3JvdGU6Cgo+IEhpIEd1LAo+IAo+
IENvdWxkIHlvdSBjaGVjayB5b3VyIGVtYWlsIGVudmlyb25tZW50Pwo+IEkgY2FuJ3QgbWVyZ2Ug
eW91ciBwYXRjaCwgc2luY2UgYWxsIHRoZSBpbmRlbnRhdGlvbnMgY29uc2lzdCBvZiB3aGl0ZQo+
IHNwYWNlcy4KPiBBbmQgYWxzbywgcGxlYXNlIGNoZWNrIDgwIGNoYXJhY3RlcnMgbGltaXQgcGVy
IGxpbmUuCj4gVGhhbmtzLAoKCk9LLCB0aGFua3MgZm9yIHlvdXIgcmVtaW5kZXIuCgpSZWdhcmRz
LApHdQoKPiAKPiAyMDEzLTA2LTI2ICjsiJgpLCAxNzo1OCArMDgwMCwgR3UgWmhlbmc6Cj4+IERl
c3Ryb3lfZnN5bmNfZG5vZGVzKCkgaXMgYSBzaW1wbGUgbGlzdC1jbGVhbnVwIGZ1bmMsIHNvIGRl
bGV0ZSB0aGUgdW51c2VkIGFuZCB1bnJlbGF0ZWQgZjJmc19zYl9pbmZvIGFyZ3VtZW50IG9mIGl0
Lgo+Pgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBHdSBaaGVuZyA8Z3V6LmZuc3RAY24uZnVqaXRzdS5j
b20+Cj4+IC0tLQo+PiAgZnMvZjJmcy9yZWNvdmVyeS5jIHwgICAgNSArKy0tLQo+PiAgMSBmaWxl
cyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9mcy9mMmZzL3JlY292ZXJ5LmMgYi9mcy9mMmZzL3JlY292ZXJ5LmMKPj4gaW5kZXggOWRi
ODIzOS4uZDU2ZDk1MSAxMDA2NDQKPj4gLS0tIGEvZnMvZjJmcy9yZWNvdmVyeS5jCj4+ICsrKyBi
L2ZzL2YyZnMvcmVjb3ZlcnkuYwo+PiBAQCAtMTkyLDggKzE5Miw3IEBAIG91dDoKPj4gICAgICAg
ICByZXR1cm4gZXJyOwo+PiAgfQo+PiAgCj4+IC1zdGF0aWMgdm9pZCBkZXN0cm95X2ZzeW5jX2Ru
b2RlcyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksCj4+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQo+PiArc3RhdGljIHZvaWQg
ZGVzdHJveV9mc3luY19kbm9kZXMoc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKPj4gIHsKPj4gICAg
ICAgICBzdHJ1Y3QgZnN5bmNfaW5vZGVfZW50cnkgKmVudHJ5LCAqdG1wOwo+PiAgCj4+IEBAIC00
MzgsNyArNDM3LDcgQEAgaW50IHJlY292ZXJfZnN5bmNfZGF0YShzdHJ1Y3QgZjJmc19zYl9pbmZv
ICpzYmkpCj4+ICAgICAgICAgZXJyID0gcmVjb3Zlcl9kYXRhKHNiaSwgJmlub2RlX2xpc3QsIENV
UlNFR19XQVJNX05PREUpOwo+PiAgICAgICAgIEJVR19PTighbGlzdF9lbXB0eSgmaW5vZGVfbGlz
dCkpOwo+PiAgb3V0Ogo+PiAtICAgICAgIGRlc3Ryb3lfZnN5bmNfZG5vZGVzKHNiaSwgJmlub2Rl
X2xpc3QpOwo+PiArICAgICAgIGRlc3Ryb3lfZnN5bmNfZG5vZGVzKCZpbm9kZV9saXN0KTsKPj4g
ICAgICAgICBrbWVtX2NhY2hlX2Rlc3Ryb3koZnN5bmNfZW50cnlfc2xhYik7Cj4+ICAgICAgICAg
c2JpLT5wb3JfZG9pbmcgPSAwOwo+PiAgICAgICAgIGlmICghZXJyKQo+IAoKCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IFdpbmRvd3M6CgpC
dWlsZCBmb3IgV2luZG93cyBTdG9yZS4KCmh0dHA6Ly9wLnNmLm5ldC9zZnUvd2luZG93cy1kZXYy
ZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
