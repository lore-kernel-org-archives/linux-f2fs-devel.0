From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: avoid to use a NULL point in
 destroy_segment_manager
Date: Wed, 06 Nov 2013 13:10:58 +0800
Message-ID: <000101cedaae$bb7ed820$327c8860$@samsung.com>
References: <000001ceda8d$5b185bd0$11491370$@samsung.com>
	<5279BA67.4040906@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VdvPb-0001qO-Fi
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Nov 2013 05:12:15 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdvPX-00075r-Lf for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Nov 2013 05:12:15 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MVT00FXVT453BG0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Nov 2013 14:12:05 +0900 (KST)
In-reply-to: <5279BA67.4040906@cn.fujitsu.com>
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
To: 'Gu Zheng' <guz.fnst@cn.fujitsu.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

SGkgR3UsCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogR3UgWmhlbmcgW21h
aWx0bzpndXouZm5zdEBjbi5mdWppdHN1LmNvbV0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVy
IDA2LCAyMDEzIDExOjQxIEFNCj4gVG86IENoYW8gWXUKPiBDYzogPz8/OyBsaW51eC1mc2RldmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IMy35q0KPiBTdWJqZWN0OiBSZTogW2YyZnMt
ZGV2XSBbUEFUQ0hdIGYyZnM6IGF2b2lkIHRvIHVzZSBhIE5VTEwgcG9pbnQgaW4gZGVzdHJveV9z
ZWdtZW50X21hbmFnZXIKPiAKPiBPbiAxMS8wNi8yMDEzIDA5OjEyIEFNLCBDaGFvIFl1IHdyb3Rl
Ogo+IAo+ID4gQSBOVUxMIHBvaW50IHNob3VsZCBhdm9pZCB0byBiZSB1c2VkIGluIGRlc3Ryb3lf
c2VnbWVudF9tYW5hZ2VyIGFmdGVyIGFsbG9jYXRpbmcgbWVtb3J5IGZhaWwgZm9yIGYyZnNfc21f
aW5mby4KPiAKPiBUaG91Z2ggd2l0aG91dCB0aGlzIHBhdGNoIGl0IHN0aWxsIGNhbiB3b3JrIHdl
bGwsIGJlY2F1c2UgaWYgaXQgZmFpbGVkCj4gdG8gYWxsb2NhdGUgZjJmc19zbV9pbmZvLCB0aGUg
c2l0X2luZm8sIGZyZWVfaW5mby4uLiBhbGwgd2VyZSBOVUxMLCBhbmQKPiB0aGUgZGVzdG9yeSBw
YXRoKGUuZy4gZGVzdHJveV9kaXJ0eV9zZWdtYXApIGNhbiBkZWFsIHdpdGggdGhlbSB3ZWxsLgoK
SSB0aGluayBpdCBjb3VsZCBub3Qgd29yayB3ZWxsLiBXaXRob3V0IHRoaXMgcGF0Y2ggd2UgbWF5
IGdvdCBhIHNlZ21lbnQgCmZhdWx0IGluIERJUlRZX0koc2JpKSBhdCB0aGUgZm9sbG93aW5nIGNv
ZGUgaWYgaXQgZmFpbGVkIHRvIGFsbG9jYXRlIApmMmZzX3NtX2luZm8gbWVtb3J5KHNiaS0+c21f
aW5mbykuIFJpZ2h0PwoKc3RhdGljIHZvaWQgZGVzdHJveV9kaXJ0eV9zZWdtYXAoc3RydWN0IGYy
ZnNfc2JfaW5mbyAqc2JpKQp7CglzdHJ1Y3QgZGlydHlfc2VnbGlzdF9pbmZvICpkaXJ0eV9pID0g
RElSVFlfSShzYmkpOwoKPiBJTU8sIHRoaXMgcGF0Y2ggaXMgc3RpbGwgYSBnb29kIGNhdGNoLgo+
IAo+IFJlZ2FyZHMsCj4gR3UKPiAKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDxjaGFv
Mi55dUBzYW1zdW5nLmNvbT4KPiA+IC0tLQo+ID4gIGZzL2YyZnMvc2VnbWVudC5jIHwgICAgMiAr
Kwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0
IGEvZnMvZjJmcy9zZWdtZW50LmMgYi9mcy9mMmZzL3NlZ21lbnQuYwo+ID4gaW5kZXggM2Q0ZDVm
Yy4uZmYzNjNlNgo+ID4gLS0tIGEvZnMvZjJmcy9zZWdtZW50LmMKPiA+ICsrKyBiL2ZzL2YyZnMv
c2VnbWVudC5jCj4gPiBAQCAtMTc0NCw2ICsxNzQ0LDggQEAgc3RhdGljIHZvaWQgZGVzdHJveV9z
aXRfaW5mbyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkpCj4gPiAgdm9pZCBkZXN0cm95X3NlZ21l
bnRfbWFuYWdlcihzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkpCj4gPiAgewo+ID4gIAlzdHJ1Y3Qg
ZjJmc19zbV9pbmZvICpzbV9pbmZvID0gU01fSShzYmkpOwo+ID4gKwlpZiAoIXNtX2luZm8pCj4g
PiArCQlyZXR1cm47Cj4gPiAgCWRlc3Ryb3lfZGlydHlfc2VnbWFwKHNiaSk7Cj4gPiAgCWRlc3Ry
b3lfY3Vyc2VnKHNiaSk7Cj4gPiAgCWRlc3Ryb3lfZnJlZV9zZWdtYXAoc2JpKTsKCgoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCk5vdmVtYmVyIFdlYmluYXJzIGZvciBDLCBDKyssIEZvcnRyYW4gRGV2
ZWxvcGVycwpBY2NlbGVyYXRlIGFwcGxpY2F0aW9uIHBlcmZvcm1hbmNlIHdpdGggc2NhbGFibGUg
cHJvZ3JhbW1pbmcgbW9kZWxzLiBFeHBsb3JlCnRlY2huaXF1ZXMgZm9yIHRocmVhZGluZywgZXJy
b3IgY2hlY2tpbmcsIHBvcnRpbmcsIGFuZCB0dW5pbmcuIEdldCB0aGUgbW9zdCAKZnJvbSB0aGUg
bGF0ZXN0IEludGVsIHByb2Nlc3NvcnMgYW5kIGNvcHJvY2Vzc29ycy4gU2VlIGFic3RyYWN0cyBh
bmQgcmVnaXN0ZXIKaHR0cDovL3B1YmFkcy5nLmRvdWJsZWNsaWNrLm5ldC9nYW1wYWQvY2xrP2lk
PTYwMTM2MjMxJml1PS80MTQwL29zdGcuY2xrdHJrCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
