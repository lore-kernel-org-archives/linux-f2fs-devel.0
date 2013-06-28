From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: fix the calculation for
 raw_node->footer.next_blkaddr in f2fs_write_root_inode
Date: Fri, 28 Jun 2013 14:56:22 +0900
Message-ID: <1372398982.736.6.camel@kjgkr>
References: <51CD1B40.2080803@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UsRfY-0006Hu-Ir
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 05:56:28 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UsRfW-0003Y3-MX for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 05:56:28 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MP3008WR9TTFT20@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 14:56:20 +0900 (KST)
In-reply-to: <51CD1B40.2080803@gmail.com>
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

SGksCgpBZ2FpbiwgaXQgZG9lc24ndCBtYWtlIHNlbnNlIHdoeSB3ZSBzaG91bGQgY3B1X3RvX2xl
MzIoeCkgKwpjcHVfdG9fbGUzMigxKSBpbnN0ZWFkIG9mIGNwdV90b19sZTMyKHggKyAxKS4KCldo
YXQgaXMgdGhlIHByb2JsZW0/CgoyMDEzLTA2LTI4ICjquIgpLCAxMzoxMiArMDgwMCwgV2FuZyBT
aGVuZy1IdWk6Cj4gVGhlIHJhd19ub2RlIHdpbGwgdGFrZSAxIGJsayBpdHNlbGYsIGFuZCBpdHMg
bmV4dCBibGsgYWRkciBzaG91bGQgYmUgKzEuCj4gCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBTaGVu
Zy1IdWkgPHNoaHVpd0BnbWFpbC5jb20+Cj4gLS0tCj4gICBta2ZzL2YyZnNfZm9ybWF0LmMgfCAg
ICAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvbWtmcy9mMmZzX2Zvcm1hdC5jIGIvbWtmcy9mMmZzX2Zvcm1hdC5j
Cj4gaW5kZXggMDY3NzFmZi4uZjAwYmEwNCAxMDA2NDQKPiAtLS0gYS9ta2ZzL2YyZnNfZm9ybWF0
LmMKPiArKysgYi9ta2ZzL2YyZnNfZm9ybWF0LmMKPiBAQCAtNzQ0LDcgKzc0NCw3IEBAIHN0YXRp
YyBpbnQgZjJmc193cml0ZV9yb290X2lub2RlKHZvaWQpCj4gICAJcmF3X25vZGUtPmZvb3Rlci5u
ZXh0X2Jsa2FkZHIgPSBjcHVfdG9fbGUzMigKPiAgIAkJCWxlMzJfdG9fY3B1KHN1cGVyX2Jsb2Nr
Lm1haW5fYmxrYWRkcikgKwo+ICAgCQkJY29uZmlnLmN1cl9zZWdbQ1VSU0VHX0hPVF9OT0RFXSAq
Cj4gLQkJCWNvbmZpZy5ibGtzX3Blcl9zZWcgKyAxKTsKPiArCQkJY29uZmlnLmJsa3NfcGVyX3Nl
ZykgKyBjcHVfdG9fbGUzMigxKTsKPiAKPiAgIAlyYXdfbm9kZS0+aS5pX21vZGUgPSBjcHVfdG9f
bGUxNigweDQxZWQpOwo+ICAgCXJhd19ub2RlLT5pLmlfbGlua3MgPSBjcHVfdG9fbGUzMigyKTsK
Ci0tIApKYWVnZXVrIEtpbQpTYW1zdW5nCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0Yu
bmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSBXaW5kb3dzOgoKQnVpbGQgZm9yIFdpbmRvd3MgU3Rv
cmUuCgpodHRwOi8vcC5zZi5uZXQvc2Z1L3dpbmRvd3MtZGV2MmRldgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
