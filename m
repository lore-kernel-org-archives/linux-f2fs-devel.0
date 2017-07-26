From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: fix printing block adresses
Date: Wed, 26 Jul 2017 14:25:46 -0700
Message-ID: <20170726212546.GA66153@jaegeuk-macbookpro.roam.corp.google.com>
References: <1501089397-10422-1-git-send-email-piosoko1@student.pg.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1daToY-0008Df-7y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jul 2017 21:25:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1daToX-0003j1-8u
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jul 2017 21:25:54 +0000
Content-Disposition: inline
In-Reply-To: <1501089397-10422-1-git-send-email-piosoko1@student.pg.edu.pl>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Piotr =?utf-8?Q?Soko=C5=82owski?= <piosoko1@student.pg.edu.pl>
Cc: magstach@student.pg.edu.pl, jackupie@student.pg.edu.pl, linux-f2fs-devel@lists.sourceforge.net

SGkgUGlvdHIsCgpJJ3ZlIG1vZGlmaWVkIHlvdXIgcGF0Y2ggdG8gcmVzb2x2ZSBzb21lIGNvbmZs
aWN0cyBhbmQgYWRkIHlvdXIgU29CLgpDb3VsZCB5b3UgdGFrZSBhIGxvb2sgYXQgdGhpcz8KCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2phZWdldWsvZjJm
cy10b29scy5naXQvY29tbWl0Lz9oPWRldi10ZXN0JmlkPTViY2Q3NDQ2OGY5YzEyYjBlYjY2YThi
M2Y1Yjc2MjMzYzBmMzhmYjgKClRoYW5rcywKCk9uIDA3LzI2LCBQaW90ciBTb2tvxYJvd3NraSB3
cm90ZToKPiBUaGlzIHBhdGNoIGFsbG93cyBwcm9wZXJseSBwcmludGluZyBhbGwgYWRkcmVzc2Vz
IGluIGFuIGlub2RlLgo+IEl0IGlzIHVzZWZ1bCBpbiBjb21tYW5kcyBsaWtlIGR1bXAuZjJmcy4K
PiAKPiAtLS0KPiAgZnNjay9tb3VudC5jIHwgMTAgKysrKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9mc2Nr
L21vdW50LmMgYi9mc2NrL21vdW50LmMKPiBpbmRleCBhMGIwYmVhLi40ZDdhYzZhIDEwMDY0NAo+
IC0tLSBhL2ZzY2svbW91bnQuYwo+ICsrKyBiL2ZzY2svbW91bnQuYwo+IEBAIC05MiwxMiArOTIs
MTQgQEAgdm9pZCBwcmludF9pbm9kZV9pbmZvKHN0cnVjdCBmMmZzX2lub2RlICppbm9kZSwgaW50
IG5hbWUpCj4gIAlESVNQX3UzMihpbm9kZSwgaV9hZGRyWzJdKTsJLyogUG9pbnRlcnMgdG8gZGF0
YSBibG9ja3MgKi8KPiAgCURJU1BfdTMyKGlub2RlLCBpX2FkZHJbM10pOwkvKiBQb2ludGVycyB0
byBkYXRhIGJsb2NrcyAqLwo+ICAKPiAtCWZvciAoaSA9IDQ7IGkgPCBBRERSU19QRVJfSU5PREUo
aW5vZGUpOyBpKyspIHsKPiArCWZvciAoaSA9IDA7IGkgPCBBRERSU19QRVJfSU5PREUoaW5vZGUp
OyBpKyspIHsKPiAgCQlpZiAoaW5vZGUtPmlfYWRkcltpXSAhPSAweDApIHsKPiAtCQkJcHJpbnRm
KCJpX2FkZHJbMHgleF0gcG9pbnRzIGRhdGEgYmxvY2tcclx0XHRbMHglNHhdXG4iLAo+IC0JCQkJ
CWksIGxlMzJfdG9fY3B1KGlub2RlLT5pX2FkZHJbaV0pKTsKPiAtCQkJYnJlYWs7Cj4gKwkJCWlm
IChpPjMpCj4gKwkJCQlwcmludGYoImlfYWRkclsweCV4XSBwb2ludHMgZGF0YSBibG9ja1x0XHRb
MHglNHhdXG4iLAo+ICsJCQkJCQlpLCBsZTMyX3RvX2NwdShpbm9kZS0+aV9hZGRyW2ldKSk7Cj4g
IAkJfQo+ICsJCWVsc2UKPiArCQkJYnJlYWs7Cj4gIAl9Cj4gIAo+ICAJRElTUF91MzIoaW5vZGUs
IGlfbmlkWzBdKTsJLyogZGlyZWN0ICovCj4gLS0gCj4gMi4xLjQKPiAKPiAKPiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiBDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25l
IG9mIHRoZSB3b3JsZCdzIG1vc3QKPiBlbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmch
IGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRo
ZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8v
c2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
