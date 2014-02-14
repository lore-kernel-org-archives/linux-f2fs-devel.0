From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: f2fs unmount hangs if f2fs_init_acl() fails
 during mkdir syscall
Date: Fri, 14 Feb 2014 10:58:31 +0900
Message-ID: <1392343111.25542.113.camel@kjgkr>
References: <52F320FC.50803@ispras.ru> <1391666564.25542.78.camel@kjgkr>
	<52F37D67.208@ispras.ru> <1391734185.25542.80.camel@kjgkr>
	<1391749933.25542.83.camel@kjgkr> <52F9DF85.7040402@ispras.ru>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WE84e-0003MW-Ks
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Feb 2014 02:00:16 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WE84c-0004V8-J2
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Feb 2014 02:00:16 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0Y004RPQW50890@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Feb 2014 11:00:05 +0900 (KST)
In-reply-to: <52F9DF85.7040402@ispras.ru>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Andrey Tsyvarev <tsyvarev@ispras.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

SGksCgpTb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UuCkkgc3VmZmVyZWQgZnJvbSBmbHUgZHVy
aW5nIGxhc3QgYSBjb3VwbGUgb2YgZGF5cy4gOigKCjIwMTQtMDItMTEgKO2ZlCksIDEyOjI5ICsw
NDAwLCBBbmRyZXkgVHN5dmFyZXY6Cj4gSGksCj4gCj4gPiBJdCB0dXJucyBvdXQgdGhhdCBtYWtl
X2JhZF9pbm9kZSBwcmlvciB0byBpcHV0IHNldHMgaV9tb2RlIHRvIGEgcmVndWxhcgo+ID4gZmls
ZSwgc28gdGhhdCBmMmZzX2V2aWN0X2lub2RlIC0+IHRydW5jYXRlX2lub2RlX3BhZ2VzIC0+Cj4g
PiBmMmZzX2ludmFsaWRhdGVfZGF0YV9wYWdlIGRvZXNuJ3QgZGVjcmVtZW50IGRpcnR5X2RlbnRz
Lgo+ID4KPiBJdCBzZWVtcyB0aGF0IHJlbW92ZV9kaXJ0eV9kaXJfaW5vZGUoKSBjYWxsIHNob3Vs
ZCBhbHNvIGJlIGFkZGVkIHRvIHRoZSAKPiBlcnJvci1wYXRoIG9mCj4gaW5pdF9pbm9kZV9tZXRh
ZGF0YSwgYmVjYXVzZSBpdHMgZnVuY3Rpb25hbGl0eSBpcyBhbHNvIGJhc2VkIG9uIAo+IGlub2Rl
LT5pX21vZGUgZmllbGQKPiB3aGljaCBpcyBjaGFuZ2VkIGJ5IG1ha2VfYmFkX2lub2RlKCkuCgpB
Z3JlZWQuCkknbGwgdXBkYXRlIHRoZSBwYXRjaCB3aXRoIHRoaXMuClRoYW5rcywKCi0tIApKYWVn
ZXVrIEtpbQpTYW1zdW5nCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBbmRyb2lkIGFwcHMgcnVu
IG9uIEJsYWNrQmVycnkgMTAKSW50cm9kdWNpbmcgdGhlIG5ldyBCbGFja0JlcnJ5IDEwLjIuMSBS
dW50aW1lIGZvciBBbmRyb2lkIGFwcHMuCk5vdyB3aXRoIHN1cHBvcnQgZm9yIEplbGx5IEJlYW4s
IEJsdWV0b290aCwgTWFwdmlldyBhbmQgbW9yZS4KR2V0IHlvdXIgQW5kcm9pZCBhcHAgaW4gZnJv
bnQgb2YgYSB3aG9sZSBuZXcgYXVkaWVuY2UuICBTdGFydCBub3cuCmh0dHA6Ly9wdWJhZHMuZy5k
b3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD0xMjQ0MDcxNTEmaXU9LzQxNDAvb3N0Zy5jbGt0
cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
