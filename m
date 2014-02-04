From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: Re: f2fs space usage
Date: Tue, 04 Feb 2014 17:52:37 +0800
Message-ID: <52F0B865.7070704@gtsys.com.hk>
References: <52E0E1BF.9090409@gtsys.com.hk> <1390529522.25542.42.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris.ruehl@gtsys.com.hk>) id 1WAcf1-0002TG-Qi
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Feb 2014 09:51:19 +0000
Received: from mail.fpasia.hk ([202.130.89.98] helo=fpa01n0.fpasia.hk)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WAces-000147-1S for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Feb 2014 09:51:19 +0000
In-Reply-To: <1390529522.25542.42.camel@kjgkr>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

T24gRnJpZGF5LCBKYW51YXJ5IDI0LCAyMDE0IDEwOjEyIEFNLCBKYWVnZXVrIEtpbSB3cm90ZToK
PiBIaSwKPgo+IDIwMTQtMDEtMjMgKOuqqSksIDE3OjMyICswODAwLCBDaHJpcyBSdWVobDoKPj4g
SGkgS2ltLAo+Pgo+PiBJIHJlY2VudGx5IHdvcmsgd2l0aCBmMmZzIGFuZCB3b25kZXJpbmcgYWJv
dXQgdGhlIHN5c3RlbSB1c2FnZS4KPj4gSSBoYXZlIGEgTkFORCBmbGFzaCAxMjhNQiBvbiBteSBT
b0MgdXNlZCBmb3IgdUJvb3QgYW5kIGEgcm9vdAo+PiBwYXJ0aW9uIChmMmZzKQo+Pgo+PiB3aGVu
IEkgaW5zdGFsbCB0aGUgYnVzeWJveCBiaW5hcmllcyBJIG5lYXJseSBydW4gb3V0IG9mIHNwYWNl
Cj4+IGJ1c3lib3ggYmluYXJ5Cj4+Cj4+IHJvb3RAZ3RzaXIyNDovbW50IyBkdSAtc2ggL21udC8u
Cj4+IDQuOE0gICAgL21udC8uCj4+Cj4+IGJ1dCBkZiAtaCBzaG93IGEgOTclIHVzYWdlCj4gRm9y
IHN1Y2ggdGhlIHNtYWxsIHNpemVkIHBhcnRpdGlvbiwgdGhlIHNwYWNlIGlzIHByZXR0eSBtdWNo
IGRlcGVuZGVudAo+IG9uIHRoZSBvdmVycHJvdmlzaW9uIHJhdGlvLgo+IFNvLCBpZiB5b3Ugd2Fu
dCB0byBnZXQgbW9yZSBzcGFjZSwgeW91IGNhbiBmb3JtYXQgdGhlIHBhcnRpdGlvbiB3aXRoIC1v
Cj4gb3B0aW9uLgo+Cj4gV2hlbiBJIHRlc3RlZCB3aXRoIDEyOE1CLCBpdCBzZWVtcyB0aGF0IDIw
JSBpcyBiZXN0LCB3aGljaCBzaG93cyA2Mk1CCj4gZm9yIGF2YWxpYWJsZSBzcGFjZSBvY2N1cHlp
bmcgNDUlIHV0aWxpemF0aW9uLgo+Cj4gVGhlIGNvbW1hbmQgaXMgbGlrZSB0aGlzOgo+Cj4gIyBt
a2ZzLmYyZnMgLW8gMjAgJGRldgo+Cj4gVGhhbmtzLAoKWWVzIGl0cyBtYWRlIHRoZSB0cmljayEK
L2Rldi9tdGRibG9jazQgIDExOU0gICA1M00gICA1Mk0gIDUxJSAvbW50CgoKVGhhbmtzIGEgbG90
IGZvciB5b3VyIGFkdmljZS4KQ2hyaXMKPj4gcm9vdEBndHNpcjI0Oi9tbnQjIGRmIC1oCj4+IEZp
bGVzeXN0ZW0gICAgICBTaXplICBVc2VkIEF2YWlsIFVzZSUgTW91bnRlZCBvbgo+PiByb290ZnMg
ICAgICAgICAgMy42RyAgNTc0TSAgMi44RyAgMTclIC8KPj4gL2Rldi9yb290ICAgICAgIDMuNkcg
IDU3NE0gIDIuOEcgIDE3JSAvCj4+IGRldnRtcGZzICAgICAgICAxMjVNICAgICAwICAxMjVNICAg
MCUgL2Rldgo+PiB0bXBmcyAgICAgICAgICAgIDI1TSAgMTU2SyAgIDI1TSAgIDElIC9ydW4KPj4g
dG1wZnMgICAgICAgICAgIDUuME0gICAgIDAgIDUuME0gICAwJSAvcnVuL2xvY2sKPj4gdG1wZnMg
ICAgICAgICAgICA1ME0gICAgIDAgICA1ME0gICAwJSAvcnVuL3NobQo+PiAvZGV2L210ZGJsb2Nr
NCAgMTE5TSAgMTAxTSAgMy4zTSAgOTclIC9tbnQKPj4KPj4gSSdtIHJ1bm5pbmcgYSBuZXh0LTIw
MTQwMTE1Lgo+Pgo+PiBDYW4geW91IGNvbW1lbnQgcGxlYXNlLgo+PiBDaHJpcwoKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpNYW5hZ2luZyB0aGUgUGVyZm9ybWFuY2Ugb2YgQ2xvdWQtQmFzZWQgQXBw
bGljYXRpb25zClRha2UgYWR2YW50YWdlIG9mIHdoYXQgdGhlIENsb3VkIGhhcyB0byBvZmZlciAt
IEF2b2lkIENvbW1vbiBQaXRmYWxscy4KUmVhZCB0aGUgV2hpdGVwYXBlci4KaHR0cDovL3B1YmFk
cy5nLmRvdWJsZWNsaWNrLm5ldC9nYW1wYWQvY2xrP2lkPTEyMTA1MTIzMSZpdT0vNDE0MC9vc3Rn
LmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
