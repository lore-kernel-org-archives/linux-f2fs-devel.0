From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: check all ones or zeros bitmap with
 integer data type for better mount performance
Date: Tue, 22 Oct 2013 21:23:32 +0900
Message-ID: <1382444612.992.67.camel@kjgkr>
References: <000701cecf09$2b2a2280$817e6780$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VYb0Q-0007R6-5D
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Oct 2013 12:24:14 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYb0N-0004x4-SE for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Oct 2013 12:24:14 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MV200E47L3R86K0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Oct 2013 21:24:05 +0900 (KST)
In-reply-to: <000701cecf09$2b2a2280$817e6780$@samsung.com>
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
Cc: linux-fsdevel@vger.kernel.org, =?UTF-8?Q?=E8=B0=AD=E5=A7=9D?= <shu.tan@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDEzLTEwLTIyICjtmZQpLCAxNzoyOCArMDgwMCwgQ2hhbyBZdToKPiBQcmV2aW91c2x5
LCBjaGVja19ibG9ja19jb3VudCBjaGVjayB2YWxpZF9tYXAgd2l0aCBiaXQgZGF0YSB0eXBlIGlu
IGNvbW1vbgo+IHNjZW5hcmlvIHRoYXQgc2l0IGhhcyBhbGwgb25lcyBvciB6ZXJvcyBiaXRtYXAs
IGl0IG1ha2VzIGxvdyBtb3VudAo+IHBlcmZvcm1hbmNlLgo+IFNvIGxldCdzIGNoZWNrIHRoZSBz
cGVjaWFsIGJpdG1hcCB3aXRoIGludGVnZXIgZGF0YSB0eXBlIGluc3RlYWQgb2YgdGhlIGJpdAo+
IG9uZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBUYW4gU2h1IDxzaHUudGFuQHNhbXN1bmcuY29tPgo+
IFNpZ25lZC1vZmYtYnk6IFl1IENoYW8gPGNoYW8yLnl1QHNhbXN1bmcuY29tPgo+IC0tLQo+ICBm
cy9mMmZzL3NlZ21lbnQuaCB8ICAgMTMgKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL3NlZ21lbnQuaCBiL2Zz
L2YyZnMvc2VnbWVudC5oCj4gaW5kZXggN2Y5NGQ3OC4uZDQzYWI5ZiAxMDA2NDQKPiAtLS0gYS9m
cy9mMmZzL3NlZ21lbnQuaAo+ICsrKyBiL2ZzL2YyZnMvc2VnbWVudC5oCj4gQEAgLTU0Myw2ICs1
NDMsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2hlY2tfYmxvY2tfY291bnQoc3RydWN0IGYyZnNf
c2JfaW5mbwo+ICpzYmksCj4gIHsKPiAgCXN0cnVjdCBmMmZzX3NtX2luZm8gKnNtX2luZm8gPSBT
TV9JKHNiaSk7Cj4gIAl1bnNpZ25lZCBpbnQgZW5kX3NlZ25vID0gc21faW5mby0+c2VnbWVudF9j
b3VudCAtIDE7Cj4gKwlpbnQgKnZhbGlkX21hcCA9IChpbnQgKilyYXdfc2l0LT52YWxpZF9tYXA7
Cj4gIAlpbnQgdmFsaWRfYmxvY2tzID0gMDsKPiAgCWludCBpOwo+ICAKPiBAQCAtNTUyLDYgKzU1
MywxOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2hlY2tfYmxvY2tfY291bnQoc3RydWN0Cj4gZjJm
c19zYl9pbmZvICpzYmksCj4gIAkvKiBjaGVjayBib3VuZGFyeSBvZiBhIGdpdmVuIHNlZ21lbnQg
bnVtYmVyICovCj4gIAlCVUdfT04oc2Vnbm8gPiBlbmRfc2Vnbm8pOwo+ICAKPiArCS8qIGNoZWNr
IGFsbCBvbmVzIG9yIHplcm9zIHZhbGlkX21hcCAqLwo+ICsJaWYgKEdFVF9TSVRfVkJMT0NLUyhy
YXdfc2l0KSA9PSAwKSB7Cj4gKwkJZm9yIChpID0gMDsgaSA8IFNJVF9WQkxPQ0tfTUFQX1NJWkUg
LyBzaXplb2YoaW50KTsgaSsrKQoKV2UgY2Fubm90IGd1YXJhbnRlZSBhbGwgdGhlIHRpbWUgdGhh
dCBTSVRfVkJMT0NLX01BUF9TSVpFIGlzIG11bHRpcGxlIG9mCnNpemVvZihpbnQpLgpIb3cgYWJv
dXQgdXNpbmcgbWVtY21wKCkgd2l0aCBfX3U4PwoKPiArCQkJaWYgKHVubGlrZWx5KHZhbGlkX21h
cFtpXSAhPSAwKSkKPiArCQkJCUJVRygpOwo+ICsJCXJldHVybjsKPiArCX0gZWxzZSBpZiAoR0VU
X1NJVF9WQkxPQ0tTKHJhd19zaXQpID09IHNiaS0+YmxvY2tzX3Blcl9zZWcpIHsKPiArCQlmb3Ig
KGkgPSAwOyBpIDwgU0lUX1ZCTE9DS19NQVBfU0laRSAvIHNpemVvZihpbnQpOyBpKyspCj4gKwkJ
CWlmICh1bmxpa2VseSh2YWxpZF9tYXBbaV0gIT0gLTEpKQo+ICsJCQkJQlVHKCk7Cj4gKwkJcmV0
dXJuOwo+ICsJfQo+ICsKPiAgCS8qIGNoZWNrIGJpdG1hcCB3aXRoIHZhbGlkIGJsb2NrIGNvdW50
ICovCj4gIAlmb3IgKGkgPSAwOyBpIDwgc2JpLT5ibG9ja3NfcGVyX3NlZzsgaSsrKQo+ICAJCWlm
IChmMmZzX3Rlc3RfYml0KGksIHJhd19zaXQtPnZhbGlkX21hcCkpCj4gLS0tCj4gCj4gLS0KPiBU
byB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUg
bGludXgtZnNkZXZlbCIgaW4KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZn
ZXIua2VybmVsLm9yZwo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5l
bC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbAoKLS0gCkphZWdldWsgS2ltClNhbXN1bmcKCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KT2N0b2JlciBXZWJpbmFyczogQ29kZSBmb3IgUGVyZm9ybWFuY2UK
RnJlZSBJbnRlbCB3ZWJpbmFycyBjYW4gaGVscCB5b3UgYWNjZWxlcmF0ZSBhcHBsaWNhdGlvbiBw
ZXJmb3JtYW5jZS4KRXhwbG9yZSB0aXBzIGZvciBNUEksIE9wZW5NUCwgYWR2YW5jZWQgcHJvZmls
aW5nLCBhbmQgbW9yZS4gR2V0IHRoZSBtb3N0IGZyb20gCnRoZSBsYXRlc3QgSW50ZWwgcHJvY2Vz
c29ycyBhbmQgY29wcm9jZXNzb3JzLiBTZWUgYWJzdHJhY3RzIGFuZCByZWdpc3RlciA+Cmh0dHA6
Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD02MDEzNTk5MSZpdT0vNDE0
MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
