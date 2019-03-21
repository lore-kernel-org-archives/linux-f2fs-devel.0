From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/5] f2fs-tools: Fix various compilation
 warnings
Date: Thu, 21 Mar 2019 14:29:26 +0800
Message-ID: <32fa9697-d57c-6d45-2981-70adfabe9af9@huawei.com>
References: <20190318063959.21369-1-damien.lemoal@wdc.com>
 <20190318063959.21369-2-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h6rCq-0007Ve-PM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 06:29:36 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h6rCo-00CzaF-Eg
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 06:29:36 +0000
In-Reply-To: <20190318063959.21369-2-damien.lemoal@wdc.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Damien Le Moal <damien.lemoal@wdc.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

T24gMjAxOS8zLzE4IDE0OjM5LCBEYW1pZW4gTGUgTW9hbCB3cm90ZToKPiBBdm9pZCB2YXJpb3Vz
IGNvbXBpbGF0aW9uIHdhcm5pbmdzIGR1ZSB0byBzdHJuY3B5Ogo+IAo+IGxpYmYyZnMuYzo1OTA6
MzM6IHdhcm5pbmc6IOKAmHNucHJpbnRm4oCZIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIGJlZm9y
ZQo+IHRoZSBsYXN0IGZvcm1hdCBjaGFyYWN0ZXIgWy1XZm9ybWF0LXRydW5jYXRpb249XQo+ICAg
c25wcmludGYocm9vdGRldiwgcmV0LCAiL2Rldi8lcyIsIGJ1Zik7Cj4gCj4gLi4vaW5jbHVkZS9m
MmZzX2ZzLmg6MTM4NDoyOiB3YXJuaW5nOiDigJhzdHJuY3B54oCZIHNwZWNpZmllZCBib3VuZAo+
IGRlcGVuZHMgb24gdGhlIGxlbmd0aCBvZiB0aGUgc291cmNlIGFyZ3VtZW50IFstV3N0cmluZ29w
LW92ZXJmbG93PV0KPiAgIHN0cm5jcHkoYnVmLCBmZWF0dXJlcywgc3RybGVuKGZlYXR1cmVzKSAr
IDEpOwo+IAo+IGYyZnN0YXQuYzoyNDM6Mzogd2FybmluZzog4oCYc3RybmNweeKAmSBvdXRwdXQg
dHJ1bmNhdGVkIGJlZm9yZQo+IHRlcm1pbmF0aW5nIG51bCBjb3B5aW5nIGFzIG1hbnkgYnl0ZXMg
ZnJvbSBhIHN0cmluZyBhcyBpdHMgbGVuZ3RoCj4gWy1Xc3RyaW5nb3AtdHJ1bmNhdGlvbl0KPiAg
ICBzdHJuY3B5KHB0cl9idWYsIG5hbWVbaV0sIHN0cmxlbihuYW1lW2ldKSk7Cj4gCj4gVGhpcyBw
YXRjaCBkb2VzIG5vdCBjaGFuZ2UgYW55IGZ1bmN0aW9uYWxpdHkuCj4gCj4gU2lnbmVkLW9mZi1i
eTogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAd2RjLmNvbT4KClJldmlld2VkLWJ5OiBD
aGFvIFl1IDx5dWNoYW8wQGh1YXdlaS5jb20+CgpUaGFua3MsCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
