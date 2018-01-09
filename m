From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: correct removexattr behavior for null
 valued extended attribute
Date: Tue, 9 Jan 2018 19:32:20 +0800
Message-ID: <60946946-7bfe-d13a-1903-398d4c6c4818@kernel.org>
References: <ffbf13bf-2657-761b-51d8-bdc097ba0e97@huawei.com>
 <1515457377-20597-1-git-send-email-daeho.jeong@samsung.com>
 <CGME20180109002241epcas1p46c06112eb4a2beef7ca377cbfe3b6e33@epcms1p2>
 <20180109095958epcms1p26d0561b455fc99d524d5330f75ed66fd@epcms1p2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eYs8u-0007Qm-Cc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 11:32:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYs8q-0007gE-PU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 11:32:32 +0000
In-Reply-To: <20180109095958epcms1p26d0561b455fc99d524d5330f75ed66fd@epcms1p2>
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
To: daeho.jeong@samsung.com, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkgRGFlaG8sCgpPbiAyMDE4LzEvOSAxNzo1OSwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gSGksIENo
YW8KPiAKPj4gSG93wqBjYW7CoHdlwqBidWlsZMKgc3VjaMKgeGF0dHLCoGVudHJ5wqB3aG9zZcKg
dmFsdWXCoGlzwqBOVUxMP8KgQ2FuwqB5b3XCoGdpdmXCoGFuCj4+IHJlcHJvZHVjZXLCoGV4YW1w
bGU/Cj4gwqAKPiBXZSB1c2VkIHNldHhhdHRyIHN5c3RlbSBjYWxsIHdpdGggInZhbHVlIiBhcyBO
VUxMIGFuZCAic2l6ZSIgYXMgMC4KPiBBbmQgdGhlbiB2ZnNfc2V0eGF0dHIgd2lsbCBjaGFuZ2Ug
InZhbHVlIiB0byAiIiBhbmQgdHJhbnNmZXIgInZhbHVlIiBhbmQgInNpemUiCj4gdG8gZjJmc19z
ZXR4YXR0cigpLgoKQ29ycmVjdCwgSSBjYW4gcmVwcm9kdWNlIHRoaXMgYnVnIHdpdGg6CgoxLiB0
b3VjaCBmaWxlCjIuIHNldGZhdHRyIC1uICJ1c2VyLmZvbyIgZmlsZQozLiBzZXRmYXR0ciAteCAi
dXNlci5mb28iIGZpbGUKNC4gZ2V0ZmF0dHIgLWQgZmlsZQp1c2VyLmZvbwoKQWZ0ZXIgYXBwbHlp
bmcgeW91ciBwYXRjaCwgdGhlIHByb2JsZW0gY2FuIGJlIGZpeGVkLgoKQ291bGQgeW91IGFkZCBi
ZWxvdyB0ZXN0IGNhc2UgZXhwbGljaXRseSBpbiB5b3VyIGNvbW1pdCBsb2c/CgpSZXZpZXdlZC1i
eTogQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29tPgpUZXN0ZWQtYnk6IENoYW8gWXUgPHl1Y2hh
bzBAaHVhd2VpLmNvbT4KClRoYW5rcywKCj4gCj4gVGhhbmtzLAo+IAo+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+IENoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2Yg
dGhlIHdvcmxkJ3MgbW9zdAo+IGVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoZG90Lm9yZyEgaHR0
cDovL3NkbS5saW5rL3NsYXNoZG90Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo+IAoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2YgdGhl
IHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9z
ZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
