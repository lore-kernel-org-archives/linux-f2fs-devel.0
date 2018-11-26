From: Chao Yu <chao@kernel.org>
Subject: Re: fsck: reset i_gc_failures from 0x1 to 0x00
Date: Mon, 26 Nov 2018 22:09:19 +0800
Message-ID: <0e88393a-e559-f430-62f7-1c63dbce6ad3@kernel.org>
References: <2dbe74e040f9061f298c45016aa37881ea6f879d.camel@bi-co.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gRHa2-0003k7-GU
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 14:09:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRHZl-004Gm5-Ng
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 14:09:42 +0000
In-Reply-To: <2dbe74e040f9061f298c45016aa37881ea6f879d.camel@bi-co.net>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: =?UTF-8?Q?Michael_La=c3=9f?= <bevan@bi-co.net>, linux-f2fs-devel@lists.sourceforge.net

SGkgTWljaGFlbCwKCk9uIDIwMTgtMTEtMjYgNzowOSwgTWljaGFlbCBMYcOfIHdyb3RlOgo+IEhp
LAo+IAo+IGFmdGVyIHVwZGF0aW5nIHRvIGYyZnMtdG9vbHMgMS4xMi4wLCBhIHJvdXRpbmUgZnNj
ayBvZiBteSBmaWxlIHN5c3RlbXMKPiB0b29rIHF1aXRlIGEgd2hpbGUgYW5kIG91dHB1dCB0ZW4t
dGhvdXNhbmRzIGluc3RhbmNlcyBvZiB0aGUgZm9sbG93aW5nCj4gbGluZToKPiAKPj4gW0ZJWF0g
KGZzY2tfY2hrX2lub2RlX2JsazogOTU0KSAgLS0+IFJlZ3VsYXI6IDB4WFlaIHJlc2V0IGlfZ2Nf
ZmFpbHVyZXMgZnJvbSAweDEgdG8gMHgwMAoKRG8geW91IHVzZSAtZiBvciAtcCAxIG9wdGlvbiB3
aGVuIGRvaW5nIGZzY2sgb24gaW1hZ2U/Cgo+IAo+IHdoZXJlIFhZWiB2YXJpZWQgZnJvbSBsaW5l
IHRvIGxpbmUuIEkgYXNzdW1lIHRoaXMgaXMgcmVsYXRlZCB0bwo+IDkxYmI3YjIxZjc0MGQ2MWNk
ZTJiYjI3ZGEzZGNjYjBhZmRkNWExNWIgYnV0IEknbSBub3Qgc3VyZSBhYm91dCB0aGUKPiBpbXBs
aWNhdGlvbnMuIElzIHRoaXMgc29tZXRoaW5nIHRvIHdvcnJ5IGFib3V0IG9yIHNvbWUgZGVsaWJl
cmF0ZQo+IGNoYW5nZSBvZiB0aGUgb24tZGlzayBmb3JtYXQgd2hpY2ggd2FzIG5vdyBicmF1Z2h0
IHVwIHRvIGRhdGUgYnkgZnNjaz8KCldlIHN0YXJ0IHRvIHN1cHBvcnQgcmVzZXRpbmcgLmlfZ2Nf
ZmFpbHVyZXMncyB2YWx1ZSB0byB6ZXJvIGluIGZzY2sgc2luY2UKOTFiYjdiMjFmNzQwICgiZjJm
cy10b29sczogZml4IHRvIHJlc2V0IGlfZ2NfZmFpbHVyZXMgb2ZmbGluZSIpLCB0aGlzIGlzIGJl
Y2F1c2UKaWYgLmlfZ2NfZmFpbHVyZXMgY29udGludWVzIGluY3JlYXNpbmcgYW5kIGV4Y2VlZCB0
aHJlc2hvbGQsIGl0IGNhbiBtYWtlIGYyZnMKYnJlYWsgYXRvbWljX3dyaXRlIHNlbWFudGljcyBk
dXJpbmcgR0MsIHNvIEkgYWRkZWQgdGhhdCBwYXRjaCB0byBhdm9pZCBzdWNoCmNvbmRpdGlvbi4K
CkJ1dCB0aGUgcHJvYmxlbSBoZXJlIGlzIGV2ZW4gLmlfZ2NfZmFpbHVyZXMncyB2YWx1ZSBpcyBv
bmUgd2hpY2ggd2FzIGluaXRpYWxpemVkCiBkdWluZyBpbm9kZSBjcmVhdGlvbiBieSBvbGQga2Vy
bmVsLCBhbmQgaXQgbmV2ZXIgYmUgaW5jcmVhc2VkIGJ5IEdDIGZsb3csIHdlCndpbGwgc3RpbGwg
dHJpZ2dlciBzdWNoIGZpeCBpbiBmc2NrLiBJIHRoaW5rIGl0J3Mgbm90IG5lY2Vzc2FyeSwgYW55
d2F5LCBsZXQgbWUKc2VuZCBvbmUgcGF0Y2ggdG8gZml4IGl0LgoKVGhhbmtzLAoKPiAKPiBCZXN0
IHJlZ2FyZHMsCj4gTWljaGFlbAo+IAo+IAo+IAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKPiAKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCg==
