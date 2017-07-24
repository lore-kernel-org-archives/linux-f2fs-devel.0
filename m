From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Subject: [PATCH] f2fs: preserve i_mode if __f2fs_set_acl() fails
Date: Sun, 23 Jul 2017 22:32:54 -0300
Message-ID: <20170724013251.GA3459@debian.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <ernesto.mnd.fernandez@gmail.com>)
 id 1dZSF7-00045O-2C
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jul 2017 01:33:05 +0000
Received: from mail-qk0-f193.google.com ([209.85.220.193])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dZSF6-0000zE-9A
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jul 2017 01:33:04 +0000
Received: by mail-qk0-f193.google.com with SMTP id d136so8808432qkg.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 23 Jul 2017 18:33:04 -0700 (PDT)
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>

V2hlbiBjaGFuZ2luZyBhIGZpbGUncyBhY2wgbWFzaywgX19mMmZzX3NldF9hY2woKSB3aWxsIGZp
cnN0IHNldCB0aGUKZ3JvdXAgYml0cyBvZiBpX21vZGUgdG8gdGhlIHZhbHVlIG9mIHRoZSBtYXNr
LCBhbmQgb25seSB0aGVuIHNldCB0aGUKYWN0dWFsIGV4dGVuZGVkIGF0dHJpYnV0ZSByZXByZXNl
bnRpbmcgdGhlIG5ldyBhY2wuCgpJZiB0aGUgc2Vjb25kIHBhcnQgZmFpbHMgKGR1ZSB0byBsYWNr
IG9mIHNwYWNlLCBmb3IgZXhhbXBsZSkgYW5kIHRoZQpmaWxlIGhhZCBubyBhY2wgYXR0cmlidXRl
IHRvIGJlZ2luIHdpdGgsIHRoZSBzeXN0ZW0gd2lsbCBmcm9tIG5vdyBvbgphc3N1bWUgdGhhdCB0
aGUgbWFzayBwZXJtaXNzaW9uIGJpdHMgYXJlIGFjdHVhbCBncm91cCBwZXJtaXNzaW9uIGJpdHMs
CnBvdGVudGlhbGx5IGdyYW50aW5nIGFjY2VzcyB0byB0aGUgd3JvbmcgdXNlcnMuCgpQcmV2ZW50
IHRoaXMgYnkgb25seSBjaGFuZ2luZyB0aGUgaW5vZGUgbW9kZSBhZnRlciB0aGUgYWNsIGhhcyBi
ZWVuIHNldC4KClNpZ25lZC1vZmYtYnk6IEVybmVzdG8gQS4gRmVybsOhbmRleiA8ZXJuZXN0by5t
bmQuZmVybmFuZGV6QGdtYWlsLmNvbT4KLS0tClRoaXMgYnVnIGlzIGNvdmVyZWQgYnkgZ2VuZXJp
Yy80NDkgaW4geGZzdGVzdHMsIHRob3VnaCB0aGF0IHRlc3QgbWF5IG5vdCBydW4KZm9yIGYyZnMg
dW5sZXNzIHlvdSBjaGFuZ2UgdGhlIHNpemUgaW4gdGhlIGNhbGwgdG8gX3NjcmF0Y2hfbWtmc19z
aXplZC4KClNldmVyYWwgZmlsZXN5c3RlbXMgYXJlIGFmZmVjdGVkOyBzb21lIG9mIHRoZW0gaGF2
ZSBhbHJlYWR5IGFwcGxpZWQgcGF0Y2hlcywKc2VlIGZvciBleGFtcGxlOiAiZmUyNjU2OSBleHQy
OiBwcmVzZXJ2ZSBpX21vZGUgaWYgZXh0Ml9zZXRfYWNsKCkgZmFpbHMiLgoKIGZzL2YyZnMvYWNs
LmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2ZzL2YyZnMvYWNsLmMgYi9mcy9mMmZzL2FjbC5jCmluZGV4IGI0
Yjg0MzguLjQzNmIzYTEgMTAwNjQ0Ci0tLSBhL2ZzL2YyZnMvYWNsLmMKKysrIGIvZnMvZjJmcy9h
Y2wuYwpAQCAtMjA3LDE1ICsyMDcsMTYgQEAgc3RhdGljIGludCBfX2YyZnNfc2V0X2FjbChzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBpbnQgdHlwZSwKIAl2b2lkICp2YWx1ZSA9IE5VTEw7CiAJc2l6ZV90
IHNpemUgPSAwOwogCWludCBlcnJvcjsKKwl1bW9kZV90IG1vZGUgPSBpbm9kZS0+aV9tb2RlOwog
CiAJc3dpdGNoICh0eXBlKSB7CiAJY2FzZSBBQ0xfVFlQRV9BQ0NFU1M6CiAJCW5hbWVfaW5kZXgg
PSBGMkZTX1hBVFRSX0lOREVYX1BPU0lYX0FDTF9BQ0NFU1M7CiAJCWlmIChhY2wgJiYgIWlwYWdl
KSB7Ci0JCQllcnJvciA9IHBvc2l4X2FjbF91cGRhdGVfbW9kZShpbm9kZSwgJmlub2RlLT5pX21v
ZGUsICZhY2wpOworCQkJZXJyb3IgPSBwb3NpeF9hY2xfdXBkYXRlX21vZGUoaW5vZGUsICZtb2Rl
LCAmYWNsKTsKIAkJCWlmIChlcnJvcikKIAkJCQlyZXR1cm4gZXJyb3I7Ci0JCQlzZXRfYWNsX2lu
b2RlKGlub2RlLCBpbm9kZS0+aV9tb2RlKTsKKwkJCXNldF9hY2xfaW5vZGUoaW5vZGUsIG1vZGUp
OwogCQl9CiAJCWJyZWFrOwogCi0tIAoyLjEuNAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVj
ayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1v
c3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xh
c2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
