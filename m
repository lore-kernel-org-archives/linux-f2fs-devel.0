From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: remove unnecessary initialization
Date: Tue, 23 Aug 2016 20:10:47 +0800
Message-ID: <20160823121047.6428-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1bcAeD-0000v5-4i
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 12:17:41 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bcAeA-0000Xr-Om
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 12:17:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

`flags' is used to save value from userspace, there is no need to
initialize it, and FS_FL_USER_VISIBLE is the mask for getflags.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 47abb96..7c6ee7e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1454,7 +1454,7 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	unsigned int flags = fi->i_flags & FS_FL_USER_VISIBLE;
+	unsigned int flags;
 	unsigned int oldflags;
 	int ret;
 
-- 
2.9.2


------------------------------------------------------------------------------
