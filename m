From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] f2fs: Reduce zoned block device memory usage
Date: Mon, 4 Mar 2019 10:46:33 +0100
Message-ID: <bae73801-92f5-f7a0-c6a0-941c90219866@suse.de>
References: <20190304070416.13429-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jthumshirn@suse.de>) id 1h0kBH-0000tt-7m
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 09:46:43 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h0kBF-009OaR-7x
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 09:46:43 +0000
In-Reply-To: <20190304070416.13429-1-damien.lemoal@wdc.com>
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
To: Damien Le Moal <damien.lemoal@wdc.com>, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Matias Bjorling <matias.bjorling@wdc.com>

SGkgRGFtaWVuLAoKT24gMDQvMDMvMjAxOSAwODowNCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj4g
QEAgLTI3NjUsOSArMjc2NSwxMSBAQCBzdGF0aWMgaW50IGluaXRfYmxrel9pbmZvKHN0cnVjdCBm
MmZzX3NiX2luZm8gKnNiaSwgaW50IGRldmkpCj4gIAlpZiAobnJfc2VjdG9ycyAmIChiZGV2X3pv
bmVfc2VjdG9ycyhiZGV2KSAtIDEpKQo+ICAJCUZERVYoZGV2aSkubnJfYmxreisrOwo+ICAKPiAt
CUZERVYoZGV2aSkuYmxrel90eXBlID0gZjJmc19rbWFsbG9jKHNiaSwgRkRFVihkZXZpKS5ucl9i
bGt6LAo+IC0JCQkJCQkJCUdGUF9LRVJORUwpOwo+IC0JaWYgKCFGREVWKGRldmkpLmJsa3pfdHlw
ZSkKPiArCUZERVYoZGV2aSkuYmxrel9zZXEgPSBmMmZzX2t6YWxsb2Moc2JpLAo+ICsJCQkJCUJJ
VFNfVE9fTE9OR1MoRkRFVihkZXZpKS5ucl9ibGt6KQo+ICsJCQkJCSogc2l6ZW9mKHVuc2lnbmVk
IGxvbmcpLAo+ICsJCQkJCUdGUF9LRVJORUwpOwo+ICsJaWYgKCFGREVWKGRldmkpLmJsa3pfc2Vx
KQo+ICAJCXJldHVybiAtRU5PTUVNOwoKTm90IHNvIHN1cmUgYWJvdXQgRjJGUyBpbnRlcm5hbHMs
IGJ1dCB0aGVyZSBpcyBhIGJpdG1hcF96YWxsb2MoKSBpbiB0aGUKbm9ybWFsIGtlcm5lbCBsaWJy
YXJ5LgoKQnl0ZSwKCUpvaGFubmVzCi0tIApKb2hhbm5lcyBUaHVtc2hpcm4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgU1VTRSBMYWJzIEZpbGVzeXN0ZW1zCmp0aHVtc2hpcm5Ac3VzZS5kZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODkKU1VTRSBMSU5V
WCBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKR0Y6IEZlbGl4IEltZW5kw7Zy
ZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbgpIUkIgMjEyODQgKEFHIE7DvHJuYmVy
ZykKS2V5IGZpbmdlcnByaW50ID0gRUMzOCA5Q0FCIEMyQzQgRjI1RCA4NjAwIEQwRDAgMDM5MyA5
NjlEIDJENzYgMDg1MAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
