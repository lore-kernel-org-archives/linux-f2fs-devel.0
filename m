From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add sysfs support for controlling
	the gc_thread
Date: Thu, 27 Jun 2013 14:43:31 +0900
Message-ID: <CAKYAXd8cfvhce3_NWiLOzRz_=sWwqisH=gH4ZMGkxjv_Pt2H7A@mail.gmail.com>
References: <1369533945-6955-1-git-send-email-linkinjeon@gmail.com>
	<1369619214.10521.25.camel@kjgkr>
	<CAKYAXd_QZronHD536LOfeFWLmtCoweRq3gbH94R4_7oKC7hv3w@mail.gmail.com>
	<1369704867.10521.46.camel@kjgkr>
	<CAKYAXd-OO5niMiFv+ysStw=c-NQXT4AkTz3m7o1wTRZRd=WYFw@mail.gmail.com>
	<1372140227.28480.69.camel@kjgkr>
	<CAKYAXd-NEKCuEyoLwWHLrN165yq7EKRRcz9RknfdbR5EOO6cvQ@mail.gmail.com>
	<1372310676.28480.89.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1Us4zb-0008Vb-5U
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 05:43:39 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Us4zZ-0006x8-E7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Jun 2013 05:43:39 +0000
Received: by mail-pb0-f47.google.com with SMTP id rr13so426703pbb.20
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 26 Jun 2013 22:43:31 -0700 (PDT)
In-Reply-To: <1372310676.28480.89.camel@kjgkr>
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
Cc: linux-fsdevel@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

MjAxMy82LzI3LCBKYWVnZXVrIEtpbSA8amFlZ2V1ay5raW1Ac2Ftc3VuZy5jb20+Ogo+IEhpLAo+
Cj4gMjAxMy0wNi0yNiAo7IiYKSwgMTQ6MTAgKzA5MDAsIE5hbWphZSBKZW9uOgo+PiAyMDEzLzYv
MjUsIEphZWdldWsgS2ltIDxqYWVnZXVrLmtpbUBzYW1zdW5nLmNvbT46Cj4+ID4+ID4gLSBhbnkg
cHJpb3JpdHkgc2NoZW1lIGZvciBjbGVhbmluZz8KPj4gPj4gQ291bGQgeW91IHBseiB0ZWxsIG1l
IGEgbGl0dGxlIG1vcmUgZGV0YWlsID8KPj4gPgo+PiA+IEkgbWVhbnQsIGFzIHdlbGwgYXMgdGhl
IEdDIHRpbWVzLCB1c2VyIGFsc28gZ2l2ZXMgYSBraW5kIG9mIHN0YXR1cwo+PiA+IGxpa2U6Cj4+
ID4gTE9OR19JRExFLCBTSE9SVF9JRExFLCBzb21ldGhpbmcgbGlrZSB0aGF0Lgo+PiA+IFRoZXJl
Zm9yZSwgaG93IGFib3V0IHVzaW5nIHRoaXMgaW5mb3JtYXRpb24gdG8gc2VsZWN0IGEgdmljdGlt
Cj4+ID4gc2VsZWN0aW9uCj4+ID4gcG9saWN5IGJldHdlZW4gY29zdC1iZW5lZml0IGFuZCBncmVl
ZHkgYWxnb3JpdGhtcz8KPj4gY3VycmVudGx5IHdlIHdpbGwgcHJvdmlkZSB0aGUgb3B0aW9uIG9m
IHVwZGF0aW5nIHRoZSB0aW1lIHZhbHVlcyBmcm9tCj4+IHRoZSDigJhzeXNmc+KAmSBpbnRlcmZh
Y2UsIGFuZCB0aGUgR0MgcG9saWN5IGlzIHNlbGVjdGVkIGJ5IGRlZmF1bHQgZnJvbQo+PiBHQyB0
aHJlYWQgYmFzZWQgdXBvbiB0aGUgZ2MgdHlwZSwgQkcgb3IgRkcuCj4+IFNvLCBkbyB5b3UgbWVh
biB3ZSBzaG91bGQgcHJvdmlkZSBhbiBvcHRpb24gdG8gc2VsZWN0IHRoZSBkZWZhdWx0IEdDCj4+
IHBvbGljeSBmb3IgdGhlIHVzZXIgdXNpbmcg4oCYc3lzZnPigJkgaW50ZXJmYWNlPyBMaWtlLCBp
ZiB0aGUgdXNlciBzZXRzCj4+IOKAnExPTkdfSURMReKAnSDigJMgd2UgY2hvb3NlIENvc3QgQmVu
ZWZpdCBhbmQgaW4gY2FzZSBvZiBTSE9SVF9JRExFCj4+IOKAnEdyZWVkeeKAnSA/IFBsZWFzZSBl
bGFib3JhdGUgbW9yZSBvbiB0aGlzLgo+Cj4gWWVzLCBleGFjdC4KPiBGb3IgZXhhbXBsZSwgaWYg
YW4gdXNlciBjb25maWd1cmVzIGEgc21hbGwgcGVyaW9kIG9mIEdDIGludGVydmFsIGJ1dAo+IGdp
dmVzIExPTkdfSURMRSwgd2UgY2FuIGNob29zZSBjb3N0LWJlbmVmaXQuCj4gQnV0LCBpZiBTSE9S
VF9JRExFIGlzIGdpdmVuIHdpdGggYSBsb25nIEdDIHBlcmlvZCwgd2UgbmVlZCB0byBjaG9vc2UK
PiBncmVlZHkuCj4gSG93IGRvIHlvdSB0aGluaz8KSGkuIEphZWdldWsuCkxvb2tzIHJlYXNvbmFi
bGUgdG8gbWUuCkkgd2lsbCBwcm92aWRlIGEgcG9saWN5IGF0dHJpYnV0ZSBmb3IgZjJmcyBzeXNm
cyB3aXRoIHZhbHVlcywKTE9OR19JRExFIGFuZCBTSE9SVF9JRExFIHdpdGggZ2MgdGltZS4KClRo
YW5rcyA6KQo+IFRoYW5rcywKPgo+IC0tCj4gSmFlZ2V1ayBLaW0KPiBTYW1zdW5nCj4KPiAtLQo+
IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmli
ZSBsaW51eC1mc2RldmVsIiBpbgo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9A
dmdlci5rZXJuZWwub3JnCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2Vy
bmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sCj4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlz
IFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgV2luZG93czoKCkJ1aWxkIGZvciBXaW5kb3dz
IFN0b3JlLgoKaHR0cDovL3Auc2YubmV0L3NmdS93aW5kb3dzLWRldjJkZXYKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
