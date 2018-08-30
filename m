From: cgxu519 <cgxu519@gmx.com>
Subject: Re: [PATCH] f2fs: add additional sanity check in
 f2fs_acl_from_disk()
Date: Fri, 31 Aug 2018 00:19:18 +0800
Message-ID: <59f106bd-50d8-8f82-f573-1d025ad19f7d@gmx.com>
References: <20180830133331.5503-1-cgxu519@gmx.com>
 <ab67166f-aa58-8a64-0672-c94e8a143ae0@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1fvPfg-0002iI-NY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 16:19:48 +0000
Received: from mout.gmx.net ([212.227.17.22])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fvPfc-003Sff-VP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 16:19:48 +0000
In-Reply-To: <ab67166f-aa58-8a64-0672-c94e8a143ae0@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Ck9uIDA4LzMwLzIwMTggMTE6NDEgUE0sIENoYW8gWXUgd3JvdGU6Cj4gSGkgQ2hlbmdndWFuZywK
Pgo+IE9uIDIwMTgvOC8zMCAyMTozMywgQ2hlbmdndWFuZyBYdSB3cm90ZToKPj4gQWRkIGFkZGl0
aW5hbCBzYW5pdHkgY2hlY2sgZm9yIGlycmVndWxhciBjYXNlKGUuZy4gY29ycnVwdGlvbikuCj4+
IElmIHNpemUgb2YgZXh0ZW5kZWQgYXR0cmlidXRpb24gaXMgc21hbGxlciB0aGFuIHNpemUgb2Yg
YWNsIGhlYWRlciwKPj4gdGhlbiByZXR1cm4gLUVJTlZBTC4KPj4KPj4gU2lnbmVkLW9mZi1ieTog
Q2hlbmdndWFuZyBYdSA8Y2d4dTUxOUBnbXguY29tPgo+PiAtLS0KPj4gICBmcy9mMmZzL2FjbC5j
IHwgMyArKysKPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYg
LS1naXQgYS9mcy9mMmZzL2FjbC5jIGIvZnMvZjJmcy9hY2wuYwo+PiBpbmRleCAxMTE4MjQxOTlh
ODguLjc5ZTllYTc3MzA3MCAxMDA2NDQKPj4gLS0tIGEvZnMvZjJmcy9hY2wuYwo+PiArKysgYi9m
cy9mMmZzL2FjbC5jCj4+IEBAIC01Myw2ICs1Myw5IEBAIHN0YXRpYyBzdHJ1Y3QgcG9zaXhfYWNs
ICpmMmZzX2FjbF9mcm9tX2Rpc2soY29uc3QgY2hhciAqdmFsdWUsIHNpemVfdCBzaXplKQo+PiAg
IAlzdHJ1Y3QgZjJmc19hY2xfZW50cnkgKmVudHJ5ID0gKHN0cnVjdCBmMmZzX2FjbF9lbnRyeSAq
KShoZHIgKyAxKTsKPj4gICAJY29uc3QgY2hhciAqZW5kID0gdmFsdWUgKyBzaXplOwo+PiAgIAo+
PiArCWlmIChzaXplIDwgc2l6ZW9mKGYyZnNfYWNsX2hlYWRlcikpCj4+ICsJCXJldHVybiBFUlJf
UFRSKC1FSU5WQUwpOwo+IEkgZ3Vlc3MgYmVsb3cgY29kZXMgaGF2ZSBjaGVja2VkIHRoYXQgYWxy
ZWFkeT8KPgo+IAljb3VudCA9IGYyZnNfYWNsX2NvdW50KHNpemUpOwo+IAlpZiAoY291bnQgPCAw
KQo+IAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7CgpIaSBDaGFvLAoKVGhhbmtzIGZvciBwcm9t
cHQgcmVwbHkuCgpJIHN0aWxsIHRoaW5rIGluIGEgcmFyZSBjYXNlLCBpdCBjYW4gcGFzcyB0aGUg
Y2hlY2sgaW4gZjJmc19hY2xfY291bnQoKSAKYW5kIGNhdXNlIHVuZXhwZWN0ZWQgYmVoYXZpb3Iu
CgpGb3IgZXhhbXBsZSwgbGlrZSBiZWxvdyBjb2RlIHBhdGggaW4gZjJmc19hY2xfY291bnQoKS4K
Ci0+IGlmIChzIDwgMCkgewogwqDCoMKgwqAgwqAgwqAgwqDCoCBpZiAoc2l6ZSAlIHNpemVvZihz
dHJ1Y3QgZjJmc19hY2xfZW50cnlfc2hvcnQpKQogwqAgwqAgwqAgwqAgwqAgwqDCoCDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLTE7Ci0+IMKgIMKgwqDCoMKgIHJldHVybiBzaXplIC8gc2l6ZW9mKHN0
cnVjdCBmMmZzX2FjbF9lbnRyeV9zaG9ydCk7Cn0KCgpUaGFua3MsCkNoZW5nZ3VhbmcKCgoKCgoK
CgoKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNv
bW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBT
bGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
