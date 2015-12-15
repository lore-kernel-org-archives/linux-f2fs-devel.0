From: Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Re: [PATCH v4] F2FS support
Date: Tue, 15 Dec 2015 11:34:24 +0300
Message-ID: <566FD090.1080906@gmail.com>
References: <1427185140-41120-1-git-send-email-jaegeuk@kernel.org>
	<20150403224908.GB25673@jaegeuk-mac02.mot.com>
	<20151119212824.GA11666@jaegeuk.local> <566E7DAA.4010202@gmail.com>
	<20151215003421.GD48918@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <arvidjaar@gmail.com>) id 1a8l45-0001gk-PF
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 08:34:33 +0000
Received: from mail-lb0-f169.google.com ([209.85.217.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a8l44-0003IW-UM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 08:34:33 +0000
Received: by mail-lb0-f169.google.com with SMTP id cs9so1048217lbb.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 15 Dec 2015 00:34:32 -0800 (PST)
In-Reply-To: <20151215003421.GD48918@jaegeuk.local>
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
Cc: The development of GNU GRUB <grub-devel@gnu.org>, linux-f2fs-devel@lists.sourceforge.net

MTUuMTIuMjAxNSAwMzozNCwgSmFlZ2V1ayBLaW0g0L/QuNGI0LXRgjoKPiBDaGFuZ2UgbG9nIGZy
b20gdjM6Cj4gIG8gYWRkIGdydWJfdGVzdF9iaXRfbGUoKQouLi4KCj4gKwo+ICtzdGF0aWMgaW5s
aW5lIGludAo+ICtncnViX2YyZnNfdGVzdF9iaXRfbGUgKGludCBuciwgY29uc3QgZ3J1Yl91aW50
OF90ICphZGRyKQo+ICt7Cj4gKyAgY29uc3QgZ3J1Yl9pbnQzMl90ICpwID0gKGNvbnN0IGdydWJf
aW50MzJfdCAqKWFkZHI7Cj4gKwo+ICsgIG5yID0gbnIgXiAwOwoKSXQgZG9lcyBub3RoaW5nLgoK
PiArCj4gKyAgcmV0dXJuIHBbbnIgPj4gNV0gJiAoMSA8PCAobnIgJiAzMSkpOwo+ICt9CgpXZWxs
LCB5b3Ugc3RpbGwgbWlzcyB0aGUgcG9pbnQgLSBpZiB5b3UgYXJlIHdvcmtpbmcgd2l0aCBpbnRl
Z2VycyB5b3UKbXVzdCBzaGlmdCBkaWZmZXJlbnRseSBkZXBlbmRpbmcgb24gd2hldGhlciB3ZSBh
cmUgcnVubmluZyBiaWcgb3IgbGl0dGxlCmVuZGlhbi4KCkJ1dCBhcyBJIG1lbnRpb25lZCBiZWZv
cmUsIHdlIGtub3cgdGhhdCBiaXRtYXAgaXMgbGl0dGxlIGVuZGlhbiBzbyB3ZQpjYW4gd29yayB3
aXRoIGJ5dGVzIGFuZCBiZSBpbmRlcGVuZGVudCBvZiBieXRlIG9yZGVyLiBDb3VsZCB5b3UgdGVz
dCBpZgp0aGlzIHdvcmtzIGZvciB5b3U6CgpzdGF0aWMgaW5saW5lIGludApncnViX2YyZnNfdGVz
dF9iaXRfbGUgKGludCBuciwgY29uc3QgZ3J1Yl91aW50OF90ICphZGRyKQp7CiAgcmV0dXJuIGFk
ZHJbbnIgPj4gM10gJiAoMSA8PCAobnIgJiA3KSk7Cn0KCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
