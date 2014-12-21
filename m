From: Ankur Tank <artfri2@gmail.com>
Subject: F2fs on eMMC on Beaglebone Black based custom board.
Date: Sun, 21 Dec 2014 08:43:37 +0530
Message-ID: <CAHoHJEjCgLyn-Om-g5G9LhjTfBKyVf4PR1fa45nPvDL2Ue+6Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <artfri2@gmail.com>) id 1Y2Wxj-0008Ux-BU
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 03:13:44 +0000
Received: from mail-ie0-f172.google.com ([209.85.223.172])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Y2Wxi-0001wI-Lh
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 03:13:43 +0000
Received: by mail-ie0-f172.google.com with SMTP id tr6so2796447ieb.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 20 Dec 2014 19:13:37 -0800 (PST)
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

SGVsbG8gQWxsLAoKV2UgYXJlIGRldmVsb3BpbmcgQmVhZ2xlYm9uZSBibGFjayBiYXNlZCBDdXN0
b20gYm9hcmQgd2l0aCBlTU1DLgpXZSB3YW50IHRvIGRlY2lkZSB0aGUgZmlsZS1zeXN0ZW0gZm9y
IFJGUyBwYXJ0aXRpb24gb2YgZU1NQy4KV2UgYXJlIGluIHByb2Nlc3Mgb2YgdGVzdGluZy9CZW5j
aG1hcmtpbmcgZGlmZmVyZW50IGZpbGVzeXN0ZW0gb24gQkJCIGl0c2VsZi4KTWFqb3IgY29udHJp
YnV0b3IgdG8gd3JpdGVzIHRvIHRoZSBmaWxlc3lzdGVtIGlzIGRvbmUgYnkgbG9nZ2luZyBwcm9j
ZXNzLgpUbyBmaW5hbGl6ZSB0aGUgZmlsZS1zeXN0ZW0gd2UgbmVlZCBzb21lIGhlbHAgZnJvbSBk
ZXZlbG9wZXJzLgpCZWxvdyBhcmUgb3VyIHNwZWNpZmljIHF1ZXN0aW9ucywgS2luZGx5IGd1aWRl
IHVzLgoKMS4gV2UgYXJlIHVzaW5nIExpbnV4IGtlcm5lbCAzLjEyLCBpcyBGMmZzIHN0YWJsZSBm
b3IgdGhhdCB2ZXJzaW9uPwoyLiBJcyB0aGVyZSBhbnkgdHVuaW5nIG9wdGlvbiB0byByZWR1Y2Ug
dGhlIGRhdGEgbG9zcyBkdXJpbmcgc3VkZGVuCnBvd2VyIGxvc3MvZmFpbHVyZXMuCjMuIE9uIG9u
ZSB0aGUgZm9ydW1zIHdlIHJlYWQgdGhhdCwgRjJmMiBkb2Vu4oCZdCB3cml0ZXMgYWdncmVzc2l2
ZWx5IHRvCnRoZSBkaXNrIHNvIHRoZXJlIGlzIGNoYW5jZSBvZiBsb3NpbmcgZGF0YSwgaXMgdGhl
cmUgYW55IG9wdGlvbiB0bwp0dW5lL2NvbnRyb2wgaXQ/CjQuIFNvbWUgZm9ydW0gc2F5cyBpdOKA
mXMgbm90IGdvb2QgZm9yIHNtYWxsIG1lbW9yeT8gSXMgaXQgdHJ1ZT8gSWYgeWVzCndoYXQgaXMg
dGhlIG1pbmltdW0gc2l6ZSBvZiBtZW1vcnkgaWRlYWwgZm9yIEYyRlMgPwoKVGhhbmsgeW91LAoK
UmVnYXJkcywKQW5rdXIKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpEb3dubG9hZCBCSVJUIGlIdWIg
Ri1UeXBlIC0gVGhlIEZyZWUgRW50ZXJwcmlzZS1HcmFkZSBCSVJUIFNlcnZlcgpmcm9tIEFjdHVh
dGUhIEluc3RhbnRseSBTdXBlcmNoYXJnZSBZb3VyIEJ1c2luZXNzIFJlcG9ydHMgYW5kIERhc2hi
b2FyZHMKd2l0aCBJbnRlcmFjdGl2aXR5LCBTaGFyaW5nLCBOYXRpdmUgRXhjZWwgRXhwb3J0cywg
QXBwIEludGVncmF0aW9uICYgbW9yZQpHZXQgdGVjaG5vbG9neSBwcmV2aW91c2x5IHJlc2VydmVk
IGZvciBiaWxsaW9uLWRvbGxhciBjb3Jwb3JhdGlvbnMsIEZSRUUKaHR0cDovL3B1YmFkcy5nLmRv
dWJsZWNsaWNrLm5ldC9nYW1wYWQvY2xrP2lkPTE2NDcwMzE1MSZpdT0vNDE0MC9vc3RnLmNsa3Ry
awpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1m
MmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
MmZzLWRldmVsCg==
