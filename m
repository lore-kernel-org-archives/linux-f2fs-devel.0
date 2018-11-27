From: =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
Subject: Re: fsck: reset i_gc_failures from 0x1 to 0x00
Date: Tue, 27 Nov 2018 11:38:05 +0100
Message-ID: <38566EC6-DC27-4103-B577-F7722584262E@bi-co.net>
References: <2dbe74e040f9061f298c45016aa37881ea6f879d.camel@bi-co.net>
 <0e88393a-e559-f430-62f7-1c63dbce6ad3@kernel.org>
 <7CFFEC72-29AB-473C-92C0-D8F7829BF18D@bi-co.net>
 <20181127000849.GF55960@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bevan@bi-co.net>) id 1gRal1-0007Jo-QG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 10:38:19 +0000
Received: from voltaic.bi-co.net ([134.119.3.22])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRakw-005c22-M9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 10:38:19 +0000
In-Reply-To: <20181127000849.GF55960@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgo+IEFtIDI3LjExLjIwMTggdW0gMDE6MDggc2NocmllYiBKYWVnZXVrIEtpbSA8amFlZ2V1
a0BrZXJuZWwub3JnPjoKPiBPbiAxMS8yNiwgTWljaGFlbCBMYcOfIHdyb3RlOgo+PiAKPj4+IEFt
IDI2LjExLjIwMTggdW0gMTU6MDkgc2NocmllYiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+Ogo+
Pj4gQnV0IHRoZSBwcm9ibGVtIGhlcmUgaXMgZXZlbiAuaV9nY19mYWlsdXJlcydzIHZhbHVlIGlz
IG9uZSB3aGljaCB3YXMgaW5pdGlhbGl6ZWQKPj4+IGR1aW5nIGlub2RlIGNyZWF0aW9uIGJ5IG9s
ZCBrZXJuZWwsIGFuZCBpdCBuZXZlciBiZSBpbmNyZWFzZWQgYnkgR0MgZmxvdywgd2UKPj4+IHdp
bGwgc3RpbGwgdHJpZ2dlciBzdWNoIGZpeCBpbiBmc2NrLiBJIHRoaW5rIGl0J3Mgbm90IG5lY2Vz
c2FyeSwgYW55d2F5LCBsZXQgbWUKPj4+IHNlbmQgb25lIHBhdGNoIHRvIGZpeCBpdC4KPj4gCj4+
IFRoaXMgaXMgYSB2ZXJ5IGxpa2VseSBjYXVzZS4gVGhlIGZpbGVzeXN0ZW1zIGFyZSBib3RoIGZy
b20gZWFybHkgMjAxNSwgc28gcHJvYmFibHkgd2VyZSB1c2VkIHdpdGggTGludXggMy4xOCBvciAz
LjE5IGF0IHRoYXQgdGltZS4KPiAKPiBKdXN0IGluIGNhc2UsIGlzIHRoaXMgQW5kcm9pZCBkZXZp
Y2U/IElmIHlvdSBkb24ndCB1c2UgaW9jdGwoRjJGU19QSU5fRklMRSksCj4gdGhpcyBvbmV0aW1l
IGZpeCB3b250JyBodXJ0IGFueSBmaWxlc3lzdGVtIG1ldGFkYXRhLgoKbm8sIGl04oCZcyB1c2Vk
IG9uIGEgcmVndWxhciBHTlUvTGludXggc3lzdGVtLCBhIFJhc3BiZXJyeSBQaSBydW5uaW5nIEFy
Y2ggTGludXggQVJNIHRvIGJlIG1vcmUgc3BlY2lmaWMuIFRoZSBrZXJuZWwgaXMgY3VycmVudGx5
IHN0aWxsIGF0IHZlcnNpb24gNC4xNC44MyBzbyBhcyBmYXIgYXMgSSBjYW4gc2VlIHRoYXQgaW9j
dGwgaXNu4oCZdCBldmVuIGF2YWlsYWJsZS4KCkkgZ3Vlc3MgSeKAmWxsIHNlZSB0aGVzZSBtZXNz
YWdlcyBhZ2FpbiBhZnRlciBuZXcgZmlsZXMgaGF2ZSBiZWVuIGNyZWF0ZWQgYnkgdGhhdCBvbGQg
a2VybmVsIGJ1dCBzaG91bGQgbm90IHdvcnJ5IGFib3V0IGl0LgoKQmVzdCByZWdhcmRzLApNaWNo
YWVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mMmZzLWRldmVsCg==
