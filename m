From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs space usage
Date: Fri, 24 Jan 2014 11:12:02 +0900
Message-ID: <1390529522.25542.42.camel@kjgkr>
References: <52E0E1BF.9090409@gtsys.com.hk>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W6WH0-0004Gy-3c
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Jan 2014 02:13:34 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W6WGx-0002wO-Ub
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Jan 2014 02:13:34 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MZV002H6VICY2A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Jan 2014 11:13:24 +0900 (KST)
In-reply-to: <52E0E1BF.9090409@gtsys.com.hk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDE0LTAxLTIzICjrqqkpLCAxNzozMiArMDgwMCwgQ2hyaXMgUnVlaGw6Cj4gSGkgS2lt
LAo+IAo+IEkgcmVjZW50bHkgd29yayB3aXRoIGYyZnMgYW5kIHdvbmRlcmluZyBhYm91dCB0aGUg
c3lzdGVtIHVzYWdlLgo+IEkgaGF2ZSBhIE5BTkQgZmxhc2ggMTI4TUIgb24gbXkgU29DIHVzZWQg
Zm9yIHVCb290IGFuZCBhIHJvb3QKPiBwYXJ0aW9uIChmMmZzKQo+IAo+IHdoZW4gSSBpbnN0YWxs
IHRoZSBidXN5Ym94IGJpbmFyaWVzIEkgbmVhcmx5IHJ1biBvdXQgb2Ygc3BhY2UKPiBidXN5Ym94
IGJpbmFyeQo+IAo+IHJvb3RAZ3RzaXIyNDovbW50IyBkdSAtc2ggL21udC8uCj4gNC44TSAgICAv
bW50Ly4KPiAKPiBidXQgZGYgLWggc2hvdyBhIDk3JSB1c2FnZQoKRm9yIHN1Y2ggdGhlIHNtYWxs
IHNpemVkIHBhcnRpdGlvbiwgdGhlIHNwYWNlIGlzIHByZXR0eSBtdWNoIGRlcGVuZGVudApvbiB0
aGUgb3ZlcnByb3Zpc2lvbiByYXRpby4KU28sIGlmIHlvdSB3YW50IHRvIGdldCBtb3JlIHNwYWNl
LCB5b3UgY2FuIGZvcm1hdCB0aGUgcGFydGl0aW9uIHdpdGggLW8Kb3B0aW9uLgoKV2hlbiBJIHRl
c3RlZCB3aXRoIDEyOE1CLCBpdCBzZWVtcyB0aGF0IDIwJSBpcyBiZXN0LCB3aGljaCBzaG93cyA2
Mk1CCmZvciBhdmFsaWFibGUgc3BhY2Ugb2NjdXB5aW5nIDQ1JSB1dGlsaXphdGlvbi4KClRoZSBj
b21tYW5kIGlzIGxpa2UgdGhpczoKCiMgbWtmcy5mMmZzIC1vIDIwICRkZXYKClRoYW5rcywKCj4g
Cj4gcm9vdEBndHNpcjI0Oi9tbnQjIGRmIC1oCj4gRmlsZXN5c3RlbSAgICAgIFNpemUgIFVzZWQg
QXZhaWwgVXNlJSBNb3VudGVkIG9uCj4gcm9vdGZzICAgICAgICAgIDMuNkcgIDU3NE0gIDIuOEcg
IDE3JSAvCj4gL2Rldi9yb290ICAgICAgIDMuNkcgIDU3NE0gIDIuOEcgIDE3JSAvCj4gZGV2dG1w
ZnMgICAgICAgIDEyNU0gICAgIDAgIDEyNU0gICAwJSAvZGV2Cj4gdG1wZnMgICAgICAgICAgICAy
NU0gIDE1NksgICAyNU0gICAxJSAvcnVuCj4gdG1wZnMgICAgICAgICAgIDUuME0gICAgIDAgIDUu
ME0gICAwJSAvcnVuL2xvY2sKPiB0bXBmcyAgICAgICAgICAgIDUwTSAgICAgMCAgIDUwTSAgIDAl
IC9ydW4vc2htCj4gL2Rldi9tdGRibG9jazQgIDExOU0gIDEwMU0gIDMuM00gIDk3JSAvbW50Cj4g
Cj4gSSdtIHJ1bm5pbmcgYSBuZXh0LTIwMTQwMTE1Lgo+IAo+IENhbiB5b3UgY29tbWVudCBwbGVh
c2UuCj4gQ2hyaXMKCi0tIApKYWVnZXVrIEtpbQpTYW1zdW5nCgoKCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpDZW50dXJ5TGluayBDbG91ZDogVGhlIExlYWRlciBpbiBFbnRlcnByaXNlIENsb3VkIFNl
cnZpY2VzLgpMZWFybiBXaHkgTW9yZSBCdXNpbmVzc2VzIEFyZSBDaG9vc2luZyBDZW50dXJ5TGlu
ayBDbG91ZCBGb3IKQ3JpdGljYWwgV29ya2xvYWRzLCBEZXZlbG9wbWVudCBFbnZpcm9ubWVudHMg
JiBFdmVyeXRoaW5nIEluIEJldHdlZW4uCkdldCBhIFF1b3RlIG9yIFN0YXJ0IGEgRnJlZSBUcmlh
bCBUb2RheS4gCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD0x
MTk0MjA0MzEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
