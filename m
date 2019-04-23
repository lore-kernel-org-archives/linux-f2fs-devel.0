From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RESEND PATCH] f2fs: Fix one GCC warning
Date: Tue, 23 Apr 2019 10:57:49 +0800
Message-ID: <eab291f6-7271-2094-9362-e5174685d856@huawei.com>
References: <1555939679-57452-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hIldC-00018p-Vo
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Apr 2019 02:58:02 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hIldB-007aHE-1J
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Apr 2019 02:58:02 +0000
In-Reply-To: <1555939679-57452-1-git-send-email-zhangshaokun@hisilicon.com>
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
To: Shaokun Zhang <zhangshaokun@hisilicon.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

T24gMjAxOS80LzIyIDIxOjI3LCBTaGFva3VuIFpoYW5nIHdyb3RlOgo+IGZzL2YyZnMvbm9kZS5j
OiBJbiBmdW5jdGlvbiDigJhmMmZzX3JlbW92ZV9pbm9kZV9wYWdl4oCZOgo+IGZzL2YyZnMvbm9k
ZS5jOjExOTM6NDc6IHdhcm5pbmc6IGZvcm1hdCDigJglbHXigJkgZXhwZWN0cyBhcmd1bWVudCBv
ZiB0eXBlIOKAmGxvbmcgdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQgNSBoYXMgdHlwZSDi
gJhibGtjbnRfdCB7YWthIGxvbmcgbG9uZyB1bnNpZ25lZCBpbnR94oCZIFstV2Zvcm1hdD1dCj4g
ICAgICJJbmNvbnNpc3RlbnQgaV9ibG9ja3MsIGlubzolbHUsIGlibG9ja3M6JWx1IiwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fl4KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAlbGx1Cj4gICAgIGlub2RlLT5pX2lu
bywgaW5vZGUtPmlfYmxvY2tzKTsKPiAgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn4K
PiBGaXhlczogY2RhZDYzNWJkMDY4ICgiZjJmczogZml4IHRvIGF2b2lkIHBhbmljIGluIGYyZnNf
cmVtb3ZlX2lub2RlX3BhZ2UoKSIpCgpXZSBoYXZlIGFscmVhZHkgZml4ZWQgdGhpcyBpc3N1ZSwg
dGhhbmtzIGZvciBub3RpY2luZyB0aGlzIGlzc3VlLiA6KQoKaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvamFlZ2V1ay9mMmZzLmdpdC9jb21taXQvP2g9ZGV2
LXRlc3QmaWQ9NWNmMjg3OWZhNzFhODY1ZjA4MzQ4ZGFlOTgyYjk3Yjk3MzhhMDg0NwoKVGhhbmtz
LAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
