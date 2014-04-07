From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: kernel BUG at fs/f2fs/segment.h:543
Date: Mon, 07 Apr 2014 12:40:28 +0900
Message-ID: <1396842028.24638.4.camel@kjgkr>
References: <53401D4A.1020203@oracle.com> <1396833642.12401.12.camel@kjgkr>
	<5342058E.4090500@oracle.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WX0SA-0004Tr-47
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Apr 2014 03:42:34 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WX0S8-0008QH-4l
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Apr 2014 03:42:34 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N3N00LGY6AODEA0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Apr 2014 12:42:24 +0900 (KST)
In-reply-to: <5342058E.4090500@oracle.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sasha Levin <sasha.levin@oracle.com>
Cc: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

MjAxNC0wNC0wNiAo7J28KSwgMjE6NTUgLTA0MDAsIFNhc2hhIExldmluOgo+IE9uIDA0LzA2LzIw
MTQgMDk6MjAgUE0sIEphZWdldWsgS2ltIHdyb3RlOgo+ID4gSGksCj4gPiAKPiA+IFRoYW5rIHlv
dSBmb3IgdGhlIHJlcG9ydC4KPiA+IAo+ID4gSWYgcG9zc2libGUsIGNvdWxkIHlvdSBzaGFyZSBm
c2NrLmYyZnMgb3IgZHVtcC5mMmZzIG9uIHRoZSBjb3JydXB0ZWQKPiA+IHBhcnRpdGlvbj8KPiA+
IAo+ID4gT3RoZXJ3aXNlLCBob3cgYWJvdXQgdGhpcz8KPiA+ICMgZmRpc2sgL2Rldi9zZHgKPiA+
PiA+IHAKPiAKPiBIZXkgSmFlZ2V1aywKPiAKPiBVbmZvcnR1bmF0ZWx5IGl0IHdhcyBhIHRlbXBv
cmFyeSBmaWxlc3lzdGVtIGluc2lkZSB0aGUgZnV6emVyIHRoYXQgaGFzCj4gZ29uZSBhd2F5IGFz
IHNvb24gYXMgdGhlIGtlcm5lbCBkaWVkLCBzbyBJIGRvbid0IGhhdmUgYWNjZXNzIHRvIGl0LgoK
R290IGl0LgpUaGVuLCBqdXN0IGZvciBzdXJlLCBpZiBpdCBpcyByZXByb2R1Y2libGUsIGNvdWxk
IHlvdSB0ZXN0IGYyZnMgd2l0aCB0aGUKZm9sbG93aW5nIHBhdGNoPwpUaGFua3MsCgpGcm9tIDg0
ZjgwYTEyNjQ1OGVlZWFhM2M0ZWJjZWNmYjY5MDhmN2QyMmIyMTQgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxCkZyb206IEphZWdldWsgS2ltIDxqYWVnZXVrLmtpbUBzYW1zdW5nLmNvbT4KRGF0ZTog
TW9uLCA3IEFwciAyMDE0IDEyOjM3OjM5ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gdGVzdAoKU2ln
bmVkLW9mZi1ieTogSmFlZ2V1ayBLaW0gPGphZWdldWsua2ltQHNhbXN1bmcuY29tPgotLS0KIGZz
L2YyZnMvc2VnbWVudC5oIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc2VnbWVudC5oIGIvZnMvZjJmcy9zZWdtZW50LmgKaW5k
ZXggNzA5MTIwNC4uZDljZjA2ZSAxMDA2NDQKLS0tIGEvZnMvZjJmcy9zZWdtZW50LmgKKysrIGIv
ZnMvZjJmcy9zZWdtZW50LmgKQEAgLTU0MCw2ICs1NDAsMTEgQEAgc3RhdGljIGlubGluZSB2b2lk
IHZlcmlmeV9ibG9ja19hZGRyKHN0cnVjdApmMmZzX3NiX2luZm8gKnNiaSwgYmxvY2tfdCBibGtf
YWRkcikKIAlibG9ja190IHRvdGFsX2Jsa3MgPSBzbV9pbmZvLT5zZWdtZW50X2NvdW50IDw8CnNi
aS0+bG9nX2Jsb2Nrc19wZXJfc2VnOwogCWJsb2NrX3Qgc3RhcnRfYWRkciA9IHNtX2luZm8tPnNl
ZzBfYmxrYWRkcjsKIAlibG9ja190IGVuZF9hZGRyID0gc3RhcnRfYWRkciArIHRvdGFsX2Jsa3Mg
LSAxOworCWlmIChibGtfYWRkciA8IHN0YXJ0X2FkZHIpIHsKKwkJZjJmc19tc2coc2JpLT5zYiwg
S0VSTl9FUlIsCisJCQkiYmxrX2FkZHI6ICVsZCwgc3RhcnQ6ICVsZCwgZW5kOiAlbGQiLAorCQkJ
YmxrX2FkZHIsIHN0YXJ0X2FkZHIsIGVuZF9hZGRyKTsKKwl9CiAJQlVHX09OKGJsa19hZGRyIDwg
c3RhcnRfYWRkcik7CiAJQlVHX09OKGJsa19hZGRyID4gZW5kX2FkZHIpOwogfQotLSAKMS44LjQu
NDc0LmcxMjhhOTZjCgoKLS0gCkphZWdldWsgS2ltClNhbXN1bmcKCgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tClB1dCBCYWQgRGV2ZWxvcGVycyB0byBTaGFtZQpEb21pbmF0ZSBEZXZlbG9wbWVudCB3
aXRoIEplbmtpbnMgQ29udGludW91cyBJbnRlZ3JhdGlvbgpDb250aW51b3VzbHkgQXV0b21hdGUg
QnVpbGQsIFRlc3QgJiBEZXBsb3ltZW50IApTdGFydCBhIG5ldyBwcm9qZWN0IG5vdy4gVHJ5IEpl
bmtpbnMgaW4gdGhlIGNsb3VkLgpodHRwOi8vcC5zZi5uZXQvc2Z1LzEzNjAwX0Nsb3VkYmVlc19B
UFIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
