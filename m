From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 1/7] f2fs: put the bio when issue_flush
	completed
Date: Mon, 14 Apr 2014 10:36:15 +0900
Message-ID: <1397439375.24638.20.camel@kjgkr>
References: <5347BAAF.9030004@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WZVqr-0005lg-0N
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 01:38:25 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WZVqo-0004Kr-R6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 01:38:24 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N3Z0007LZ7RBW70@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 10:38:15 +0900 (KST)
In-reply-to: <5347BAAF.9030004@cn.fujitsu.com>
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
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

SGkgR3UsCk1lcmdlZC4KdGhhbmsgeW91LiA6KQoKMjAxNC0wNC0xMSAo6riIKSwgMTc6NDkgKzA4
MDAsIEd1IFpoZW5nOgo+IFB1dCB0aGUgYmlvIHdoZW4gdGhlIGZsdXNoIGNtZCBpc3N1ZWQsIGl0
IGFsc28gY2FuIGZpeCB0aGUgZm9sbG93aW5nCj4ga21lbWxlYWs6Cj4gdW5yZWZlcmVuY2VkIG9i
amVjdCAweGZmZmY4ODAwMjcwYzczYzAgKHNpemUgMjAwKToKPiAgIGNvbW0gImYyZnNfZmx1c2gt
NzowIiwgcGlkIDI3MTYxLCBqaWZmaWVzIDQzMTIxMjc5ODggKGFnZSA5ODguNTAzcykKPiAgIGhl
eCBkdW1wIChmaXJzdCAzMiBieXRlcyk6Cj4gICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDQw
IDA3IDgxIDE5IDAxIDg4IGZmIGZmICAuLi4uLi4uLkAuLi4uLi4uCj4gICAgIDAxIDAwIDAwIDAw
IDAwIDAwIDAwIGYwIDExIDE0IDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCj4g
ICBiYWNrdHJhY2U6Cj4gICAgIFs8ZmZmZmZmZmY4MTU1OTg2Nj5dIGttZW1sZWFrX2FsbG9jKzB4
NzIvMHg5Ngo+ICAgICBbPGZmZmZmZmZmODExNTZmN2U+XSBzbGFiX3Bvc3RfYWxsb2NfaG9vaysw
eDI4LzB4MmEKPiAgICAgWzxmZmZmZmZmZjgxMTU5NWIxPl0ga21lbV9jYWNoZV9hbGxvYysweGVj
LzB4MTU3Cj4gICAgIFs8ZmZmZmZmZmY4MTExOTI0ZD5dIG1lbXBvb2xfYWxsb2Nfc2xhYisweDE1
LzB4MTcKPiAgICAgWzxmZmZmZmZmZjgxMTE5NTEzPl0gbWVtcG9vbF9hbGxvYysweDcxLzB4MTM4
Cj4gICAgIFs8ZmZmZmZmZmY4MTE5MzU0OD5dIGJpb19hbGxvY19iaW9zZXQrMHg5My8weDE4Ywo+
ICAgICBbPGZmZmZmZmZmYTA0MGY4NTc+XSBpc3N1ZV9mbHVzaF90aHJlYWQrMHg4ZC8weDE0NSBb
ZjJmc10KPiAgICAgWzxmZmZmZmZmZjgxMDdhYzE2Pl0ga3RocmVhZCsweGJhLzB4YzIKPiAgICAg
WzxmZmZmZmZmZjgxNTcxYjJjPl0gcmV0X2Zyb21fZm9yaysweDdjLzB4YjAKPiAgICAgWzxmZmZm
ZmZmZmZmZmZmZmZmPl0gMHhmZmZmZmZmZmZmZmZmZmZmCj4gCj4gU2lnbmVkLW9mZi1ieTogR3Ug
WmhlbmcgPGd1ei5mbnN0QGNuLmZ1aml0c3UuY29tPgo+IC0tLQo+ICBmcy9mMmZzL3NlZ21lbnQu
YyB8ICAgIDEgKwo+ICAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zZWdtZW50LmMgYi9mcy9mMmZzL3NlZ21l
bnQuYwo+IGluZGV4IDA4NWY1NDguLjUyNGI3ZWQgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9zZWdt
ZW50LmMKPiArKysgYi9mcy9mMmZzL3NlZ21lbnQuYwo+IEBAIC0yMjYsNiArMjI2LDcgQEAgcmVw
ZWF0Ogo+ICAJCQluZXh0ID0gY21kLT5uZXh0Owo+ICAJCQljb21wbGV0ZSgmY21kLT53YWl0KTsK
PiAgCQl9Cj4gKwkJYmlvX3B1dChiaW8pOwo+ICAJCXNtX2ktPmRpc3BhdGNoX2xpc3QgPSBOVUxM
Owo+ICAJfQo+ICAKCi0tIApKYWVnZXVrIEtpbQpTYW1zdW5nCgoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCkxlYXJuIEdyYXBoIERhdGFiYXNlcyAtIERvd25sb2FkIEZSRUUgTydSZWlsbHkgQm9vawoi
R3JhcGggRGF0YWJhc2VzIiBpcyB0aGUgZGVmaW5pdGl2ZSBuZXcgZ3VpZGUgdG8gZ3JhcGggZGF0
YWJhc2VzIGFuZCB0aGVpcgphcHBsaWNhdGlvbnMuIFdyaXR0ZW4gYnkgdGhyZWUgYWNjbGFpbWVk
IGxlYWRlcnMgaW4gdGhlIGZpZWxkLAp0aGlzIGZpcnN0IGVkaXRpb24gaXMgbm93IGF2YWlsYWJs
ZS4gRG93bmxvYWQgeW91ciBmcmVlIGJvb2sgdG9kYXkhCmh0dHA6Ly9wLnNmLm5ldC9zZnUvTmVv
VGVjaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mMmZzLWRldmVsCg==
