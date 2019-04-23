From: Zhangshaokun <zhangshaokun@hisilicon.com>
Subject: Re: [RESEND PATCH] f2fs: Fix one GCC warning
Date: Tue, 23 Apr 2019 11:31:01 +0800
Message-ID: <264958c8-779e-db74-dbae-4e97d136f59f@hisilicon.com>
References: <1555939679-57452-1-git-send-email-zhangshaokun@hisilicon.com>
 <eab291f6-7271-2094-9362-e5174685d856@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangshaokun@hisilicon.com>) id 1hIm9Y-0006cK-1W
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Apr 2019 03:31:28 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hIm9U-0073wH-7J
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Apr 2019 03:31:27 +0000
In-Reply-To: <eab291f6-7271-2094-9362-e5174685d856@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

SGksCgpPbiAyMDE5LzQvMjMgMTA6NTcsIENoYW8gWXUgd3JvdGU6Cj4gT24gMjAxOS80LzIyIDIx
OjI3LCBTaGFva3VuIFpoYW5nIHdyb3RlOgo+PiBmcy9mMmZzL25vZGUuYzogSW4gZnVuY3Rpb24g
4oCYZjJmc19yZW1vdmVfaW5vZGVfcGFnZeKAmToKPj4gZnMvZjJmcy9ub2RlLmM6MTE5Mzo0Nzog
d2FybmluZzogZm9ybWF0IOKAmCVsdeKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYbG9u
ZyB1bnNpZ25lZCBpbnTigJksIGJ1dCBhcmd1bWVudCA1IGhhcyB0eXBlIOKAmGJsa2NudF90IHth
a2EgbG9uZyBsb25nIHVuc2lnbmVkIGludH3igJkgWy1XZm9ybWF0PV0KPj4gICAgICJJbmNvbnNp
c3RlbnQgaV9ibG9ja3MsIGlubzolbHUsIGlibG9ja3M6JWx1IiwKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5eCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICVsbHUKPj4gICAgIGlub2RlLT5pX2lubywgaW5vZGUt
PmlfYmxvY2tzKTsKPj4gICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+Cj4+IEZpeGVz
OiBjZGFkNjM1YmQwNjggKCJmMmZzOiBmaXggdG8gYXZvaWQgcGFuaWMgaW4gZjJmc19yZW1vdmVf
aW5vZGVfcGFnZSgpIikKPiAKPiBXZSBoYXZlIGFscmVhZHkgZml4ZWQgdGhpcyBpc3N1ZSwgdGhh
bmtzIGZvciBub3RpY2luZyB0aGlzIGlzc3VlLiA6KQo+IAoKTmljZSwgdGhhbmtzIHlvdXIgcmVw
bHkuCgo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2ph
ZWdldWsvZjJmcy5naXQvY29tbWl0Lz9oPWRldi10ZXN0JmlkPTVjZjI4NzlmYTcxYTg2NWYwODM0
OGRhZTk4MmI5N2I5NzM4YTA4NDcKPiAKPiBUaGFua3MsCj4gCj4gLgo+IAoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
