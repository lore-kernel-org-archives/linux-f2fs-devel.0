From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: fix wrong number of max_nid when init
Date: Thu, 17 Apr 2014 16:16:43 +0900
Message-ID: <1397719003.7727.24.camel@kjgkr>
References: <000c01cf5a06$46b1ba30$d4152e90$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wagb0-0001g6-KQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 07:18:54 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wagay-0004Yv-Mk
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 07:18:54 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4500G0MYZ8O3C0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 16:18:44 +0900 (KST)
In-reply-to: <000c01cf5a06$46b1ba30$d4152e90$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDE0LTA0LTE3ICjrqqkpLCAxNDoyNyArMDgwMCwgQ2hhbyBZdToKPiBTaW5jZSBtYXhf
bmlkIHZhbHVlIHdhcyBtaW51cyB0aHJlZSBpbiBwcmV2aW91cyBjb21taXQ6Cj4gJ2I2M2RhMTVl
OGI0NzUyNDUwMjZiZGYyMDk2ODUzNjgzZjE4OTcwNmInLCBPdXIgbGFzdCB0aHJlZSBuaWRzIGNv
dWxkIG5vdCBiZQo+IHVzZWQgZXZlciwgYnV0IDAvbm9kZSBuaWQvbWV0YSBuaWQgaXMgc3RpbGwg
b2NjdXBpZWQuCj4gQW5kIGFsc28gb3VyIHJhX21ldGFfcGFnZXMoKSBjb3VsZCBub3QgcmVhZGFo
ZWFkIHRoZSBsYXN0IGJsb2NrIG9mIE5BVC4KCldoYXQgaXMgdGhlIHJvb3QgcHJvYmxlbSBpbiB0
aGVyZT8KSUlSQywgdGhlIG1heF9uaWQgc2hvdWxkIG5vdCBiZSB0dXJuZWQgYmFjayBzaW5jZSB0
aGF0IGNhbiBjYXVzZSBhbgppbmZpbml0ZSBsb29wIGR1cmluZyBidWlsZF9mcmVlX25pZHMoKSB1
bmRlciBhIHRlc3QgdXNpbmcgd2hvbGUgdGhlCm5pZHMuCgo+IExldCdzIGZpeCB0aGUgd3Jvbmcg
Y2FsY3VsYXRpb24gb2YgdGhpcyB2YWx1ZSwgYW5kIGxlZnQgdGhlIHJlc2VydmVkIG5pZHMgdGhl
cmUuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhbzIueXVAc2Ftc3VuZy5jb20+Cj4g
LS0tCj4gIGZzL2YyZnMvbm9kZS5jIHwgICAgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9ub2RlLmMg
Yi9mcy9mMmZzL25vZGUuYwo+IGluZGV4IDg0ZjliN2IuLjNmMGJiNTAgMTAwNjQ0Cj4gLS0tIGEv
ZnMvZjJmcy9ub2RlLmMKPiArKysgYi9mcy9mMmZzL25vZGUuYwo+IEBAIC0xODYwLDcgKzE4NjAs
NyBAQCBzdGF0aWMgaW50IGluaXRfbm9kZV9tYW5hZ2VyKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNi
aSkKPiAgCW5hdF9ibG9ja3MgPSBuYXRfc2VncyA8PCBsZTMyX3RvX2NwdShzYl9yYXctPmxvZ19i
bG9ja3NfcGVyX3NlZyk7Cj4gIAo+ICAJLyogbm90IHVzZWQgbmlkczogMCwgbm9kZSwgbWV0YSwg
KGFuZCByb290IGNvdW50ZWQgYXMgdmFsaWQgbm9kZSkgKi8KPiAtCW5tX2ktPm1heF9uaWQgPSBO
QVRfRU5UUllfUEVSX0JMT0NLICogbmF0X2Jsb2NrcyAtIDM7Cj4gKwlubV9pLT5tYXhfbmlkID0g
TkFUX0VOVFJZX1BFUl9CTE9DSyAqIG5hdF9ibG9ja3M7Cj4gIAlubV9pLT5mY250ID0gMDsKPiAg
CW5tX2ktPm5hdF9jbnQgPSAwOwo+ICAJbm1faS0+cmFtX3RocmVzaCA9IERFRl9SQU1fVEhSRVNI
T0xEOwoKLS0gCkphZWdldWsgS2ltClNhbXN1bmcKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxl
YXJuIEdyYXBoIERhdGFiYXNlcyAtIERvd25sb2FkIEZSRUUgTydSZWlsbHkgQm9vawoiR3JhcGgg
RGF0YWJhc2VzIiBpcyB0aGUgZGVmaW5pdGl2ZSBuZXcgZ3VpZGUgdG8gZ3JhcGggZGF0YWJhc2Vz
IGFuZCB0aGVpcgphcHBsaWNhdGlvbnMuIFdyaXR0ZW4gYnkgdGhyZWUgYWNjbGFpbWVkIGxlYWRl
cnMgaW4gdGhlIGZpZWxkLAp0aGlzIGZpcnN0IGVkaXRpb24gaXMgbm93IGF2YWlsYWJsZS4gRG93
bmxvYWQgeW91ciBmcmVlIGJvb2sgdG9kYXkhCmh0dHA6Ly9wLnNmLm5ldC9zZnUvTmVvVGVjaApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCg==
