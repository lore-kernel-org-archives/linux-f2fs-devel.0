From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: fix a deadlock in fsync
Date: Wed, 07 Aug 2013 18:43:16 +0900
Message-ID: <1375868596.22638.35.camel@kjgkr>
References: <1375704124-22274-1-git-send-email-jinuxstyle@gmail.com>
	<1375793175.22638.18.camel@kjgkr>
	<7C98DE50-F64F-4FE8-8804-964DDD25561A@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V70HV-0005F8-CA
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Aug 2013 09:43:49 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V70HT-0000qt-LK for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Aug 2013 09:43:49 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MR500MM0MZ0EED0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Aug 2013 18:43:41 +0900 (KST)
In-reply-to: <7C98DE50-F64F-4FE8-8804-964DDD25561A@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jim Xu <jinuxstyle@gmail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkgSmluLAoKMjAxMy0wOC0wNyAo7IiYKSwgMTI6MjMgKzA4MDAsIEppbSBYdToKPiBIaSBLaW0s
Cj4gCj4gVGhlIHBhdGNoIHNvdW5kcyBnb29kIHRvIG1lLgo+IAo+IEJUVywgYXMgaW4gdGhlIGRl
YWRsb2NrIHNpdHVhdGlvbiBJIG5vdGljZWQsIEkgZGlkIG5vdCBmaW5kIGFueSB0aHJlYWQgd2Fz
IGRvaW5nIGNoZWNrcG9pbnQgYXQgdGhhdCBtb21lbnQuIFRoZSBiZGkgd3JpdGViYWNrIHRocmVh
ZCBhbmQgdGhlIGZzeW5jIHVzZXIgdGhyZWFkIHdhcyBub3QuIE5laXRoZXIgd2FzIHRoZSBiYWNr
Z3JvdW5kIGYyZnNfZ2MgdGhyZWFkIGJlY2F1c2UgdGhlcmUgaGFkIGVub3VnaCBmcmVlIHNlZ21l
bnRzLiBNZWFud2hpbGUsIGFub3RoZXIgdXNlciB0aHJlYWQgd2FzIGJsb2NrZWQgaW4gdGhlIGYy
ZnNfc3luY19maWxlLT5zeW5jX25vZGVfcGFnZXMsIHdoaWNoLCBJIHRoaW5rLCBpcyBub3QgYSBm
YWN0b3IgY29udHJpYnV0aW5nIHRvIHRoZSBkZWFkbG9jay4KCkkgaW5kaWNhdGVkIG9uZSBwb3Nz
aWJsZSBzY2VuYXJpby4KQXMgeW91IGRlc2NyaWJlZCwgbWFueSBmc3luYyBjYWxscyBjYW4gYWxz
byBjb25zdW1lIGFsbCB0aGUgZnNfbG9jayB0b28uClRoYW5rcywKCi0tIApKYWVnZXVrIEtpbQpT
YW1zdW5nCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpHZXQgMTAwJSB2aXNpYmlsaXR5IGludG8g
SmF2YS8uTkVUIGNvZGUgd2l0aCBBcHBEeW5hbWljcyBMaXRlIQpJdCdzIGEgZnJlZSB0cm91Ymxl
c2hvb3RpbmcgdG9vbCBkZXNpZ25lZCBmb3IgcHJvZHVjdGlvbi4KR2V0IGRvd24gdG8gY29kZS1s
ZXZlbCBkZXRhaWwgZm9yIGJvdHRsZW5lY2tzLCB3aXRoIDwyJSBvdmVyaGVhZC4gCkRvd25sb2Fk
IGZvciBmcmVlIGFuZCBnZXQgc3RhcnRlZCB0cm91Ymxlc2hvb3RpbmcgaW4gbWludXRlcy4gCmh0
dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD00ODg5NzAzMSZpdT0v
NDE0MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
