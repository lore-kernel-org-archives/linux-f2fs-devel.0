From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 1/3 V2] f2fs: check filename length in
 recover_dentry
Date: Thu, 26 Dec 2013 07:55:29 +0900
Message-ID: <1388012129.2101.302.camel@kjgkr>
References: <002201ceff8c$efbd2da0$cf3788e0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VvxNg-0008FP-Rj
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Dec 2013 22:56:48 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VvxNf-0000k0-0c
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Dec 2013 22:56:48 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYD004HHX2EG280@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 26 Dec 2013 07:56:38 +0900 (KST)
In-reply-to: <002201ceff8c$efbd2da0$cf3788e0$@samsung.com>
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

SGksCgoyMDEzLTEyLTIzICjsm5QpLCAxMToxMiArMDgwMCwgQ2hhbyBZdToKPiBJbiBjdXJyZW50
IGZsb3csIHdlIHdpbGwgZ2V0IE51bGwgcmV0dXJuIHZhbHVlIG9mIGYyZnNfZmluZF9lbnRyeSBp
bgo+IHJlY292ZXJfZGVudHJ5IHdoZW4gbmFtZS5sZW4gaXMgYmlnZ2VyIHRoYW4gRjJGU19OQU1F
X0xFTiwgYW5kIHRoZW4gd2UKPiBzdGlsbCBhZGQgdGhpcyBpbm9kZSBpbnRvIGl0cyBkaXIgZW50
cnkuCj4gVG8gYXZvaWQgdGhpcyBzaXR1YXRpb24sIHdlIG11c3QgY2hlY2sgZmlsZW5hbWUgbGVu
Z3RoIGJlZm9yZSB3ZSB1c2UgaXQuCj4gCj4gQW5vdGhlciBwb2ludCBpcyB0aGF0IHdlIGNvdWxk
IHJlbW92ZSB0aGUgY29kZSBvZiBjaGVja2luZyBmaWxlbmFtZSBsZW5ndGgKPiBJbiBmMmZzX2Zp
bmRfZW50cnksIGJlY2F1c2UgZjJmc19sb29rdXAgd2lsbCBiZSBjYWxsZWQgcHJldmlvdXNseSB0
byBlbnN1cmUgb2YKPiB2YWxpZGl0eSBvZiBmaWxlbmFtZSBsZW5ndGguCgpUaGUgZjJmc19maW5k
X2VudHJ5IGlzIGNhbGxlZCBieSBmMmZzX3VubGluayBhbmQgZjJmc19yZW5hbWUgdG9vLgpTbywg
eW91IGNhbid0IHJlbW92ZSB0aGlzLCBpbnN0ZWFkIGl0J2QgYmUgYmV0dGVyIHJlbW92ZSBpdCBm
cm9tCmYyZnNfbG9va3VwLgpUaGFua3MsCgo+IAo+IFYyOgo+ICBvIGFkZCBXQVJOX09OKCkgYXMg
SmFlZ2V1ayBLaW0gc3VnZ2VzdGVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENoYW8gWXUgPGNoYW8y
Lnl1QHNhbXN1bmcuY29tPgo+IC0tLQo+ICBmcy9mMmZzL2Rpci5jICAgICAgfCAgICAzIC0tLQo+
ICBmcy9mMmZzL3JlY292ZXJ5LmMgfCAgICA2ICsrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9k
aXIuYyBiL2ZzL2YyZnMvZGlyLmMKPiBpbmRleCAwN2FkODUwLi5mMGI0NjMwIDEwMDY0NAo+IC0t
LSBhL2ZzL2YyZnMvZGlyLmMKPiArKysgYi9mcy9mMmZzL2Rpci5jCj4gQEAgLTE5MCw5ICsxOTAs
NiBAQCBzdHJ1Y3QgZjJmc19kaXJfZW50cnkgKmYyZnNfZmluZF9lbnRyeShzdHJ1Y3QgaW5vZGUg
KmRpciwKPiAgCXVuc2lnbmVkIGludCBtYXhfZGVwdGg7Cj4gIAl1bnNpZ25lZCBpbnQgbGV2ZWw7
Cj4gIAo+IC0JaWYgKHVubGlrZWx5KG5hbWVsZW4gPiBGMkZTX05BTUVfTEVOKSkKPiAtCQlyZXR1
cm4gTlVMTDsKPiAtCj4gIAlpZiAobnBhZ2VzID09IDApCj4gIAkJcmV0dXJuIE5VTEw7Cj4gIAo+
IGRpZmYgLS1naXQgYS9mcy9mMmZzL3JlY292ZXJ5LmMgYi9mcy9mMmZzL3JlY292ZXJ5LmMKPiBp
bmRleCBhM2Y0NTQyLi40ZDQxMWEyIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvcmVjb3ZlcnkuYwo+
ICsrKyBiL2ZzL2YyZnMvcmVjb3ZlcnkuYwo+IEBAIC02Miw2ICs2MiwxMiBAQCBzdGF0aWMgaW50
IHJlY292ZXJfZGVudHJ5KHN0cnVjdCBwYWdlICppcGFnZSwgc3RydWN0IGlub2RlICppbm9kZSkK
PiAgCj4gIAluYW1lLmxlbiA9IGxlMzJfdG9fY3B1KHJhd19pbm9kZS0+aV9uYW1lbGVuKTsKPiAg
CW5hbWUubmFtZSA9IHJhd19pbm9kZS0+aV9uYW1lOwo+ICsKPiArCWlmICh1bmxpa2VseShuYW1l
LmxlbiA+IEYyRlNfTkFNRV9MRU4pKSB7Cj4gKwkJV0FSTl9PTigxKTsKPiArCQllcnIgPSAtRU5B
TUVUT09MT05HOwo+ICsJCWdvdG8gb3V0Owo+ICsJfQo+ICByZXRyeToKPiAgCWRlID0gZjJmc19m
aW5kX2VudHJ5KGRpciwgJm5hbWUsICZwYWdlKTsKPiAgCWlmIChkZSAmJiBpbm9kZS0+aV9pbm8g
PT0gbGUzMl90b19jcHUoZGUtPmlubykpCgotLSAKSmFlZ2V1ayBLaW0KU2Ftc3VuZwoKCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KUmFwaWRseSB0cm91Ymxlc2hvb3QgcHJvYmxlbXMgYmVmb3JlIHRo
ZXkgYWZmZWN0IHlvdXIgYnVzaW5lc3MuIE1vc3QgSVQgCm9yZ2FuaXphdGlvbnMgZG9uJ3QgaGF2
ZSBhIGNsZWFyIHBpY3R1cmUgb2YgaG93IGFwcGxpY2F0aW9uIHBlcmZvcm1hbmNlIAphZmZlY3Rz
IHRoZWlyIHJldmVudWUuIFdpdGggQXBwRHluYW1pY3MsIHlvdSBnZXQgMTAwJSB2aXNpYmlsaXR5
IGludG8geW91ciAKSmF2YSwuTkVULCAmIFBIUCBhcHBsaWNhdGlvbi4gU3RhcnQgeW91ciAxNS1k
YXkgRlJFRSBUUklBTCBvZiBBcHBEeW5hbWljcyBQcm8hCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVj
bGljay5uZXQvZ2FtcGFkL2Nsaz9pZD04NDM0OTgzMSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRl
dmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApo
dHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRl
dmVsCg==
