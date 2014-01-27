From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: A lot of data written by cleaner for specific
	workload
Date: Mon, 27 Jan 2014 14:06:11 +0900
Message-ID: <1390799171.25542.50.camel@kjgkr>
References: <CAFvQSYSRv-SVs+n3rC6tugw1KSOgViEzkBVhbqzum0zjo+gP7Q@mail.gmail.com>
	<1390520510.25542.34.camel@kjgkr>
	<CAFvQSYS88P3P-BiqzWE_QjLmuUQ_xScEGKrUdsnymi6jrVPK3A@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W7eQF-0006z7-2j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Jan 2014 05:07:47 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W7eQD-0006AN-2B
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Jan 2014 05:07:47 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0100FVGNKO3H40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Jan 2014 14:07:36 +0900 (KST)
In-reply-to: <CAFvQSYS88P3P-BiqzWE_QjLmuUQ_xScEGKrUdsnymi6jrVPK3A@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Clemens Eisserer <linuxhippy@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDE0LTAxLTI0ICjquIgpLCAyMzowNyArMDEwMCwgQ2xlbWVucyBFaXNzZXJlcjoKPiBI
aSBKYWVnZXVrLAo+IAo+IFRoYW5rcyBhIGxvdCBmb3IgeW91ciByZXBseS4KPiAKPiA+IFRoZSBm
MmZzX2djIGNhbiBiZSBjb250cm9sbGVkIGJ5IHVzZXIgdGhyb3VnaCBhIHN5c2ZzIGVudHJ5Lgo+
ID4gU28sIGNvdWxkIHlvdSBsb29rIGF0IHRoZSBhbW91bnQgb2Ygd3JpdHRlbiBkYXRhIGJ5IHZh
cnlpbmcgdGhlIGdjCj4gPiBpbnRlcnZhbD8KPiA+Cj4gPiBjYXQgL3N5cy9mcy9mMmZzLyRkZXYv
Z2NfbWluX3NsZWVwX3RpbWUKPiA+IDMwMDAwCj4gPiBjYXQgL3N5cy9mcy9mMmZzLyRkZXYvZ2Nf
bWF4X3NsZWVwX3RpbWUKPiA+IDYwMDAwCj4gPgo+ID4gVGhlc2UgdmFsdWVzIGFyZSByZXByZXNl
bnRlZCBpbiBtaWxsaXNlY29uZHMuCj4gPiBJZiB5b3UgZG9uJ3Qgd2FudCB0byB3cml0ZSBkYXRh
IGFzIG11Y2ggYXMgcG9zc2liZSBhbmQgZG9uJ3QgbmVlZCBhIGhpZ2gKPiA+IHBlcmZvcm1hbmNl
IGFzIHRoZSBwYXJ0aXRpb24gYmVjb21lcyBmdWxsLCB5b3UgY2FuIGp1c3QgZ3JvdyB0aGUKPiA+
IGludGVydmFsIHRpbWVzLgo+ID4gVGhlIG90aGVyIHdheSBpcyB0aGF0IHlvdSBjYW4ganVzdCBh
ZGQgYSBtb3VudCBvcHRpb24sICItbwo+ID4gYmFja2dyb3VuZF9nYz1vZmYiLCB3aGljaCB0dXJu
cyBvZmYgdGhlIGYyZnNfZ2MuCj4gCj4gSSdsbCB0cnkgdHVybmluZyBvZmYgdGhlIGJhY2tncm91
bmQtZ2MsIGFzIEkgY2FuJ3QgZmluZCB0aGUKPiBzeXNmcy1rbm9icyBpbiBteSBzeXN0ZW0uCj4g
Cj4gV2hhdCBJIHN0aWxsIHdvbmRlciBpcywgaG93IHRoZSBjbGVhbmVyIGNhbiB3cml0ZSB0d2lj
ZSB0aGUgZGF0YSBpdAo+IHJlYWRzIChhcyBpbiB0aGUgYWJvdmUgZXhhbXBsZSkuCgpJZiBhIGRh
dGEgaXMgc2VsZWN0ZWQgdG8gYmUgbW92ZWQsIGl0cyBub2RlIGJsb2NrLCBhbiBpbmRleCBibG9j
aywKc2hvdWxkIGJlIHJlYWQgdG9vLgpTbywgSSB0aGluayBpdCBjYW4gYmUgZG91YmxlLgoKSSB0
aGluayB0aGUgbW91bnQgb3B0aW9uIHdvdWxkIGJlICJiYWNrZ3JvdW5kX2djX29mZiIgaW4gdjMu
MTAuClRoYW5rcywKCj4gCj4gUmVnYXJkcywgQ2xlbWVucwo+IAo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+IENlbnR1cnlMaW5rIENsb3VkOiBUaGUgTGVhZGVyIGluIEVudGVycHJpc2UgQ2xvdWQg
U2VydmljZXMuCj4gTGVhcm4gV2h5IE1vcmUgQnVzaW5lc3NlcyBBcmUgQ2hvb3NpbmcgQ2VudHVy
eUxpbmsgQ2xvdWQgRm9yCj4gQ3JpdGljYWwgV29ya2xvYWRzLCBEZXZlbG9wbWVudCBFbnZpcm9u
bWVudHMgJiBFdmVyeXRoaW5nIEluIEJldHdlZW4uCj4gR2V0IGEgUXVvdGUgb3IgU3RhcnQgYSBG
cmVlIFRyaWFsIFRvZGF5LiAKPiBodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBh
ZC9jbGs/aWQ9MTE5NDIwNDMxJml1PS80MTQwL29zdGcuY2xrdHJrCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoK
LS0gCkphZWdldWsgS2ltClNhbXN1bmcKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ2VudHVyeUxp
bmsgQ2xvdWQ6IFRoZSBMZWFkZXIgaW4gRW50ZXJwcmlzZSBDbG91ZCBTZXJ2aWNlcy4KTGVhcm4g
V2h5IE1vcmUgQnVzaW5lc3NlcyBBcmUgQ2hvb3NpbmcgQ2VudHVyeUxpbmsgQ2xvdWQgRm9yCkNy
aXRpY2FsIFdvcmtsb2FkcywgRGV2ZWxvcG1lbnQgRW52aXJvbm1lbnRzICYgRXZlcnl0aGluZyBJ
biBCZXR3ZWVuLgpHZXQgYSBRdW90ZSBvciBTdGFydCBhIEZyZWUgVHJpYWwgVG9kYXkuIApodHRw
Oi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9MTE5NDIwNDMxJml1PS80
MTQwL29zdGcuY2xrdHJrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
