From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: Re: How do I execute regression test for f2fs?
Date: Mon, 04 Sep 2017 01:30:36 +0000
Message-ID: <20170904013036epcms1p41ff336171e7ddbb04be682ed85f9cbce@epcms1p4>
References: <20170901173414.GA6786@jaegeuk-macbookpro.roam.corp.google.com>
 <20170901051947epcms1p477656fd4bbe3f2b8d85d0f57df3c47fd@epcms1p4>
 <CGME20170901051947epcms1p477656fd4bbe3f2b8d85d0f57df3c47fd@epcms1p4>
Reply-To: daeho.jeong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <daeho.jeong@samsung.com>)
 id 1dogE0-00044z-Mn
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Sep 2017 01:30:52 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dogDv-00021L-2S
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Sep 2017 01:30:52 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20170904013038epoutp01895a966f4492f135e26d2a64a53b052e~hBHIsZcyJ2957329573epoutp01j
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  4 Sep 2017 01:30:38 +0000 (GMT)
In-Reply-To: <20170901173414.GA6786@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daeho.jeong@samsung.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

PiBXZWxsLMKgeGZzdGVzdHPCoGFscmVhZHnCoHN1cHBvcnRzwqBmMmZzP8KgWW91wqBjYW7CoHRl
c3TCoGp1c3TCoHdpdGjCoEZTVFlQPWYyZnMuDQrCoA0KPiBUaGFua3MsDQoNCkhpIEphZWdldWss
DQoNCk9rLCBJJ2xsIHRyeSB0aGF0Lg0KVGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlLiA6LSkN
CsKgDQrCoAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNo
IGNvbW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVz
LCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
