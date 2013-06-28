From: Wang Sheng-Hui <shhuiw@gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: fix the calculation for
 raw_node->footer.next_blkaddr in f2fs_write_root_inode
Date: Fri, 28 Jun 2013 13:56:44 +0800
Message-ID: <51CD259C.5080902@gmail.com>
References: <51CD1B40.2080803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shhuiw@gmail.com>) id 1UsRg7-0004jl-4P
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 05:57:03 +0000
Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UsRg5-0006D8-FK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 05:57:03 +0000
Received: by mail-ie0-f169.google.com with SMTP id 10so3389676ied.14
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 27 Jun 2013 22:56:56 -0700 (PDT)
In-Reply-To: <51CD1B40.2080803@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net

T24gMjAxM+W5tDA25pyIMjjml6UgMTM6MTIsIFdhbmcgU2hlbmctSHVpIHdyb3RlOgo+IFRoZSBy
YXdfbm9kZSB3aWxsIHRha2UgMSBibGsgaXRzZWxmLCBhbmQgaXRzIG5leHQgYmxrIGFkZHIgc2hv
dWxkIGJlICsxLgo+Cj4gU2lnbmVkLW9mZi1ieTogV2FuZyBTaGVuZy1IdWkgPHNoaHVpd0BnbWFp
bC5jb20+Cj4gLS0tCj4gICBta2ZzL2YyZnNfZm9ybWF0LmMgfCAgICAyICstCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9t
a2ZzL2YyZnNfZm9ybWF0LmMgYi9ta2ZzL2YyZnNfZm9ybWF0LmMKPiBpbmRleCAwNjc3MWZmLi5m
MDBiYTA0IDEwMDY0NAo+IC0tLSBhL21rZnMvZjJmc19mb3JtYXQuYwo+ICsrKyBiL21rZnMvZjJm
c19mb3JtYXQuYwo+IEBAIC03NDQsNyArNzQ0LDcgQEAgc3RhdGljIGludCBmMmZzX3dyaXRlX3Jv
b3RfaW5vZGUodm9pZCkKPiAgICAgICByYXdfbm9kZS0+Zm9vdGVyLm5leHRfYmxrYWRkciA9IGNw
dV90b19sZTMyKAo+ICAgICAgICAgICAgICAgbGUzMl90b19jcHUoc3VwZXJfYmxvY2subWFpbl9i
bGthZGRyKSArCj4gICAgICAgICAgICAgICBjb25maWcuY3VyX3NlZ1tDVVJTRUdfSE9UX05PREVd
ICoKPiAtICAgICAgICAgICAgY29uZmlnLmJsa3NfcGVyX3NlZyArIDEpOwo+ICsgICAgICAgICAg
ICBjb25maWcuYmxrc19wZXJfc2VnKSArIGNwdV90b19sZTMyKDEpOwo+Cj4gICAgICAgcmF3X25v
ZGUtPmkuaV9tb2RlID0gY3B1X3RvX2xlMTYoMHg0MWVkKTsKPiAgICAgICByYXdfbm9kZS0+aS5p
X2xpbmtzID0gY3B1X3RvX2xlMzIoMik7CgpTb3JyeSwgSSBtaXNsb29rZWQgdGhlICgpIHBvc2l0
aW9uLiBBbmQgdGhlIG9yaWdpbiBjYWxjdWxhdGlvbiBpcyByaWdodC4KUGxlYXNlIGlnbm9yZSB0
aGlzIHBhdGNoLgoKVGhhbmtzLApTaGVuZy1IdWkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlz
IFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgV2luZG93czoKCkJ1aWxkIGZvciBXaW5kb3dz
IFN0b3JlLgoKaHR0cDovL3Auc2YubmV0L3NmdS93aW5kb3dzLWRldjJkZXYKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
