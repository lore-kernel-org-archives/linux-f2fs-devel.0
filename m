From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: dentry Hash Method
Date: Mon, 04 Nov 2013 09:51:01 +0900
Message-ID: <1383526261.14041.42.camel@kjgkr>
References: <CAECMkcMHVx6OrvHSQkURA7wej6vE4LEtDV=TkzkwhZse8GoiFQ@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vd8OX-0006Uz-45
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 00:51:53 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vd8OT-0003OK-Fz for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 00:51:53 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MVP00FC6RQ0K4A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 09:51:42 +0900 (KST)
In-reply-to: <CAECMkcMHVx6OrvHSQkURA7wej6vE4LEtDV=TkzkwhZse8GoiFQ@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Zachary <zacharyw09264@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDEzLTExLTAzICjsnbwpLCAwMjo0NyAtMDUwMCwgWmFjaGFyeToKPiBIZWxsbywKPiAK
PiBJIHdhcyBsb29raW5nIGF0IHRoZSBzb3VyY2UgY29kZSBmb3IgZjJmcyB3aXRoIHJlZ2FyZCB0
byBob3cgZGVudHJpZXMKPiBhcmUgY3JlYXRlZCBhbmQgSSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQg
aG93IHRoZSBfX2xlMzIgaGFzaF9jb2RlIGlzCj4gY2FsY3VsYXRlZC4gIElmIEkgaGF2ZSBhIGZp
bGUgbGlrZSAvZXRjL2ZzdGFiLCB3b3VsZCB0aGUgaGFzaCBiZQo+IGYyZnNfZGVudHJ5X2hhc2go
Ii9ldGMvZnN0YWIiLCAxMCkgb3IgZjJmc19kZW50cnlfaGFzaCgiZnN0YWIiLCA1KSBvcgo+IHNv
bWV0aGluZyBjb21wbGV0ZWx5IGRpZmZlcmVudD8KClRoZSBoYXNoIHdpbGwgYmUgbWFkZSBieSBm
MmZzX2RlbnRyeV9oYXNoKCJmc3RhYiIsIDUpLgpUaGFua3MsIDopCgotLSAKSmFlZ2V1ayBLaW0K
U2Ftc3VuZwoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBbmRyb2lkIGlzIGluY3JlYXNpbmcgaW4g
cG9wdWxhcml0eSwgYnV0IHRoZSBvcGVuIGRldmVsb3BtZW50IHBsYXRmb3JtIHRoYXQKZGV2ZWxv
cGVycyBsb3ZlIGlzIGFsc28gYXR0cmFjdGl2ZSB0byBtYWx3YXJlIGNyZWF0b3JzLiBEb3dubG9h
ZCB0aGlzIHdoaXRlCnBhcGVyIHRvIGxlYXJuIG1vcmUgYWJvdXQgc2VjdXJlIGNvZGUgc2lnbmlu
ZyBwcmFjdGljZXMgdGhhdCBjYW4gaGVscCBrZWVwCkFuZHJvaWQgYXBwcyBzZWN1cmUuCmh0dHA6
Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD02NTgzOTk1MSZpdT0vNDE0
MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
