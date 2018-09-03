From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200951] kernel NULL pointer dereference in
 update_sit_entry
Date: Mon, 03 Sep 2018 09:41:44 +0000
Message-ID: <bug-200951-202145-nc3JRSKBGE@https.bugzilla.kernel.org/>
References: <bug-200951-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fwlMo-0000xm-Dr
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 03 Sep 2018 09:41:54 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fwlMm-0085q1-Ft
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 03 Sep 2018 09:41:54 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8AC6C29581
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Sep 2018 09:41:44 +0000 (UTC)
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
b21tZW50ICMxMyBmcm9tIENoYW8gWXUgKGNoYW9Aa2VybmVsLm9yZykgLS0tCihJbiByZXBseSB0
byB2aWNlbmNiIGZyb20gY29tbWVudCAjMTIpCj4gQXMgc3RhdGVkIGluIHRoZSBidWcgZGVzY3Jp
cHRpb24sIHRoZXJlIGlzIGFuIHVkZXYgcnVsZSB0byBzZXQKClNvcnJ5LCBJIG1pc3NlZCB0aGlz
IG9uZS4uLiA6KAoKPiB0aGUgcHJvdmlzaW9uaW5nX21vZGUgYXR0cmlidXRlIHRvIHVubWFwLiBX
aGVuIHNlYXJjaGluZyBmb3IKPiB0aGlzIGF0dHJpYnV0ZSBuYW1lLCBpIGZvdW5kIHRoaXM6Cj4g
ZHJpdmVycy9zY3NpL3NkLmM6NzQ5Cj4gICBibGtfcXVldWVfbWF4X2Rpc2NhcmRfc2VjdG9ycyhx
LCAuLi4pOwo+ICAgYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfRElTQ0FSRCwgcSk7Cj4g
Cj4gU28sIGl0IGxvb2tzIGxpa2UgdGhlIGFuc3dlciBpcyB5ZXMsIHRoZXJlIGlzIGFuIGludGVy
ZmFjZSB0bwo+IHR1cm4gb24gZGlzY2FyZCBvZiBkZXZpY2UgaW4gcmVhbCB0aW1lLgoKQWxyaWdo
dCwgbGV0IG1lIHNlbmQgb25lIHBhdGNoIHRvIGZpeCB0aGlzIGlzc3VlLgoKPiAKPiBSZWdhcmRz
LAo+ICAgVmljZW7Dpy4KCi0tIApZb3UgYXJlIHJlY2VpdmluZyB0aGlzIG1haWwgYmVjYXVzZToK
WW91IGFyZSB3YXRjaGluZyB0aGUgYXNzaWduZWUgb2YgdGhlIGJ1Zy4KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2YgdGhl
IHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9z
ZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
