From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fix the calculation
 raw_node->footer.next_blkaddr for in f2fs_write_root_inode
Date: Fri, 28 Jun 2013 11:51:30 +0900
Message-ID: <1372387890.736.1.camel@kjgkr>
References: <51CCF7D6.1080008@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UsOmg-00060N-AK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 02:51:38 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UsOmc-0003JB-Oz for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 02:51:38 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MP300GGX19BLCH0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 11:51:28 +0900 (KST)
In-reply-to: <51CCF7D6.1080008@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Wang Sheng-Hui <shhuiw@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDEzLTA2LTI4ICjquIgpLCAxMDo0MSArMDgwMCwgV2FuZyBTaGVuZy1IdWk6Cj4gVGhl
IHJhd19ub2RlIHdpbGwgdGFrZSAxIGJsayBpdHNlbGYsIGFuZCBpdHMgbmV4dCBibGsgYWRkciBz
aG91bGQgYmUgKzEuCj4gCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBTaGVuZy1IdWkgPHNoaHVpd0Bn
bWFpbC5jb20+Cj4gLS0tCj4gICBta2ZzL2YyZnNfZm9ybWF0LmMgfCAgICAyICstCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvbWtmcy9mMmZzX2Zvcm1hdC5jIGIvbWtmcy9mMmZzX2Zvcm1hdC5jCj4gaW5kZXggMDY3NzFm
Zi4uM2FiNDFjYyAxMDA2NDQKPiAtLS0gYS9ta2ZzL2YyZnNfZm9ybWF0LmMKPiArKysgYi9ta2Zz
L2YyZnNfZm9ybWF0LmMKPiBAQCAtNzQ0LDcgKzc0NCw3IEBAIHN0YXRpYyBpbnQgZjJmc193cml0
ZV9yb290X2lub2RlKHZvaWQpCj4gICAJcmF3X25vZGUtPmZvb3Rlci5uZXh0X2Jsa2FkZHIgPSBj
cHVfdG9fbGUzMigKPiAgIAkJCWxlMzJfdG9fY3B1KHN1cGVyX2Jsb2NrLm1haW5fYmxrYWRkcikg
Kwo+ICAgCQkJY29uZmlnLmN1cl9zZWdbQ1VSU0VHX0hPVF9OT0RFXSAqCj4gLQkJCWNvbmZpZy5i
bGtzX3Blcl9zZWcgKyAxKTsKPiArCQkJY29uZmlnLmJsa3NfcGVyX3NlZykgKyAxOwoKV2hhdCBk
byB5b3UgbWVhbj8KKzEgc2hvdWxkIGJlIGluc2lkZSB0aGUgY3B1X3RvX2xlMzIoKS4KVGhhbmtz
LAoKPiAKPiAgIAlyYXdfbm9kZS0+aS5pX21vZGUgPSBjcHVfdG9fbGUxNigweDQxZWQpOwo+ICAg
CXJhd19ub2RlLT5pLmlfbGlua3MgPSBjcHVfdG9fbGUzMigyKTsKCi0tIApKYWVnZXVrIEtpbQpT
YW1zdW5nCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9u
c29yZWQgYnkgV2luZG93czoKCkJ1aWxkIGZvciBXaW5kb3dzIFN0b3JlLgoKaHR0cDovL3Auc2Yu
bmV0L3NmdS93aW5kb3dzLWRldjJkZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
