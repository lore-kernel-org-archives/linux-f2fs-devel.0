From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 1/3] f2fs: check filename length in
 recover_dentry
Date: Mon, 23 Dec 2013 10:25:31 +0900
Message-ID: <1387761931.2101.289.camel@kjgkr>
References: <000001cefe33$b62a0f40$227e2dc0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VuuIC-0002I4-PB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Dec 2013 01:26:48 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VuuIA-0006QI-UC
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Dec 2013 01:26:48 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MY8005I9K0FMZ80@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Dec 2013 10:26:39 +0900 (KST)
In-reply-to: <000001cefe33$b62a0f40$227e2dc0$@samsung.com>
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

MjAxMy0xMi0yMSAo7YagKSwgMTg6MDEgKzA4MDAsIENoYW8gWXU6Cj4gSW4gY3VycmVudCBmbG93
LCB3ZSB3aWxsIGdldCBOdWxsIHJldHVybiB2YWx1ZSBvZiBmMmZzX2ZpbmRfZW50cnkgaW4KPiBy
ZWNvdmVyX2RlbnRyeSB3aGVuIG5hbWUubGVuIGlzIGJpZ2dlciB0aGFuIEYyRlNfTkFNRV9MRU4s
IGFuZCB0aGVuIHdlCj4gc3RpbGwgYWRkIHRoaXMgaW5vZGUgaW50byBpdHMgZGlyIGVudHJ5Lgo+
IFRvIGF2b2lkIHRoaXMgc2l0dWF0aW9uLCB3ZSBtdXN0IGNoZWNrIGZpbGVuYW1lIGxlbmd0aCBi
ZWZvcmUgd2UgdXNlIGl0Lgo+IAo+IEFub3RoZXIgcG9pbnQgaXMgdGhhdCB3ZSBjb3VsZCByZW1v
dmUgdGhlIGNvZGUgb2YgY2hlY2tpbmcgZmlsZW5hbWUgbGVuZ3RoCj4gSW4gZjJmc19maW5kX2Vu
dHJ5LCBiZWNhdXNlIGYyZnNfbG9va3VwIHdpbGwgYmUgY2FsbGVkIHByZXZpb3VzbHkgdG8gZW5z
dXJlIG9mCj4gdmFsaWRpdHkgb2YgZmlsZW5hbWUgbGVuZ3RoLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IENoYW8gWXUgPGNoYW8yLnl1QHNhbXN1bmcuY29tPgo+IC0tLQo+ICBmcy9mMmZzL2Rpci5jICAg
ICAgfCAgICAzIC0tLQo+ICBmcy9mMmZzL3JlY292ZXJ5LmMgfCAgICA1ICsrKysrCj4gIDIgZmls
ZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9mcy9mMmZzL2Rpci5jIGIvZnMvZjJmcy9kaXIuYwo+IGluZGV4IDBjYzI2YmEuLjNmM2I2
NjEgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9kaXIuYwo+ICsrKyBiL2ZzL2YyZnMvZGlyLmMKPiBA
QCAtMTkwLDkgKzE5MCw2IEBAIHN0cnVjdCBmMmZzX2Rpcl9lbnRyeSAqZjJmc19maW5kX2VudHJ5
KHN0cnVjdCBpbm9kZSAqZGlyLAo+ICAJdW5zaWduZWQgaW50IG1heF9kZXB0aDsKPiAgCXVuc2ln
bmVkIGludCBsZXZlbDsKPiAgCj4gLQlpZiAodW5saWtlbHkobmFtZWxlbiA+IEYyRlNfTkFNRV9M
RU4pKQo+IC0JCXJldHVybiBOVUxMOwo+IC0KPiAgCWlmIChucGFnZXMgPT0gMCkKPiAgCQlyZXR1
cm4gTlVMTDsKPiAgCj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvcmVjb3ZlcnkuYyBiL2ZzL2YyZnMv
cmVjb3ZlcnkuYwo+IGluZGV4IGEzZjQ1NDIuLmZkZDE3NWIgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJm
cy9yZWNvdmVyeS5jCj4gKysrIGIvZnMvZjJmcy9yZWNvdmVyeS5jCj4gQEAgLTYyLDYgKzYyLDEx
IEBAIHN0YXRpYyBpbnQgcmVjb3Zlcl9kZW50cnkoc3RydWN0IHBhZ2UgKmlwYWdlLCBzdHJ1Y3Qg
aW5vZGUgKmlub2RlKQo+ICAKPiAgCW5hbWUubGVuID0gbGUzMl90b19jcHUocmF3X2lub2RlLT5p
X25hbWVsZW4pOwo+ICAJbmFtZS5uYW1lID0gcmF3X2lub2RlLT5pX25hbWU7Cj4gKwo+ICsJaWYg
KHVubGlrZWx5KG5hbWUubGVuID4gRjJGU19OQU1FX0xFTikpIHsKPiArCQllcnIgPSAtRU5BTUVU
T09MT05HOwo+ICsJCWdvdG8gb3V0Owo+ICsJfQoKSGF2ZSB5b3Ugc2VlbiB0aGlzIGJlZm9yZT8K
VGhpcyBpcyBhIHRyaXZpYWwgYnVnIGNhc2UsIHNvLCBpZiB5b3UgaGF2ZSBnb3QgdGhpcyBidWcs
IHdlIHNob3VsZCBmaXgKdGhlIGJ1ZyBmaXJzdCBpbnN0ZWFkIG9mIGFkZGluZyBhbnkgd29ya2Fy
b3VuZCBwYXRjaC4KTGV0J3MgYWRkIFdBUk5fT04oKSBhdCBsZWFzdC4KVGhhbmtzLAoKPiAgcmV0
cnk6Cj4gIAlkZSA9IGYyZnNfZmluZF9lbnRyeShkaXIsICZuYW1lLCAmcGFnZSk7Cj4gIAlpZiAo
ZGUgJiYgaW5vZGUtPmlfaW5vID09IGxlMzJfdG9fY3B1KGRlLT5pbm8pKQoKLS0gCkphZWdldWsg
S2ltClNhbXN1bmcKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJhcGlkbHkgdHJvdWJsZXNob290
IHByb2JsZW1zIGJlZm9yZSB0aGV5IGFmZmVjdCB5b3VyIGJ1c2luZXNzLiBNb3N0IElUIApvcmdh
bml6YXRpb25zIGRvbid0IGhhdmUgYSBjbGVhciBwaWN0dXJlIG9mIGhvdyBhcHBsaWNhdGlvbiBw
ZXJmb3JtYW5jZSAKYWZmZWN0cyB0aGVpciByZXZlbnVlLiBXaXRoIEFwcER5bmFtaWNzLCB5b3Ug
Z2V0IDEwMCUgdmlzaWJpbGl0eSBpbnRvIHlvdXIgCkphdmEsLk5FVCwgJiBQSFAgYXBwbGljYXRp
b24uIFN0YXJ0IHlvdXIgMTUtZGF5IEZSRUUgVFJJQUwgb2YgQXBwRHluYW1pY3MgUHJvIQpodHRw
Oi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9ODQzNDk4MzEmaXU9LzQx
NDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo=
