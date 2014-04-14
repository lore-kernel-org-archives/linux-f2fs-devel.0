From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 0/7] f2fs: some fix and cleanup about
	flush_merge
Date: Mon, 14 Apr 2014 10:44:15 +0900
Message-ID: <1397439855.24638.24.camel@kjgkr>
References: <5347BAA5.6070104@cn.fujitsu.com> <534B374C.8030009@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WZVyc-00065w-R4
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 01:46:26 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WZVya-0005i7-Ib
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 01:46:26 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N3Z00IQ6ZL2EI90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 10:46:15 +0900 (KST)
In-reply-to: <534B374C.8030009@cn.fujitsu.com>
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

SGkgR3UsCgpJIGp1c3Qgc3RhcnRlZCB0byByZXZpZXcgdGhlIHBhdGNoZXMgYW5kIG1lcmdlIHRo
ZW0gaW5kaXZpZHVhbGx5IHRob3VnaC4KU2luY2UgSSd2ZSBiZWVuIGludGVybmFsbHkgZG9pbmcg
aW4gbXkgbG9jYWwgdHJlZSwgc28gdGhhdCBzaG91bGQgYmUgbm8KcHJvYmxlbS4gSSdsbCByb2xs
IGJhY2sgdG8gdGhlIGxhdGVzdCBwb2ludC4KQW55d2F5LCB0aGFuayB5b3UgZm9yIHlvdXIgd29y
ay4gOikKCjIwMTQtMDQtMTQgKOyblCksIDA5OjE4ICswODAwLCBHdSBaaGVuZzoKPiBIaSBBbGws
Cj4gVGhlcmUgc2VlbXMgdG8gYmUgYSBtaXN0YWtlIGluICJbUEFUQ0ggMi83XWYyZnM6IHJlbW92
ZSB0aGUgdW51c2VmdWwgImlzc3VlX3RhaWwiIGxpc3QiLAo+IGFuZCB0aGUgd2hvbGUgcGF0Y2hz
ZXQgbmVlZHMgdG8gYmUgcmV3b3JrZWQuIFNvIHBsZWFzZSBpZ25vcmUgdGhpcyBvbmUuCj4gU29y
cnkgZm9yIHRoZSBub2lzZS4KPiAKPiBSZWdhcmRzLAo+IEd1Cj4gT24gMDQvMTEvMjAxNCAwNTo0
OSBQTSwgR3UgWmhlbmcgd3JvdGU6Cj4gCj4gPiBHdSBaaGVuZyAoNyk6Cj4gPiAgIGYyZnM6IHB1
dCB0aGUgYmlvIHdoZW4gaXNzdWVfZmx1c2ggY29tcGxldGVkCj4gPiAgIGYyZnM6IHJlbW92ZSB0
aGUgdW51c2VmdWwgImlzc3VlX3RhaWwiIGxpc3QKPiA+ICAgZjJmczogdXNlIF9fR0ZQX1pFUk8g
dG8gYXZvaWQgYXBwZW5kaW5nIHNldC1OVUxMCj4gPiAgIGYyZnM6IGVuYWJsZSBmbHVzaF9tZXJn
ZSBvbmx5IGluIGYyZnMgaXMgbm90IHJlYWQtb25seQo+ID4gICBmMmZzOiBhZGQgdGhlIGZsdXNo
X21lcmdlIGhhbmRsZSBpbiB0aGUgcmVtb3VudCBmbG93Cj4gPiAgIGYyZnM6IGludHJvZHVjZSBz
dHJ1Y3QgZmx1c2hfY21kX2NvbnRyb2wgdG8gd3JhcCB0aGUgZmx1c2hfbWVyZ2UKPiA+ICAgICBm
aWVsZHMKPiA+ICAgZjJmczogaW50cm9kdWNlIGhlbHAgZnVuY3Rpb24ge2NyZWF0ZSxkZXN0cm95
fV9mbHVzaF9jbWRfY29udHJvbAo+ID4gCj4gPiAgZnMvZjJmcy9mMmZzLmggICAgfCAgIDE3ICsr
KysrKy0tLQo+ID4gIGZzL2YyZnMvc2VnbWVudC5jIHwgIDEwMiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCj4gPiAgZnMvZjJmcy9zdXBlci5jICAg
fCAgIDMyICsrKysrKysrKysrKysrLS0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEwNyBpbnNlcnRp
b25zKCspLCA0NCBkZWxldGlvbnMoLSkKPiA+IAo+IAo+IAo+IC0tCj4gVG8gdW5zdWJzY3JpYmUg
ZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGxpbnV4LWZzZGV2ZWwi
IGluCj4gdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcK
PiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9t
by1pbmZvLmh0bWwKCi0tIApKYWVnZXVrIEtpbQpTYW1zdW5nCgoKCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpMZWFybiBHcmFwaCBEYXRhYmFzZXMgLSBEb3dubG9hZCBGUkVFIE8nUmVpbGx5IEJvb2sK
IkdyYXBoIERhdGFiYXNlcyIgaXMgdGhlIGRlZmluaXRpdmUgbmV3IGd1aWRlIHRvIGdyYXBoIGRh
dGFiYXNlcyBhbmQgdGhlaXIKYXBwbGljYXRpb25zLiBXcml0dGVuIGJ5IHRocmVlIGFjY2xhaW1l
ZCBsZWFkZXJzIGluIHRoZSBmaWVsZCwKdGhpcyBmaXJzdCBlZGl0aW9uIGlzIG5vdyBhdmFpbGFi
bGUuIERvd25sb2FkIHlvdXIgZnJlZSBib29rIHRvZGF5IQpodHRwOi8vcC5zZi5uZXQvc2Z1L05l
b1RlY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
