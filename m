From: =?UTF-8?B?5q635ZWf6IGw?= <seamlikok@gmail.com>
Subject: [PATCH] libf2fs_fmt Based on mkfs.f2fs Sources
Date: Thu, 10 Dec 2015 01:33:24 +0800
Message-ID: <CAKxyyfbhezbwtUubo15FhAis=HXmkKi91ceXm_NjrBMqfOnZSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <seamlikok@gmail.com>) id 1a6ich-0006J0-TI
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 17:33:51 +0000
Received: from mail-qg0-f50.google.com ([209.85.192.50])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a6icg-0002hL-E3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 17:33:51 +0000
Received: by qgcc31 with SMTP id c31so90803154qgc.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 09 Dec 2015 09:33:45 -0800 (PST)
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

SGkgZjJmcy10b29scyBtYWludGFpbmVycywKClRoaXMgcGF0Y2ggYWRkcyBhIHNlY3Rpb24gdG8g
bWtmcy9NYWtlZmlsZS5hbSB0byBidWlsZCBhIGxpYnJhcnkKImxpYmYyZnNfZm10Ii4gVGhpcyBs
aWJyYXJ5IGlzIGNvbXBpbGVkIGZyb20gdGhlIHNhbWUgc291cmNlcyBvZgpta2ZzLmYyZnMgYW5k
IGlzIHJlcXVpcmVkIGJ5IGxpYmYyZnNfdXRpbHMgYW5kIGZhc3Rib290IGZyb20gdGhlCkFuZHJv
aWQgT3BlbiBTb3VyY2UgUHJvamVjdCAoY2hlY2sKPGh0dHBzOi8vYW5kcm9pZC5nb29nbGVzb3Vy
Y2UuY29tL3BsYXRmb3JtL2V4dGVybmFsL2YyZnMtdG9vbHMvKy9tYXN0ZXIvQW5kcm9pZC5taz4p
LgpJIGFtIGZyb20gRGViaWFuJ3MgQW5kcm9pZCBUb29scyBNYWludGFpbmVyIHRlYW0gYW5kIEkg
YmVsaWV2ZSB0aGlzCnBhdGNoIGNhbiByZWR1Y2UgdGhlIGNoYW5nZXMgdG8gdGhlIHVwc3RyZWFt
IHNvdXJjZSB3aGVuIHdlIGFyZQpwYWNrYWdpbmcgQW5kcm9pZCBTREsuIFRoaXMgcGF0Y2ggaXMg
YWxzbyBhdmFpbGFibGUgYXQKPGh0dHBzOi8vZ2l0aHViLmNvbS9zZWFtbGlrL2YyZnMtdG9vbHMv
Y29tcGFyZS9saWJmMmZzX2ZtdD4uIFRoYW5rCnlvdSEKCmRpZmYgLS1naXQgYS9ta2ZzL01ha2Vm
aWxlLmFtIGIvbWtmcy9NYWtlZmlsZS5hbQppbmRleCA3MzQzZjIzLi44OTY5YTA0IDEwMDY0NAot
LS0gYS9ta2ZzL01ha2VmaWxlLmFtCisrKyBiL21rZnMvTWFrZWZpbGUuYW0KQEAgLTUsMyArNSw5
IEBAIEFNX0NGTEFHUyA9IC1XYWxsIC1EV0lUSF9CTEtESVNDQVJECiBzYmluX1BST0dSQU1TID0g
bWtmcy5mMmZzCiBta2ZzX2YyZnNfU09VUkNFUyA9IGYyZnNfZm9ybWF0X21haW4uYyBmMmZzX2Zv
cm1hdC5jCmYyZnNfZm9ybWF0X3V0aWxzLmMgZjJmc19mb3JtYXRfdXRpbHMuaAokKHRvcF9zcmNk
aXIpL2luY2x1ZGUvZjJmc19mcy5oCiBta2ZzX2YyZnNfTERBREQgPSAke2xpYnV1aWRfTElCU30g
JCh0b3BfYnVpbGRkaXIpL2xpYi9saWJmMmZzLmxhCisKK2xpYl9MVExJQlJBUklFUyA9IGxpYmYy
ZnNfZm9ybWF0LmxhCitsaWJmMmZzX2Zvcm1hdF9sYV9TT1VSQ0VTID0gZjJmc19mb3JtYXRfbWFp
bi5jIGYyZnNfZm9ybWF0LmMKZjJmc19mb3JtYXRfdXRpbHMuYworbGliZjJmc19mb3JtYXRfbGFf
Q0ZMQUdTID0gLURXSVRIX0JMS0RJU0NBUkQKK2xpYmYyZnNfZm9ybWF0X2xhX0NQUEZMQUdTID0g
LUkkKHRvcF9zcmNkaXIpL2luY2x1ZGUKK2xpYmYyZnNfZm9ybWF0X2xhX0xERkxBR1MgPSAtbHV1
aWQgLUwkKHRvcF9zcmNkaXIpL2xpYiAtbGYyZnMKCi0tIAovKgoqIOaut+WVn+iBsCB8IEthaS1D
aHVuZyBZYW4KKiDkuIDnlJ/lj6rlkJHnnJ/nkIboiIflprvlrZDkvY7poK0KKiBGdWxsLXRpbWUg
c3R1ZGVudCBvZiBOYXRpb25hbCBUYWljaHVuZyBVbml2ZXJzaXR5IG9mIEVkdWNhdGlvbgoqIExp
bmtlZEluOiA8aHR0cHM6Ly9saW5rZWRpbi5jb20vaW4vc2VhbWxpaz4KKiBCbG9nOiA8c2VhbWxp
ay5sb2dkb3duLmNvbT4KKi8KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
