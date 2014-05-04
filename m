From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] f2fs: avoid uneeded check of xattr name
Date: Sun, 4 May 2014 16:13:08 +0800
Message-ID: <5365F694.1050304@huawei.com>
References: <1399174618-2382-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhenzhang.zhang@huawei.com>) id 1WgrY8-00042m-AF
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 May 2014 08:13:28 +0000
Received: from szxga01-in.huawei.com ([119.145.14.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WgrY5-00028W-7Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 May 2014 08:13:28 +0000
In-Reply-To: <1399174618-2382-1-git-send-email-zhenzhang.zhang@huawei.com>
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

In all the callers of f2fs_set(get)xattr(),
the xattr name can not be NULL.

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 fs/f2fs/xattr.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 503c245..f382e24 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -404,8 +404,6 @@ int f2fs_getxattr(struct inode *inode, int name_index, const char *name,
 	int error = 0;
 	size_t value_len, name_len;

-	if (name == NULL)
-		return -EINVAL;
 	name_len = strlen(name);
 	if (name_len > F2FS_NAME_LEN)
 		return -ERANGE;
@@ -487,9 +485,6 @@ static int __f2fs_setxattr(struct inode *inode, int name_index,
 	__u32 new_hsize;
 	int error = -ENOMEM;

-	if (name == NULL)
-		return -EINVAL;
-
 	if (value == NULL)
 		value_len = 0;

-- 
1.8.1.2


.





------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
