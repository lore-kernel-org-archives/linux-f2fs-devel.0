From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Questions about commit f2fs: fix to avoid broken of
 dnode block list
Date: Wed, 4 Jul 2018 04:34:00 +0000
Message-ID: <808556C6-7CCE-4D50-9F54-F34072A83AE3@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1faZUZ-0003ak-6v
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Jul 2018 04:34:11 +0000
Received: from mail-cys01nam02on0092.outbound.protection.outlook.com
 ([104.47.37.92] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1faZUW-009Kss-6X
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Jul 2018 04:34:11 +0000
Content-Language: en-US
Content-ID: <F84297C1EBC2B145AA0143B7AF99949D@namprd07.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkgQ2hhbywNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvY2hhby9saW51eC5naXQvY29tbWl0Lz9oPWYyZnMtZGV2JmlkPTBhYzI4OTAxNTZhYjUxN2E4
YWM3OTg0OWVlNWFiYWI3YWQ2MDMxMGINCg0KSW4gdGhpcyBwYXRjaDogZjJmczogZml4IHRvIGF2
b2lkIGJyb2tlbiBvZiBkbm9kZSBibG9jayBsaXN0DQotaW50IGYyZnNfd2FpdF9vbl9ub2RlX3Bh
Z2VzX3dyaXRlYmFjayhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksIG5pZF90IGlubykNCitpbnQg
ZjJmc193YWl0X29uX25vZGVfcGFnZXNfd3JpdGViYWNrKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNi
aSkNCg0KWW91IG1vZGlmeSBmMmZzX3dhaXRfb25fbm9kZV9wYWdlc193cml0ZWJhY2soKSBpbiBm
aWxlLmMgYnV0IHNlZW1zIG5vdCBtb2RpZnlpbmcgdGhlIGRlY2xhcmF0aW9uIGluIGYyZnMuaD8g
V2hpY2ggbWFrZXMgY29tcGlsYXRpb24gZmFpbGVk4oCmDQoNClRoYW5rcywNCi1XZW4KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBv
bmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmch
IGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZz
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
