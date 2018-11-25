From: Perfect Gentleman <perfect007gentleman@gmail.com>
Subject: Bug in f2fs-tools-1.12.0
Date: Sun, 25 Nov 2018 12:24:24 +0700
Message-ID: <e8884c8d-9009-cb70-bdf1-73fc38e83abc@GMail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <perfect007gentleman@gmail.com>) id 1gQmuJ-0005oX-HS
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 25 Nov 2018 05:24:35 +0000
Received: from mail-lj1-f174.google.com ([209.85.208.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gQmuH-00DsTK-KA
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 25 Nov 2018 05:24:35 +0000
Received: by mail-lj1-f174.google.com with SMTP id v15-v6so13650186ljh.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 24 Nov 2018 21:24:33 -0800 (PST)
Received: from [192.168.88.11] ([31.135.34.118])
 by smtp.gmail.com with ESMTPSA id r199sm8613555lff.50.2018.11.24.21.24.24
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 24 Nov 2018 21:24:25 -0800 (PST)
Content-Language: ru-RU
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

SGkgZjJmcy10ZWFtLAoKdGhlcmUgaXMgYnVnOiBmc2NrLmYyZnMgY2Fubm90IGNoZWNrIHJlYWQt
b25seSBmaWxlc3lzdGVtLiBCdXQgMS4xMS4wIApjYW4gZG8gdGhhdC4KCmZzY2vCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8SW5mbzogRml4IHRoZSByZXBvcnRlZCBjb3JydXB0aW9uLgpmc2Nr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfEluZm86IE1vdW50ZWQgZGV2aWNlIQpmc2NrwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfEluZm86IENoZWNrIEZTIG9ubHkgZHVlIHRvIFJPCmZz
Y2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8RXJyb3I6IEZhaWxlZCB0byBvcGVuIHRoZSBk
ZXZpY2UhCmZzY2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8ICogRmlsZXN5c3RlbXMgY291
bGRuJ3QgYmUgZml4ZWQKIMKgWyAhISBdCmZzY2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
ICogRVJST1I6IGZzY2sgZmFpbGVkIHRvIHN0YXJ0CgpSZWdhcmRzLApBbGV4CgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
