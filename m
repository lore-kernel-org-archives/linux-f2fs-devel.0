From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: move all the bio initialization into
 __bio_alloc
Date: Thu, 19 Dec 2013 17:59:45 +0900
Message-ID: <1387443585.2101.216.camel@kjgkr>
References: <52B17905.7040708@cn.fujitsu.com>
	<000a01cefc59$0a9b4580$1fd1d080$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VtZTZ-0001Gn-Hy
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 09:01:01 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VtZTX-0002LU-OP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 09:01:01 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MY100F22QDF8210@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 18:00:51 +0900 (KST)
In-reply-to: <000a01cefc59$0a9b4580$1fd1d080$@samsung.com>
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
Cc: 'Gu Zheng' <guz.fnst@cn.fujitsu.com>, 'fsdevel' <linux-fsdevel@vger.kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>

SGkgR3UsCgpJIGFncmVlZCB3aXRoIENoYW8uCkl0IGlzIG1vcmUgcmVhZGFibGUgdG8gdXNlIHNv
bWV0aGluZyBsaWtlICJpc19yZWFkIiBpbnN0ZWFkIG9mICJydyIuClRoYW5rcywKCjIwMTMtMTIt
MTkgKOuqqSksIDA5OjIzICswODAwLCBDaGFvIFl1Ogo+IEhpIEd1LAo+IAo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IEd1IFpoZW5nIFttYWlsdG86Z3V6LmZuc3RAY24u
ZnVqaXRzdS5jb21dCj4gPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDE4LCAyMDEzIDY6Mjkg
UE0KPiA+IFRvOiBLaW0KPiA+IENjOiBmc2RldmVsOyBsaW51eC1rZXJuZWw7IGYyZnMKPiA+IFN1
YmplY3Q6IFtmMmZzLWRldl0gW1BBVENIXSBmMmZzOiBtb3ZlIGFsbCB0aGUgYmlvIGluaXRpYWxp
emF0aW9uIGludG8gX19iaW9fYWxsb2MKPiA+IAo+ID4gTW92ZSBhbGwgdGhlIGJpbyBpbml0aWFs
aXphdGlvbiBpbnRvIF9fYmlvX2FsbG9jLCBhbmQgc29tZSBtaW5vciBjbGVhbnVwcyBhcmUKPiA+
IGFsc28gYWRkZWQuCj4gCj4gTG9va3MgbW9yZSBuZWF0IQo+IAo+ID4gQEAgLTE3OCwxNyArMTc5
LDE2IEBAIHZvaWQgZjJmc19zdWJtaXRfcGFnZV9tYmlvKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNi
aSwgc3RydWN0IHBhZ2UgKnBhZ2UsCj4gPiAgCQkJYmxvY2tfdCBibGtfYWRkciwgc3RydWN0IGYy
ZnNfaW9faW5mbyAqZmlvKQo+ID4gIHsKPiA+ICAJZW51bSBwYWdlX3R5cGUgYnR5cGUgPSBQQUdF
X1RZUEVfT0ZfQklPKGZpby0+dHlwZSk7Cj4gPiAtCXN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYg
PSBzYmktPnNiLT5zX2JkZXY7Cj4gPiAgCXN0cnVjdCBmMmZzX2Jpb19pbmZvICppbzsKPiA+IC0J
aW50IGJpb19ibG9ja3M7Cj4gPiArCWludCBydyA9IGlzX3JlYWRfaW8oZmlvLT5ydyk7Cj4gCj4g
TWF5YmUgaXQncyBtb3JlIG5lYXQgdG8gdXNlICdpc19yZWFkJyB0byBpbnN0ZWFkIG9mICdydycu
Cj4gCj4gVGhhbmtzCj4gCgotLSAKSmFlZ2V1ayBLaW0KU2Ftc3VuZwoKCgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KUmFwaWRseSB0cm91Ymxlc2hvb3QgcHJvYmxlbXMgYmVmb3JlIHRoZXkgYWZmZWN0
IHlvdXIgYnVzaW5lc3MuIE1vc3QgSVQgCm9yZ2FuaXphdGlvbnMgZG9uJ3QgaGF2ZSBhIGNsZWFy
IHBpY3R1cmUgb2YgaG93IGFwcGxpY2F0aW9uIHBlcmZvcm1hbmNlIAphZmZlY3RzIHRoZWlyIHJl
dmVudWUuIFdpdGggQXBwRHluYW1pY3MsIHlvdSBnZXQgMTAwJSB2aXNpYmlsaXR5IGludG8geW91
ciAKSmF2YSwuTkVULCAmIFBIUCBhcHBsaWNhdGlvbi4gU3RhcnQgeW91ciAxNS1kYXkgRlJFRSBU
UklBTCBvZiBBcHBEeW5hbWljcyBQcm8hCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQv
Z2FtcGFkL2Nsaz9pZD04NDM0OTgzMSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
