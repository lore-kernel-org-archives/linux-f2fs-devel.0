From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Bug report: some new bugs found by fuzzing
Date: Fri, 6 Jul 2018 15:00:43 +0800
Message-ID: <62019555-437e-b94d-1962-86bcee7e43f3@huawei.com>
References: <B655752F-CBBA-4D7D-B504-E1E21378429A@gatech.edu>
 <7f5282db-2bb6-b808-679b-620957185945@huawei.com>
 <0C7436B3-FE05-4999-A163-89F9851ADC00@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fbKkF-0005Jj-7q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 07:01:31 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fbKkC-00EEsL-W0
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 07:01:31 +0000
In-Reply-To: <0C7436B3-FE05-4999-A163-89F9851ADC00@gatech.edu>
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
To: "Xu, Wen" <wen.xu@gatech.edu>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkgV2VuCgpPbiAyMDE4LzcvNiA5OjMwLCBYdSwgV2VuIHdyb3RlOgo+IFRoYW5rcyB2ZXJ5IG11
Y2ghIEkgd291bGQgbGlrZSB0byBwcm92aWRlIGFueSBmdXJ0aGVyIGhlbHAgb3IgdGVzdGluZy4K
CkkgZm91bmQgc29tZXRoaW5nIGludGVyZXN0aW5nLCBvdXIga2V5IG1ldGFkYXRhIGluIGNoZWNr
cG9pbnQgcGFjayBoYXMgYWxyZWFkeQpiZWVuIHByb3RlY3RlZCBieSBjaGVja3N1bSwgaW4gaW1h
Z2UgeW91IGF0dGFjaGVkLCB0aGUgdmFsdWUgb2YgY2hlY2tzdW0gaXMKY29ycmVjdCwgYnV0IHN0
aWxsIHNvbWUga2V5IG1ldGFkYXRhJ3MgdmFsdWUgYXJlIGNvcnJ1cHRlZCwgc28gSSBndWVzcyBm
dXp6aW5nCndpbGwgaW5qZWN0IGVycm9yIGRhdGEgaW4gdG9vbHMgbGlrZSBta2ZzLmYyZnMsIGlz
IHRoYXQgY29ycmVjdD8KClRoYW5rcywKCj4gCj4gLVdlbgo+IAo+PiBPbiBKdWwgNSwgMjAxOCwg
YXQgOToxMyBQTSwgQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29tPiB3cm90ZToKPj4KPj4gSGkg
V2VuLAo+Pgo+PiBPbiAyMDE4LzcvNiAzOjE5LCBYdSwgV2VuIHdyb3RlOgo+Pj4gRGVhciBGMkZT
IGRldmVsb3BlcnMsCj4+Pgo+Pj4gQnkgZnV6emluZywgSSBmaW5kIHNvbWUgbmV3IGlzc3VlcyBp
biBMaW51eCBmMmZzIGtlcm5lbCBtb2R1bGUuIEhlcmUgYXJlIHRoZSBsaW5rcyBvbiBCdWd6aWxs
YSwKPj4+Cj4+PiAyMDA0MTkJTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIF9fcmVtb3ZlX2Rp
cnR5X3NlZ21lbnQoKSB3aGVuIG1vdW50aW5nIGFuIGYyZnMgaW1hZ2UKPj4+IGh0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAwNDE5Cj4+Pgo+Pj4gMjAwNDIxCUJ1
ZmZlciBvdmVycnVuIGluIGYyZnNfdHJ1bmNhdGVfaW5saW5lX2lub2RlKCkgd2hlbiB1bW91bnRp
bmcgYW4gZjJmcyBpbWFnZQo+Pj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0yMDA0MjEKPj4+Cj4+PiAyMDA0MjMJT3V0LW9mLWJvdW5kIGFjY2VzcyBpbiBmMmZz
X2dldF9kbm9kZV9vZl9kYXRhKCkgd2hlbiBvcGVyYXRpbmcgZmlsZSBvbiBhbiBmMmZzIGltYWdl
Cj4+PiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwMDQyMwo+
Pj4KPj4+IDIwMDQyNQlJbnZhbGlkIG1lbW9yeSBhY2Nlc3MgaW4gZjJmc19maW5kX3RhcmdldF9k
ZW50cnkoKSB3aGVuIG9wZXJhdGluZyBmaWxlcyBvbiBhbiBmMmZzIGltYWdlCj4+PiBodHRwczov
L2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwMDQyNQo+Pj4KPj4+IFJlZ2Fy
ZGluZyBteSB0ZXN0aW5nLCB0aGV5IGNhbiBhbGwgYmUgcmVwcm9kdWNlZCB3LyBDaGFv4oCZcyBm
MmZzLWRldiBicmFuY2guIFRoYW5rcyEKPj4KPj4gQWxyaWdodCwgSSB3aWxsIGRpZyBpbnRvIHRo
ZXNlIGlzc3VlcyBpbiB0aGVzZSBkYXlzLCBvbmNlIEkgaGF2ZSBzb2x1dGlvbiwgd2lsbAo+PiBs
ZXQgeW91IGtub3cuCj4+Cj4+IFRoYW5rcywKPj4KPj4+Cj4+PiAtV2VuCj4gCgoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUg
b2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0
dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
