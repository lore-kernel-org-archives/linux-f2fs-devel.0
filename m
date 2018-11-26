From: Chao Yu <chao@kernel.org>
Subject: [PATCH] fsck.f2fs: fix to skip repairing initialized
 i_gc_failures
Date: Mon, 26 Nov 2018 22:19:14 +0800
Message-ID: <20181126141914.8238-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gRHjj-0004Ek-Nh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 14:19:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRHjT-004HML-OT
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 14:19:43 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

RnJvbTogQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29tPgoKQXMgTWljaGFlbCByZXBvcnRlZDoK
CmFmdGVyIHVwZGF0aW5nIHRvIGYyZnMtdG9vbHMgMS4xMi4wLCBhIHJvdXRpbmUgZnNjayBvZiBt
eSBmaWxlIHN5c3RlbXMKdG9vayBxdWl0ZSBhIHdoaWxlIGFuZCBvdXRwdXQgdGVuLXRob3VzYW5k
cyBpbnN0YW5jZXMgb2YgdGhlIGZvbGxvd2luZwpsaW5lOgoKPiBbRklYXSAoZnNja19jaGtfaW5v
ZGVfYmxrOiA5NTQpICAtLT4gUmVndWxhcjogMHhYWVogcmVzZXQgaV9nY19mYWlsdXJlcyBmcm9t
IDB4MSB0byAweDAwCgpJbiBvbGQga2VybmVsLCB3ZSBpbml0aWFsaXplZCBpX2djX2ZhaWx1cmVz
IGFzIDB4MDEsIGxldCdzIHNraXAKcmVzZXR0aW5nIHN1Y2ggdW5jaGFuZ2VkIGluaXRpYWxpemVk
IHZhbHVlIHRvIGF2b2lkIHVubmVjZXNzYXJ5CnJlcGFpcmluZy4KClJlcG9ydGVkLWJ5OiBNaWNo
YWVsIExhw58gPGJldmFuQGJpLWNvLm5ldD4KU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8eXVjaGFv
MEBodWF3ZWkuY29tPgotLS0KIGZzY2svZnNjay5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnNjay9mc2NrLmMg
Yi9mc2NrL2ZzY2suYwppbmRleCA5NzBkMTUwLi5kYjBlNzJmIDEwMDY0NAotLS0gYS9mc2NrL2Zz
Y2suYworKysgYi9mc2NrL2ZzY2suYwpAQCAtOTQxLDcgKzk0MSw5IEBAIHNraXBfYmxrY250X2Zp
eDoKIAl9CiAKIAlpX2djX2ZhaWx1cmVzID0gbGUxNl90b19jcHUobm9kZV9ibGstPmkuaV9nY19m
YWlsdXJlcyk7Ci0JaWYgKGZ0eXBlID09IEYyRlNfRlRfUkVHX0ZJTEUgJiYgaV9nY19mYWlsdXJl
cykgeworCisJLyogb2xkIGtlcm5lbCBpbml0aWFsaXplZCBpX2djX2ZhaWx1cmVzIGFzIDB4MDEs
IHNraXAgcmVwYWlyaW5nICovCisJaWYgKGZ0eXBlID09IEYyRlNfRlRfUkVHX0ZJTEUgJiYgaV9n
Y19mYWlsdXJlcyA+IDEpIHsKIAogCQlEQkcoMSwgIlJlZ3VsYXIgSW5vZGU6IDB4JXggWyVzXSBk
ZXB0aDogJWRcblxuIiwKIAkJCQlsZTMyX3RvX2NwdShub2RlX2Jsay0+Zm9vdGVyLmlubyksIGVu
LAotLSAKMi4xOC4wCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
