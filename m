From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: introduce f2fs_issue_discard() to clean up
Date: Thu, 28 Nov 2013 18:24:41 +0900
Message-ID: <1385630681.2417.41.camel@kjgkr>
References: <20131126145315.GA27436@elgon.mountain>
	<1385520381.2417.17.camel@kjgkr> <20131127083117.GT5443@mwanda>
	<1385543097.2417.35.camel@kjgkr> <20131127104130.GW5443@mwanda>
	<1385611487.2417.40.camel@kjgkr> <20131128080852.GD5443@mwanda>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vlxr5-0007gd-1o
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 09:25:51 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Vlxr3-0006Zz-1D
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 09:25:51 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWY00E19VIOS020@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 18:25:36 +0900 (KST)
In-reply-to: <20131128080852.GD5443@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

MjAxMy0xMS0yOCAo66qpKSwgMTE6MDggKzAzMDAsIERhbiBDYXJwZW50ZXI6Cj4gT24gVGh1LCBO
b3YgMjgsIDIwMTMgYXQgMDE6MDQ6NDdQTSArMDkwMCwgSmFlZ2V1ayBLaW0gd3JvdGU6Cj4gPiBk
aWZmIC0tZ2l0IGEvZnMvZjJmcy9nYy5jIGIvZnMvZjJmcy9nYy5jCj4gPiBpbmRleCBiN2FkMWVj
Li41ZmE1NGMxIDEwMDY0NAo+ID4gLS0tIGEvZnMvZjJmcy9nYy5jCj4gPiArKysgYi9mcy9mMmZz
L2djLmMKPiA+IEBAIC02NjQsOCArNjY0LDYgQEAgc3RhdGljIHZvaWQgZG9fZ2FyYmFnZV9jb2xs
ZWN0KHN0cnVjdCBmMmZzX3NiX2luZm8KPiA+ICpzYmksIHVuc2lnbmVkIGludCBzZWdubywKPiA+
ICAKPiA+ICAJLyogcmVhZCBzZWdtZW50IHN1bW1hcnkgb2YgdmljdGltICovCj4gPiAgCXN1bV9w
YWdlID0gZ2V0X3N1bV9wYWdlKHNiaSwgc2Vnbm8pOwo+ID4gLQlpZiAoSVNfRVJSKHN1bV9wYWdl
KSkKPiA+IC0JCXJldHVybjsKPiAKPiBEaWRuJ3QgeW91IHdhbnQgdG8gY2hlY2sgZm9yIE5VTEwg
aGVyZT8KCkl0IHdhcyBuZWVkbGVzcywgc2luY2UgZ2V0X3N1bV9wYWdlKCkgcmV0dXJucyBhbHdh
eXMgdmFsaWQgcGFnZS4KCi0tIApKYWVnZXVrIEtpbQpTYW1zdW5nCgoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpSYXBpZGx5IHRyb3VibGVzaG9vdCBwcm9ibGVtcyBiZWZvcmUgdGhleSBhZmZlY3Qg
eW91ciBidXNpbmVzcy4gTW9zdCBJVCAKb3JnYW5pemF0aW9ucyBkb24ndCBoYXZlIGEgY2xlYXIg
cGljdHVyZSBvZiBob3cgYXBwbGljYXRpb24gcGVyZm9ybWFuY2UgCmFmZmVjdHMgdGhlaXIgcmV2
ZW51ZS4gV2l0aCBBcHBEeW5hbWljcywgeW91IGdldCAxMDAlIHZpc2liaWxpdHkgaW50byB5b3Vy
IApKYXZhLC5ORVQsICYgUEhQIGFwcGxpY2F0aW9uLiBTdGFydCB5b3VyIDE1LWRheSBGUkVFIFRS
SUFMIG9mIEFwcER5bmFtaWNzIFBybyEKaHR0cDovL3B1YmFkcy5nLmRvdWJsZWNsaWNrLm5ldC9n
YW1wYWQvY2xrP2lkPTg0MzQ5MzUxJml1PS80MTQwL29zdGcuY2xrdHJrCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
