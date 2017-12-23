From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] fsck.f2fs: check and fix i_namelen to
 avoid double free
Date: Sat, 23 Dec 2017 11:35:38 +0800
Message-ID: <7409e62c-cf8f-b5d3-9ec7-f22d1e3a5c7c@huawei.com>
References: <1513319130-114230-1-git-send-email-yunlong.song@huawei.com>
 <1513603527-163036-1-git-send-email-yunlong.song@huawei.com>
 <cbf1ef8f-9347-3a4c-bac7-62173544068f@huawei.com>
 <1d02d383-434e-bf32-1940-ff2ef790868f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eSabV-0004wN-FA
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Dec 2017 03:36:05 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eSabU-00070B-1U
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Dec 2017 03:36:05 +0000
In-Reply-To: <1d02d383-434e-bf32-1940-ff2ef790868f@huawei.com>
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
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: shengyong1@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

T24gMjAxNy8xMi8yMyAxMToxOSwgWXVubG9uZyBTb25nIHdyb3RlOgo+IERvdWJsZSBmcmVlIHBy
b2JsZW06Cj4gU2luY2UgZGRyIGJpdCBqdW1wIG1ha2VzIGlfbmFtZWxlbiBhIGxhcmdlciB2YWx1
ZSAoPiAyNTUp77yMd2hlbiBmaWxlIGlzIAo+IG5vdCBlbmNyeXB0ZWQsCj4gdGhlIGNvbnZlcnRf
ZW5jcnlwdGVkX25hbWUgd2lsbCBtZW1jcHkgb3V0IHJhbmdlIG9mIGVuWzI1NV0sIHdoZW4gZW4g
aXMgCj4gZnJlZWQsIHRoZXJlCj4gd2lsbCBiZSBkb3VibGUgZnJlZSBwcm9ibGVtLgoKSXQgbG9v
a3MgdGhlcmUgaXMgb25seSBtZW1jcHkgb3ZlcmZsb3cgcHJvYmxlbSBoZXJlLgoKVGhhbmtzLAoK
PiAKPiBPbiAyMDE3LzEyLzIzIDExOjA1LCBDaGFvIFl1IHdyb3RlOgo+PiBPbiAyMDE3LzEyLzE4
IDIxOjI1LCBZdW5sb25nIFNvbmcgd3JvdGU6Cj4+PiB2MSAtPiB2MjogdXNlIGNoaWxkX2luZm8g
dG8gcGFzcyBkZW50cnkgbmFtZWxlbgo+Pj4gdjIgLT4gdjM6IGNoZWNrIGNoaWxkICE9IE5VTEwg
dG8gaW5jbHVkZSB0aGUgRjJGU19GVF9PUlBIQU4gZmlsZSB0eXBlCj4+PiB2MyAtPiB2NDogZml4
IHRoZSBpX25hbWVsZW4gcHJvYmxlbSBvZiBkdW1wLmYyZnPjgIEKPj4gVGhlcmUgaXMgbm8gY29t
bWl0IGxvZywgc28gd2hhdCBkbyB5b3UgbWVhbiBhYm91dCAiYXZvaWQgZG91YmxlIGZyZWUiPwo+
Pgo+PiBPdGhlciB0aGFuIHRoYXQsIGxvb2tzIGdvb2QgdG8gbWUuCj4+Cj4+IFJldmlld2VkLWJ5
OiBDaGFvIFl1IDx5dWNoYW8wQGh1YXdlaS5jb20+Cj4+Cj4+IFRoYW5rcywKPj4KPj4KPj4gLgo+
Pgo+IAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBj
b21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRlcywg
U2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
