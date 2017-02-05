From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/6] f2fs: add a kernel thread to issue
 discard commands asynchronously
Date: Sun, 5 Feb 2017 00:59:47 -0800
Message-ID: <20170205085947.GA25319@infradead.org>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
	<20170112224407.54026-5-jaegeuk@kernel.org>
	<20170113080159.GB31777@infradead.org>
	<20170113191211.GB1301@jaegeuk.local>
	<20170116173220.GA2199@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+7c9ed557eb952ccf5513+4914+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1caIfv-0008OX-Jv for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 05 Feb 2017 08:59:59 +0000
Received: from bombadil.infradead.org ([65.50.211.133])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1caIfu-0005IJ-HP
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 05 Feb 2017 08:59:59 +0000
Content-Disposition: inline
In-Reply-To: <20170116173220.GA2199@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

T24gTW9uLCBKYW4gMTYsIDIwMTcgYXQgMDk6MzI6MjBBTSAtMDgwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6Cj4gT24gRnJpLCBKYW4gMTMsIDIwMTcgYXQgMTE6MTI6MTFBTSAtMDgwMCwgSmFl
Z2V1ayBLaW0gd3JvdGU6Cj4gPiBQcmV2aW91c2x5LCBJJ3ZlIGRvbmUgdG8gaXNzdWUgZGlzY2Fy
ZCBiaW9zIGFzeW5jaHJvbm91c2x5LiBCdXQgdGhlIHByb2JsZW0gdGhhdAo+ID4gSSd2ZSBnb3Qg
aXMgdGhhdCB3YXMgbm90IGVub3VnaC4gV2hlbiB0ZXN0aW5nIG52bWUgU1NEIHdpdGggbm9vcCBJ
TyBzY2hlZHVsZXIsCj4gPiBzdWJtaXRfYmlvKCkgd2FzIGJsb2NrZWQgYXQgZXZlcnkgOCBhc3lu
YyBkaXNjYXJkIGJpb3MsIHJlc3VsdGluZyBpbiB2ZXJ5IHNsb3cKPiA+IGNoZWNrcG9pbnQgcHJv
Y2VzcyB3aGljaCBibG9ja3MgbW9zdCBvZiBvdGhlciBGUyBvcGVyYXRpb25zLgo+IAo+IFdoZXJl
IGRvZXMgaXQgYmxvY2s/ICBBcmUgeW91IHJ1bm5pbmcgb3V0IG9mIHJlcXVlc3Q/ICBXaGF0IGRy
aXZlciBpcwo+IHRoaXMgb24gdG9wIG9mPwoKUGluZz8gIEknbSBjdXJyZW50bHkgc3BlbmRpbmcg
YSBsb3Qgb2YgZWZmb3J0IG9uIGZzIGFuZCBibG9jayBk0ZZzY2FyZApjb2RlLCBhbmQgSSdkIGxp
a2UgdG8gbWFrZSBzdXJlIHdlIGdldCBjb21tb24gaW5mcmFzdHJ1Y3R1cmUgaW5zdGVhZApvZiBs
b2NhbCBoYWNrcy4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQg
dGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBz
aXRlcywgU2xhc2hEb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
