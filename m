From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add the missing delection of orphan
 inode entry in write_orphan_inodes()
Date: Mon, 22 Jul 2013 21:51:19 +0900
Message-ID: <1374497479.26443.20.camel@kjgkr>
References: <51E8F65F.9040007@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V1FaX-00059C-Vb
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Jul 2013 12:51:42 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V1FaW-00020d-0r for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Jul 2013 12:51:41 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQC0090Q91GIWT0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Jul 2013 21:51:33 +0900 (KST)
In-reply-to: <51E8F65F.9040007@cn.fujitsu.com>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

SGksCgoyMDEzLTA3LTE5ICjquIgpLCAxNjoxOCArMDgwMCwgR3UgWmhlbmc6Cj4gQWZ0ZXIgd3Jp
dGluZyBvcnBoYW4gaW5vZGUgZW50cnkgaW4gam9ybmFsIGJsb2NrLCB3ZSBuZWVkIHRvIGRlbGV0
ZSBlYWNoCj4gZW50cnkgZnJvbSB0aGUgb3JwaGFuIGVudHJ5IGxpc3QsIGFuZCByZWxlYXNlIHRo
ZW0uCj4gCj4gCj4gU2lnbmVkLW9mZi1ieTogR3UgWmhlbmcgPGd1ei5mbnN0QGNuLmZ1aml0c3Uu
Y29tPgo+IC0tLQo+ICBmcy9mMmZzL2NoZWNrcG9pbnQuYyB8ICAgIDQgKysrKwo+ICAxIGZpbGVz
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvZnMvZjJmcy9jaGVja3BvaW50LmMgYi9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+IGluZGV4IDY2
YTZiODUuLjI5MGRiMDQgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9jaGVja3BvaW50LmMKPiArKysg
Yi9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+IEBAIC0zMzcsNiArMzM3LDEwIEBAIHN0YXRpYyB2b2lk
IHdyaXRlX29ycGhhbl9pbm9kZXMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBibG9ja190IHN0
YXJ0X2JsaykKPiAgCQltZW1zZXQob3JwaGFuX2JsaywgMCwgc2l6ZW9mKCpvcnBoYW5fYmxrKSk7
Cj4gIHBhZ2VfZXhpc3Q6Cj4gIAkJb3JwaGFuX2Jsay0+aW5vW25lbnRyaWVzKytdID0gY3B1X3Rv
X2xlMzIob3JwaGFuLT5pbm8pOwo+ICsKPiArCQlsaXN0X2RlbCgmb3JwaGFuLT5saXN0KTsKPiAr
CQlrbWVtX2NhY2hlX2ZyZWUob3JwaGFuX2VudHJ5X3NsYWIsIG9ycGhhbik7Cj4gKwkJc2JpLT5u
X29ycGhhbnMtLTsKCk5BSy4KV2Ugc2hvdWxkIG5vdCByZWxlYXNlIHRoZW0gaGVyZS4KT25seSBm
MmZzX2V2aWN0X2lub2RlIGNhbiBkbyBpdC4gCgo+ICAJfQo+ICAJaWYgKCFwYWdlKQo+ICAJCWdv
dG8gZW5kOwoKLS0gCkphZWdldWsgS2ltClNhbXN1bmcKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ClNlZSBldmVyeXRoaW5nIGZyb20gdGhlIGJyb3dzZXIgdG8gdGhlIGRhdGFiYXNlIHdpdGggQXBw
RHluYW1pY3MKR2V0IGVuZC10by1lbmQgdmlzaWJpbGl0eSB3aXRoIGFwcGxpY2F0aW9uIG1vbml0
b3JpbmcgZnJvbSBBcHBEeW5hbWljcwpJc29sYXRlIGJvdHRsZW5lY2tzIGFuZCBkaWFnbm9zZSBy
b290IGNhdXNlIGluIHNlY29uZHMuClN0YXJ0IHlvdXIgZnJlZSB0cmlhbCBvZiBBcHBEeW5hbWlj
cyBQcm8gdG9kYXkhCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9p
ZD00ODgwODgzMSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
