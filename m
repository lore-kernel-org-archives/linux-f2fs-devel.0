From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add additional sanity check in
 f2fs_acl_from_disk()
Date: Fri, 31 Aug 2018 15:02:56 +0800
Message-ID: <cc042ca1-9620-ed18-f0e5-3f07031d16bc@huawei.com>
References: <20180830133331.5503-1-cgxu519@gmx.com>
 <ab67166f-aa58-8a64-0672-c94e8a143ae0@kernel.org>
 <59f106bd-50d8-8f82-f573-1d025ad19f7d@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fvdSX-0001Lz-2m
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 07:03:09 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fvdSU-004T6I-PA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 07:03:09 +0000
In-Reply-To: <59f106bd-50d8-8f82-f573-1d025ad19f7d@gmx.com>
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
To: cgxu519 <cgxu519@gmx.com>, Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

T24gMjAxOC84LzMxIDA6MTksIGNneHU1MTkgd3JvdGU6Cj4gCj4gT24gMDgvMzAvMjAxOCAxMTo0
MSBQTSwgQ2hhbyBZdSB3cm90ZToKPj4gSGkgQ2hlbmdndWFuZywKPj4KPj4gT24gMjAxOC84LzMw
IDIxOjMzLCBDaGVuZ2d1YW5nIFh1IHdyb3RlOgo+Pj4gQWRkIGFkZGl0aW5hbCBzYW5pdHkgY2hl
Y2sgZm9yIGlycmVndWxhciBjYXNlKGUuZy4gY29ycnVwdGlvbikuCj4+PiBJZiBzaXplIG9mIGV4
dGVuZGVkIGF0dHJpYnV0aW9uIGlzIHNtYWxsZXIgdGhhbiBzaXplIG9mIGFjbCBoZWFkZXIsCj4+
PiB0aGVuIHJldHVybiAtRUlOVkFMLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IENoZW5nZ3Vhbmcg
WHUgPGNneHU1MTlAZ214LmNvbT4KPj4+IC0tLQo+Pj4gICBmcy9mMmZzL2FjbC5jIHwgMyArKysK
Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9mcy9mMmZzL2FjbC5jIGIvZnMvZjJmcy9hY2wuYwo+Pj4gaW5kZXggMTExODI0MTk5YTg4Li43
OWU5ZWE3NzMwNzAgMTAwNjQ0Cj4+PiAtLS0gYS9mcy9mMmZzL2FjbC5jCj4+PiArKysgYi9mcy9m
MmZzL2FjbC5jCj4+PiBAQCAtNTMsNiArNTMsOSBAQCBzdGF0aWMgc3RydWN0IHBvc2l4X2FjbCAq
ZjJmc19hY2xfZnJvbV9kaXNrKGNvbnN0IGNoYXIgKnZhbHVlLCBzaXplX3Qgc2l6ZSkKPj4+ICAg
CXN0cnVjdCBmMmZzX2FjbF9lbnRyeSAqZW50cnkgPSAoc3RydWN0IGYyZnNfYWNsX2VudHJ5ICop
KGhkciArIDEpOwo+Pj4gICAJY29uc3QgY2hhciAqZW5kID0gdmFsdWUgKyBzaXplOwo+Pj4gICAK
Pj4+ICsJaWYgKHNpemUgPCBzaXplb2YoZjJmc19hY2xfaGVhZGVyKSkKPj4+ICsJCXJldHVybiBF
UlJfUFRSKC1FSU5WQUwpOwo+PiBJIGd1ZXNzIGJlbG93IGNvZGVzIGhhdmUgY2hlY2tlZCB0aGF0
IGFscmVhZHk/Cj4+Cj4+IAljb3VudCA9IGYyZnNfYWNsX2NvdW50KHNpemUpOwo+PiAJaWYgKGNv
dW50IDwgMCkKPj4gCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPiAKPiBIaSBDaGFvLAo+IAo+
IFRoYW5rcyBmb3IgcHJvbXB0IHJlcGx5Lgo+IAo+IEkgc3RpbGwgdGhpbmsgaW4gYSByYXJlIGNh
c2UsIGl0IGNhbiBwYXNzIHRoZSBjaGVjayBpbiBmMmZzX2FjbF9jb3VudCgpIAo+IGFuZCBjYXVz
ZSB1bmV4cGVjdGVkIGJlaGF2aW9yLgo+IAo+IEZvciBleGFtcGxlLCBsaWtlIGJlbG93IGNvZGUg
cGF0aCBpbiBmMmZzX2FjbF9jb3VudCgpLgoKaWYgc2l6ZSA8IHNpemVvZihmMmZzX2FjbF9oZWFk
ZXIpCgpzaXplIC09IHNpemVvZihzdHJ1Y3QgZjJmc19hY2xfaGVhZGVyKTsKCnNpemUgc2hvdWxk
IGJlIHNtYWxsZXIgdGhhbiB6ZXJvLCByaWdodD8KCj4gCj4gLT4gaWYgKHMgPCAwKSB7Cj4gIMKg
wqDCoMKgIMKgIMKgIMKgwqAgaWYgKHNpemUgJSBzaXplb2Yoc3RydWN0IGYyZnNfYWNsX2VudHJ5
X3Nob3J0KSkKPiAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLTE7
Cj4gLT4gwqAgwqDCoMKgwqAgcmV0dXJuIHNpemUgLyBzaXplb2Yoc3RydWN0IGYyZnNfYWNsX2Vu
dHJ5X3Nob3J0KTsKClNvIHRoZSByZXR1cm4gdmFsdWUgc2hvdWxkIGJlIHNtYWxsZXIgdGhhbiB6
ZXJvPwoKVGhhbmtzLAoKPiB9Cj4gCj4gCj4gVGhhbmtzLAo+IENoZW5nZ3VhbmcKPiAKPiAKPiAK
PiAKPiAKPiAKPiAKPiAKPiAKPiAKPiAKPiAKPiAuCj4gCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxk
J3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGlu
ay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9saW51eC1mMmZzLWRldmVsCg==
