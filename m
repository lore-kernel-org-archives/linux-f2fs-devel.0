From: Zhangshaokun <zhangshaokun@hisilicon.com>
Subject: Re: [Shaokun Zhang] f2fs: Fix one GCC warning
Date: Mon, 22 Apr 2019 21:31:04 +0800
Message-ID: <27742093-62fd-9f0b-e309-dd30e07d3553@hisilicon.com>
References: <1555939549-57376-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangshaokun@hisilicon.com>) id 1hIZHr-0004Kn-FF
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 13:47:11 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hIZHo-006EvX-Jm
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 13:47:11 +0000
In-Reply-To: <1555939549-57376-1-git-send-email-zhangshaokun@hisilicon.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

cGxlYXNlIGlnbm9yZSB0aGlzLgoKVGhhbmtzLApTaGFva3VuCgpPbiAyMDE5LzQvMjIgMjE6MjUs
IFNoYW9rdW4gWmhhbmcgd3JvdGU6Cj4gZnMvZjJmcy9ub2RlLmM6IEluIGZ1bmN0aW9uIOKAmGYy
ZnNfcmVtb3ZlX2lub2RlX3BhZ2XigJk6Cj4gZnMvZjJmcy9ub2RlLmM6MTE5Mzo0Nzogd2Fybmlu
ZzogZm9ybWF0IOKAmCVsdeKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYbG9uZyB1bnNp
Z25lZCBpbnTigJksIGJ1dCBhcmd1bWVudCA1IGhhcyB0eXBlIOKAmGJsa2NudF90IHtha2EgbG9u
ZyBsb25nIHVuc2lnbmVkIGludH3igJkgWy1XZm9ybWF0PV0KPiAgICAgIkluY29uc2lzdGVudCBp
X2Jsb2NrcywgaW5vOiVsdSwgaWJsb2NrczolbHUiLAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIH5+Xgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICVsbHUKPiAgICAgaW5vZGUtPmlfaW5vLCBpbm9kZS0+aV9ibG9ja3Mp
Owo+ICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fgo+IEdDQyB2ZXJzaW9uIGlzIGdj
YyAoR0NDKSA3LjMuMSAyMDE4MDcxMiAoUmVkIEhhdCA3LjMuMS02KS4KPiAKPiBGaXhlczogY2Rh
ZDYzNWJkMDY4ICgiZjJmczogZml4IHRvIGF2b2lkIHBhbmljIGluIGYyZnNfcmVtb3ZlX2lub2Rl
X3BhZ2UoKSIpCj4gQ2M6IEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4gQ2M6IENo
YW8gWXUgPHl1Y2hhbzBAaHVhd2VpLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFva3VuIFpoYW5n
IDx6aGFuZ3NoYW9rdW5AaGlzaWxpY29uLmNvbT4KPiAtLS0KPiAgZnMvZjJmcy9ub2RlLmMgfCAy
ICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS9mcy9mMmZzL25vZGUuYyBiL2ZzL2YyZnMvbm9kZS5jCj4gaW5kZXggMjJk
MjFjNTQ2YmY2Li5lMTVkMGJlNzI5YjQgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9ub2RlLmMKPiAr
KysgYi9mcy9mMmZzL25vZGUuYwo+IEBAIC0xMTkwLDcgKzExOTAsNyBAQCBpbnQgZjJmc19yZW1v
dmVfaW5vZGVfcGFnZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQo+ICAKPiAgCWlmICh1bmxpa2VseShp
bm9kZS0+aV9ibG9ja3MgIT0gMCAmJiBpbm9kZS0+aV9ibG9ja3MgIT0gOCkpIHsKPiAgCQlmMmZz
X21zZyhGMkZTX0lfU0IoaW5vZGUpLT5zYiwgS0VSTl9XQVJOSU5HLAo+IC0JCQkiSW5jb25zaXN0
ZW50IGlfYmxvY2tzLCBpbm86JWx1LCBpYmxvY2tzOiVsdSIsCj4gKwkJCSJJbmNvbnNpc3RlbnQg
aV9ibG9ja3MsIGlubzolbHUsIGlibG9ja3M6JWxsdSIsCj4gIAkJCWlub2RlLT5pX2lubywgaW5v
ZGUtPmlfYmxvY2tzKTsKPiAgCQlzZXRfc2JpX2ZsYWcoRjJGU19JX1NCKGlub2RlKSwgU0JJX05F
RURfRlNDSyk7Cj4gIAl9Cj4gCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
