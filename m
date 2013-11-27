From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: remove unneeded code in punch_hole
Date: Wed, 27 Nov 2013 14:14:08 +0900
Message-ID: <1385529248.2417.19.camel@kjgkr>
References: <000201cee760$58df9f10$0a9edd30$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VlXT3-0006Ni-C1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Nov 2013 05:15:17 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VlXT1-0001Pm-8y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Nov 2013 05:15:17 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWW0043EP94J510@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Nov 2013 14:15:04 +0900 (KST)
In-reply-to: <000201cee760$58df9f10$0a9edd30$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

R290IGl0LgoKQnV0LCB3aXRoIHRoaXMgcGF0Y2gsIHdlIGNhbiBhbHNvIHJlbW92ZSB0aGUgcGFy
YW1ldGVyLCBpbnQgbW9kZSwgaW4KcHVuY2hfaG9sZSgpLgpJZiBubyBvYmplY3Rpb24sIEknbGwg
Zml4IHRoYXQgaW4geW91ciBwYXRjaC4KVGhhbmtzLAoKMjAxMy0xMS0yMiAo6riIKSwgMTY6NTIg
KzA4MDAsIENoYW8gWXU6Cj4gQmVjYXVzZSBGQUxMT0NfRkxfUFVOQ0hfSE9MRSBmbGFnIG11c3Qg
YmUgT1JlZCB3aXRoIEZBTExPQ19GTF9LRUVQX1NJWkUgCj4gaW4gZmFsbG9jYXRlLCBzbyB3ZSBj
b3VsZCByZW1vdmUgdGhlIHVzZWxlc3MgJ2tlZXAgc2l6ZScgYnJhbmNoIGNvZGUgd2hpY2ggCj4g
d2lsbCBuZXZlciBiZSBleGN1dGVkIGluIHB1bmNoX2hvbGUuCj4gCj4gU2lnbmVkLW9mZi1ieTog
Q2hhbyBZdSA8Y2hhbzIueXVAc2Ftc3VuZy5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRmFuIExpIDxm
YW5vZmNvZGUubGlAc2Ftc3VuZy5jb20+Cj4gLS0tCj4gIGZzL2YyZnMvZmlsZS5jIHwgICAgNiAt
LS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2ZzL2YyZnMvZmlsZS5jIGIvZnMvZjJmcy9maWxlLmMKPiBpbmRleCA3ZDcxNGY0Li4wMDg3ZDJh
IDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZmlsZS5jCj4gKysrIGIvZnMvZjJmcy9maWxlLmMKPiBA
QCAtNDk5LDEyICs0OTksNiBAQCBzdGF0aWMgaW50IHB1bmNoX2hvbGUoc3RydWN0IGlub2RlICpp
bm9kZSwgbG9mZl90IG9mZnNldCwgbG9mZl90IGxlbiwgaW50IG1vZGUpCj4gIAkJfQo+ICAJfQo+
ICAKPiAtCWlmICghKG1vZGUgJiBGQUxMT0NfRkxfS0VFUF9TSVpFKSAmJgo+IC0JCWlfc2l6ZV9y
ZWFkKGlub2RlKSA8PSAob2Zmc2V0ICsgbGVuKSkgewo+IC0JCWlfc2l6ZV93cml0ZShpbm9kZSwg
b2Zmc2V0KTsKPiAtCQltYXJrX2lub2RlX2RpcnR5KGlub2RlKTsKPiAtCX0KPiAtCj4gIAlyZXR1
cm4gcmV0Owo+ICB9Cj4gIAoKLS0gCkphZWdldWsgS2ltClNhbXN1bmcKCgoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tClJhcGlkbHkgdHJvdWJsZXNob290IHByb2JsZW1zIGJlZm9yZSB0aGV5IGFmZmVj
dCB5b3VyIGJ1c2luZXNzLiBNb3N0IElUIApvcmdhbml6YXRpb25zIGRvbid0IGhhdmUgYSBjbGVh
ciBwaWN0dXJlIG9mIGhvdyBhcHBsaWNhdGlvbiBwZXJmb3JtYW5jZSAKYWZmZWN0cyB0aGVpciBy
ZXZlbnVlLiBXaXRoIEFwcER5bmFtaWNzLCB5b3UgZ2V0IDEwMCUgdmlzaWJpbGl0eSBpbnRvIHlv
dXIgCkphdmEsLk5FVCwgJiBQSFAgYXBwbGljYXRpb24uIFN0YXJ0IHlvdXIgMTUtZGF5IEZSRUUg
VFJJQUwgb2YgQXBwRHluYW1pY3MgUHJvIQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0
L2dhbXBhZC9jbGs/aWQ9ODQzNDkzNTEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
