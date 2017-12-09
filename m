From: hsiangkao--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: question about find_next_free_block in f2fs-tools
Date: Sat, 9 Dec 2017 14:29:58 +0800
Message-ID: <2017120914295588417753@aol.com>
Reply-To: "hsiangkao@aol.com" <hsiangkao@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hsiangkao@aol.com>) id 1eNYeE-0002Zg-Pk
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Dec 2017 06:30:06 +0000
Received: from omr-a010e.mx.aol.com ([204.29.186.54])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) id 1eNYeD-0005Ug-Rr
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Dec 2017 06:30:06 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk <jaegeuk@kernel.org>, chao <chao@kernel.org>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

SGkgSmFlZ2V1ayBhbmQgQ2hhbywKwqAgwqAgSSBoYXZlIGEgbWlub3IgcXVlc3Rpb24gYWJvdXQg
dGhlIGZvbGxvd2luZyBjb2RlIHNuaXBwZXQgaW7CoGZpbmRfbmV4dF9mcmVlX2Jsb2NrwqByZWNl
bnRseQoJCWlmIChzZS0+dmFsaWRfYmxvY2tzID09IDAgJiYgIShzZWdubyAlIHNiaS0+c2Vnc19w
ZXJfc2VjKSkgewoJCQlzdHJ1Y3Qgc2VnX2VudHJ5ICpzZTI7CgkJCXVuc2lnbmVkIGludCBpOwoK
CQkJZm9yIChpID0gMTsgaSA8IHNiaS0+c2Vnc19wZXJfc2VjOyBpKyspIHsKCQkJCXNlMiA9IGdl
dF9zZWdfZW50cnkoc2JpLCBzZWdubyArIGkpOwoJCQkJaWYgKHNlMi0+dmFsaWRfYmxvY2tzKQoJ
CQkJCWJyZWFrOwoJCQl9CgkJCWlmIChpID09IHNiaS0+c2Vnc19wZXJfc2VjKQoJCQkJcmV0dXJu
IDA7CgkJfQrCoCDCoCBXaGF0IGRvZXMgaXQgZG8gaWYgYSBzZWN0aW9uIGhhcyAyIG9yIG1vcmUg
c2VnbWVudHM/CsKgIMKgIEl0IHNlZW1zIHRoYXQgaXQgc3VjY2VlZHMgb25secKgaWYgdGhlIHNl
Y3Rpb24gaXMgdG90YWxseSBmcmVlPyBpZiBub3QsIGRvIFNTUiBpbnN0ZWFkP8KgSSBoYXZlIG5v
IGlkZWEgYWJvdXQgdGhhdC4gOigKwqAgwqAgQW5kIHRoZSBjb2RlIG1haW5seSBmb3IgU1NSwqBm
b2xsb3dzLCBidXQgSSBhbSBjb25mdXNlZCB3aGVuIEkgYXNzb2NpYXRlwqB0aGF0IHdpdGggdGhl
IGFib3ZlLi4uCgkJaWYgKHNlLT50eXBlID09IHR5cGUgJiYKCQkJIWYyZnNfdGVzdF9iaXQob2Zm
c2V0LCAoY29uc3QgY2hhciAqKXNlLT5jdXJfdmFsaWRfbWFwKSkKCQkJcmV0dXJuIDA7CsKgIMKg
IERvZXMgdGhhdCBpbmRpY2F0ZSBzZWdtZW50cyBvZiBhIHNlY3Rpb24gc2hvdWxkIGhhdmUgdGhl
IHNhbWUgdHlwZT8KwqAgwqAgwqAgwqAgYnV0IEkgY291bGQgbm90IGZpbmQgYW55IG1lY2hhbmlz
bSB0byBrZWVwIHNlZ21lbnRzIG9mIGEgc2VjdGlvbiBpbiB0aGUgc2FtZSB0eXBlLi7CoAoKwqAg
wqAgQW5kIEkgY291bGQgbm90IHVuZGVyc3RhbmQgd2hhdMKgdGhlIGNvbW1pdCBtZXNzYWdlKCJm
c2NrLmYyZnM6IExGUyBhbGxvY190eXBlIG11c3QgaGF2ZSBmcmVlIHNlZ21lbnQgYWZ0ZXIgYmxr
b2ZmIikgbWVhbnMuLi4KwqAgwqAgV2h5IHNob3VsZCB0aGUgbGFzdCBvZiBzZWdtZW50IGhhdmUg
bm8gdmFsaWQgYmxvY2sgaW7CoExGUyBtb2RlPwoKwqAgwqAgQ291bGQgeW91IHRha2Ugc29tZSB0
aW1lIGFuZCBnaXZlIG1lIHNvbWUgY2x1ZXMgb24gaXQuLi4gOkQKClRoYW5rcyBhIGxvdC4KCkdh
byBYaWFuZwpoc2lhbmdrYW9AYW9sLmNvbQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ2hlY2sgb3V0
IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5IG9uIG9uZSBvZiB0aGUgd29ybGQncyBtb3N0CmVu
Z2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoZG90Lm9yZyEgaHR0cDovL3NkbS5saW5rL3NsYXNoZG90
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
