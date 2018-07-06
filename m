From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Bug report: some new bugs found by fuzzing
Date: Fri, 6 Jul 2018 09:13:26 +0800
Message-ID: <7f5282db-2bb6-b808-679b-620957185945@huawei.com>
References: <B655752F-CBBA-4D7D-B504-E1E21378429A@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fbFJl-00034Q-SB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 01:13:49 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fbFJj-000RAL-Px
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 01:13:49 +0000
In-Reply-To: <B655752F-CBBA-4D7D-B504-E1E21378429A@gatech.edu>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Xu, Wen" <wen.xu@gatech.edu>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkgV2VuLAoKT24gMjAxOC83LzYgMzoxOSwgWHUsIFdlbiB3cm90ZToKPiBEZWFyIEYyRlMgZGV2
ZWxvcGVycywKPiAKPiBCeSBmdXp6aW5nLCBJIGZpbmQgc29tZSBuZXcgaXNzdWVzIGluIExpbnV4
IGYyZnMga2VybmVsIG1vZHVsZS4gSGVyZSBhcmUgdGhlIGxpbmtzIG9uIEJ1Z3ppbGxhLAo+IAo+
IDIwMDQxOQlOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gX19yZW1vdmVfZGlydHlfc2VnbWVu
dCgpIHdoZW4gbW91bnRpbmcgYW4gZjJmcyBpbWFnZQo+IGh0dHBzOi8vYnVnemlsbGEua2VybmVs
Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAwNDE5Cj4gCj4gMjAwNDIxCUJ1ZmZlciBvdmVycnVuIGlu
IGYyZnNfdHJ1bmNhdGVfaW5saW5lX2lub2RlKCkgd2hlbiB1bW91bnRpbmcgYW4gZjJmcyBpbWFn
ZQo+IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAwNDIxCj4g
Cj4gMjAwNDIzCU91dC1vZi1ib3VuZCBhY2Nlc3MgaW4gZjJmc19nZXRfZG5vZGVfb2ZfZGF0YSgp
IHdoZW4gb3BlcmF0aW5nIGZpbGUgb24gYW4gZjJmcyBpbWFnZQo+IGh0dHBzOi8vYnVnemlsbGEu
a2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAwNDIzCj4gCj4gMjAwNDI1CUludmFsaWQgbWVt
b3J5IGFjY2VzcyBpbiBmMmZzX2ZpbmRfdGFyZ2V0X2RlbnRyeSgpIHdoZW4gb3BlcmF0aW5nIGZp
bGVzIG9uIGFuIGYyZnMgaW1hZ2UKPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19i
dWcuY2dpP2lkPTIwMDQyNQo+IAo+IFJlZ2FyZGluZyBteSB0ZXN0aW5nLCB0aGV5IGNhbiBhbGwg
YmUgcmVwcm9kdWNlZCB3LyBDaGFv4oCZcyBmMmZzLWRldiBicmFuY2guIFRoYW5rcyEKCkFscmln
aHQsIEkgd2lsbCBkaWcgaW50byB0aGVzZSBpc3N1ZXMgaW4gdGhlc2UgZGF5cywgb25jZSBJIGhh
dmUgc29sdXRpb24sIHdpbGwKbGV0IHlvdSBrbm93LgoKVGhhbmtzLAoKPiAKPiAtV2VuCj4gCgoK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0
eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRv
dC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
