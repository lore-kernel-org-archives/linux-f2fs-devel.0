From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Questions about commit f2fs: fix to avoid broken of
 dnode block list
Date: Wed, 4 Jul 2018 14:58:08 +0800
Message-ID: <e71300ba-b88e-dc35-b141-6e2cb3464713@huawei.com>
References: <808556C6-7CCE-4D50-9F54-F34072A83AE3@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fabkd-00069b-Gr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Jul 2018 06:58:55 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fabkb-009Py5-7D
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Jul 2018 06:58:55 +0000
In-Reply-To: <808556C6-7CCE-4D50-9F54-F34072A83AE3@gatech.edu>
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
To: "Xu, Wen" <wen.xu@gatech.edu>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkgV2VuLAoKT24gMjAxOC83LzQgMTI6MzQsIFh1LCBXZW4gd3JvdGU6Cj4gSGkgQ2hhbywKPiAK
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaGFvL2xp
bnV4LmdpdC9jb21taXQvP2g9ZjJmcy1kZXYmaWQ9MGFjMjg5MDE1NmFiNTE3YThhYzc5ODQ5ZWU1
YWJhYjdhZDYwMzEwYgo+IAo+IEluIHRoaXMgcGF0Y2g6IGYyZnM6IGZpeCB0byBhdm9pZCBicm9r
ZW4gb2YgZG5vZGUgYmxvY2sgbGlzdAo+IC1pbnQgZjJmc193YWl0X29uX25vZGVfcGFnZXNfd3Jp
dGViYWNrKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgbmlkX3QgaW5vKQo+ICtpbnQgZjJmc193
YWl0X29uX25vZGVfcGFnZXNfd3JpdGViYWNrKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSkKPiAK
PiBZb3UgbW9kaWZ5IGYyZnNfd2FpdF9vbl9ub2RlX3BhZ2VzX3dyaXRlYmFjaygpIGluIGZpbGUu
YyBidXQgc2VlbXMgbm90IG1vZGlmeWluZyB0aGUgZGVjbGFyYXRpb24gaW4gZjJmcy5oPyBXaGlj
aCBtYWtlcyBjb21waWxhdGlvbiBmYWlsZWTigKYKClNvcnJ5LCBteSBtaXN0YWtlLCBpdCBhZGRl
ZCBkZWZpbml0aW9uIGNoYW5nZSBsb2NhdGVkIGluIGYyZnMuaCBpbnRvIGluY29ycmVjdApwYXRj
aCB3aGVuIEkgc3BsaXQgb25lIHBhdGNoIHRvIGJlbG93IHR3bzoKCmYyZnM6IGxldCBjaGVja3Bv
aW50IGZsdXNoIGRub2RlIHBhZ2Ugb2YgcmVndWxhcgpmMmZzOiBmaXggdG8gYXZvaWQgYnJva2Vu
IG9mIGRub2RlIGJsb2NrIGxpc3QKCkkgd2lsbCB1cGRhdGUgdGhlbSwgdGhhbmtzIGZvciB5b3Vy
IHJlcG9ydC4gOikKClRoYW5rcywKCj4gCj4gVGhhbmtzLAo+IC1XZW4KPiAKCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5IG9uIG9uZSBv
ZiB0aGUgd29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoZG90Lm9yZyEgaHR0
cDovL3NkbS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
