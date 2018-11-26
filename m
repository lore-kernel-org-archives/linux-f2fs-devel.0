From: =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
Subject: Re: fsck: reset i_gc_failures from 0x1 to 0x00
Date: Mon, 26 Nov 2018 15:28:26 +0100
Message-ID: <7CFFEC72-29AB-473C-92C0-D8F7829BF18D@bi-co.net>
References: <2dbe74e040f9061f298c45016aa37881ea6f879d.camel@bi-co.net>
 <0e88393a-e559-f430-62f7-1c63dbce6ad3@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bevan@bi-co.net>) id 1gRHsO-0001Qc-4d
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 14:28:40 +0000
Received: from voltaic.bi-co.net ([134.119.3.22])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRHsI-00FrhA-7S
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 14:28:40 +0000
In-Reply-To: <0e88393a-e559-f430-62f7-1c63dbce6ad3@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

SGksCgo+IEFtIDI2LjExLjIwMTggdW0gMTU6MDkgc2NocmllYiBDaGFvIFl1IDxjaGFvQGtlcm5l
bC5vcmc+Ogo+IE9uIDIwMTgtMTEtMjYgNzowOSwgTWljaGFlbCBMYcOfIHdyb3RlOgo+PiBIaSwK
Pj4gCj4+IGFmdGVyIHVwZGF0aW5nIHRvIGYyZnMtdG9vbHMgMS4xMi4wLCBhIHJvdXRpbmUgZnNj
ayBvZiBteSBmaWxlIHN5c3RlbXMKPj4gdG9vayBxdWl0ZSBhIHdoaWxlIGFuZCBvdXRwdXQgdGVu
LXRob3VzYW5kcyBpbnN0YW5jZXMgb2YgdGhlIGZvbGxvd2luZwo+PiBsaW5lOgo+PiAKPj4+IFtG
SVhdIChmc2NrX2Noa19pbm9kZV9ibGs6IDk1NCkgIC0tPiBSZWd1bGFyOiAweFhZWiByZXNldCBp
X2djX2ZhaWx1cmVzIGZyb20gMHgxIHRvIDB4MDAKPiAKPiBEbyB5b3UgdXNlIC1mIG9yIC1wIDEg
b3B0aW9uIHdoZW4gZG9pbmcgZnNjayBvbiBpbWFnZT8KCk9uZSBvZiB0aGUgZGV2aWNlcyB3YXMg
YXV0b21hdGljYWxseSBjaGVja2VkIGR1cmluZyBib290LXVwLiBBcyBmYXIgYXMgSSBjYW4gc2Vl
LCB0aGUgZm9sbG93aW5nIGNvbW1hbmQgaXMgaXNzdWVkIGluc2lkZSB0aGUgaW5pdHJkOgogICAg
ZnNjayAtVGEgLUMiJEZTQ0tfRkQiICIkMeKAnQp3aGVyZSAkMSBpcyB0aGUgZGV2aWNlLiBUaGUg
b3RoZXIgb25lIEkgY2hlY2tlZCBtYW51YWxseSBjYWxsaW5nIGZzY2suZjJmcyB3aXRob3V0IGFu
eSBhZGRpdGlvbmFsIGFyZ3VtZW50cy4gRnJvbSBteSBleHBlcmllbmNlLCB0aGUgY2hlY2tzIGFy
ZSBhbHdheXMgcGVyZm9ybWVkIHdoZW4gdGhlIGxhc3QgY2hlY2sgd2FzIGRvbmUgd2l0aCBhbiBv
bGRlciBrZXJuZWwgdmVyc2lvbiAod2hpY2ggd2FzIHRoZSBjYXNlIGhlcmUpLgoKPiBXZSBzdGFy
dCB0byBzdXBwb3J0IHJlc2V0aW5nIC5pX2djX2ZhaWx1cmVzJ3MgdmFsdWUgdG8gemVybyBpbiBm
c2NrIHNpbmNlCj4gOTFiYjdiMjFmNzQwICgiZjJmcy10b29sczogZml4IHRvIHJlc2V0IGlfZ2Nf
ZmFpbHVyZXMgb2ZmbGluZSIpLCB0aGlzIGlzIGJlY2F1c2UKPiBpZiAuaV9nY19mYWlsdXJlcyBj
b250aW51ZXMgaW5jcmVhc2luZyBhbmQgZXhjZWVkIHRocmVzaG9sZCwgaXQgY2FuIG1ha2UgZjJm
cwo+IGJyZWFrIGF0b21pY193cml0ZSBzZW1hbnRpY3MgZHVyaW5nIEdDLCBzbyBJIGFkZGVkIHRo
YXQgcGF0Y2ggdG8gYXZvaWQgc3VjaAo+IGNvbmRpdGlvbi4KPiAKPiBCdXQgdGhlIHByb2JsZW0g
aGVyZSBpcyBldmVuIC5pX2djX2ZhaWx1cmVzJ3MgdmFsdWUgaXMgb25lIHdoaWNoIHdhcyBpbml0
aWFsaXplZAo+IGR1aW5nIGlub2RlIGNyZWF0aW9uIGJ5IG9sZCBrZXJuZWwsIGFuZCBpdCBuZXZl
ciBiZSBpbmNyZWFzZWQgYnkgR0MgZmxvdywgd2UKPiB3aWxsIHN0aWxsIHRyaWdnZXIgc3VjaCBm
aXggaW4gZnNjay4gSSB0aGluayBpdCdzIG5vdCBuZWNlc3NhcnksIGFueXdheSwgbGV0IG1lCj4g
c2VuZCBvbmUgcGF0Y2ggdG8gZml4IGl0LgoKVGhpcyBpcyBhIHZlcnkgbGlrZWx5IGNhdXNlLiBU
aGUgZmlsZXN5c3RlbXMgYXJlIGJvdGggZnJvbSBlYXJseSAyMDE1LCBzbyBwcm9iYWJseSB3ZXJl
IHVzZWQgd2l0aCBMaW51eCAzLjE4IG9yIDMuMTkgYXQgdGhhdCB0aW1lLgoKVGhhbmtzIGZvciB0
aGUgZXhwbGFuYXRpb24gYW5kIHRoZSBwcm9wb3NlZCBwYXRjaCEKCkJlc3QgcmVnYXJkcywKTWlj
aGFlbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
