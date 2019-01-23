From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] f2fs: jump to label 'free_node_inode' when
 failing from d_make_root()
Date: Wed, 23 Jan 2019 15:49:44 +0800
Message-ID: <20190123074944.28421-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1gmDIx-0008RD-Q3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Jan 2019 07:50:35 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gmDIq-007igt-62
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Jan 2019 07:50:35 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Chengguang Xu <cgxu519@gmx.com>, linux-f2fs-devel@lists.sourceforge.net

When sb->s_root is NULL dput() will do nothing,
so jump to label 'free_node_inode' instead of lable
'free_root_inode' when failing from d_make_root().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c46a1d4318d4..d92d4508f262 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3288,7 +3288,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_root = d_make_root(root); /* allocate root dentry */
 	if (!sb->s_root) {
 		err = -ENOMEM;
-		goto free_root_inode;
+		goto free_node_inode;
 	}
 
 	err = f2fs_register_sysfs(sbi);
-- 
2.20.1
