From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] f2fs: move all the bio initialization into
 __bio_alloc
Date: Thu, 19 Dec 2013 17:22:18 +0800
Message-ID: <52B2BACA.80600@cn.fujitsu.com>
References: <52B17905.7040708@cn.fujitsu.com>
	<000a01cefc59$0a9b4580$1fd1d080$@samsung.com>
	<1387443585.2101.216.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VtZvH-0001bn-WD
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 09:29:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtZvE-0003n8-Qc for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 09:29:39 +0000
In-Reply-To: <1387443585.2101.216.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: 'fsdevel' <linux-fsdevel@vger.kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>

SGkgS2ltLCBZdSwKVGhhbmtzIGZvciB5b3VyIHJldmlldyEKCk9uIDEyLzE5LzIwMTMgMDQ6NTkg
UE0sIEphZWdldWsgS2ltIHdyb3RlOgoKPiBIaSBHdSwKPiAKPiBJIGFncmVlZCB3aXRoIENoYW8u
Cj4gSXQgaXMgbW9yZSByZWFkYWJsZSB0byB1c2Ugc29tZXRoaW5nIGxpa2UgImlzX3JlYWQiIGlu
c3RlYWQgb2YgInJ3Ii4KCkFncmVlLiBJJ2xsIGZvbGxvdyBpdC4KClJlZ2FyZHMsCkd1Cgo+IFRo
YW5rcywKPiAKPiAyMDEzLTEyLTE5ICjrqqkpLCAwOToyMyArMDgwMCwgQ2hhbyBZdToKPj4gSGkg
R3UsCj4+Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4gRnJvbTogR3UgWmhlbmcg
W21haWx0bzpndXouZm5zdEBjbi5mdWppdHN1LmNvbV0KPj4+IFNlbnQ6IFdlZG5lc2RheSwgRGVj
ZW1iZXIgMTgsIDIwMTMgNjoyOSBQTQo+Pj4gVG86IEtpbQo+Pj4gQ2M6IGZzZGV2ZWw7IGxpbnV4
LWtlcm5lbDsgZjJmcwo+Pj4gU3ViamVjdDogW2YyZnMtZGV2XSBbUEFUQ0hdIGYyZnM6IG1vdmUg
YWxsIHRoZSBiaW8gaW5pdGlhbGl6YXRpb24gaW50byBfX2Jpb19hbGxvYwo+Pj4KPj4+IE1vdmUg
YWxsIHRoZSBiaW8gaW5pdGlhbGl6YXRpb24gaW50byBfX2Jpb19hbGxvYywgYW5kIHNvbWUgbWlu
b3IgY2xlYW51cHMgYXJlCj4+PiBhbHNvIGFkZGVkLgo+Pgo+PiBMb29rcyBtb3JlIG5lYXQhCj4+
Cj4+PiBAQCAtMTc4LDE3ICsxNzksMTYgQEAgdm9pZCBmMmZzX3N1Ym1pdF9wYWdlX21iaW8oc3Ry
dWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBzdHJ1Y3QgcGFnZSAqcGFnZSwKPj4+ICAJCQlibG9ja190
IGJsa19hZGRyLCBzdHJ1Y3QgZjJmc19pb19pbmZvICpmaW8pCj4+PiAgewo+Pj4gIAllbnVtIHBh
Z2VfdHlwZSBidHlwZSA9IFBBR0VfVFlQRV9PRl9CSU8oZmlvLT50eXBlKTsKPj4+IC0Jc3RydWN0
IGJsb2NrX2RldmljZSAqYmRldiA9IHNiaS0+c2ItPnNfYmRldjsKPj4+ICAJc3RydWN0IGYyZnNf
YmlvX2luZm8gKmlvOwo+Pj4gLQlpbnQgYmlvX2Jsb2NrczsKPj4+ICsJaW50IHJ3ID0gaXNfcmVh
ZF9pbyhmaW8tPnJ3KTsKPj4KPj4gTWF5YmUgaXQncyBtb3JlIG5lYXQgdG8gdXNlICdpc19yZWFk
JyB0byBpbnN0ZWFkIG9mICdydycuCj4+Cj4+IFRoYW5rcwo+Pgo+IAoKCgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KUmFwaWRseSB0cm91Ymxlc2hvb3QgcHJvYmxlbXMgYmVmb3JlIHRoZXkgYWZmZWN0
IHlvdXIgYnVzaW5lc3MuIE1vc3QgSVQgCm9yZ2FuaXphdGlvbnMgZG9uJ3QgaGF2ZSBhIGNsZWFy
IHBpY3R1cmUgb2YgaG93IGFwcGxpY2F0aW9uIHBlcmZvcm1hbmNlIAphZmZlY3RzIHRoZWlyIHJl
dmVudWUuIFdpdGggQXBwRHluYW1pY3MsIHlvdSBnZXQgMTAwJSB2aXNpYmlsaXR5IGludG8geW91
ciAKSmF2YSwuTkVULCAmIFBIUCBhcHBsaWNhdGlvbi4gU3RhcnQgeW91ciAxNS1kYXkgRlJFRSBU
UklBTCBvZiBBcHBEeW5hbWljcyBQcm8hCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQv
Z2FtcGFkL2Nsaz9pZD04NDM0OTgzMSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
