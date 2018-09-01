From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200951] kernel NULL pointer dereference in
 update_sit_entry
Date: Sat, 01 Sep 2018 12:53:38 +0000
Message-ID: <bug-200951-202145-fUvsafRiRJ@https.bugzilla.kernel.org/>
References: <bug-200951-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fw5PO-0002wM-3z
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Sep 2018 12:53:46 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fw5PM-005wxu-5s
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Sep 2018 12:53:46 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8A7D729C75
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  1 Sep 2018 12:53:38 +0000 (UTC)
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
b21tZW50ICM0IGZyb20gdmljZW5jYkBnbWFpbC5jb20gLS0tCkhpISBZZXMsIGl0IGlzIHJlcHJv
ZHVjaWJsZS4KRWFjaCB0aW1lIFRSSU0gaXMgZW5hYmxlZCB2aWEgdGhlIFVERVYgcnVsZSBhbmQg
dGhlIEZTIG1vdW50ZWQgd2l0aAp0aGUgZGlzY2FyZCBvcHRpb24sIHRoZSBpc3N1ZSBpcyB0cmln
Z2VyZWQgYXQgdGhlIHZlcnkgZmlyc3Qgd3JpdGUgYXR0ZW1wdC4KQmVmb3JlIG1vdW50aW5nIGZz
Y2suZjJmcyB3YXMgc3VjY2Vzc2Z1bGx5IHJ1biBvbiB0aGUgRlMuCgpSZWdhcmRzLAogIFZpY2Vu
w6cuCgotLSAKWW91IGFyZSByZWNlaXZpbmcgdGhpcyBtYWlsIGJlY2F1c2U6CllvdSBhcmUgd2F0
Y2hpbmcgdGhlIGFzc2lnbmVlIG9mIHRoZSBidWcuCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVj
ayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1v
c3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xh
c2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
