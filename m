From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/5] f2fs: add unlikely macro for compiler
 optimization
Date: Mon, 02 Dec 2013 12:32:04 +0800
Message-ID: <000001ceef17$9205e830$b611b890$@samsung.com>
References: <003301ceec0d$77ddaef0$67990cd0$@samsung.com>
	<1385720057.2417.46.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VnLBx-0006s0-4V
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Dec 2013 04:33:05 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VnLBv-0003ty-5w
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Dec 2013 04:33:05 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MX5003JGWMVFMD0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Dec 2013 13:32:55 +0900 (KST)
In-reply-to: <1385720057.2417.46.camel@kjgkr>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

SGkgS2ltLAoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEphZWdldWsgS2lt
IFttYWlsdG86amFlZ2V1ay5raW1Ac2Ftc3VuZy5jb21dCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJl
ciAyOSwgMjAxMyA2OjE0IFBNCj4gVG86IENoYW8gWXUKPiBDYzogbGludXgtZnNkZXZlbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0OyDosK3lp50KPiBTdWJqZWN0OiBSZTogW2YyZnMtZGV2
XSBbUEFUQ0ggMi81XSBmMmZzOiBhZGQgdW5saWtlbHkgbWFjcm8gZm9yIGNvbXBpbGVyIG9wdGlt
aXphdGlvbgo+IAo+IEhpLAo+IAo+IENvdWxkIHlvdSBtYWtlIGEgcGF0Y2ggdG8gYWRkICp1bmxp
a2VseSogYXMgbWFueSBhcyBwb3NzaWJsZSBhY3Jvc3MgdGhlCj4gd2hvbGUgc291cmNlIGZpbGVz
IGF0IG9uY2U/Cj4gSXQgaXMgd2FzdGVmdWwgdG8gYWRkIGl0IHdpdGggYSBidW5jaCBvZiBwYXRj
aGVzIGF0IG11bHRpcGxlIHRpbWVzLgoKQWxyaWdodCwgSSB3aWxsIHdvcmsgb24gdGhpcy4KCj4g
Cj4gQW5kIHBsZWFzZSB3cml0ZSBkZXNjcmlwdGlvbnMgZm9yIGFsbCB0aGUgcGF0Y2hlcyBldmVu
IGlmIG5vdGhpbmcgaXMKPiBzcGVjaWFsLgo+IEluIHRoaXMgY2FzZSwgd2h5IHNob3VsZCB3ZSBz
ZXQgKnVubGlrZWx5KiBmb3IgY2hlY2tpbmcgdGhpcyBjb25kaXRpb24/CgpHb3QgaXQuCgpSZWdh
cmRzLApZdQoKPiAKPiBUaGFua3MsCj4gCj4gMjAxMy0xMS0yOCAo66qpKSwgMTU6NDIgKzA4MDAs
IENoYW8gWXU6Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDxjaGFvMi55dUBzYW1zdW5nLmNv
bT4KPiA+IC0tLQo+ID4gIGZzL2YyZnMvbm9kZS5jIHwgICAgMiArLQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9m
cy9mMmZzL25vZGUuYyBiL2ZzL2YyZnMvbm9kZS5jCj4gPiBpbmRleCAwZmU5YTk3Li45NTQxNTVi
IDEwMDY0NAo+ID4gLS0tIGEvZnMvZjJmcy9ub2RlLmMKPiA+ICsrKyBiL2ZzL2YyZnMvbm9kZS5j
Cj4gPiBAQCAtMTE2MCw3ICsxMTYwLDcgQEAgaW50IHdhaXRfb25fbm9kZV9wYWdlc193cml0ZWJh
Y2soc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBuaWRfdCBpbm8pCj4gPiAgCQkJc3RydWN0IHBh
Z2UgKnBhZ2UgPSBwdmVjLnBhZ2VzW2ldOwo+ID4KPiA+ICAJCQkvKiB1bnRpbCByYWRpeCB0cmVl
IGxvb2t1cCBhY2NlcHRzIGVuZF9pbmRleCAqLwo+ID4gLQkJCWlmIChwYWdlLT5pbmRleCA+IGVu
ZCkKPiA+ICsJCQlpZiAodW5saWtlbHkocGFnZS0+aW5kZXggPiBlbmQpKQo+ID4gIAkJCQljb250
aW51ZTsKPiA+Cj4gPiAgCQkJaWYgKGlubyAmJiBpbm9fb2Zfbm9kZShwYWdlKSA9PSBpbm8pIHsK
PiAKPiAtLQo+IEphZWdldWsgS2ltCj4gU2Ftc3VuZwoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpS
YXBpZGx5IHRyb3VibGVzaG9vdCBwcm9ibGVtcyBiZWZvcmUgdGhleSBhZmZlY3QgeW91ciBidXNp
bmVzcy4gTW9zdCBJVCAKb3JnYW5pemF0aW9ucyBkb24ndCBoYXZlIGEgY2xlYXIgcGljdHVyZSBv
ZiBob3cgYXBwbGljYXRpb24gcGVyZm9ybWFuY2UgCmFmZmVjdHMgdGhlaXIgcmV2ZW51ZS4gV2l0
aCBBcHBEeW5hbWljcywgeW91IGdldCAxMDAlIHZpc2liaWxpdHkgaW50byB5b3VyIApKYXZhLC5O
RVQsICYgUEhQIGFwcGxpY2F0aW9uLiBTdGFydCB5b3VyIDE1LWRheSBGUkVFIFRSSUFMIG9mIEFw
cER5bmFtaWNzIFBybyEKaHR0cDovL3B1YmFkcy5nLmRvdWJsZWNsaWNrLm5ldC9nYW1wYWQvY2xr
P2lkPTg0MzQ5MzUxJml1PS80MTQwL29zdGcuY2xrdHJrCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
