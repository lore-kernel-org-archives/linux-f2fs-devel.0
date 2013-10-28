From: Huajun Li <huajun.li.lee@gmail.com>
Subject: Re: [f2fs-dev 5/5] f2fs: Handle inline data operations
Date: Tue, 29 Oct 2013 00:56:55 +0800
Message-ID: <CA+v9cxYUJ20_N5Zbo1W4WbTDB_SgXsbngZ0fEJx0dk+sxTS_1g@mail.gmail.com>
References: <1382716919-23345-1-git-send-email-huajun.li.lee@gmail.com>
	<1382716919-23345-6-git-send-email-huajun.li.lee@gmail.com>
	<1382964295.992.122.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huajun.li.lee@gmail.com>) id 1Vaq7h-0003SZ-ES
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Oct 2013 16:57:01 +0000
Received: from mail-ve0-f169.google.com ([209.85.128.169])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vaq7g-0006Jc-Nw
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Oct 2013 16:57:01 +0000
Received: by mail-ve0-f169.google.com with SMTP id c14so3827633vea.28
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 28 Oct 2013 09:56:55 -0700 (PDT)
In-Reply-To: <1382964295.992.122.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk.kim" <jaegeuk.kim@samsung.com>
Cc: Huajun Li <huajun.li@intel.com>, Weihong Xu <weihong.xu@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

T24gTW9uLCBPY3QgMjgsIDIwMTMgYXQgODo0NCBQTSwgSmFlZ2V1ayBLaW0gPGphZWdldWsua2lt
QHNhbXN1bmcuY29tPiB3cm90ZToKPiBIaSwKPgo+IDIwMTMtMTAtMjYgKO2GoCksIDAwOjAxICsw
ODAwLCBIdWFqdW4gTGk6Cj4+IEZyb206IEh1YWp1biBMaSA8aHVhanVuLmxpQGludGVsLmNvbT4K
Pj4KPgo+IFtzbmlwXQo+Cj4+Cj4+IEBAIC01MzgsNyArNTUzLDcgQEAgc3RhdGljIGludCBmMmZz
X3dyaXRlX2RhdGFfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSwKPj4gICAgICAgbG9mZl90IGlfc2l6
ZSA9IGlfc2l6ZV9yZWFkKGlub2RlKTsKPj4gICAgICAgY29uc3QgcGdvZmZfdCBlbmRfaW5kZXgg
PSAoKHVuc2lnbmVkIGxvbmcgbG9uZykgaV9zaXplKQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA+PiBQQUdFX0NBQ0hFX1NISUZUOwo+PiAt
ICAgICB1bnNpZ25lZCBvZmZzZXQ7Cj4+ICsgICAgIHVuc2lnbmVkIG9mZnNldCA9IDA7Cj4+ICAg
ICAgIGJvb2wgbmVlZF9iYWxhbmNlX2ZzID0gZmFsc2U7Cj4+ICAgICAgIGludCBlcnIgPSAwOwo+
Pgo+PiBAQCAtNTcyLDcgKzU4NywxNCBAQCB3cml0ZToKPj4gICAgICAgICAgICAgICBlcnIgPSBk
b193cml0ZV9kYXRhX3BhZ2UocGFnZSk7Cj4+ICAgICAgIH0gZWxzZSB7Cj4+ICAgICAgICAgICAg
ICAgZjJmc19sb2NrX29wKHNiaSk7Cj4+IC0gICAgICAgICAgICAgZXJyID0gZG9fd3JpdGVfZGF0
YV9wYWdlKHBhZ2UpOwo+PiArICAgICAgICAgICAgIGlmICh0ZXN0X29wdChzYmksIElOTElORV9E
QVRBKSAmJiAoaV9zaXplIDw9IE1BWF9JTkxJTkVfREFUQSkpIHsKPj4gKyAgICAgICAgICAgICAg
ICAgICAgIGVyciA9IGYyZnNfd3JpdGVfaW5saW5lX2RhdGEoaW5vZGUsIHBhZ2UsIG9mZnNldCk7
Cj4+ICsgICAgICAgICAgICAgICAgICAgICBDbGVhclBhZ2VEaXJ0eShwYWdlKTsKPgo+IERvbid0
IG5lZWQgdG8gY2FsbCBDbGVhclBhZ2VEaXJ0eShwYWdlKS4KPgoKWWVzLiBJIHdpbGwgcmVtb3Zl
IGl0IGluIG5leHQgdmVyc2lvbiwgdGhhbmtzLgoKPj4gKyAgICAgICAgICAgICAgICAgICAgIGYy
ZnNfdW5sb2NrX29wKHNiaSk7Cj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsKPj4g
KyAgICAgICAgICAgICB9IGVsc2Ugewo+PiArICAgICAgICAgICAgICAgICAgICAgZXJyID0gZG9f
d3JpdGVfZGF0YV9wYWdlKHBhZ2UpOwo+PiArICAgICAgICAgICAgIH0KPj4gICAgICAgICAgICAg
ICBmMmZzX3VubG9ja19vcChzYmkpOwo+PiAgICAgICAgICAgICAgIG5lZWRfYmFsYW5jZV9mcyA9
IHRydWU7Cj4+Cj4gLS0KPiBKYWVnZXVrIEtpbQo+IFNhbXN1bmcKPgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCk9jdG9iZXIgV2ViaW5hcnM6IENvZGUgZm9yIFBlcmZvcm1hbmNlCkZyZWUgSW50ZWwg
d2ViaW5hcnMgY2FuIGhlbHAgeW91IGFjY2VsZXJhdGUgYXBwbGljYXRpb24gcGVyZm9ybWFuY2Uu
CkV4cGxvcmUgdGlwcyBmb3IgTVBJLCBPcGVuTVAsIGFkdmFuY2VkIHByb2ZpbGluZywgYW5kIG1v
cmUuIEdldCB0aGUgbW9zdCBmcm9tIAp0aGUgbGF0ZXN0IEludGVsIHByb2Nlc3NvcnMgYW5kIGNv
cHJvY2Vzc29ycy4gU2VlIGFic3RyYWN0cyBhbmQgcmVnaXN0ZXIgPgpodHRwOi8vcHViYWRzLmcu
ZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9NjAxMzU5OTEmaXU9LzQxNDAvb3N0Zy5jbGt0
cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
