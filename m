From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH] f2fs: merge read IOs at ra_nat_pages()
Date: Fri, 22 Nov 2013 12:41:19 +0900
Message-ID: <1385091679.16054.5.camel@lcm>
References: <1385026550-21055-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1Vjhe7-0004je-Up
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 03:43:08 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Vjhe4-0002Dw-Is
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 03:43:07 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWN004XWBNK3I70@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 12:42:56 +0900 (KST)
In-reply-to: <1385026550-21055-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

CkhvdyBhYm91dCBkb2luZyBtYXJrX3BhZ2VfYWNjZXNzZWQocGFnZSkgaW4gcmFfbmF0X3BhZ2Vz
IGxpa2UKcmFfc2l0X3BhZ2VzIHRvIHByZXZlbnQgcmVhZGFoZWFkIHBhZ2VzIGFyZSByZWNsYWlt
ZWQgYnkgVk0/CgpPbiDrqqksIDIwMTMtMTEtMjEgYXQgMTg6MzUgKzA5MDAsIEphZWdldWsgS2lt
IHdyb3RlOgo+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgcG9saWN5IG9mIHN1Ym1pdHRpbmcgcmVh
ZCBiaW9zIGF0IHJhX25hdF9wYWdlcy4KPiAKPiBQcmV2aW91c2x5LCBmMmZzIHN1Ym1pdHMgc21h
bGwgcmVhZCBiaW9zIHdpdGggYmxvY2sgcGx1Z2dpbmcuCj4gQnV0LCB3aXRoIHRoaXMgcGF0Y2gs
IGYyZnMgaXRzZWxmIG1lcmdlcyByZWFkIGJpb3MgZmlyc3QgYW5kIHRoZW4gc3VibWl0cyBhCj4g
bGFyZ2UgYmlvLCB3aGljaCBjYW4gcmVkdWNlIHRoZSBiaW8gaGFuZGxpbmcgb3ZlcmhlYWRzLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IEphZWdldWsgS2ltIDxqYWVnZXVrLmtpbUBzYW1zdW5nLmNvbT4K
PiAtLS0KPiAgZnMvZjJmcy9ub2RlLmMgfCA4ICsrLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMv
bm9kZS5jIGIvZnMvZjJmcy9ub2RlLmMKPiBpbmRleCBiODQzYTViLi5jMDY4NzFmIDEwMDY0NAo+
IC0tLSBhL2ZzL2YyZnMvbm9kZS5jCj4gKysrIGIvZnMvZjJmcy9ub2RlLmMKPiBAQCAtODksMTMg
Kzg5LDEwIEBAIHN0YXRpYyB2b2lkIHJhX25hdF9wYWdlcyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpz
YmksIGludCBuaWQpCj4gIHsKPiAgCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gc2Jp
LT5tZXRhX2lub2RlLT5pX21hcHBpbmc7Cj4gIAlzdHJ1Y3QgZjJmc19ubV9pbmZvICpubV9pID0g
Tk1fSShzYmkpOwo+IC0Jc3RydWN0IGJsa19wbHVnIHBsdWc7Cj4gIAlzdHJ1Y3QgcGFnZSAqcGFn
ZTsKPiAgCXBnb2ZmX3QgaW5kZXg7Cj4gIAlpbnQgaTsKPiAgCj4gLQlibGtfc3RhcnRfcGx1Zygm
cGx1Zyk7Cj4gLQo+ICAJZm9yIChpID0gMDsgaSA8IEZSRUVfTklEX1BBR0VTOyBpKyssIG5pZCAr
PSBOQVRfRU5UUllfUEVSX0JMT0NLKSB7Cj4gIAkJaWYgKG5pZCA+PSBubV9pLT5tYXhfbmlkKQo+
ICAJCQluaWQgPSAwOwo+IEBAIC0xMDgsMTIgKzEwNSwxMSBAQCBzdGF0aWMgdm9pZCByYV9uYXRf
cGFnZXMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBpbnQgbmlkKQoKbWFya19wYWdlX2FjY2Vz
c2VkKHBhZ2UpOwoKPiAgCQkJZjJmc19wdXRfcGFnZShwYWdlLCAxKTsKPiAgCQkJY29udGludWU7
Cj4gIAkJfQo+IC0JCWlmIChmMmZzX3JlYWRwYWdlKHNiaSwgcGFnZSwgaW5kZXgsIFJFQUQpKQo+
IC0JCQljb250aW51ZTsKPiArCQlzdWJtaXRfcmVhZF9wYWdlKHNiaSwgcGFnZSwgaW5kZXgsIFJF
QURfU1lOQyk7Cj4gIAoKbWFya19wYWdlX2FjY2Vzc2VkKHBhZ2UpOwoKPiAgCQlmMmZzX3B1dF9w
YWdlKHBhZ2UsIDApOwo+ICAJfQo+IC0JYmxrX2ZpbmlzaF9wbHVnKCZwbHVnKTsKPiArCWYyZnNf
c3VibWl0X3JlYWRfYmlvKHNiaSwgUkVBRF9TWU5DKTsKPiAgfQo+ICAKPiAgc3RhdGljIHN0cnVj
dCBuYXRfZW50cnkgKl9fbG9va3VwX25hdF9jYWNoZShzdHJ1Y3QgZjJmc19ubV9pbmZvICpubV9p
LCBuaWRfdCBuKQoKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KU2hhcGUgdGhlIE1vYmlsZSBFeHBl
cmllbmNlOiBGcmVlIFN1YnNjcmlwdGlvbgpTb2Z0d2FyZSBleHBlcnRzIGFuZCBkZXZlbG9wZXJz
OiBCZSBhdCB0aGUgZm9yZWZyb250IG9mIHRlY2ggaW5ub3ZhdGlvbi4KSW50ZWwoUikgU29mdHdh
cmUgQWRyZW5hbGluZSBkZWxpdmVycyBzdHJhdGVnaWMgaW5zaWdodCBhbmQgZ2FtZS1jaGFuZ2lu
ZyAKY29udmVyc2F0aW9ucyB0aGF0IHNoYXBlIHRoZSByYXBpZGx5IGV2b2x2aW5nIG1vYmlsZSBs
YW5kc2NhcGUuIFNpZ24gdXAgbm93LiAKaHR0cDovL3B1YmFkcy5nLmRvdWJsZWNsaWNrLm5ldC9n
YW1wYWQvY2xrP2lkPTYzNDMxMzExJml1PS80MTQwL29zdGcuY2xrdHJrCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
