From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: fix build warning for
	f2fs_has_inline_data()
Date: Fri, 27 Dec 2013 18:22:03 +0900
Message-ID: <1388136123.2101.310.camel@kjgkr>
References: <1388126708-27839-1-git-send-email-haicheng.li@linux.intel.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VwTdb-0002b8-LX
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 09:23:23 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwTdZ-0004fi-Pl
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 09:23:23 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYG0047EKQQV1E0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 18:23:14 +0900 (KST)
In-reply-to: <1388126708-27839-1-git-send-email-haicheng.li@linux.intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Haicheng Li <haicheng.li@linux.intel.com>
Cc: Huajun Li <huajun.li@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Haicheng Li <haicheng.lee@gmail.com>, linux-fsdevel@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>

SGksCgpDb3VsZCB5b3UgcmVmZXIgdGhlIGZvbGxvd2luZyBwYXRjaCB0aGF0IEkgc2VudD8KClJl
OiBbUEFUQ0ggNS82XSBmMmZzOiBhZGQgdGhlIG51bWJlciBvZiBpbmxpbmVfZGF0YSBmaWxlcyB0
byBzdGF0dXMgaW5mbwoKVGhhbmtzLAoKMjAxMy0xMi0yNyAo6riIKSwgMTQ6NDUgKzA4MDAsIEhh
aWNoZW5nIExpOgo+IFRoaXMgcGF0Y2ggaXMgdG8gZml4IHRoZSBpc3N1ZSByZXBvcnRlZCBieSBG
ZW5nZ3VhbmcgV3U6Cj4gPiBOb3RlOiB0aGUgZjJmcy9saW51eC0zLjQgSEVBRCAyMmE0OGQxODgw
MjQ4MzBkNjEzNjVjZTk3YTBhOGEwYmVkZDQ5NGE5IGJ1aWxkcyBmaW5lLgo+ID4gICAgICAgSXQg
b25seSBodXJ0cyBiaXNlY3RpYmlsaXR5Lgo+ID4KPiA+IEFsbCBlcnJvci93YXJuaW5nczoKPiA+
Cj4gPiAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZnMvZjJmcy9kYXRhLmM6MjI6MDoKPiA+ICAg
IGZzL2YyZnMvZGF0YS5jOiBJbiBmdW5jdGlvbiAnZjJmc19kaXJlY3RfSU8nOgo+ID4gPj4gZnMv
ZjJmcy9mMmZzLmg6MTMwMjoxMjogZXJyb3I6IGlubGluaW5nIGZhaWxlZCBpbiBjYWxsIHRvCj4g
PiA+PiBhbHdheXNfaW5saW5lICdmMmZzX2hhc19pbmxpbmVfZGF0YSc6IGZ1bmN0aW9uIGJvZHkg
bm90IGF2YWlsYWJsZQo+ID4gICAgIGlubGluZSBpbnQgZjJmc19oYXNfaW5saW5lX2RhdGEoc3Ry
dWN0IGlub2RlICopOwo+IC4uc25pcC4uCj4gCj4gU2lnbmVkLW9mZi1ieTogSGFpY2hlbmcgTGkg
PGhhaWNoZW5nLmxpQGxpbnV4LmludGVsLmNvbT4KPiBSZXBvcnRlZC1ieTogRmVuZ2d1YW5nIFd1
IDxmZW5nZ3Vhbmcud3VAaW50ZWwuY29tPgo+IENjOiBIdWFqdW4gTGkgPGh1YWp1bi5saUBpbnRl
bC5jb20+Cj4gLS0tCj4gIGZzL2YyZnMvZjJmcy5oICAgfCAgICA1ICsrKystCj4gIGZzL2YyZnMv
aW5saW5lLmMgfCAgICA1IC0tLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2YyZnMuaCBiL2ZzL2Yy
ZnMvZjJmcy5oCj4gaW5kZXggNjk5MWEyOC4uZTE0M2NhMSAxMDA2NDQKPiAtLS0gYS9mcy9mMmZz
L2YyZnMuaAo+ICsrKyBiL2ZzL2YyZnMvZjJmcy5oCj4gQEAgLTEzMTQsNyArMTMxNCwxMCBAQCBl
eHRlcm4gY29uc3Qgc3RydWN0IGlub2RlX29wZXJhdGlvbnMgZjJmc19zcGVjaWFsX2lub2RlX29w
ZXJhdGlvbnM7Cj4gIC8qCj4gICAqIGlubGluZS5jCj4gICAqLwo+IC1pbmxpbmUgaW50IGYyZnNf
aGFzX2lubGluZV9kYXRhKHN0cnVjdCBpbm9kZSAqKTsKPiArc3RhdGljIGlubGluZSBpbnQgZjJm
c19oYXNfaW5saW5lX2RhdGEoc3RydWN0IGlub2RlICppbm9kZSkKPiArewo+ICsJcmV0dXJuIGlz
X2lub2RlX2ZsYWdfc2V0KEYyRlNfSShpbm9kZSksIEZJX0lOTElORV9EQVRBKTsKPiArfQo+ICBi
b29sIGYyZnNfbWF5X2lubGluZShzdHJ1Y3QgaW5vZGUgKik7Cj4gIGludCBmMmZzX3JlYWRfaW5s
aW5lX2RhdGEoc3RydWN0IGlub2RlICosIHN0cnVjdCBwYWdlICopOwo+ICBpbnQgZjJmc19jb252
ZXJ0X2lubGluZV9kYXRhKHN0cnVjdCBpbm9kZSAqLCBwZ29mZl90KTsKPiBkaWZmIC0tZ2l0IGEv
ZnMvZjJmcy9pbmxpbmUuYyBiL2ZzL2YyZnMvaW5saW5lLmMKPiBpbmRleCAwZTk0MGNlLi5iY2M2
ZjY1IDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvaW5saW5lLmMKPiArKysgYi9mcy9mMmZzL2lubGlu
ZS5jCj4gQEAgLTEzLDExICsxMyw2IEBACj4gIAo+ICAjaW5jbHVkZSAiZjJmcy5oIgo+ICAKPiAt
aW5saW5lIGludCBmMmZzX2hhc19pbmxpbmVfZGF0YShzdHJ1Y3QgaW5vZGUgKmlub2RlKQo+IC17
Cj4gLQlyZXR1cm4gaXNfaW5vZGVfZmxhZ19zZXQoRjJGU19JKGlub2RlKSwgRklfSU5MSU5FX0RB
VEEpOwo+IC19Cj4gLQo+ICBib29sIGYyZnNfbWF5X2lubGluZShzdHJ1Y3QgaW5vZGUgKmlub2Rl
KQo+ICB7Cj4gIAlzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkgPSBGMkZTX1NCKGlub2RlLT5pX3Ni
KTsKCi0tIApKYWVnZXVrIEtpbQpTYW1zdW5nCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpSYXBp
ZGx5IHRyb3VibGVzaG9vdCBwcm9ibGVtcyBiZWZvcmUgdGhleSBhZmZlY3QgeW91ciBidXNpbmVz
cy4gTW9zdCBJVCAKb3JnYW5pemF0aW9ucyBkb24ndCBoYXZlIGEgY2xlYXIgcGljdHVyZSBvZiBo
b3cgYXBwbGljYXRpb24gcGVyZm9ybWFuY2UgCmFmZmVjdHMgdGhlaXIgcmV2ZW51ZS4gV2l0aCBB
cHBEeW5hbWljcywgeW91IGdldCAxMDAlIHZpc2liaWxpdHkgaW50byB5b3VyIApKYXZhLC5ORVQs
ICYgUEhQIGFwcGxpY2F0aW9uLiBTdGFydCB5b3VyIDE1LWRheSBGUkVFIFRSSUFMIG9mIEFwcER5
bmFtaWNzIFBybyEKaHR0cDovL3B1YmFkcy5nLmRvdWJsZWNsaWNrLm5ldC9nYW1wYWQvY2xrP2lk
PTg0MzQ5ODMxJml1PS80MTQwL29zdGcuY2xrdHJrCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
