From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Bug in f2fs-tools-1.12.0
Date: Mon, 26 Nov 2018 18:52:59 +0800
Message-ID: <c5b93b62-37df-a351-7dc5-e1c0f26b5813@huawei.com>
References: <e8884c8d-9009-cb70-bdf1-73fc38e83abc@GMail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gREW6-0007nm-FL
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 10:53:26 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gREVq-0046Uz-L0
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 10:53:26 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5FE7BA5EC12AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Nov 2018 18:53:02 +0800 (CST)
In-Reply-To: <e8884c8d-9009-cb70-bdf1-73fc38e83abc@GMail.com>
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
To: Perfect Gentleman <perfect007gentleman@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

SGkgUGVyZmVjdCBHZW50bGVtYW4sCgpUaGFua3MgZm9yIHRoZSByZXBvcnQuCgpPbiAyMDE4LzEx
LzI1IDEzOjI0LCBQZXJmZWN0IEdlbnRsZW1hbiB3cm90ZToKPiBIaSBmMmZzLXRlYW0sCj4gCj4g
dGhlcmUgaXMgYnVnOiBmc2NrLmYyZnMgY2Fubm90IGNoZWNrIHJlYWQtb25seSBmaWxlc3lzdGVt
LiBCdXQgMS4xMS4wIAo+IGNhbiBkbyB0aGF0Lgo+IAo+IGZzY2vCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8SW5mbzogRml4IHRoZSByZXBvcnRlZCBjb3JydXB0aW9uLgo+IGZzY2vCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8SW5mbzogTW91bnRlZCBkZXZpY2UhCj4gZnNja8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHxJbmZvOiBDaGVjayBGUyBvbmx5IGR1ZSB0byBSTwo+IGZzY2vC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8RXJyb3I6IEZhaWxlZCB0byBvcGVuIHRoZSBkZXZp
Y2UhCgpJIGd1ZXNzIHRoaXMgaXMgZHVlIHRvIGJlbG93IGNvbW1pdCwgd2hpY2ggc3RvcCBvcGVu
aW5nIGRldmljZSBpbgpmMmZzLXRvb2xzIGlmIHRoZSBkZXZpY2UgaGFzIGFscmVhZHkgYmVlbiBv
cGVuZWQgYnkgb3RoZXIgb25lLCBsaWtlIG1vdW50LgoKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvamFlZ2V1ay9mMmZzLXRvb2xzLmdpdC9jb21taXQvP2g9
ZGV2LXRlc3QmaWQ9ZWI5ZDgwMzdlZDNiMzdhNjQ3ZDUxNDQ3MGYxYTFkZjkxZGFlZGI2NAoKSSB0
cmllZCBlMmZzcHJvZ3MsIHcvbyAtZiBvcHRpb24sIHRoZSByZXN1bHQgaXMgdGhlIHNhbWU6Cgpm
c2NrIDEuNDQuNCAoMTgtQXVnLTIwMTgpCmUyZnNjayAxLjQ0LjQgKDE4LUF1Zy0yMDE4KQovZGV2
L3pyYW0wIGlzIG1vdW50ZWQuCmUyZnNjazogQ2Fubm90IGNvbnRpbnVlLCBhYm9ydGluZy4KCkJ1
dCBzdGlsbCB3ZSBjYW4gdHJpZ2dlciBmb3JjZWQgZnNjay5leHQ0IGJ5IHVzaW5nIC1mIG9wdGlv
bi4KCkNvdWxkIHlvdSBoYXZlIGEgdHJ5IHdpdGggZm9sbG93aW5nIHBhdGNoPwoKW1BBVENIXSBm
c2NrLmYyZnM6IGFsbG93IHRvIGZzY2sgcmVhZG9ubHkgaW1hZ2Ugdy8gLWYgb3B0aW9uCgpUaGFu
a3MsCgo+IGZzY2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8ICogRmlsZXN5c3RlbXMgY291
bGRuJ3QgYmUgZml4ZWQKPiAgwqBbICEhIF0KPiBmc2NrwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAqIEVSUk9SOiBmc2NrIGZhaWxlZCB0byBzdGFydAo+IAo+IFJlZ2FyZHMsCj4gQWxleAo+
IAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKPiAKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
