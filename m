From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add the missing delection of orphan
 inode entry in write_orphan_inodes()
Date: Tue, 23 Jul 2013 09:24:06 +0800
Message-ID: <51EDDB36.8020904@cn.fujitsu.com>
References: <51E8F65F.9040007@cn.fujitsu.com> <1374497479.26443.20.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1V1ROJ-0001N1-2m
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Jul 2013 01:27:51 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V1ROH-0006lC-Rq for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Jul 2013 01:27:51 +0000
In-Reply-To: <1374497479.26443.20.camel@kjgkr>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

T24gMDcvMjIvMjAxMyAwODo1MSBQTSwgSmFlZ2V1ayBLaW0gd3JvdGU6Cgo+IEhpLAo+IAo+IDIw
MTMtMDctMTkgKOq4iCksIDE2OjE4ICswODAwLCBHdSBaaGVuZzoKPj4gQWZ0ZXIgd3JpdGluZyBv
cnBoYW4gaW5vZGUgZW50cnkgaW4gam9ybmFsIGJsb2NrLCB3ZSBuZWVkIHRvIGRlbGV0ZSBlYWNo
Cj4+IGVudHJ5IGZyb20gdGhlIG9ycGhhbiBlbnRyeSBsaXN0LCBhbmQgcmVsZWFzZSB0aGVtLgo+
Pgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBHdSBaaGVuZyA8Z3V6LmZuc3RAY24uZnVqaXRzdS5jb20+
Cj4+IC0tLQo+PiAgZnMvZjJmcy9jaGVja3BvaW50LmMgfCAgICA0ICsrKysKPj4gIDEgZmlsZXMg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZnMvZjJmcy9jaGVja3BvaW50LmMgYi9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+PiBpbmRleCA2
NmE2Yjg1Li4yOTBkYjA0IDEwMDY0NAo+PiAtLS0gYS9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+PiAr
KysgYi9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+PiBAQCAtMzM3LDYgKzMzNywxMCBAQCBzdGF0aWMg
dm9pZCB3cml0ZV9vcnBoYW5faW5vZGVzKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgYmxvY2tf
dCBzdGFydF9ibGspCj4+ICAJCW1lbXNldChvcnBoYW5fYmxrLCAwLCBzaXplb2YoKm9ycGhhbl9i
bGspKTsKPj4gIHBhZ2VfZXhpc3Q6Cj4+ICAJCW9ycGhhbl9ibGstPmlub1tuZW50cmllcysrXSA9
IGNwdV90b19sZTMyKG9ycGhhbi0+aW5vKTsKPj4gKwo+PiArCQlsaXN0X2RlbCgmb3JwaGFuLT5s
aXN0KTsKPj4gKwkJa21lbV9jYWNoZV9mcmVlKG9ycGhhbl9lbnRyeV9zbGFiLCBvcnBoYW4pOwo+
PiArCQlzYmktPm5fb3JwaGFucy0tOwo+IAo+IE5BSy4KPiBXZSBzaG91bGQgbm90IHJlbGVhc2Ug
dGhlbSBoZXJlLgo+IE9ubHkgZjJmc19ldmljdF9pbm9kZSBjYW4gZG8gaXQuIAoKWWVhaCwgZjJm
c19ldmljdF9pbm9kZSBjYW4gZG8gdGhpcyBqb2Igc2FmZWx5LCBzb3JyeSBmb3IgbXkgbWlzdGFr
ZSwKcGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLjopCgpSZWdhcmRzLApHdSAKCj4gCj4+ICAJfQo+
PiAgCWlmICghcGFnZSkKPj4gIAkJZ290byBlbmQ7Cj4gCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpTZWUgZXZlcnl0aGluZyBmcm9tIHRoZSBicm93c2VyIHRvIHRoZSBkYXRhYmFzZSB3aXRoIEFw
cER5bmFtaWNzCkdldCBlbmQtdG8tZW5kIHZpc2liaWxpdHkgd2l0aCBhcHBsaWNhdGlvbiBtb25p
dG9yaW5nIGZyb20gQXBwRHluYW1pY3MKSXNvbGF0ZSBib3R0bGVuZWNrcyBhbmQgZGlhZ25vc2Ug
cm9vdCBjYXVzZSBpbiBzZWNvbmRzLgpTdGFydCB5b3VyIGZyZWUgdHJpYWwgb2YgQXBwRHluYW1p
Y3MgUHJvIHRvZGF5IQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/
aWQ9NDg4MDg4MzEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
