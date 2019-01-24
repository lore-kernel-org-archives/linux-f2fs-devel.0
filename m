From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix to data block override node
 segment by mistake
Date: Thu, 24 Jan 2019 22:10:32 +0800
Message-ID: <89908961-cc74-be29-0fed-dcdc47917acb@kernel.org>
References: <710067dd-5553-8606-efc9-6d1be40b2dc4@huawei.com>
 <20be8521-d934-0995-e423-925fe039ad3c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gmfiR-0005xY-Sb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Jan 2019 14:10:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gmfiQ-00B7FL-E2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Jan 2019 14:10:47 +0000
In-Reply-To: <20be8521-d934-0995-e423-925fe039ad3c@huawei.com>
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
To: zhengliang <zhengliang6@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

T24gMjAxOS0xLTI0IDIwOjU3LCB6aGVuZ2xpYW5nIHdyb3RlOgo+IAo+IFRoZSBmb2xsb3dpbmcg
cmFjZSBjb3VsZCBsZWFkIHRvIGRhdGEgYmxvY2sgb3ZlcnJpZGUgbm9kZSBzZWdtZW50IGJ5IG1p
c3Rha2UuCj4gCj4gVGFzayBBICAgICAgICAgICAgfCAgICBUYXNrIEIgICAgICAgICB8ICBUYXNr
IEMgICAgICAgICAgICB8ICAgIFRhc2sgRAo+ID09PT09PT0gICAgICAgICAgIHwgICA9PT09PT09
PSAgICAgICAgfD09PT09PT09PT0gICAgICAgICAgfCAgPT09PT09PT09Cj4gb3BlbiBmaWxlICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICB8Cj4gd2hpdGUg
ZmlsZSAgICAgICAgfCAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICB8Cj4g
c3VibWl0IGJpbyAgICAgICAgfCAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICB8Cj4gd2FpdCBpbyBjb21wbGV0ZSAgfCAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICB8Cj4gCQkgIHwgICByZW1vdmUgZmlsZSAgICAgfCAgICAgICAgICAgICAgICAgICAg
fAo+IC4uLi4uLi4uICAgICAgICAgIHwgICBpcHV0X2ZpbmFsICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgfAo+IAkJICB8ICAgICAgICAgICAgICAgICAgIHwgICBzeW5jICAgICAgICAgICAgIHwK
PiAJCSAgfCAgICAgICAgICAgICAgICAgICB8ICBkbyBjaGVja3BvaW50ICAgICB8Cj4gCQkgIHwJ
CSAgICAgIHwgIGRhdGEgc2VnbWVudCBmcmVlIHwKPiAJCSAgfCAgICAgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICB8IGNyZWF0ZSBmaWxlMQo+IAkJICB8CQkgICAgICB8CQkgICAg
ICAgICAgIHwgYWxsb2NhdGUgbm9kZSBzZWdtZW50o6hpZiBpdCBpcyB0aGUgc2FtZSBzZWdtZW50
IGZyZWVkIGJ5IFRhc2sgQ6OpCj4gZjJmc193cml0ZV9lbmRfaW8gfAkJICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgfAkJCQkJCQkJCj4gCj4gU28gd2UgbmVlZCB0byBndWFyYW50ZWUgaW8gY29t
cGxldGUgYmVmb3JlIHRydW5jYXRlIGlub2RlCj4gaW4gZjJmc19kcm9wX2lub2RlLgo+IAo+IHYx
LT52MjogSXQgZG9uJ3QgbmVlZCB0byBwYXNzIEBpbm8gaW4gZjJmc19zdWJtaXRfbWVyZ2VkX3dy
aXRlX2NvbmQgLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFpoZW5nIExpYW5nIDx6aGVuZ2xpYW5nNkBo
dWF3ZWkuY29tPgoKUmV2aWV3ZWQtYnk6IENoYW8gWXUgPHl1Y2hhbzBAaHVhd2VpLmNvbT4KClRo
YW5rcywKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
