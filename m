From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: Segment size
Date: Wed, 07 May 2014 09:04:44 +0900
Message-ID: <1399421084.13268.13.camel@kjgkr>
References: <CAN3U_kWiD81+cV3JxNhTKvTZFjFtmeCtzmohOTzVxX3+WqdgbA@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WhpO8-0008SI-PI
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 May 2014 00:07:08 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WhpO6-0002Jy-EV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 May 2014 00:07:08 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N5600JLAGBLXQ60@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 May 2014 09:06:58 +0900 (KST)
In-reply-to: <CAN3U_kWiD81+cV3JxNhTKvTZFjFtmeCtzmohOTzVxX3+WqdgbA@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Paul Ni <nikulinpi@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDE0LTA1LTA0ICjsnbwpLCAyMzo1OSArMDAwMCwgUGF1bCBOaToKPiBJcyBpdCBwb3Nz
aWJsZSB0byBzZXQgYW4gYXJiaXRyYXJ5IHNlZ21lbnQgc2l6ZT8gSSdtIHRyeWluZyB0byBzZXQg
aXQKPiB0byAxLjVNaUIgdG8gbWFrZSBpdCBhbGlnbiB3aXRoIGVyYXNlIGJsb2NrcyBvbiBmbGFz
aCBjaGlwcyBpbiBteSBFVk8KPiA4NDAgU1NELgoKSW1wb3NzaWJsZS4gVGhlIGhhcmQtY29kZWQg
c2VnbWVudCBzaXplIGlzIGZpeGVkIHRvIG1hbmFuZ2UgdGhlIHdob2xlIEZTCm1ldGFkYXRhLgpJ
ZiB5b3Ugd2FudCB0byBhZGp1c3QgdGhlIHVuZGVybHlpbmcgRlRMIGxheW91dCwgeW91IGNhbiBj
aGFuZ2UgdGhlCnNlY3Rpb24gYW5kIHpvbmUgc2l6ZXMuClRoYW5rcywKCj4gCj4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCj4gSXMgeW91ciBsZWdhY3kgU0NNIHN5c3RlbSBob2xkaW5nIHlvdSBiYWNr
PyBKb2luIFBlcmZvcmNlIE1heSA3IHRvIGZpbmQgb3V0Ogo+ICYjMTQ5OyAzIHNpZ25zIHlvdXIg
U0NNIGlzIGhpbmRlcmluZyB5b3VyIHByb2R1Y3Rpdml0eQo+ICYjMTQ5OyBSZXF1aXJlbWVudHMg
Zm9yIHJlbGVhc2luZyBzb2Z0d2FyZSBmYXN0ZXIKPiAmIzE0OTsgRXhwZXJ0IHRpcHMgYW5kIGFk
dmljZSBmb3IgbWlncmF0aW5nIHlvdXIgU0NNIG5vdwo+IGh0dHA6Ly9wLnNmLm5ldC9zZnUvcGVy
Zm9yY2UKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXyBM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdCBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldCBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCgotLSAKSmFlZ2V1ayBLaW0KU2Ftc3VuZwoKCgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KSXMgeW91ciBsZWdhY3kgU0NNIHN5c3RlbSBob2xkaW5nIHlvdSBiYWNrPyBKb2lu
IFBlcmZvcmNlIE1heSA3IHRvIGZpbmQgb3V0OgomIzE0OTsgMyBzaWducyB5b3VyIFNDTSBpcyBo
aW5kZXJpbmcgeW91ciBwcm9kdWN0aXZpdHkKJiMxNDk7IFJlcXVpcmVtZW50cyBmb3IgcmVsZWFz
aW5nIHNvZnR3YXJlIGZhc3RlcgomIzE0OTsgRXhwZXJ0IHRpcHMgYW5kIGFkdmljZSBmb3IgbWln
cmF0aW5nIHlvdXIgU0NNIG5vdwpodHRwOi8vcC5zZi5uZXQvc2Z1L3BlcmZvcmNlCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
