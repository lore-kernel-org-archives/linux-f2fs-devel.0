From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v4] F2FS support
Date: Tue, 15 Dec 2015 10:08:43 -0800
Message-ID: <20151215180843.GA60269@jaegeuk.local>
References: <1427185140-41120-1-git-send-email-jaegeuk@kernel.org>
	<20150403224908.GB25673@jaegeuk-mac02.mot.com>
	<20151119212824.GA11666@jaegeuk.local> <566E7DAA.4010202@gmail.com>
	<20151215003421.GD48918@jaegeuk.local> <566FD090.1080906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a8u1v-0005MU-DY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 18:08:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a8u1u-0008NF-Gy for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 18:08:55 +0000
Content-Disposition: inline
In-Reply-To: <566FD090.1080906@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: The development of GNU GRUB <grub-devel@gnu.org>, linux-f2fs-devel@lists.sourceforge.net

T24gVHVlLCBEZWMgMTUsIDIwMTUgYXQgMTE6MzQ6MjRBTSArMDMwMCwgQW5kcmVpIEJvcnplbmtv
diB3cm90ZToKPiAxNS4xMi4yMDE1IDAzOjM0LCBKYWVnZXVrIEtpbSDQv9C40YjQtdGCOgo+ID4g
Q2hhbmdlIGxvZyBmcm9tIHYzOgo+ID4gIG8gYWRkIGdydWJfdGVzdF9iaXRfbGUoKQo+IC4uLgo+
IAo+ID4gKwo+ID4gK3N0YXRpYyBpbmxpbmUgaW50Cj4gPiArZ3J1Yl9mMmZzX3Rlc3RfYml0X2xl
IChpbnQgbnIsIGNvbnN0IGdydWJfdWludDhfdCAqYWRkcikKPiA+ICt7Cj4gPiArICBjb25zdCBn
cnViX2ludDMyX3QgKnAgPSAoY29uc3QgZ3J1Yl9pbnQzMl90ICopYWRkcjsKPiA+ICsKPiA+ICsg
IG5yID0gbnIgXiAwOwo+IAo+IEl0IGRvZXMgbm90aGluZy4KCkFoLCByaWdodC4KCj4gCj4gPiAr
Cj4gPiArICByZXR1cm4gcFtuciA+PiA1XSAmICgxIDw8IChuciAmIDMxKSk7Cj4gPiArfQo+IAo+
IFdlbGwsIHlvdSBzdGlsbCBtaXNzIHRoZSBwb2ludCAtIGlmIHlvdSBhcmUgd29ya2luZyB3aXRo
IGludGVnZXJzIHlvdQo+IG11c3Qgc2hpZnQgZGlmZmVyZW50bHkgZGVwZW5kaW5nIG9uIHdoZXRo
ZXIgd2UgYXJlIHJ1bm5pbmcgYmlnIG9yIGxpdHRsZQo+IGVuZGlhbi4KCkkganVzdCB0aG91Z2h0
IHRoYXQgaXQgd291bGQgYmUgb2theSB0byBieXBhc3MgMzJiaXRzIGFuZCB0aGVuIGNoZWNrIGl0
cyB0YXJnZXQKbG9jYXRpb24sIHNpbmNlIHdlIGtub3cgaXQgaXMgTEUuCkluZGVlZCwgSSB3YXMg
d3JvbmcgdGhhdCB5b3VyIGNvbmNlcm4gd2FzIHRoaXMgbGluZSB3aWxsIGJlIGNvbnZlcnRlZCB0
byBCRSB3aGVuCkNQVSBsb2FkcyB0aGlzIDMyLWJpdCB2YWx1ZS4KCj4gQnV0IGFzIEkgbWVudGlv
bmVkIGJlZm9yZSwgd2Uga25vdyB0aGF0IGJpdG1hcCBpcyBsaXR0bGUgZW5kaWFuIHNvIHdlCj4g
Y2FuIHdvcmsgd2l0aCBieXRlcyBhbmQgYmUgaW5kZXBlbmRlbnQgb2YgYnl0ZSBvcmRlci4gQ291
bGQgeW91IHRlc3QgaWYKPiB0aGlzIHdvcmtzIGZvciB5b3U6Cj4gCj4gc3RhdGljIGlubGluZSBp
bnQKPiBncnViX2YyZnNfdGVzdF9iaXRfbGUgKGludCBuciwgY29uc3QgZ3J1Yl91aW50OF90ICph
ZGRyKQo+IHsKPiAgIHJldHVybiBhZGRyW25yID4+IDNdICYgKDEgPDwgKG5yICYgNykpOwo+IH0K
CkFjdHVhbGx5LCBJIHRlc3RlZCB0aGlzIGJlZm9yZSwgYnV0IEkgZ290IHNvbWVob3cgZmFpbHVy
ZSwgc28gdHJpZWQgdGhpcyBvbmUuCk9uY2UgSSd2ZSBjaGVja2VkIGJpdG1hcCBjb250ZW50cyBp
biBtb3JlIGRldGFpbHMsIEkgcmVhbGl6ZWQgdGhhdCB0aGlzIHNob3VsZApiZSBhIGNvcnJlY3Qg
d2F5OyBJIGNvbmZpcm1lZCB0aGF0IHRoaXMgaGFzIG5vIHByb2JsZW0uCgpJJ2xsIHNlbmQgYW5v
dGhlciBwYXRjaC4KVGhhbmsgeW91IHNvIG11Y2gsCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
