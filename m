From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200951] kernel NULL pointer dereference in
 update_sit_entry
Date: Tue, 04 Sep 2018 12:51:57 +0000
Message-ID: <bug-200951-202145-Y1vjW1dOLZ@https.bugzilla.kernel.org/>
References: <bug-200951-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fxAoR-0006pa-J8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Sep 2018 12:52:07 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxAoN-008G61-UI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Sep 2018 12:52:07 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 48CD52959D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Sep 2018 12:51:56 +0000 (UTC)
In-Reply-To: <bug-200951-202145@https.bugzilla.kernel.org/>
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

aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDA5NTEKCi0tLSBD
b21tZW50ICMxNiBmcm9tIHZpY2VuY2JAZ21haWwuY29tIC0tLQpIaSwKdGhhbmsgeW91IGZvciBi
ZWluZyB0aGF0IGZhc3QhCgpJIGhhdmUgdHJpZWQgaXQgYWdhaW5zdCB2NC4xOS1yYzIKIApodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXgu
Z2l0L2NvbW1pdC8/aWQ9NTczNjE4NDZiNTJiYzY4NjExMmRhNmNhNTM2OGQxMTIxMDc5NjgwNApi
dXQgaXQgZG9lcyBub3QgYXBwbHkKICBjaGVja2luZyBmaWxlIGZzL2YyZnMvZGVidWcuYwogIEh1
bmsgIzEgc3VjY2VlZGVkIGF0IDE5MCAob2Zmc2V0IC0zIGxpbmVzKS4KICBjaGVja2luZyBmaWxl
IGZzL2YyZnMvZjJmcy5oCiAgSHVuayAjMSBGQUlMRUQgYXQgMzQzNi4KICAxIG91dCBvZiAxIGh1
bmsgRkFJTEVECiAgY2hlY2tpbmcgZmlsZSBmcy9mMmZzL2ZpbGUuYwogIGNoZWNraW5nIGZpbGUg
ZnMvZjJmcy9zZWdtZW50LmMKICBIdW5rICMxIHN1Y2NlZWRlZCBhdCAxNzI1IChvZmZzZXQgLTQz
IGxpbmVzKS4KICAuLi4KICBIdW5rICM4IHN1Y2NlZWRlZCBhdCAzOTU5IChvZmZzZXQgLTQ1IGxp
bmVzKS4KICBjaGVja2luZyBmaWxlIGZzL2YyZnMvc3VwZXIuYwogIEh1bmsgIzEgc3VjY2VlZGVk
IGF0IDM2MCAob2Zmc2V0IC0zIGxpbmVzKS4KICBIdW5rICMyIEZBSUxFRCBhdCA0MTcuCiAgSHVu
ayAjMyBzdWNjZWVkZWQgYXQgMTAzMSAob2Zmc2V0IC0yOSBsaW5lcykuCiAgSHVuayAjNCBGQUlM
RUQgYXQgMTQ0MC4KICAyIG91dCBvZiA0IGh1bmtzIEZBSUxFRAoKV2hpY2gga2VybmVsIHRyZWUg
c2hvdWxkIGkgYmUgdXNpbmc/CgpSZWdhcmRzLAogIFZpY2Vuw6cuCgotLSAKWW91IGFyZSByZWNl
aXZpbmcgdGhpcyBtYWlsIGJlY2F1c2U6CllvdSBhcmUgd2F0Y2hpbmcgdGhlIGFzc2lnbmVlIG9m
IHRoZSBidWcuCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVj
aCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRl
cywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5n
IGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
