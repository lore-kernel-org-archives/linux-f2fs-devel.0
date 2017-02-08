From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/6] f2fs: add a kernel thread to issue
 discard commands asynchronously
Date: Wed, 8 Feb 2017 08:02:07 -0800
Message-ID: <20170208160207.GA14621@infradead.org>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
	<20170112224407.54026-5-jaegeuk@kernel.org>
	<20170113080159.GB31777@infradead.org>
	<20170113191211.GB1301@jaegeuk.local>
	<20170116173220.GA2199@infradead.org>
	<20170205085947.GA25319@infradead.org>
	<20170207034403.GA24935@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+add76be85c7e68b62602+4917+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1cbUhI-0000D1-49 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Feb 2017 16:02:20 +0000
Received: from bombadil.infradead.org ([65.50.211.133])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cbUhF-0000ii-L4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Feb 2017 16:02:20 +0000
Content-Disposition: inline
In-Reply-To: <20170207034403.GA24935@jaegeuk.local>
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
Cc: linux-fsdevel@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net

T24gTW9uLCBGZWIgMDYsIDIwMTcgYXQgMDc6NDQ6MDNQTSAtMDgwMCwgSmFlZ2V1ayBLaW0gd3Jv
dGU6Cj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlIGR1ZSB0byB0aGUgdHJhdmVsLgo+IAo+
IFdoZW4gZG9pbmcgZnN0cmltIHdpdGggYSBmcmVzaCBmMmZzIGltYWdlIGZvbWF0dGVkIG9uIElu
dGVsIE5WTWUgU1NEIHdob3NlCj4gbW9kZWwgbmFtZSBpcyBTU0RQRTJNVzAxMlQ0LCBJJ3ZlIGdv
dCB0aGUgZm9sbG93aW5nIHRyYWNlLgoKPHNuaXA+Cgo+IFNvLCBJIGludmVzdGlnYXRlZCB3aHkg
YmxvY2tfcnFfY29tcGxldGUoKSBoYXBwZW5lZCBpbiBtb3JlIGRldGFpbC4KPiAKPiBUaGUgcm9v
dC1jYXVzZWQgY2FsbCBwYXRoIGxvb2tzIGxpa2U6Cj4gIC0gc3VibWl0X2Jpbwo+ICAgLSBnZW5l
cmljX21ha2VfcmVxdWVzdAo+ICAgIC0gcS0+bWFrZV9yZXF1ZXN0X2ZuCj4gICAgIC0gYmxrX21x
X21ha2VfcmVxdWVzdAo+ICAgICAgLSBibGtfbXFfbWFwX3JlcXVlc3QKPiAgICAgICAtIGJsa19t
cV9hbGxvY19yZXF1ZXN0Cj4gICAgICAgIC0gYmxrX21xX2dldF90YWcKPiAgICAgICAgIC0gX19i
bGtfbXFfZ2V0X3RhZwo+ICAgICAgICAgIC0gYnRfZ2V0Cj4gICAgICAgICAgIC0gYmxrX21xX3J1
bl9od19xdWV1ZQo+ICAgICAgICAgICAtIGZpbmlzaF93YWl0Cj4gICAgICAgICAgIC0tPiB0aGlz
IHdhaXRzIGZvciBwZW5kaW5nIDggZGlzY2FyZCBiaW9zIQoKWW91J3JlIGJsb2NraW5nIG9uIHRh
ZyBhbGxvY2F0aW9uLiAgSG93IG1hbnkgdGFncyBwZXIgcXVldWUgZG9lcwp5b3VyIGRldmljZSBo
YXZlPywgZS5nLiBkbyBhCgpjYXQgL3N5cy9ibG9jay9udm1lMG4xL21xLzAvbnJfdGFncwoKPiBJ
dCBzZWVtcyB0aGUgcHJvYmxlbSBjb21lcyBmcm9tIHRoZSBzdG9yYWdlIHByb2Nlc3NpbmcgZGlz
Y2FyZCBjb21tYW5kcyB0b28KPiBzbG93bHkgY29tcGFyaW5nIHRvIG5vcm1hbCByZWFkL3dyaXRl
IElPcy4KPiAKPiBBbnkgdGhvdWdodHM/CgpEZWFsbG9jYXRlIGlzIGFsd2F5cyBnb2luZyB0byBi
ZSBhbiBleGNlcHRpb24gcGF0aCBjb21wYXJlZCB0byBub3JtYWwKcmVhZC93cml0ZeKApiBidXQg
anVzdCBob3cgbXVjaCBzbG93ZXIgaXMgZ29pbmcgdG8gYmUgZGV2aWNlCmRlcGVuZGVudC4KCk9u
ZSBvcHRpb24gd291bGQgYmUgdG8gcmV1c2UgdGhlIG51bWJlciBvZiBkaXNjYXJkcywgZm9yIHRo
YXQgY2FuIHlvdQp0cnkgdGhlIHNlcmllcyBoZXJlIHRvIHN1cHBvcnQgdmVjdG9yZWQgZGlzY2Fy
ZHM6CgpodHRwOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL2Jsb2NrLmdpdC9zaG9ydGxv
Zy9yZWZzL2hlYWRzL3ZlY3RvcmVkLWRpc2NhcmQtZm9yLWF4Ym9lCgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5IG9uIG9uZSBvZiB0aGUg
d29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoRG90Lm9yZyEgaHR0cDovL3Nk
bS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
