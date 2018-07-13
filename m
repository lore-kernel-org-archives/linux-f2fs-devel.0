From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] f2fs: hide unused procfs helpers
Date: Fri, 13 Jul 2018 11:53:04 +0800
Message-ID: <20180713035304.18520-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuehaibing@huawei.com>) id 1fdpLg-0004kZ-37
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 04:06:28 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fdpLe-007iTa-9B
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 04:06:28 +0000
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
Cc: YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

V2hlbiBDT05GSUdfUFJPQ19GUyBpc24ndCBzZXQsIGdjYyB3YXJuaW5nIHRoaXM6Cgpmcy9mMmZz
L3N5c2ZzLmM6NTE5OjEyOiB3YXJuaW5nOiDigJhzZWdtZW50X2luZm9fc2VxX3Nob3figJkgZGVm
aW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQogc3RhdGljIGludCBzZWdtZW50
X2luZm9fc2VxX3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEsIHZvaWQgKm9mZnNldCkKICAgICAg
ICAgICAgXgpmcy9mMmZzL3N5c2ZzLmM6NTQ2OjEyOiB3YXJuaW5nOiDigJhzZWdtZW50X2JpdHNf
c2VxX3Nob3figJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQogc3Rh
dGljIGludCBzZWdtZW50X2JpdHNfc2VxX3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEsIHZvaWQg
Km9mZnNldCkKICAgICAgICAgICAgXgpmcy9mMmZzL3N5c2ZzLmM6NTcwOjEyOiB3YXJuaW5nOiDi
gJhpb3N0YXRfaW5mb19zZXFfc2hvd+KAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
ZnVuY3Rpb25dCiBzdGF0aWMgaW50IGlvc3RhdF9pbmZvX3NlcV9zaG93KHN0cnVjdCBzZXFfZmls
ZSAqc2VxLCB2b2lkICpvZmZzZXQpCgpXZSBjYW4gZml4IHRoZSB3YXJuaW5nIGJ5IGFkZGluZyB0
aGUgc2FtZSAjaWZkZWYgYXJvdW5kIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5
dWVoYWliaW5nQGh1YXdlaS5jb20+Ci0tLQogZnMvZjJmcy9zeXNmcy5jIHwgMiArKwogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc3lzZnMuYyBi
L2ZzL2YyZnMvc3lzZnMuYwppbmRleCAyZTdlNjExLi43ZDQ1ZTY1IDEwMDY0NAotLS0gYS9mcy9m
MmZzL3N5c2ZzLmMKKysrIGIvZnMvZjJmcy9zeXNmcy5jCkBAIC01MTYsNiArNTE2LDcgQEAgc3Rh
dGljIHN0cnVjdCBrb2JqZWN0IGYyZnNfZmVhdCA9IHsKIAkua3NldAk9ICZmMmZzX2tzZXQsCiB9
OwogCisjaWZkZWYgQ09ORklHX1BST0NfRlMKIHN0YXRpYyBpbnQgc2VnbWVudF9pbmZvX3NlcV9z
aG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxLCB2b2lkICpvZmZzZXQpCiB7CiAJc3RydWN0IHN1cGVy
X2Jsb2NrICpzYiA9IHNlcS0+cHJpdmF0ZTsKQEAgLTYwOCw2ICs2MDksNyBAQCBzdGF0aWMgaW50
IGlvc3RhdF9pbmZvX3NlcV9zaG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxLCB2b2lkICpvZmZzZXQp
CiAKIAlyZXR1cm4gMDsKIH0KKyNlbmRpZgogCiBpbnQgX19pbml0IGYyZnNfaW5pdF9zeXNmcyh2
b2lkKQogewotLSAKMi43LjAKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUg
dmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2lu
ZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRl
dmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApo
dHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRl
dmVsCg==
