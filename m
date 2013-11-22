From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH V3 2/2] f2fs: read contiguous sit entry pages
 by merging for mount performance
Date: Fri, 22 Nov 2013 18:10:41 +0900
Message-ID: <1385111441.26319.81.camel@kjgkr>
References: <000301cee71f$b0e54160$12afc420$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vjmm9-0005M4-2K
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 09:11:45 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Vjmm5-0000pi-G1
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 09:11:45 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWN005FFQV4E2Q0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 18:11:33 +0900 (KST)
In-reply-to: <000301cee71f$b0e54160$12afc420$@samsung.com>
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

SGksCgpKdXN0IG9uZSBuaXB0aWNrLgoKMjAxMy0xMS0yMiAo6riIKSwgMDk6MDkgKzA4MDAsIENo
YW8gWXU6Cj4gUHJldmlvdXNseSB3ZSByZWFkIHNpdCBlbnRyaWVzIHBhZ2Ugb25lIGJ5IG9uZSwg
dGhpcyBtZXRob2QgbG9zdCB0aGUgY2hhbmNlIAo+IG9mIHJlYWRpbmcgY29udGlndW91cyBwYWdl
IHRvZ2V0aGVyLiBTbyB3ZSByZWFkIHBhZ2VzIGFzIGNvbnRpZ3VvdXMgYXMgCj4gcG9zc2libGUg
Zm9yIGJldHRlciBtb3VudCBwZXJmb3JtYW5jZS4KPiAKPiBjaGFuZ2UgbG9nOgo+ICBvIG1lcmdl
IGp1ZGdlbWVudHMvdXNlICdDb250aW51ZScgb3IgJ0JyZWFrJyBpbnN0ZWFkIG9mICdHb3RvJyBh
cyBHdSBaaGVuZyAKPiAgICBzdWdnZXN0ZWQuCj4gIG8gYWRkIG1hcmtfcGFnZV9hY2Nlc3NlZCgp
IGJlZm9yZSByZWxlYXNlIHBhZ2UgdG8gZGVsYXkgVk0gcmVjbGFpbWluZy4KPiAgbyByZW1vdmUg
JypvcmRlcicgZm9yIHNpbXBsaWZpY2F0aW9uIG9mIGZ1bmN0aW9uIGFzIEphZWdldWsgS2ltIHN1
Z2dlc3RlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDxjaGFvMi55dUBzYW1zdW5nLmNv
bT4KPiAtLS0KPiAgZnMvZjJmcy9zZWdtZW50LmMgfCAgMTAzICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4gIGZzL2YyZnMvc2VnbWVudC5oIHwg
ICAgMiArKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL3NlZ21lbnQuYyBiL2ZzL2YyZnMvc2VnbWVu
dC5jCj4gaW5kZXggODE0OWViYS4uOTk4ZTdkMyAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL3NlZ21l
bnQuYwo+ICsrKyBiL2ZzL2YyZnMvc2VnbWVudC5jCj4gQEAgLTE0LDYgKzE0LDcgQEAKPiAgI2lu
Y2x1ZGUgPGxpbnV4L2Jsa2Rldi5oPgo+ICAjaW5jbHVkZSA8bGludXgvcHJlZmV0Y2guaD4KPiAg
I2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3N3YXAuaD4KPiAg
Cj4gICNpbmNsdWRlICJmMmZzLmgiCj4gICNpbmNsdWRlICJzZWdtZW50LmgiCj4gQEAgLTE0ODgs
NDEgKzE0ODksODkgQEAgc3RhdGljIGludCBidWlsZF9jdXJzZWcoc3RydWN0IGYyZnNfc2JfaW5m
byAqc2JpKQo+ICAJcmV0dXJuIHJlc3RvcmVfY3Vyc2VnX3N1bW1hcmllcyhzYmkpOwo+ICB9Cj4g
IAo+ICtzdGF0aWMgaW50IHJhX3NpdF9wYWdlcyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksIGlu
dCBzdGFydCwgaW50IG5ycGFnZXMpCj4gK3sKPiArCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBw
aW5nID0gc2JpLT5tZXRhX2lub2RlLT5pX21hcHBpbmc7Cj4gKwlzdHJ1Y3QgcGFnZSAqcGFnZTsK
PiArCWJsb2NrX3QgYmxrX2FkZHIsIHByZXZfYmxrX2FkZHIgPSAwOwo+ICsJaW50IHNpdF9ibGtf
Y250ID0gU0lUX0JMS19DTlQoc2JpKTsKCkNhbiB3ZSByZW1vdmUgU0lUX0JMS19DTlQgYnkgcmVw
bGFjaW5nIHdpdGggc2l0X2ktPnNpdF9ibG9ja3M/CgotLSAKSmFlZ2V1ayBLaW0KU2Ftc3VuZwoK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTaGFwZSB0aGUgTW9iaWxlIEV4cGVyaWVuY2U6IEZyZWUg
U3Vic2NyaXB0aW9uClNvZnR3YXJlIGV4cGVydHMgYW5kIGRldmVsb3BlcnM6IEJlIGF0IHRoZSBm
b3JlZnJvbnQgb2YgdGVjaCBpbm5vdmF0aW9uLgpJbnRlbChSKSBTb2Z0d2FyZSBBZHJlbmFsaW5l
IGRlbGl2ZXJzIHN0cmF0ZWdpYyBpbnNpZ2h0IGFuZCBnYW1lLWNoYW5naW5nIApjb252ZXJzYXRp
b25zIHRoYXQgc2hhcGUgdGhlIHJhcGlkbHkgZXZvbHZpbmcgbW9iaWxlIGxhbmRzY2FwZS4gU2ln
biB1cCBub3cuIApodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9
NjM0MzEzMTEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
