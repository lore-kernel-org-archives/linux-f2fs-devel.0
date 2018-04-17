From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: allocate hot_data for atomic write
 more strictly
Date: Tue, 17 Apr 2018 17:52:43 +0800
Message-ID: <eba7f589-8de0-39f8-fc25-8d1ca2f52b44@huawei.com>
References: <1523878456-5058-1-git-send-email-heyunlei@huawei.com>
 <16d8fe6b-5e48-2723-b7df-7f199ecb499c@huawei.com>
 <42B685BFA705F94C860C6DD0752F056548373AE8@DGGEMA503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f8NKu-0003iR-GF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 09:55:40 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8NIJ-00FsEN-VF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 09:55:40 +0000
In-Reply-To: <42B685BFA705F94C860C6DD0752F056548373AE8@DGGEMA503-MBS.china.huawei.com>
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
To: heyunlei <heyunlei@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Zhangdianfang (Euler)" <zhangdianfang@huawei.com>

T24gMjAxOC80LzE3IDE3OjE0LCBoZXl1bmxlaSB3cm90ZToKPiAKPiAKPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogWXVjaGFvIChUKQo+PiBTZW50OiBUdWVzZGF5LCBBcHJp
bCAxNywgMjAxOCA0OjMxIFBNCj4+IFRvOiBoZXl1bmxlaTsgamFlZ2V1a0BrZXJuZWwub3JnOyBs
aW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+PiBDYzogV2FuZ2JpbnRpYW47
IFpoYW5nZGlhbmZhbmcgKEV1bGVyKQo+PiBTdWJqZWN0OiBSZTogW2YyZnMtZGV2XVtQQVRDSF0g
ZjJmczogYWxsb2NhdGUgaG90X2RhdGEgZm9yIGF0b21pYyB3cml0ZSBtb3JlIHN0cmljdGx5Cj4+
Cj4+IE9uIDIwMTgvNC8xNiAxOTozNCwgWXVubGVpIEhlIHdyb3RlOgo+Pj4gSWYgYSBmaWxlIG5v
dCBzZXQgdHlwZSBhcyBob3QsIGhhcyBkaXJ0eSBwYWdlcyBtb3JlIHRoYW4KPj4+IHRocmVzaG9s
ZCA2NCBiZWZvcmUgc3RhcnRpbmcgYXRvbWljIHdyaXRlLCBtYXkgYmUgbG9zZSBob3QKPj4+IGZs
YWcuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWXVubGVpIEhlIDxoZXl1bmxlaUBodWF3ZWkuY29t
Pgo+Pj4gLS0tCj4+PiAgZnMvZjJmcy9maWxlLmMgfCAzICstLQo+Pj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZnMv
ZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYwo+Pj4gaW5kZXggNzllZWVkNS4uYmY2MWUyMCAx
MDA2NDQKPj4+IC0tLSBhL2ZzL2YyZnMvZmlsZS5jCj4+PiArKysgYi9mcy9mMmZzL2ZpbGUuYwo+
Pj4gQEAgLTE2ODUsNyArMTY4NSw2IEBAIHN0YXRpYyBpbnQgZjJmc19pb2Nfc3RhcnRfYXRvbWlj
X3dyaXRlKHN0cnVjdCBmaWxlICpmaWxwKQo+Pj4gIAkJZ290byBvdXQ7Cj4+Pgo+Pj4gIAlzZXRf
aW5vZGVfZmxhZyhpbm9kZSwgRklfQVRPTUlDX0ZJTEUpOwo+Pgo+PiBIb3cgYWJvdXQgbW92aW5n
IHRoaXMgYmVsb3cgaW5jX3N0YXQgdGFnPyBJZiB0aGVyZSBpcyBzdGlsbCBkaXJ0eSBwYWdlLCBm
b3IKPj4gcmVjbGFpbSBwYXRoLCB3ZSBtYXkgcmVkaXJ0eSBwYWdlIHdpdGggYXRvbWljIHdyaXRl
IG1vZGUsIHdlIG5lZWQgdG8gYXZvaWQgdGhhdC4KPj4KPiBXaXRoIGl0o6xtYXliZSBzdGlsbCBo
YXMgZGlydHkgcGFnZXMgYWZ0ZXIgZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZaOsCj4gd2hp
Y2ggYXJlIG5vdCBpbm1lbSBwYWdlcyBhbmQgbWF5YmUgYWZmZWN0IGF0b21pY2l0eT8KCkkganVz
dCBzZW5kIGEgcGF0Y2gsIGNvdWxkIHlvdSBjaGVjayB0aGF0PwoKVGhhbmtzLAoKPiAKPiBUaGFu
a3MuCj4gCj4+PiAtCXNldF9pbm9kZV9mbGFnKGlub2RlLCBGSV9IT1RfREFUQSk7Cj4+PiAgCWYy
ZnNfdXBkYXRlX3RpbWUoRjJGU19JX1NCKGlub2RlKSwgUkVRX1RJTUUpOwo+Pgo+PiBEaXR0by4K
Pj4KPj4gVGhhbmtzLAo+Pgo+Pj4KPj4+ICAJaWYgKCFnZXRfZGlydHlfcGFnZXMoaW5vZGUpKQo+
Pj4gQEAgLTE2OTcsMTEgKzE2OTYsMTEgQEAgc3RhdGljIGludCBmMmZzX2lvY19zdGFydF9hdG9t
aWNfd3JpdGUoc3RydWN0IGZpbGUgKmZpbHApCj4+PiAgCXJldCA9IGZpbGVtYXBfd3JpdGVfYW5k
X3dhaXRfcmFuZ2UoaW5vZGUtPmlfbWFwcGluZywgMCwgTExPTkdfTUFYKTsKPj4+ICAJaWYgKHJl
dCkgewo+Pj4gIAkJY2xlYXJfaW5vZGVfZmxhZyhpbm9kZSwgRklfQVRPTUlDX0ZJTEUpOwo+Pj4g
LQkJY2xlYXJfaW5vZGVfZmxhZyhpbm9kZSwgRklfSE9UX0RBVEEpOwo+Pj4gIAkJZ290byBvdXQ7
Cj4+PiAgCX0KPj4+Cj4+PiAgaW5jX3N0YXQ6Cj4+PiArCXNldF9pbm9kZV9mbGFnKGlub2RlLCBG
SV9IT1RfREFUQSk7Cj4+PiAgCUYyRlNfSShpbm9kZSktPmlubWVtX3Rhc2sgPSBjdXJyZW50Owo+
Pj4gIAlzdGF0X2luY19hdG9taWNfd3JpdGUoaW5vZGUpOwo+Pj4gIAlzdGF0X3VwZGF0ZV9tYXhf
YXRvbWljX3dyaXRlKGlub2RlKTsKPj4+Cj4gCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNr
IG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9z
dAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFz
aGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mMmZzLWRldmVsCg==
