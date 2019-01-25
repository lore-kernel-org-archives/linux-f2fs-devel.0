From: Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: use xattr_prefix to wrap up
Date: Fri, 25 Jan 2019 20:11:39 +0800
Message-ID: <20190125121139.27858-1-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gaoxiang25@huawei.com>) id 1gn0Mh-0003ip-Hd
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Jan 2019 12:13:43 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gn0MW-00DiA0-MG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Jan 2019 12:13:43 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Let's use xattr_prefix instead of open code.
No logic changes.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 18d5ffbc5e8c..fa620d31ea5f 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -538,7 +538,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		if (!handler || (handler->list && !handler->list(dentry)))
 			continue;
 
-		prefix = handler->prefix ?: handler->name;
+		prefix = xattr_prefix(handler);
 		prefix_len = strlen(prefix);
 		size = prefix_len + entry->e_name_len + 1;
 		if (buffer) {
-- 
2.14.4
