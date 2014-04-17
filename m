From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: fix wrong number of max_nid when init
Date: Thu, 17 Apr 2014 16:01:20 +0800
Message-ID: <000001cf5a13$5d8d6620$18a83260$@samsung.com>
References: <000c01cf5a06$46b1ba30$d4152e90$@samsung.com>
	<1397719003.7727.24.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WahHG-0003d8-3r
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 08:02:34 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WahHD-0005yh-UK
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 08:02:34 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N46003Q00ZZAH10@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 17:02:23 +0900 (KST)
In-reply-to: <1397719003.7727.24.camel@kjgkr>
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
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

SGksCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogSmFlZ2V1ayBLaW0gW21h
aWx0bzpqYWVnZXVrLmtpbUBzYW1zdW5nLmNvbV0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTcs
IDIwMTQgMzoxNyBQTQo+IFRvOiBDaGFvIFl1Cj4gQ2M6IGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMu
c291cmNlZm9yZ2UubmV0OyBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsKPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gU3ViamVjdDogUmU6IFtmMmZzLWRldl0gW1BBVENIXSBm
MmZzOiBmaXggd3JvbmcgbnVtYmVyIG9mIG1heF9uaWQgd2hlbiBpbml0Cj4gCj4gSGksCj4gCj4g
MjAxNC0wNC0xNyAo66qpKSwgMTQ6MjcgKzA4MDAsIENoYW8gWXU6Cj4gPiBTaW5jZSBtYXhfbmlk
IHZhbHVlIHdhcyBtaW51cyB0aHJlZSBpbiBwcmV2aW91cyBjb21taXQ6Cj4gPiAnYjYzZGExNWU4
YjQ3NTI0NTAyNmJkZjIwOTY4NTM2ODNmMTg5NzA2YicsIE91ciBsYXN0IHRocmVlIG5pZHMgY291
bGQgbm90IGJlCj4gPiB1c2VkIGV2ZXIsIGJ1dCAwL25vZGUgbmlkL21ldGEgbmlkIGlzIHN0aWxs
IG9jY3VwaWVkLgo+ID4gQW5kIGFsc28gb3VyIHJhX21ldGFfcGFnZXMoKSBjb3VsZCBub3QgcmVh
ZGFoZWFkIHRoZSBsYXN0IGJsb2NrIG9mIE5BVC4KPiAKPiBXaGF0IGlzIHRoZSByb290IHByb2Js
ZW0gaW4gdGhlcmU/CgpUaGUgbGFzdCBvbmUgaXMgdGhlIHJvb3QgcHJvYmxlbSwgSSB3aWxsIHN1
Ym1pdCBhbm90aGVyIHBhdGNoIHRvIGZpeCBpdC4KCj4gSUlSQywgdGhlIG1heF9uaWQgc2hvdWxk
IG5vdCBiZSB0dXJuZWQgYmFjayBzaW5jZSB0aGF0IGNhbiBjYXVzZSBhbgo+IGluZmluaXRlIGxv
b3AgZHVyaW5nIGJ1aWxkX2ZyZWVfbmlkcygpIHVuZGVyIGEgdGVzdCB1c2luZyB3aG9sZSB0aGUK
PiBuaWRzLgoKR290IGl0LCB0aGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24uCgpSZWdhcmRzLgoK
PiAKPiA+IExldCdzIGZpeCB0aGUgd3JvbmcgY2FsY3VsYXRpb24gb2YgdGhpcyB2YWx1ZSwgYW5k
IGxlZnQgdGhlIHJlc2VydmVkIG5pZHMgdGhlcmUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQ2hh
byBZdSA8Y2hhbzIueXVAc2Ftc3VuZy5jb20+Cj4gPiAtLS0KPiA+ICBmcy9mMmZzL25vZGUuYyB8
ICAgIDIgKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9ub2RlLmMgYi9mcy9mMmZzL25vZGUuYwo+
ID4gaW5kZXggODRmOWI3Yi4uM2YwYmI1MCAxMDA2NDQKPiA+IC0tLSBhL2ZzL2YyZnMvbm9kZS5j
Cj4gPiArKysgYi9mcy9mMmZzL25vZGUuYwo+ID4gQEAgLTE4NjAsNyArMTg2MCw3IEBAIHN0YXRp
YyBpbnQgaW5pdF9ub2RlX21hbmFnZXIoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQo+ID4gIAlu
YXRfYmxvY2tzID0gbmF0X3NlZ3MgPDwgbGUzMl90b19jcHUoc2JfcmF3LT5sb2dfYmxvY2tzX3Bl
cl9zZWcpOwo+ID4KPiA+ICAJLyogbm90IHVzZWQgbmlkczogMCwgbm9kZSwgbWV0YSwgKGFuZCBy
b290IGNvdW50ZWQgYXMgdmFsaWQgbm9kZSkgKi8KPiA+IC0Jbm1faS0+bWF4X25pZCA9IE5BVF9F
TlRSWV9QRVJfQkxPQ0sgKiBuYXRfYmxvY2tzIC0gMzsKPiA+ICsJbm1faS0+bWF4X25pZCA9IE5B
VF9FTlRSWV9QRVJfQkxPQ0sgKiBuYXRfYmxvY2tzOwo+ID4gIAlubV9pLT5mY250ID0gMDsKPiA+
ICAJbm1faS0+bmF0X2NudCA9IDA7Cj4gPiAgCW5tX2ktPnJhbV90aHJlc2ggPSBERUZfUkFNX1RI
UkVTSE9MRDsKPiAKPiAtLQo+IEphZWdldWsgS2ltCj4gU2Ftc3VuZwoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpMZWFybiBHcmFwaCBEYXRhYmFzZXMgLSBEb3dubG9hZCBGUkVFIE8nUmVpbGx5IEJv
b2sKIkdyYXBoIERhdGFiYXNlcyIgaXMgdGhlIGRlZmluaXRpdmUgbmV3IGd1aWRlIHRvIGdyYXBo
IGRhdGFiYXNlcyBhbmQgdGhlaXIKYXBwbGljYXRpb25zLiBXcml0dGVuIGJ5IHRocmVlIGFjY2xh
aW1lZCBsZWFkZXJzIGluIHRoZSBmaWVsZCwKdGhpcyBmaXJzdCBlZGl0aW9uIGlzIG5vdyBhdmFp
bGFibGUuIERvd25sb2FkIHlvdXIgZnJlZSBib29rIHRvZGF5IQpodHRwOi8vcC5zZi5uZXQvc2Z1
L05lb1RlY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bGludXgtZjJmcy1kZXZlbAo=
