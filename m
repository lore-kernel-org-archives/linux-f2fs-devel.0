From: ZhangZhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] f2fs: Check the acl's validity before setting
Date: Fri, 4 Apr 2014 09:47:16 +0800
Message-ID: <533E0F24.4020205@huawei.com>
References: <1396429285-64601-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhenzhang.zhang@huawei.com>) id 1WVtEO-0003ee-E1
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Apr 2014 01:47:44 +0000
Received: from szxga01-in.huawei.com ([119.145.14.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WVtEK-0006ug-DH
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Apr 2014 01:47:44 +0000
In-Reply-To: <1396429285-64601-1-git-send-email-zhenzhang.zhang@huawei.com>
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


Before setting the acl, call posix_acl_valid() to check if it is
valid or not.

Signed-off-by: zhangzhen <zhenzhang.zhang@huawei.com>
---
 fs/f2fs/acl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index fa8da4c..d4069e1 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -203,6 +203,12 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	size_t size = 0;
 	int error;

+	if (acl) {
+		error = posix_acl_valid(acl);
+		if (error < 0)
+			return error;
+	}
+
 	switch (type) {
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
-- 
1.6.0.2


.





------------------------------------------------------------------------------
