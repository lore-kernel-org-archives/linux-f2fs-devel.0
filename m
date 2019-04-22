From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [RESEND PATCH] f2fs: Fix one GCC warning
Date: Mon, 22 Apr 2019 21:27:59 +0800
Message-ID: <1555939679-57452-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangshaokun@hisilicon.com>) id 1hIZG1-000325-UI
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 13:45:17 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hIZFz-006ElO-UZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 13:45:17 +0000
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Jaegeuk Kim <jaegeuk@kernel.org>

ZnMvZjJmcy9ub2RlLmM6IEluIGZ1bmN0aW9uIOKAmGYyZnNfcmVtb3ZlX2lub2RlX3BhZ2XigJk6
CmZzL2YyZnMvbm9kZS5jOjExOTM6NDc6IHdhcm5pbmc6IGZvcm1hdCDigJglbHXigJkgZXhwZWN0
cyBhcmd1bWVudCBvZiB0eXBlIOKAmGxvbmcgdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQg
NSBoYXMgdHlwZSDigJhibGtjbnRfdCB7YWthIGxvbmcgbG9uZyB1bnNpZ25lZCBpbnR94oCZIFst
V2Zvcm1hdD1dCiAgICAiSW5jb25zaXN0ZW50IGlfYmxvY2tzLCBpbm86JWx1LCBpYmxvY2tzOiVs
dSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+XgogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAlbGx1CiAgICBpbm9kZS0+
aV9pbm8sIGlub2RlLT5pX2Jsb2Nrcyk7CiAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+
fgpGaXhlczogY2RhZDYzNWJkMDY4ICgiZjJmczogZml4IHRvIGF2b2lkIHBhbmljIGluIGYyZnNf
cmVtb3ZlX2lub2RlX3BhZ2UoKSIpCkNjOiBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3Jn
PgpDYzogQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29tPgpTaWduZWQtb2ZmLWJ5OiBTaGFva3Vu
IFpoYW5nIDx6aGFuZ3NoYW9rdW5AaGlzaWxpY29uLmNvbT4KLS0tCiBmcy9mMmZzL25vZGUuYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2ZzL2YyZnMvbm9kZS5jIGIvZnMvZjJmcy9ub2RlLmMKaW5kZXggMjJkMjFjNTQ2
YmY2Li5lMTVkMGJlNzI5YjQgMTAwNjQ0Ci0tLSBhL2ZzL2YyZnMvbm9kZS5jCisrKyBiL2ZzL2Yy
ZnMvbm9kZS5jCkBAIC0xMTkwLDcgKzExOTAsNyBAQCBpbnQgZjJmc19yZW1vdmVfaW5vZGVfcGFn
ZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQogCiAJaWYgKHVubGlrZWx5KGlub2RlLT5pX2Jsb2NrcyAh
PSAwICYmIGlub2RlLT5pX2Jsb2NrcyAhPSA4KSkgewogCQlmMmZzX21zZyhGMkZTX0lfU0IoaW5v
ZGUpLT5zYiwgS0VSTl9XQVJOSU5HLAotCQkJIkluY29uc2lzdGVudCBpX2Jsb2NrcywgaW5vOiVs
dSwgaWJsb2NrczolbHUiLAorCQkJIkluY29uc2lzdGVudCBpX2Jsb2NrcywgaW5vOiVsdSwgaWJs
b2NrczolbGx1IiwKIAkJCWlub2RlLT5pX2lubywgaW5vZGUtPmlfYmxvY2tzKTsKIAkJc2V0X3Ni
aV9mbGFnKEYyRlNfSV9TQihpbm9kZSksIFNCSV9ORUVEX0ZTQ0spOwogCX0KLS0gCjIuNy40CgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
