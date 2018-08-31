From: "Chengguang Xu" <cgxu519@gmx.com>
Subject: Re: [PATCH] f2fs: add additional sanity check in
 f2fs_acl_from_disk()
Date: Fri, 31 Aug 2018 13:40:37 +0200
Message-ID: <trinity-122b8888-efc4-4bf5-a7fa-8d8a50065457-1535715637482@msvc-mesg-gmx021>
References: <20180830133331.5503-1-cgxu519@gmx.com>
 <ab67166f-aa58-8a64-0672-c94e8a143ae0@kernel.org>
 <59f106bd-50d8-8f82-f573-1d025ad19f7d@gmx.com>
 <cc042ca1-9620-ed18-f0e5-3f07031d16bc@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1fvhnK-0008Tt-3I
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 11:40:54 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fvhnG-004j6H-De
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 11:40:54 +0000
In-Reply-To: <cc042ca1-9620-ed18-f0e5-3f07031d16bc@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

CgpPbiAyMDE4LzgvMzEgYXQg5LiL5Y2IMzowMiwgQ2hhbyBZdSB3cm90ZToKCj4gT24gMjAxOC84
LzMxIDA6MTksIGNneHU1MTkgd3JvdGU6Cj4gPiAKPiA+IE9uIDA4LzMwLzIwMTggMTE6NDEgUE0s
IENoYW8gWXUgd3JvdGU6Cj4gPj4gSGkgQ2hlbmdndWFuZywKPiA+Pgo+ID4+IE9uIDIwMTgvOC8z
MCAyMTozMywgQ2hlbmdndWFuZyBYdSB3cm90ZToKPiA+Pj4gQWRkIGFkZGl0aW5hbCBzYW5pdHkg
Y2hlY2sgZm9yIGlycmVndWxhciBjYXNlKGUuZy4gY29ycnVwdGlvbikuCj4gPj4+IElmIHNpemUg
b2YgZXh0ZW5kZWQgYXR0cmlidXRpb24gaXMgc21hbGxlciB0aGFuIHNpemUgb2YgYWNsIGhlYWRl
ciwKPiA+Pj4gdGhlbiByZXR1cm4gLUVJTlZBTC4KPiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTog
Q2hlbmdndWFuZyBYdSA8Y2d4dTUxOUBnbXguY29tPgo+ID4+PiAtLS0KPiA+Pj4gICBmcy9mMmZz
L2FjbC5jIHwgMyArKysKPiA+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4g
Pj4+Cj4gPj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2FjbC5jIGIvZnMvZjJmcy9hY2wuYwo+ID4+
PiBpbmRleCAxMTE4MjQxOTlhODguLjc5ZTllYTc3MzA3MCAxMDA2NDQKPiA+Pj4gLS0tIGEvZnMv
ZjJmcy9hY2wuYwo+ID4+PiArKysgYi9mcy9mMmZzL2FjbC5jCj4gPj4+IEBAIC01Myw2ICs1Myw5
IEBAIHN0YXRpYyBzdHJ1Y3QgcG9zaXhfYWNsICpmMmZzX2FjbF9mcm9tX2Rpc2soY29uc3QgY2hh
ciAqdmFsdWUsIHNpemVfdCBzaXplKQo+ID4+PiAgIAlzdHJ1Y3QgZjJmc19hY2xfZW50cnkgKmVu
dHJ5ID0gKHN0cnVjdCBmMmZzX2FjbF9lbnRyeSAqKShoZHIgKyAxKTsKPiA+Pj4gICAJY29uc3Qg
Y2hhciAqZW5kID0gdmFsdWUgKyBzaXplOwo+ID4+PiAgIAo+ID4+PiArCWlmIChzaXplIDwgc2l6
ZW9mKGYyZnNfYWNsX2hlYWRlcikpCj4gPj4+ICsJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+
ID4+IEkgZ3Vlc3MgYmVsb3cgY29kZXMgaGF2ZSBjaGVja2VkIHRoYXQgYWxyZWFkeT8KPiA+Pgo+
ID4+IAljb3VudCA9IGYyZnNfYWNsX2NvdW50KHNpemUpOwo+ID4+IAlpZiAoY291bnQgPCAwKQo+
ID4+IAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gPiAKPiA+IEhpIENoYW8sCj4gPiAKPiA+
IFRoYW5rcyBmb3IgcHJvbXB0IHJlcGx5Lgo+ID4gCj4gPiBJIHN0aWxsIHRoaW5rIGluIGEgcmFy
ZSBjYXNlLCBpdCBjYW4gcGFzcyB0aGUgY2hlY2sgaW4gZjJmc19hY2xfY291bnQoKSAKPiA+IGFu
ZCBjYXVzZSB1bmV4cGVjdGVkIGJlaGF2aW9yLgo+ID4gCj4gPiBGb3IgZXhhbXBsZSwgbGlrZSBi
ZWxvdyBjb2RlIHBhdGggaW4gZjJmc19hY2xfY291bnQoKS4KPiAKPiBpZiBzaXplIDwgc2l6ZW9m
KGYyZnNfYWNsX2hlYWRlcikKPiAKPiBzaXplIC09IHNpemVvZihzdHJ1Y3QgZjJmc19hY2xfaGVh
ZGVyKTsKPiAKPiBzaXplIHNob3VsZCBiZSBzbWFsbGVyIHRoYW4gemVybywgcmlnaHQ/Cj4gCj4g
PiAKPiA+IC0+IGlmIChzIDwgMCkgewo+ID4gIMKgwqDCoMKgIMKgIMKgIMKgwqAgaWYgKHNpemUg
JSBzaXplb2Yoc3RydWN0IGYyZnNfYWNsX2VudHJ5X3Nob3J0KSkKPiA+ICDCoCDCoCDCoCDCoCDC
oCDCoMKgIMKgwqDCoMKgwqDCoMKgIHJldHVybiAtMTsKPiA+IC0+IMKgIMKgwqDCoMKgIHJldHVy
biBzaXplIC8gc2l6ZW9mKHN0cnVjdCBmMmZzX2FjbF9lbnRyeV9zaG9ydCk7Cj4gCj4gU28gdGhl
IHJldHVybiB2YWx1ZSBzaG91bGQgYmUgc21hbGxlciB0aGFuIHplcm8/CgpzaXplIGlzIHVuc2ln
bmVkIHNvIHRoZSByZXR1cm4gdmFsdWUgd2lsbCBub3QgYmUgbmVnYXRpdmUgaGVyZS4KClRoYW5r
cywKQ2hlbmdndWFuZwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFu
dCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNo
IHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
