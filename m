From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] fibmap: include f2fs_fs.h before other header
 files
Date: Tue, 27 Feb 2018 16:39:33 +0800
Message-ID: <20180227083933.6480-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eqans-00574K-OT
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Feb 2018 08:40:04 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eqann-003yDI-5U
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Feb 2018 08:40:03 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

R0NDIDcuMi4wIGlzIHVuaGFwcHkgd2l0aCB0aGUgdXNhZ2Ugb2YgbWFqb3IvbWlub3I6CgpmaWJt
YXAuYzogSW4gZnVuY3Rpb24g4oCYcHJpbnRfc3RhdOKAmToKZmlibWFwLmM6NzA6MTM6IHdhcm5p
bmc6IEluIHRoZSBHTlUgQyBMaWJyYXJ5LCAibWFqb3IiIGlzIGRlZmluZWQKIGJ5IDxzeXMvc3lz
bWFjcm9zLmg+LiBGb3IgaGlzdG9yaWNhbCBjb21wYXRpYmlsaXR5LCBpdCBpcwogY3VycmVudGx5
IGRlZmluZWQgYnkgPHN5cy90eXBlcy5oPiBhcyB3ZWxsLCBidXQgd2UgcGxhbiB0bwogcmVtb3Zl
IHRoaXMgc29vbi4gVG8gdXNlICJtYWpvciIsIGluY2x1ZGUgPHN5cy9zeXNtYWNyb3MuaD4KIGRp
cmVjdGx5LiBJZiB5b3UgZGlkIG5vdCBpbnRlbmQgdG8gdXNlIGEgc3lzdGVtLWRlZmluZWQgbWFj
cm8KICJtYWpvciIsIHlvdSBzaG91bGQgdW5kZWZpbmUgaXQgYWZ0ZXIgaW5jbHVkaW5nIDxzeXMv
dHlwZXMuaD4uCiAgcHJpbnRmKCJkZXYgICAgICAgWyVkOiVkXVxuIiwgbWFqb3Ioc3QtPnN0X2Rl
diksIG1pbm9yKHN0LT5zdF9kZXYpKTsKICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKVGhpcyBpcyBiZWNhdXNlIGNv
bmZpZy5oIGlzIG5vdCBpbmNsdWRlZCBmaXJzdCwgYXMgYSByZXN1bHQsIG1hY3JvcwpkZWZpbmVk
IGluIGNvbmZpZy5oIGlzIG5vdCByZWNvZ25pemVkLiBTbyBsZXQncyBpbmNsdWRlIGYyZnNfZnMu
aApiZWZvcmUgb3RoZXIgaGVhZGVyIGZpbGVzLgoKU2lnbmVkLW9mZi1ieTogU2hlbmcgWW9uZyA8
c2hlbmd5b25nMUBodWF3ZWkuY29tPgotLS0KIHRvb2xzL2ZpYm1hcC5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdG9v
bHMvZmlibWFwLmMgYi90b29scy9maWJtYXAuYwppbmRleCBkMTcxNDRhLi45ZTk2Y2I2IDEwMDY0
NAotLS0gYS90b29scy9maWJtYXAuYworKysgYi90b29scy9maWJtYXAuYwpAQCAtMTUsNiArMTUs
NyBAQAogI2lmbmRlZiBPX0xBUkdFRklMRQogI2RlZmluZSBPX0xBUkdFRklMRSAwCiAjZW5kaWYK
KyNpbmNsdWRlIDxmMmZzX2ZzLmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8c3Ry
aW5nLmg+CiAjaW5jbHVkZSA8c3RkbGliLmg+CkBAIC0zOCw3ICszOSw2IEBACiAjaW5jbHVkZSA8
bGludXgvZnMuaD4KICNlbmRpZgogI2luY2x1ZGUgPGludHR5cGVzLmg+Ci0jaW5jbHVkZSA8ZjJm
c19mcy5oPgogCiAjaWZuZGVmIEZJQk1BUAogI2RlZmluZSBGSUJNQVAgICAgICAgICAgX0lPKDB4
MDAsIDEpICAgIC8qIGJtYXAgYWNjZXNzICovCi0tIAoyLjE1LjEKCgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5IG9uIG9uZSBvZiB0aGUg
d29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoZG90Lm9yZyEgaHR0cDovL3Nk
bS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
