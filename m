From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200951] kernel NULL pointer dereference in
 update_sit_entry
Date: Mon, 03 Sep 2018 09:35:24 +0000
Message-ID: <bug-200951-202145-tdiLuhrwHW@https.bugzilla.kernel.org/>
References: <bug-200951-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fwlGj-0000re-LX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 03 Sep 2018 09:35:37 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fwlGd-0085WR-Ob
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 03 Sep 2018 09:35:37 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id ED31B29567
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Sep 2018 09:35:25 +0000 (UTC)
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
b21tZW50ICMxMiBmcm9tIHZpY2VuY2JAZ21haWwuY29tIC0tLQpBcyBzdGF0ZWQgaW4gdGhlIGJ1
ZyBkZXNjcmlwdGlvbiwgdGhlcmUgaXMgYW4gdWRldiBydWxlIHRvIHNldAp0aGUgcHJvdmlzaW9u
aW5nX21vZGUgYXR0cmlidXRlIHRvIHVubWFwLiBXaGVuIHNlYXJjaGluZyBmb3IKdGhpcyBhdHRy
aWJ1dGUgbmFtZSwgaSBmb3VuZCB0aGlzOgpkcml2ZXJzL3Njc2kvc2QuYzo3NDkKICBibGtfcXVl
dWVfbWF4X2Rpc2NhcmRfc2VjdG9ycyhxLCAuLi4pOwogIGJsa19xdWV1ZV9mbGFnX3NldChRVUVV
RV9GTEFHX0RJU0NBUkQsIHEpOwoKU28sIGl0IGxvb2tzIGxpa2UgdGhlIGFuc3dlciBpcyB5ZXMs
IHRoZXJlIGlzIGFuIGludGVyZmFjZSB0bwp0dXJuIG9uIGRpc2NhcmQgb2YgZGV2aWNlIGluIHJl
YWwgdGltZS4KClJlZ2FyZHMsCiAgVmljZW7Dpy4KCi0tIApZb3UgYXJlIHJlY2VpdmluZyB0aGlz
IG1haWwgYmVjYXVzZToKWW91IGFyZSB3YXRjaGluZyB0aGUgYXNzaWduZWUgb2YgdGhlIGJ1Zy4K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0
eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRv
dC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
