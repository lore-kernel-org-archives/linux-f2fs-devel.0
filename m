From: =?UTF-8?B?7KCV64yA7Zi4?= <daeho.jeong@samsung.com>
Subject: Re: =?utf-8?b?562U5aSNOiAgW1BBVENIXSBmMmZzOiBwcmV2ZW50?=
 =?utf-8?q?_newly_created_inode_from_being_dirtied_incorrectly?=
Date: Fri, 12 Jan 2018 07:59:03 +0000
Message-ID: <20180112075903epcms1p4efb58a097d4ac19261aa2e78f2d49091@epcms1p4>
References: <D642D0D599E2434C97EA15C58EE8D70E0832800E@DGGEMA501-MBX.china.huawei.com>
 <1515711960-10781-1-git-send-email-daeho.jeong@samsung.com>
 <CGME20180111230540epcas1p4c839d6dae432f5c1b388b43c17e0f649@epcms1p4>
Reply-To: daeho.jeong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daeho.jeong@samsung.com>) id 1eZuF8-0000X2-Ht
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 12 Jan 2018 07:59:14 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZuF6-0003xs-18
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 12 Jan 2018 07:59:14 +0000
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20180112075904epoutp02e05e652f368582ecadd1c49cc377e062~JARZUJJZs1269612696epoutp02i
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 Jan 2018 07:59:04 +0000 (GMT)
In-Reply-To: <D642D0D599E2434C97EA15C58EE8D70E0832800E@DGGEMA501-MBX.china.huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkgWmhpa2FuZywKCldlIGRyb3BwZWQgdmZzIGNhY2hlcyBwZXJpb2RpY2FsbHkgdG8gcmVwcm9k
dWNlIHRoZSBrZXJuZWwgcGFuaWMgdXNpbmcgZHJvcCBjYWNoZSBjb21tYW5kLgpJIG1lYW4geW91
IGhhdmUgdG8gdHJpZ2dlciBhIGNoZWNrcG9pbnQgcmlnaHQgYWZ0ZXIgZjJmc19tYXJrX2lub2Rl
X2RpcnR5X3N5bmMoKSBmb3IgYSBuZXcgaW5vZGUuCldlIGRvbid0IGhhdmUgYW55IHNwZWNpYWwg
dGVzdCBjYXNlcyBmb3IgdGhhdCBhbmQgd2UganVzdCB0cmlnZ2VyZWQgdG8gZHJvcCBjYWNoZXMg
cGVyaW9kaWNhbGx5LgpJdCB3YXMgbm90IGVhc3kgdG8gcmVwcm9kdWNlIHRoYXQsIGJ1dCBpdCBh
bHdheXMgb2NjdXJycyB3aXRoaW4gMjQgaG91cnMuCgpUaGFua3MsCgrCoA0KLS0tLS0tLS0tIE9y
aWdpbmFsIE1lc3NhZ2UgLS0tLS0tLS0tDQpTZW5kZXIgOiB6aGFuZ3poaWthbmfCoDx6aGFuZ3po
aWthbmcxQGh1YXdlaS5jb20+DQpEYXRlICAgOiAyMDE4LTAxLTEyIDE2OjExIChHTVQrOSkNClRp
dGxlICA6IOetlOWkjTogW2YyZnMtZGV2XSBbUEFUQ0hdIGYyZnM6IHByZXZlbnQgbmV3bHkgY3Jl
YXRlZCBpbm9kZSBmcm9tIGJlaW5nIGRpcnRpZWQgaW5jb3JyZWN0bHkNCsKgDQpIacKgRGFlaG86
DQrCoA0KV2XCoGhhZMKgdHJpZWTCoHRvwqBtc2xlZXAoMTAwMDApwqBhZnRlcsKgZjJmc19tYXJr
X2lub2RlX2RpcnR5X3N5bmMoKcKgaW7CoGNyZWF0aW5nwqBhwqBuZXfCoGZpbGUswqBhbmTCoHRo
ZW7CoHdyaXRlwqBjaGVja3BvaW50wqBpbsKgYW5vdGhlcsKgdGhyZWFkLg0KQnV0wqBpdMKgZGlk
bid0wqBjYXVzZcKgYcKga2VybmVswqBwYW5pYy4NCsKgDQpTb8KgY2FuwqB5b3XCoHRlbGzCoG1l
wqB3aGF0wqB0ZXN0wqBjYXNlwqBkaWTCoHlvdcKgdXNlLMKgYW5kwqBwcm92aWRlwqB0aGXCoGNh
bGzCoHRyYWNlPw0KwqANClRoYW5rwqB5b3UhDQrCoA0KQmVzdMKgcmVnYXJkcywNClpoaWthbmfC
oFpoYW5nDQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVj
aCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRl
cywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5n
IGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
