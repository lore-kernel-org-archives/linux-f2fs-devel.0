From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] fails to build
Date: Mon, 08 Jul 2013 18:46:11 +0900
Message-ID: <1373276771.14296.30.camel@lcm>
References: <20130706145001.GB19245@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1Uw836-0000QH-5d
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Jul 2013 09:48:00 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uw833-0002fA-T6 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Jul 2013 09:48:00 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MPM00N4437F39O0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Jul 2013 18:47:45 +0900 (KST)
In-reply-to: <20130706145001.GB19245@belle.intranet.vanheusden.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: folkert <folkert@vanheusden.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

SSdtIHNvcnJ5IHRvIGZhaWwgY29tcGlsaW5nLgpGcmFua2x5IHNwZWFraW5nLCBJIGRvbid0IGtu
b3cgdGhlIHNvbHV0aW9uIGFib3V0IGl0LiBJIGd1ZXNzIGl0J3MgZHVlCnRvIHZlcnNpb24gb2Yg
bGlidG9vbGl6ZS4KSSdtIHVzaW5nICdsaWJ0b29saXplIChHTlUgbGlidG9vbCkgMi40LjInLgpJ
J2xsIHRoaW5rIGFib3V0IHRoZSAqLmRlYiBvZiBmMmZzLXRvb2xzIGEgbGl0dGxlIG1vcmUuCgpU
aGFua3MuCgoKT24g7YagLCAyMDEzLTA3LTA2IGF0IDE2OjUwICswMjAwLCBmb2xrZXJ0IHdyb3Rl
Ogo+IEhpLAo+IAo+IGYyZnMtdG9vbHMgZmFpbHMgdG8gYnVpbGQ6Cj4gCj4gcm9vdEB2bnZuYXRp
b246L3Vzci9zcmMvZjJmcy10b29scyMgYXV0b3JlY29uZiAtLWluc3RhbGwKPiBjb25maWd1cmUu
YWM6MzY6IGluc3RhbGxpbmcgYGJ1aWxkLWF1eC9pbnN0YWxsLXNoJwo+IGNvbmZpZ3VyZS5hYzoz
NjogaW5zdGFsbGluZyBgYnVpbGQtYXV4L21pc3NpbmcnCj4gZnNjay9NYWtlZmlsZS5hbTogaW5z
dGFsbGluZyBgYnVpbGQtYXV4L2RlcGNvbXAnCj4gbGliL01ha2VmaWxlLmFtOjM6IExpYnRvb2wg
bGlicmFyeSB1c2VkIGJ1dCBgTElCVE9PTCcgaXMgdW5kZWZpbmVkCj4gbGliL01ha2VmaWxlLmFt
OjM6ICAgVGhlIHVzdWFsIHdheSB0byBkZWZpbmUgYExJQlRPT0wnIGlzIHRvIGFkZCBgTFRfSU5J
VCcKPiBsaWIvTWFrZWZpbGUuYW06MzogICB0byBgY29uZmlndXJlLmFjJyBhbmQgcnVuIGBhY2xv
Y2FsJyBhbmQgYGF1dG9jb25mJyBhZ2Fpbi4KPiBsaWIvTWFrZWZpbGUuYW06MzogICBJZiBgTFRf
SU5JVCcgaXMgaW4gYGNvbmZpZ3VyZS5hYycsIG1ha2Ugc3VyZQo+IGxpYi9NYWtlZmlsZS5hbToz
OiAgIGl0cyBkZWZpbml0aW9uIGlzIGluIGFjbG9jYWwncyBzZWFyY2ggcGF0aC4KPiBhdXRvcmVj
b25mOiBhdXRvbWFrZSBmYWlsZWQgd2l0aCBleGl0IHN0YXR1czogMQo+IAo+IEkgdHJpZWQgYWRk
aW5nIExUX0lOSVQgdG8gY29uZmlndXJlLmFjIGJ1dCB0aGF0IGRpZCBub3QgaGVscC4KPiAKPiBB
bnkgaWRlYXM/Cj4gCj4gQWxzbzogcGxlYXNlIGNvbnNpZGVyIHB1Ymxpc2hpbmcgZGViaWFuIHBh
Y2thZ2VzLgo+IAo+IAo+IEZvbGtlcnQgdmFuIEhldXNkZW4KPiAKCgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tClRoaXMgU0YubmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSBXaW5kb3dzOgoKQnVpbGQg
Zm9yIFdpbmRvd3MgU3RvcmUuCgpodHRwOi8vcC5zZi5uZXQvc2Z1L3dpbmRvd3MtZGV2MmRldgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCg==
