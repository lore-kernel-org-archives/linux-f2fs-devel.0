From: "Arseniy Skvortsov" <ettavolt@gmail.com>
Subject: fsck.f2fs fails with "can't find valid checkpoint"
Date: Wed, 14 Mar 2018 09:07:45 +0300
Message-ID: <op.zfura7xx6r7ij4@ptits-lt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ettavolt@gmail.com>) id 1evzZs-0002Gy-DS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Mar 2018 06:07:56 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-lf0-f66.google.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1evzZn-00Ds9l-2h
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Mar 2018 06:07:53 +0000
Received: by mail-lf0-f66.google.com with SMTP id y2-v6so836096lfc.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Mar 2018 23:07:54 -0700 (PDT)
Received: from ptits-lt.lan (128-70-247-232.broadband.corbina.ru.
 [128.70.247.232])
 by smtp.gmail.com with ESMTPSA id c74-v6sm438502lfe.96.2018.03.13.23.07.46
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Tue, 13 Mar 2018 23:07:46 -0700 (PDT)
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

SGVsbG8sCgpJJ3ZlIGdvdCBhIHByb2JsZW0gdmVyeSBzaW1pbGFyIHRvICAKaHR0cHM6Ly9zb3Vy
Y2Vmb3JnZS5uZXQvcC9saW51eC1mMmZzL21haWxtYW4vbWVzc2FnZS8zNTkzMTk2MC8sIGp1c3Qg
dGhhdCAgCnRoZXJlIGlzIG5vIGVuY3J5cHRpb24uCllvdSBjYW4gdGFrZSBpbWFnZSBvZiBlbnRp
cmUgU1NEIGZyb20gIApodHRwczovL3JnLmV0dGF2b2x0Lm5sL2Z0cC9wdWJsaWMvMzJHQi5iaW4u
eHogKDI1ODU1NzE5NTg0IGJ5dGVzLCBzaG91bGQgIApoYXZlIHplcm9lZCB0aGUgZGlzayBiZWZv
cmUgaW5zdGFsbGF0aW9u4oCmKSAoc2l0ZSBtYXkgYmUgdW5hdmFpbGFibGUgZHVyaW5nICAKRE5T
IHVwZGF0ZSkuIENvbnRhaW5zIEdQVCB3aXRoIEVTUCBhbmQgcm9vdCBwYXJ0aXRpb24gc28geW91
IGNhbiB0cnkgdG8gIApib290IGlmIHlvdSB3aXNoLgpUaGVyZSBpcyBub3RoaW5nIHByaXZhdGUg
ZXhjZXB0IGZvciBwYXNzd29yZHMgb2Ygc3VkbyB1c2VyIGFuZCBXaUZpLiA6KQpXaGVuIHRoZSBw
cm9ibGVtIGhhcHBlbmVkLCB0aGUgc2Vzc2lvbiB3YXMgbGlrZTogYm9vdCwgY2hhbmdlIHRoZSBu
YW1lIG9mICAKc29tZSBmb2xkZXIgb3IgZmlsZSwgcnVuIE9PIHByZXNlbnRhdGlvbiwgY2xlYW5s
eSBzaHV0ZG93bi4KSSdtIGdvaW5nIHRvIGtlZXAgdGhpcyBkaXNrIGludGFjdCBmb3IgYSB3aGls
ZS4gSWYgeW91J2QgbGlrZSB0byB0cnkgIAphbnl0aGluZyBvbiBpdCBqdXN0IHRlbGwgbWUgd2hh
dC4KClAuUy4gSWYgaXQgaGVscHMsIEkgd2FzIG9ic2VydmluZyBzaW1pbGFyIGlzc3VlIGVhcmxp
ZXIgb24gNC45IGtlcm5lbCBmcm9tICAKQXJjaCBhbmQgcGxhaW4gZG0tY3J5cHQgcGFydGl0aW9u
LiBFdmVyeXRpbWUgaXQgaGFwcGVuZWQgYWZ0ZXIgSSd2ZSBib290ZWQgIApsaXZlIHN0aWNrLCBt
b3VudGVkIHJvb3QsIGVkaXRlZCBmc3RhYi9jcnlwdGFiLCB1bm1vdW50ZWQgcm9vdCAoYnV0ICAK
aGF2ZW4ndCBkZXRhY2hlZCBkbSBkZXZpY2UsIG5vdCBzdXJlIGlmIHN5c3RlbSBkb2VzIHRoaXMg
aXRzZWxmKSBhbmQgIApyZWJvb3RlZC4gU2luY2UgdGhlbiBJIHdhcyBydW5uaW5nIHRoZSBzYW1l
IHNldHVwIG9uIDQuOS43MyB3aXRoIHNvbWUgIApiaWdnZXIgd3JpdGVzIHRvIGYyZnMgcGFydGl0
aW9uLiBJdCBzdXJ2aXZlZCBzZXZlcmFsIHVuY2xlYW4gcG93ZXJvZmZzLgoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2Yg
dGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6
Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
