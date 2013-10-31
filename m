From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: F2FS Superblock Locations
Date: Thu, 31 Oct 2013 10:55:50 +0900
Message-ID: <1383184550.14041.29.camel@kjgkr>
References: <CAECMkcPVofeNqT=9jYp5arM5_EikERojWdj+tEqKzecWh4nZRg@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VbhV0-0004YQ-Cf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Oct 2013 01:56:38 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VbhUy-0004o6-8Y for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Oct 2013 01:56:38 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MVI00E5SG1R4EC0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Oct 2013 10:56:29 +0900 (KST)
In-reply-to: <CAECMkcPVofeNqT=9jYp5arM5_EikERojWdj+tEqKzecWh4nZRg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Zachary <zacharyw09264@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgoyMDEzLTEwLTMwICjsiJgpLCAyMTowNiAtMDQwMCwgWmFjaGFyeToKPiBIZWxsbywKPiAK
PiBSZWNlbnRseSBJIHdhcyBjaGVja2luZyB0aGUgZmlsZSBmb3JtYXQgZm9yIEYyRlMgYW5kIG5v
dGljZWQgdGhhdCB0aGUKPiBzdXBlcmJsb2NrcycgbG9jYXRpb24gb24gdGhlIHBhcnRpdGlvbiB3
YXMgYm90aCBhdCB0aGUgYmVnaW5uaW5nLgo+IFRoaXMgbWVhbnMgdGhhdCBpZiBhIGxhcmdlIHBv
cnRpb24gb2YgdGhlIHBhcnRpdGlvbiBpcyBjb3JydXB0ZWQsIHRoZW4KPiBpdCBpcyBwb3NzaWJs
ZSBmb3IgYm90aCBzdXBlcmJsb2NrcyB0byBiZSBkZXN0cm95ZWQuICBGcm9tIG15Cj4gdW5kZXJz
dGFuZGluZyBvZiBvdGhlciBmaWxlc3lzdGVtcywgdGhleSBwcmV2ZW50IHRoYXQgYnkgc3ByZWFk
aW5nIG91dAo+IHRoZSBzdXBlcmJvbG9jayBiYWNrdXBzIGFjcm9zcyB0aGUgcGFydGl0aW9uIHNv
IHRoYXQgaXQgcmVkdWNlcyB0aGUKPiBjaGFuY2VzIG9mIGFsbCBzdXBlcmJsb2NrcyBiZWluZyBk
ZXN0cm95ZWQuICBIYXMgdGhpcyBiZWVuIG5vdGljZWQKPiBiZWZvcmUgb3IgYW0gSSBtaXN0YWtl
biBpbiBzb21lIHdheT8KCklNSE8sIHRyYWRpdGlvbmFsIHJvdGF0aW9uYWwgZGlza3MgbGlrZSBI
RERzIG5lZWQgc3VjaCB0aGUgc3VwZXJibG9jawpiYWNrdXBzLgoKQnV0IGZvciB0aGUgc29saWQt
c3RhdGUgZGlza3MgbGlrZSBTU0RzIGFuZCBlTU1DcywgSSBzdXNwZWN0IHRoYXQgdGhlCmJhY2t1
cHMgYXJlIG5lZWRlZCBpbiBwcmFjdGljYWwsIHNpbmNlIGl0cyBmaXJtd2FyZSwgRlRMLCBzcHJl
YWRzIHRoZQpkYXRhIGFjcm9zcyB0aGUgd2hvbGUgTkFORCBhcnJheXMgdG8gYXZvaWQgY2VsbCBl
cnJvcnMgKGUuZy4sIHdlYXItb3V0KS4KU28gSSB0aGluayB0aGUgc3VwZXJibG9jayBpcyB2ZXJ5
IG11Y2ggaGFyZCB0byBiZSBicm9rZW4gZXNwZWNpYWxseSBvbgpmbGFzaCBzdG9yYWdlcy4KClRo
YW5rIHlvdSwKCgotLSAKSmFlZ2V1ayBLaW0KU2Ftc3VuZwoKCgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KQW5kcm9pZCBpcyBpbmNyZWFzaW5nIGluIHBvcHVsYXJpdHksIGJ1dCB0aGUgb3BlbiBkZXZl
bG9wbWVudCBwbGF0Zm9ybSB0aGF0CmRldmVsb3BlcnMgbG92ZSBpcyBhbHNvIGF0dHJhY3RpdmUg
dG8gbWFsd2FyZSBjcmVhdG9ycy4gRG93bmxvYWQgdGhpcyB3aGl0ZQpwYXBlciB0byBsZWFybiBt
b3JlIGFib3V0IHNlY3VyZSBjb2RlIHNpZ25pbmcgcHJhY3RpY2VzIHRoYXQgY2FuIGhlbHAga2Vl
cApBbmRyb2lkIGFwcHMgc2VjdXJlLgpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dh
bXBhZC9jbGs/aWQ9NjU4Mzk5NTEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5n
IGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
