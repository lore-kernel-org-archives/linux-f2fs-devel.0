From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: use timespec64 for inode timestamps
Date: Thu, 21 Jun 2018 14:08:06 +0800
Message-ID: <cda86b47-c61d-121e-a353-97f3e5447bb7@huawei.com>
References: <20180620080603.4156809-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <20180620080603.4156809-1-arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Sheng Yong <shengyong1@huawei.com>, Eric Biggers <ebiggers@google.com>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Yunlong Song <yunlong.song@huawei.com>, Yunlei He <heyunlei@huawei.com>, Deepa Dinamani <deepa.kernel@gmail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

T24gMjAxOC82LzIwIDE2OjAyLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+IFRoZSBvbi1kaXNrIHJl
cHJlc2VudGF0aW9uIGFuZCB0aGUgdmZzIGJvdGggdXNlIDY0LWJpdCB0dl9zZWMgdmFsdWVzLAo+
IHNvIGxldCdzIGNoYW5nZSB0aGUgbGFzdCBtaXNzaW5nIHBpZWNlIGluIHRoZSBtaWRkbGUuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KClJldmlld2Vk
LWJ5OiBDaGFvIFl1IDx5dWNoYW8wQGh1YXdlaS5jb20+CgpUaGFua3MsCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAzOCBtYWlsaW5nIGxpc3QKWTIw
MzhAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0
aW5mby95MjAzOAo=
