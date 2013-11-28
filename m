From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: introduce f2fs_issue_discard() to clean up
Date: Thu, 28 Nov 2013 12:45:03 +0300
Message-ID: <20131128094503.GF5443@mwanda>
References: <20131126145315.GA27436@elgon.mountain>
	<1385520381.2417.17.camel@kjgkr> <20131127083117.GT5443@mwanda>
	<1385543097.2417.35.camel@kjgkr> <20131127104130.GW5443@mwanda>
	<1385611487.2417.40.camel@kjgkr> <20131128080852.GD5443@mwanda>
	<1385630681.2417.41.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Vly9t-0003Aq-Io
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 09:45:17 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vly9s-0003A7-Mr
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 09:45:17 +0000
Content-Disposition: inline
In-Reply-To: <1385630681.2417.41.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

T24gVGh1LCBOb3YgMjgsIDIwMTMgYXQgMDY6MjQ6NDFQTSArMDkwMCwgSmFlZ2V1ayBLaW0gd3Jv
dGU6Cj4gMjAxMy0xMS0yOCAo66qpKSwgMTE6MDggKzAzMDAsIERhbiBDYXJwZW50ZXI6Cj4gPiBP
biBUaHUsIE5vdiAyOCwgMjAxMyBhdCAwMTowNDo0N1BNICswOTAwLCBKYWVnZXVrIEtpbSB3cm90
ZToKPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZ2MuYyBiL2ZzL2YyZnMvZ2MuYwo+ID4gPiBp
bmRleCBiN2FkMWVjLi41ZmE1NGMxIDEwMDY0NAo+ID4gPiAtLS0gYS9mcy9mMmZzL2djLmMKPiA+
ID4gKysrIGIvZnMvZjJmcy9nYy5jCj4gPiA+IEBAIC02NjQsOCArNjY0LDYgQEAgc3RhdGljIHZv
aWQgZG9fZ2FyYmFnZV9jb2xsZWN0KHN0cnVjdCBmMmZzX3NiX2luZm8KPiA+ID4gKnNiaSwgdW5z
aWduZWQgaW50IHNlZ25vLAo+ID4gPiAgCj4gPiA+ICAJLyogcmVhZCBzZWdtZW50IHN1bW1hcnkg
b2YgdmljdGltICovCj4gPiA+ICAJc3VtX3BhZ2UgPSBnZXRfc3VtX3BhZ2Uoc2JpLCBzZWdubyk7
Cj4gPiA+IC0JaWYgKElTX0VSUihzdW1fcGFnZSkpCj4gPiA+IC0JCXJldHVybjsKPiA+IAo+ID4g
RGlkbid0IHlvdSB3YW50IHRvIGNoZWNrIGZvciBOVUxMIGhlcmU/Cj4gCj4gSXQgd2FzIG5lZWRs
ZXNzLCBzaW5jZSBnZXRfc3VtX3BhZ2UoKSByZXR1cm5zIGFsd2F5cyB2YWxpZCBwYWdlLgoKT2gg
eWVhaC4gIEkgd2Fzbid0IGxvb2tpbmcgY2FyZWZ1bGx5LgoKcmVnYXJkcywKZGFuIGNhcnBlbnRl
cgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJhcGlkbHkgdHJvdWJsZXNob290IHByb2JsZW1zIGJl
Zm9yZSB0aGV5IGFmZmVjdCB5b3VyIGJ1c2luZXNzLiBNb3N0IElUIApvcmdhbml6YXRpb25zIGRv
bid0IGhhdmUgYSBjbGVhciBwaWN0dXJlIG9mIGhvdyBhcHBsaWNhdGlvbiBwZXJmb3JtYW5jZSAK
YWZmZWN0cyB0aGVpciByZXZlbnVlLiBXaXRoIEFwcER5bmFtaWNzLCB5b3UgZ2V0IDEwMCUgdmlz
aWJpbGl0eSBpbnRvIHlvdXIgCkphdmEsLk5FVCwgJiBQSFAgYXBwbGljYXRpb24uIFN0YXJ0IHlv
dXIgMTUtZGF5IEZSRUUgVFJJQUwgb2YgQXBwRHluYW1pY3MgUHJvIQpodHRwOi8vcHViYWRzLmcu
ZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9ODQzNDkzNTEmaXU9LzQxNDAvb3N0Zy5jbGt0
cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
