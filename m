From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] f2fs: fix error return code in init_f2fs_fs()
Date: Fri, 23 Aug 2013 08:30:20 +0800
Message-ID: <CAPgLHd-bUFP3Rr+yBkSgP7mm12dx4oHAvuZgswf1eTkhkdBdaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com, namjae.jeon@samsung.com
Cc: yongjun_wei@trendmicro.com.cn, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in the kset create and add error handling
case instead of 0, as done elsewhere in this function.

Introduced by commit b59d0bae6ca30c496f298881616258f9cde0d9c6.
(f2fs: add sysfs support for controlling the gc_thread)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 fs/f2fs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 66d1ec1..33a809f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1013,8 +1013,10 @@ static int __init init_f2fs_fs(void)
 	if (err)
 		goto fail;
 	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
-	if (!f2fs_kset)
+	if (!f2fs_kset) {
+		err = -ENOMEM;
 		goto fail;
+	}
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto fail;
