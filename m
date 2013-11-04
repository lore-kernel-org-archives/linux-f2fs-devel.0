From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 1/1] No need to do recovery if there is no
	available CP
Date: Mon, 04 Nov 2013 10:24:13 +0900
Message-ID: <1383528253.14041.53.camel@kjgkr>
References: <1383491301-11460-1-git-send-email-huajun.li.lee@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vd8uc-0007gs-WD
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 01:25:03 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vd8ua-0001XZ-WE for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 01:25:02 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MVP0009DT9IKX70@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 10:24:54 +0900 (KST)
In-reply-to: <1383491301-11460-1-git-send-email-huajun.li.lee@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, linux-f2fs-devel@lists.sourceforge.net

MjAxMy0xMS0wMyAo7J28KSwgMjM6MDggKzA4MDAsIEh1YWp1biBMaToKPiBGcm9tOiBIdWFqdW4g
TGkgPGh1YWp1bi5saUBpbnRlbC5jb20+Cj4gCj4gTm9ybWFsbHkgd2UgZXhwZWN0IGFuIGVtcHR5
IHBhcnRpdGlvbiBhZnRlciBmb3JtYXR0aW5nIGJ5Cj4gbWtmcy5mMmZzLiBCdXQgaW4gdGhpcyBj
YXNlLCB3aGVuIHdlIGZvcm1hdCBhIGRpcnR5IHBhcnRpdGlvbiBhbmQgbW91bnQKPiBpdCBhZ2Fp
bi4gVGhlIGZvcm1lciBmaWxlIHdpbGwgYmUgcmVjb3ZlcmVkIGFuZCBhdmFpbGFibGUgYWdhaW4h
IGFuZAo+IGtlcm5lbCBsb2cgc2hvd3MgYSByZWNvdmVyeSBwcm9jZWR1cmUgaXMgZXZva2VkLgo+
IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBmbGFnIENQX0VYSVNUX0ZMQUcgdG8gaW5kaWNhdGUgd2hl
dGhlciBpcyBhCj4gYXZhaWxhYmxlIENQLCBhbmQgZG8gcmVjb3Zlcnkgb25seSB3aGVuIHRoaXMg
ZmxhZyBpcyBzZXQuCgpJTU8sIG1rZnMuZjJmcyBzaG91bGQgZG8gdGhlIHJpZ2h0IHRoaW5nIHRv
IGF2b2lkIHRoaXMuCklmIHN0b3JhZ2UgZG9lcyBub3Qgc3VwcG9ydCBkaXNjYXJkLCBta2ZzLmYy
ZnMgY2FuIHNpbXBseSBhZGRyZXNzIHRoZQpwcm9ibGVtIGJ5IHdyaXRpbmcgb25lIG5vZGUgYmxv
Y2sgd2l0aCB6ZXJvcyB0byBwcmV2ZW50IHRoaXMuCgpBbmQsIGlmIHlvdSBpbnRyb2R1Y2UgYSBu
ZXcgZmxhZywgbWtmcy5mMmZzIHNob3VsZCBkbyB0aGUgc2FtZSB0aGluZywKd2hpY2ggbWVhbnMg
dGhhdCBta2ZzLmYyZnMgYWxzbyBuZWVkcyB0byBzZXQgdGhlIENQX0VYSVNUX0ZMQUcuClNvIHRo
ZW4sIGl0IGNvdWxkIG5vdCBmaXggdGhlIGJ1Zy4KCkhvdyBkbyB5b3UgdGhpbms/IAoKLS0gCkph
ZWdldWsgS2ltClNhbXN1bmcKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQW5kcm9pZCBpcyBpbmNy
ZWFzaW5nIGluIHBvcHVsYXJpdHksIGJ1dCB0aGUgb3BlbiBkZXZlbG9wbWVudCBwbGF0Zm9ybSB0
aGF0CmRldmVsb3BlcnMgbG92ZSBpcyBhbHNvIGF0dHJhY3RpdmUgdG8gbWFsd2FyZSBjcmVhdG9y
cy4gRG93bmxvYWQgdGhpcyB3aGl0ZQpwYXBlciB0byBsZWFybiBtb3JlIGFib3V0IHNlY3VyZSBj
b2RlIHNpZ25pbmcgcHJhY3RpY2VzIHRoYXQgY2FuIGhlbHAga2VlcApBbmRyb2lkIGFwcHMgc2Vj
dXJlLgpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9NjU4Mzk5
NTEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
