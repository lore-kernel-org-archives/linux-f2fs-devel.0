From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: Segment size
Date: Fri, 09 May 2014 09:11:56 +0900
Message-ID: <1399594316.13268.63.camel@kjgkr>
References: <CAN3U_kWiD81+cV3JxNhTKvTZFjFtmeCtzmohOTzVxX3+WqdgbA@mail.gmail.com>
	<1399421084.13268.13.camel@kjgkr>
	<CAN3U_kVBpbuaOQn6Q=obm5GmfOUdCLahWp6DXvUSaYnRj=frvA@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WiYSD-0006pb-89
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 May 2014 00:14:21 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WiYSB-00029T-D5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 May 2014 00:14:21 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N5A0043X5ZNSH60@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 May 2014 09:14:11 +0900 (KST)
In-reply-to: <CAN3U_kVBpbuaOQn6Q=obm5GmfOUdCLahWp6DXvUSaYnRj=frvA@mail.gmail.com>
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

MjAxNC0wNS0wOCAo66qpKSwgMTI6NDMgLTA3MDAsIFBhdWwgTmk6Cj4gT24gNiBNYXkgMjAxNCAx
NzowNCwgSmFlZ2V1ayBLaW0gPGphZWdldWsua2ltQHNhbXN1bmcuY29tPiB3cm90ZToKPiA+Cj4g
PiBIaSwKPiA+Cj4gPiAyMDE0LTA1LTA0ICjsnbwpLCAyMzo1OSArMDAwMCwgUGF1bCBOaToKPiA+
ID4gSXMgaXQgcG9zc2libGUgdG8gc2V0IGFuIGFyYml0cmFyeSBzZWdtZW50IHNpemU/IEknbSB0
cnlpbmcgdG8gc2V0IGl0Cj4gPiA+IHRvIDEuNU1pQiB0byBtYWtlIGl0IGFsaWduIHdpdGggZXJh
c2UgYmxvY2tzIG9uIGZsYXNoIGNoaXBzIGluIG15IEVWTwo+ID4gPiA4NDAgU1NELgo+ID4KPiA+
IEltcG9zc2libGUuIFRoZSBoYXJkLWNvZGVkIHNlZ21lbnQgc2l6ZSBpcyBmaXhlZCB0byBtYW5h
bmdlIHRoZSB3aG9sZSBGUwo+ID4gbWV0YWRhdGEuCj4gPiBJZiB5b3Ugd2FudCB0byBhZGp1c3Qg
dGhlIHVuZGVybHlpbmcgRlRMIGxheW91dCwgeW91IGNhbiBjaGFuZ2UgdGhlCj4gPiBzZWN0aW9u
IGFuZCB6b25lIHNpemVzLgo+ID4gVGhhbmtzLAo+ID4KWy4uLl0KCj4gSXMgdGhlcmUgYW55IG90
aGVyIHdheSB0byBhdm9pZCB1bmFsaWduZWQgd3JpdGVzIHRvIGVyYXNlIGJsb2NrcyBvbgo+IFRM
QyBmbGFzaCBiYXNlZCBTU0RzPyBBcyBmYXIgYXMgSSBrbm93LCBhbGwgVExDIGZsYXNoIG1lbW9y
eSBoYXMgZXJhc2UKPiBibG9ja3Mgc2l6ZXMgaW4gbXVsdGlwbGVzIG9mIDMuCgpJZiB5b3Ugd2Fu
dCB0byBhbGlnbiBtb3JlIHByZWNpc2VseSB0byB0aGUgc3RvcmFnZSwgeW91IGNhbiBjb25maWd1
cmUKdGhlIHNlY3Rpb24gc2l6ZSBpbiBtdWx0aXBsZXMgb2YgMy4KCkZvciBleGFtcGxlLApta2Zz
LmYyZnMgLXMgMyAkREVWCiAtPiB0aGlzIGNvbmZpZ3VyZXMgdGhlIHNlY3Rpb25zIGNvbnNpc3Rp
bmcgb2YgMyBzZWdtZW50cywgNk1CLgoKVGhhbmtzLAoKLS0gCkphZWdldWsgS2ltClNhbXN1bmcK
CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCklzIHlvdXIgbGVnYWN5IFNDTSBzeXN0ZW0gaG9sZGlu
ZyB5b3UgYmFjaz8gSm9pbiBQZXJmb3JjZSBNYXkgNyB0byBmaW5kIG91dDoKJiMxNDk7IDMgc2ln
bnMgeW91ciBTQ00gaXMgaGluZGVyaW5nIHlvdXIgcHJvZHVjdGl2aXR5CiYjMTQ5OyBSZXF1aXJl
bWVudHMgZm9yIHJlbGVhc2luZyBzb2Z0d2FyZSBmYXN0ZXIKJiMxNDk7IEV4cGVydCB0aXBzIGFu
ZCBhZHZpY2UgZm9yIG1pZ3JhdGluZyB5b3VyIFNDTSBub3cKaHR0cDovL3Auc2YubmV0L3NmdS9w
ZXJmb3JjZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
