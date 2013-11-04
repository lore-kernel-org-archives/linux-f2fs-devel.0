From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: Porting f2fs tools to Android.
Date: Mon, 04 Nov 2013 09:48:26 +0900
Message-ID: <1383526106.14041.40.camel@kjgkr>
References: <527650FE.4050303@codeaurora.org>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vd8M0-0006VD-1W
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 00:49:16 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vd8Ly-0004L7-BE for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 00:49:15 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MVP00924RLNF090@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 09:49:07 +0900 (KST)
In-reply-to: <527650FE.4050303@codeaurora.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDEzLTExLTAzICjsnbwpLCAxNTozNCArMDIwMCwgS29uc3RhbnRpbiBEb3JmbWFuOgo+
IEhlbGxvLAo+IAo+IEknbSB3b3JraW5nIG9uIFtzdWJqXS4KPiBQYXJ0aWN1bGFybHkgcG9ydGlu
ZyBta2ZzLmYyZnMgYW5kIGZzY2suZjJmcyB0byBhbmRyb2lkIGJ1aWxkIGVudmlyb25tZW50Lgo+
IAo+IERvIHlvdSBrbm93IGFib3V0IHNpbWlsYXIgZWZmb3J0PwoKU28gZmFyLCBJIGNvdWxkbid0
IGhhdmUgaGVhcmQgYWJvdXQgdGhhdC4KV2VsbCwgc29tZW9uZSB3aG8gYXJlIHdvcmtpbmcgb24g
YW5kcm9pZCBtYXkgYmUgaW50ZXJlc3RlZCBpbiBzdWNoIHRoZQplZmZvcnQuClRoYW5rcyB0byB0
aGUgaW50ZXJlc3QgaW4gZjJmcy4gOikKCi0tIApKYWVnZXVrIEtpbQpTYW1zdW5nCgoKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpBbmRyb2lkIGlzIGluY3JlYXNpbmcgaW4gcG9wdWxhcml0eSwgYnV0
IHRoZSBvcGVuIGRldmVsb3BtZW50IHBsYXRmb3JtIHRoYXQKZGV2ZWxvcGVycyBsb3ZlIGlzIGFs
c28gYXR0cmFjdGl2ZSB0byBtYWx3YXJlIGNyZWF0b3JzLiBEb3dubG9hZCB0aGlzIHdoaXRlCnBh
cGVyIHRvIGxlYXJuIG1vcmUgYWJvdXQgc2VjdXJlIGNvZGUgc2lnbmluZyBwcmFjdGljZXMgdGhh
dCBjYW4gaGVscCBrZWVwCkFuZHJvaWQgYXBwcyBzZWN1cmUuCmh0dHA6Ly9wdWJhZHMuZy5kb3Vi
bGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD02NTgzOTk1MSZpdT0vNDE0MC9vc3RnLmNsa3Ryawpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCg==
