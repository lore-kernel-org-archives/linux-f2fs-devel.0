From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs.fsck] status report show fails
Date: Tue, 2 Sep 2014 21:28:07 -0700
Message-ID: <20140903042807.GA72472@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <CAOWmdGMyHzm2exVPKi7Gd1EZc9vKtVQV8W92=2H=nR6HCH7Tew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XP2B6-0001js-N8
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 04:28:16 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XP2B4-0005V4-Lj for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 04:28:16 +0000
Content-Disposition: inline
In-Reply-To: <CAOWmdGMyHzm2exVPKi7Gd1EZc9vKtVQV8W92=2H=nR6HCH7Tew@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Petar =?utf-8?Q?Koreti=C4=87?= <petar.koretic@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgpKdXN0IGZvciBub3RlLCBJIGltcGxlbWVudGVkIGZzY2suZjJmcyB3aGljaCBmaXhlcyBh
bnkgZjJmcyBjb3JydXB0aW9uLgoKVGhhbmtzLAoKT24gRnJpLCBKdWwgMTEsIDIwMTQgYXQgMTE6
MTg6MTBQTSArMDIwMCwgUGV0YXIgS29yZXRpxIcgd3JvdGU6Cj4gSGkgZ3V5cy4KPiAKPiBJJ3Zl
IGJlZW4gdXNpbmcgZjJmcyBvbiBteSBwcmltYXJ5IFNTRCBkaXNrIGFuZCBsYXB0b3AgZnJvbSBB
cHJpbCAxNywgMjAxMy4KPiAKPiBJIHJlYWxseSBkaWRuJ3QgaGF2ZSBhbnkgcHJvYmxlbXMgYnV0
IGxhdGVseSBJJ3ZlIHN0YXJ0ZWQgdG8gc2VlIHNvbWUuCj4gRm9yIGV4YW1wbGUsIGRhdGEgaXMg
bm90IGJlaW5nIHNhdmVkIG9yIGFmdGVyIHJlYm9vdCBvbGQgZGF0YSBpcyBsb2FkZWQuCj4gSSBo
YXZlbid0IHJlYWxseSB0YWtlbiBhIGRlZXBlciBsb29rIGludG8gaXQgeWV0IGJ1dCB0aGF0J3Mg
bm90IGRpcmVjdGx5Cj4gd2h5IEknbSBwb3N0aW5nLgo+IAo+IFRvZGF5IEkgZmluYWxseSBydW4g
ZnNjay4gSW4gdGhlIG91dHB1dCBJIGdvdCBhbGwgZmFpbHMgZXhjZXB0Ogo+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+IFtGU0NLXSBIYXJkIGxpbmsgY2hlY2tpbmcgZm9yIHJlZ3VsYXIgZmlsZQo+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+IHdoaWNoIHdhcyB0aGUgb25seSBvbmUgd2l0aCAnW09rLi4uXScgc3RhdHVzLgo+IAo+
IEFzIGZhciBhcyBJIGtub3cgYW5kIGNhbiBzZWUgZnJvbSBnaXQgbG9ncyBmc2NrCj4gZG9lc24n
dCB5ZXQgaGF2ZSBhYmlsaXR5IHRvIGZpeCBwcm9ibGVtcy4KPiAKPiBKdXN0IHRvIG1lbnRpb24g
Y3VycmVudGx5IEkgaGF2ZSBpdCBtb3VudGVkIHdpdGg6Cj4gcncscmVsYXRpbWUsZGlzY2FyZCxi
YWNrZ3JvdW5kX2djPW9mZixub2FjbCxub3VzZXJfeGF0dHIKPiAKPiBTbyB3aGF0IGFyZSB0aGVz
ZSBmYWlscyB0ZWxsaW5nIG1lIGFuZCB3aGF0Cj4gYXJlIG15IG9wdGlvbnM/Cj4gCj4gVGhhbmtz
LAo+IFBldGFyCgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tClNsYXNoZG90IFRWLiAgClZpZGVvIGZvciBOZXJkcy4gIFN0dWZm
IHRoYXQgbWF0dGVycy4KaHR0cDovL3R2LnNsYXNoZG90Lm9yZy8KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
