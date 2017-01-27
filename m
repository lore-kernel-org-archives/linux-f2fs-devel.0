From: V10lator <v10lator@myway.de>
Subject: Unrecoverable FS errors
Date: Fri, 27 Jan 2017 13:11:43 +0100
Message-ID: <29539c24-f249-41c6-aa1e-d7851140e20c@myway.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <v10lator@myway.de>) id 1cX5eo-0003f1-DG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 12:29:34 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cX5em-0002yj-EC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 12:29:34 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3v8yM43W3Pz3hjr0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 13:11:44 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3v8yM43QLyzvkdS
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 13:11:44 +0100 (CET)
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
	port 10024) with ESMTP id Qo0BrIQSP3FE
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 13:11:43 +0100 (CET)
Received: from localhost (ppp-188-174-80-15.dynamic.mnet-online.de
	[188.174.80.15])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPS
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 13:11:43 +0100 (CET)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

SGksCgpGaXJzdCBvZmYgaWYgdGhpcyBpcyB0aGUgd3JvbmcgbWFpbGluZyBsaXN0IHBsZWFzZSB0
ZWxsIG1lLCBJIGp1c3QgY291bGRuJ3QgCmZpbmQgYW55IG90aGVyIGZvciBmMmZzLgoKQXJvdW5k
IGEgeWVhciAobWF5YmUgbG9uZ2VyKSBhZ28gbXkgY29tcHV0ZXIgY3Jhc2hlZCwgdGhlIG9ubHkg
d2F5IHdhcyBhIApoYXJkIHJlc2V0IHdoaWNoIGNhdXNlZCBmMmZzIGNvcnJ1cHRpb25zLiBTaW5j
ZSB0aGVuIGZzY2suZjJmcyAtZiBmaW5kcyAKZXJyb3JzLiBUaGVzZSBhcmUgYWx3YXlzIHRoZSBz
YW1lIGVycm9ycy4KClRvZGF5IEkgbm90aWNlZCBteSBwYWNrYWdlIG1hbmFnZXIgdW5saW5raW5n
IGEgZGVhdGggbGluayBidXQgdGhhdCBmYWlsZWQsIApzbyBJIGxvb2tlZCBpbnRvIHRoZSBkaXJl
Y3RvcnkgZm9yIG15c2VsZjoKCmxzIC9ldGMvc3NsL2NlcnRzLyB8IGdyZXAgRUJHX0VsZWt0cm9u
aWsKRUJHX0VsZWt0cm9uaWtfU2VydGlmaWthX0hpem1ldF9TYcSfbGF5xLFjxLFzxLEucGVtCgoK
c28gdGhlIGZpbGUgaXMgdGhlcmUsIGxldCdzIGxvb2sgY2xvc2VyOgoKJCBMQU5HPUMgbHMgLWwg
L2V0Yy9zc2wvY2VydHMvIHwgZ3JlcCBFQkdfRWxla3Ryb25pawpsczogWnVncmlmZiBhdWYgCicv
ZXRjL3NzbC9jZXJ0cy9FQkdfRWxla3Ryb25pa19TZXJ0aWZpa2FfSGl6bWV0X1NhxJ9sYXnEsWPE
sXPEsS5wZW0nIG5pY2h0IAptw7ZnbGljaDogRGF0ZWkgb2RlciBWZXJ6ZWljaG5pcyBuaWNodCBn
ZWZ1bmRlbgpsPz8/Pz8/Pz8/ID8gPyAgICA/ICAgICAgICAgPyAgICAgICAgICAgICA/IApFQkdf
RWxla3Ryb25pa19TZXJ0aWZpa2FfSGl6bWV0X1NhxJ9sYXnEsWPEsXPEsS5wZW0KCgpEb2Vzbid0
IGxvb2sgZ29vZC4gT25lIG1vcmUgdHJ5OgoKJCBMQU5HPUMgZmlsZSAKL2V0Yy9zc2wvY2VydHMv
RUJHX0VsZWt0cm9uaWtfU2VydGlmaWthX0hpem1ldF9TYcSfbGF5xLFjxLFzxLEucGVtCi9ldGMv
c3NsL2NlcnRzL0VCR19FbGVrdHJvbmlrX1NlcnRpZmlrYV9IaXptZXRfU2HEn2xhecSxY8Sxc8Sx
LnBlbTogY2Fubm90IG9wZW4gCmAvZXRjL3NzbC9jZXJ0cy9FQkdfRWxla3Ryb25pa19TZXJ0aWZp
a2FfSGl6bWV0X1NhxJ9sYXnEsWPEsXPEsS5wZW0nIChObyBzdWNoIApmaWxlIG9yIGRpcmVjdG9y
eSkKCgpPa2F5LCBzbyB0aGUgZmlsZSBpcyBjbGVhcmx5IGNvcnJ1cHRlZC4gTGV0J3MgcmVtb3Zl
IGl0OgoKIyBMQU5HPUMgTENfQUxMPUMgcm0gCi9ldGMvc3NsL2NlcnRzL0VCR19FbGVrdHJvbmlr
X1NlcnRpZmlrYV9IaXptZXRfU2HEn2xhecSxY8Sxc8SxLnBlbQpybTogY2Fubm90IHJlbW92ZSAK
Jy9ldGMvc3NsL2NlcnRzL0VCR19FbGVrdHJvbmlrX1NlcnRpZmlrYV9IaXptZXRfU2EnJCdcMzA0
XDIzNycnbGF5JyQnXDMwNFwyNjEnJ2MnJCdcMzA0XDI2MScncyckJ1wzMDRcMjYxJycucGVtJzog
Ck5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKCgoKSXMgdGhlcmUgYW55dGhpbmcgSSBjYW4gZG8g
dG8gcmVtb3ZlIHRoYXQgZmlsZSAob3IgdGhlIGRpcmVjdG9yeSBlbnRyeSBhcyBJIAp0aGluayB0
aGVyZSBpcyBubyBmaWxlKSA/CgpUaGFua3MsClRob21hcyAiVjEwbGF0b3IiIFJvaGxvZmYKCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkg
b24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hEb3Qu
b3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
