From: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Subject: [PATCH 3/4] lib/libf2fs_io.c: Added a missing free
 statement.
Date: Thu, 11 Oct 2018 18:21:14 -0400
Message-ID: <75B9BAFA-1C55-41F8-887F-170007D80688@cs.toronto.edu>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <smaneas@cs.toronto.edu>) id 1gAjKb-00027b-RF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 22:21:21 +0000
Received: from aviary.cs.toronto.edu ([128.100.3.90])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES128-SHA:128) (Exim 4.90_1) id 1gAjKa-006Mik-GJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 22:21:21 +0000
Received: from airport-26.cs.toronto.edu ([128.100.27.26] helo=[172.31.34.138])
 by aviary.cs.toronto.edu (as smtp.cs.toronto.edu) with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <smaneas@cs.toronto.edu>) id 1gAjKU-0006Sd-NI
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 18:21:14 -0400
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

QWRkZWQgYSBtaXNzaW5nIGZyZWUgc3RhdGVtZW50IHJlbGF0ZWQgdG8gZWFjaCBkZXZpY2XigJlz
IHBhdGguCgpTaWduZWQtb2ZmLWJ5OiBTb3Rpcmlvcy1FZnN0YXRoaW9zIE1hbmVhcyA8c21hbmVh
c0Bjcy50b3JvbnRvLmVkdT4KLS0tCiBsaWIvbGliZjJmc19pby5jIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9saWIvbGliZjJmc19pby5jIGIvbGli
L2xpYmYyZnNfaW8uYwppbmRleCA3NmQyODNkLi5lYTEzNjRkIDEwMDY0NAotLS0gYS9saWIvbGli
ZjJmc19pby5jCisrKyBiL2xpYi9saWJmMmZzX2lvLmMKQEAgLTM3NCw2ICszNzQsNyBAQCBpbnQg
ZjJmc19maW5hbGl6ZV9kZXZpY2Uodm9pZCkKIAkJCU1TRygwLCAiXHRFcnJvcjogRmFpbGVkIHRv
IGNsb3NlIGRldmljZSBmaWxlISEhXG4iKTsKIAkJCWJyZWFrOwogCQl9CisJCWZyZWUoYy5kZXZp
Y2VzW2ldLnBhdGgpOwogCX0KIAljbG9zZShjLmtkKTsKIAotLSAKMi4xMC4xCgpLaW5kIHJlZ2Fy
ZHMsClN0YXRoaXMgTWFuZWFzCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
