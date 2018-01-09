From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: Re: [PATCH] f2fs: correct removexattr behavior for null
 valued extended attribute
Date: Tue, 09 Jan 2018 09:59:58 +0000
Message-ID: <20180109095958epcms1p26d0561b455fc99d524d5330f75ed66fd@epcms1p2>
References: <ffbf13bf-2657-761b-51d8-bdc097ba0e97@huawei.com>
 <1515457377-20597-1-git-send-email-daeho.jeong@samsung.com>
 <CGME20180109002241epcas1p46c06112eb4a2beef7ca377cbfe3b6e33@epcms1p2>
Reply-To: daeho.jeong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daeho.jeong@samsung.com>) id 1eYqhb-0005Pt-D2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 10:00:15 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYqhU-0005TZ-AD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 10:00:15 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20180109100000epoutp04764ae72415a4b3d14b5789b9f2d52685~IG-ICPMbK1983219832epoutp04N
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Jan 2018 10:00:00 +0000 (GMT)
In-Reply-To: <ffbf13bf-2657-761b-51d8-bdc097ba0e97@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGksIENoYW8KCj4gSG93wqBjYW7CoHdlwqBidWlsZMKgc3VjaMKgeGF0dHLCoGVudHJ5wqB3aG9z
ZcKgdmFsdWXCoGlzwqBOVUxMP8KgQ2FuwqB5b3XCoGdpdmXCoGFuDQo+IHJlcHJvZHVjZXLCoGV4
YW1wbGU/DQrCoA0KV2UgdXNlZCBzZXR4YXR0ciBzeXN0ZW0gY2FsbCB3aXRoICJ2YWx1ZSIgYXMg
TlVMTCBhbmQgInNpemUiIGFzIDAuDQpBbmQgdGhlbiB2ZnNfc2V0eGF0dHIgd2lsbCBjaGFuZ2Ug
InZhbHVlIiB0byAiIiBhbmQgdHJhbnNmZXIgInZhbHVlIiBhbmQgInNpemUiDQp0byBmMmZzX3Nl
dHhhdHRyKCkuDQoNClRoYW5rcywKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhl
IHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdp
bmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1k
ZXZlbAo=
