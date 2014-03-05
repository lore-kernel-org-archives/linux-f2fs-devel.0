From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] HACKING: document where to send patches
Date: Wed, 05 Mar 2014 10:21:54 +0900
Message-ID: <1393982514.3870.5.camel@kjgkr>
References: <1393937715-30399-1-git-send-email-ncopa@alpinelinux.org>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WL0Ym-00073u-77
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Mar 2014 01:23:48 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WL0Yh-00031A-9k
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Mar 2014 01:23:48 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N1X00L93VV8YMB0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Mar 2014 10:23:32 +0900 (KST)
In-reply-to: <1393937715-30399-1-git-send-email-ncopa@alpinelinux.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgpUaGlzIGluZm9ybWF0aW9uIGNhbiBiZSByZXRyaWV2ZWQgZnJvbToKbGludXgvTUFJTlRB
SU5FUlMuCk5vIG5lZWQgdG8gZG8gdGhpcy4KVGhhbmtzLAoKMjAxNC0wMy0wNCAo7ZmUKSwgMTI6
NTUgKzAwMDAsIE5hdGFuYWVsIENvcGE6Cj4gU2lnbmVkLW9mZi1ieTogTmF0YW5hZWwgQ29wYSA8
bmNvcGFAYWxwaW5lbGludXgub3JnPgo+IC0tLQo+ICBIQUNLSU5HIHwgMSArCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgSEFDS0lORwo+IAo+
IGRpZmYgLS1naXQgYS9IQUNLSU5HIGIvSEFDS0lORwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4g
aW5kZXggMDAwMDAwMC4uNTE1YjczZQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9IQUNLSU5HCj4g
QEAgLTAsMCArMSBAQAo+ICtTZW5kIHBhdGNoZXMgdG8gbGludXgtZjJmcy1kZXZlbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKCi0tIApKYWVnZXVrIEtpbQpTYW1zdW5nCgoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpTdWJ2ZXJzaW9uIEtpbGxzIFByb2R1Y3Rpdml0eS4gR2V0IG9mZiBTdWJ2ZXJzaW9u
ICYgTWFrZSB0aGUgTW92ZSB0byBQZXJmb3JjZS4KV2l0aCBQZXJmb3JjZSwgeW91IGdldCBoYXNz
bGUtZnJlZSB3b3JrZmxvd3MuIE1lcmdlIHRoYXQgYWN0dWFsbHkgd29ya3MuIApGYXN0ZXIgb3Bl
cmF0aW9ucy4gVmVyc2lvbiBsYXJnZSBiaW5hcmllcy4gIEJ1aWx0LWluIFdBTiBvcHRpbWl6YXRp
b24gYW5kIHRoZQpmcmVlZG9tIHRvIHVzZSBHaXQsIFBlcmZvcmNlIG9yIGJvdGguIE1ha2UgdGhl
IG1vdmUgdG8gUGVyZm9yY2UuCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFk
L2Nsaz9pZD0xMjIyMTg5NTEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
