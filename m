From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add additional sanity check in
 f2fs_acl_from_disk()
Date: Fri, 31 Aug 2018 20:16:27 +0800
Message-ID: <9c8dd97e-0412-f76a-e588-3a68d84f4851@huawei.com>
References: <20180830133331.5503-1-cgxu519@gmx.com>
 <ab67166f-aa58-8a64-0672-c94e8a143ae0@kernel.org>
 <59f106bd-50d8-8f82-f573-1d025ad19f7d@gmx.com>
 <cc042ca1-9620-ed18-f0e5-3f07031d16bc@huawei.com>
 <trinity-122b8888-efc4-4bf5-a7fa-8d8a50065457-1535715637482@msvc-mesg-gmx021>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fviM3-0007WA-IG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 12:16:47 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fviLz-004CBN-LH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 12:16:47 +0000
In-Reply-To: <trinity-122b8888-efc4-4bf5-a7fa-8d8a50065457-1535715637482@msvc-mesg-gmx021>
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
To: Chengguang Xu <cgxu519@gmx.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

T24gMjAxOC84LzMxIDE5OjQwLCBDaGVuZ2d1YW5nIFh1IHdyb3RlOgo+IAo+IAo+IE9uIDIwMTgv
OC8zMSBhdCDkuIvljYgzOjAyLCBDaGFvIFl1IHdyb3RlOgo+IAo+PiBPbiAyMDE4LzgvMzEgMDox
OSwgY2d4dTUxOSB3cm90ZToKPj4+Cj4+PiBPbiAwOC8zMC8yMDE4IDExOjQxIFBNLCBDaGFvIFl1
IHdyb3RlOgo+Pj4+IEhpIENoZW5nZ3VhbmcsCj4+Pj4KPj4+PiBPbiAyMDE4LzgvMzAgMjE6MzMs
IENoZW5nZ3VhbmcgWHUgd3JvdGU6Cj4+Pj4+IEFkZCBhZGRpdGluYWwgc2FuaXR5IGNoZWNrIGZv
ciBpcnJlZ3VsYXIgY2FzZShlLmcuIGNvcnJ1cHRpb24pLgo+Pj4+PiBJZiBzaXplIG9mIGV4dGVu
ZGVkIGF0dHJpYnV0aW9uIGlzIHNtYWxsZXIgdGhhbiBzaXplIG9mIGFjbCBoZWFkZXIsCj4+Pj4+
IHRoZW4gcmV0dXJuIC1FSU5WQUwuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENoZW5nZ3Vh
bmcgWHUgPGNneHU1MTlAZ214LmNvbT4KPj4+Pj4gLS0tCj4+Pj4+ICAgZnMvZjJmcy9hY2wuYyB8
IDMgKysrCj4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pj4+Pgo+Pj4+
PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9hY2wuYyBiL2ZzL2YyZnMvYWNsLmMKPj4+Pj4gaW5kZXgg
MTExODI0MTk5YTg4Li43OWU5ZWE3NzMwNzAgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2ZzL2YyZnMvYWNs
LmMKPj4+Pj4gKysrIGIvZnMvZjJmcy9hY2wuYwo+Pj4+PiBAQCAtNTMsNiArNTMsOSBAQCBzdGF0
aWMgc3RydWN0IHBvc2l4X2FjbCAqZjJmc19hY2xfZnJvbV9kaXNrKGNvbnN0IGNoYXIgKnZhbHVl
LCBzaXplX3Qgc2l6ZSkKPj4+Pj4gICAJc3RydWN0IGYyZnNfYWNsX2VudHJ5ICplbnRyeSA9IChz
dHJ1Y3QgZjJmc19hY2xfZW50cnkgKikoaGRyICsgMSk7Cj4+Pj4+ICAgCWNvbnN0IGNoYXIgKmVu
ZCA9IHZhbHVlICsgc2l6ZTsKPj4+Pj4gICAKPj4+Pj4gKwlpZiAoc2l6ZSA8IHNpemVvZihmMmZz
X2FjbF9oZWFkZXIpKQo+Pj4+PiArCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPj4+PiBJIGd1
ZXNzIGJlbG93IGNvZGVzIGhhdmUgY2hlY2tlZCB0aGF0IGFscmVhZHk/Cj4+Pj4KPj4+PiAJY291
bnQgPSBmMmZzX2FjbF9jb3VudChzaXplKTsKPj4+PiAJaWYgKGNvdW50IDwgMCkKPj4+PiAJCXJl
dHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+Pj4KPj4+IEhpIENoYW8sCj4+Pgo+Pj4gVGhhbmtzIGZv
ciBwcm9tcHQgcmVwbHkuCj4+Pgo+Pj4gSSBzdGlsbCB0aGluayBpbiBhIHJhcmUgY2FzZSwgaXQg
Y2FuIHBhc3MgdGhlIGNoZWNrIGluIGYyZnNfYWNsX2NvdW50KCkgCj4+PiBhbmQgY2F1c2UgdW5l
eHBlY3RlZCBiZWhhdmlvci4KPj4+Cj4+PiBGb3IgZXhhbXBsZSwgbGlrZSBiZWxvdyBjb2RlIHBh
dGggaW4gZjJmc19hY2xfY291bnQoKS4KPj4KPj4gaWYgc2l6ZSA8IHNpemVvZihmMmZzX2FjbF9o
ZWFkZXIpCj4+Cj4+IHNpemUgLT0gc2l6ZW9mKHN0cnVjdCBmMmZzX2FjbF9oZWFkZXIpOwo+Pgo+
PiBzaXplIHNob3VsZCBiZSBzbWFsbGVyIHRoYW4gemVybywgcmlnaHQ/Cj4+Cj4+Pgo+Pj4gLT4g
aWYgKHMgPCAwKSB7Cj4+PiAgwqDCoMKgwqAgwqAgwqAgwqDCoCBpZiAoc2l6ZSAlIHNpemVvZihz
dHJ1Y3QgZjJmc19hY2xfZW50cnlfc2hvcnQpKQo+Pj4gIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC0xOwo+Pj4gLT4gwqAgwqDCoMKgwqAgcmV0dXJuIHNpemUgLyBz
aXplb2Yoc3RydWN0IGYyZnNfYWNsX2VudHJ5X3Nob3J0KTsKPj4KPj4gU28gdGhlIHJldHVybiB2
YWx1ZSBzaG91bGQgYmUgc21hbGxlciB0aGFuIHplcm8/Cj4gCj4gc2l6ZSBpcyB1bnNpZ25lZCBz
byB0aGUgcmV0dXJuIHZhbHVlIHdpbGwgbm90IGJlIG5lZ2F0aXZlIGhlcmUuCgpZb3UncmUgcmln
aHQsIEkgbWlzcmVhZCBzaXplX3QgYXMgc3NpemVfdCwgc29ycnkuCgpUaGFua3MsCgo+IAo+IFRo
YW5rcywKPiBDaGVuZ2d1YW5nCj4gCj4gLgo+IAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVj
ayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1v
c3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xh
c2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
