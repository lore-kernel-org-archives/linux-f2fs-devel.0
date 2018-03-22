From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: no need to initialize zero value for GFP_F2FS_ZERO
Date: Thu, 22 Mar 2018 10:08:40 +0800
Message-ID: <1521684520-142131-1-git-send-email-yunlong.song@huawei.com>
References: <1521635131-137071-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521635131-137071-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since f2fs_inode_info is allocated with flag GFP_F2FS_ZERO, so we do not
need to initialize zero value for its member any more.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/super.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0c1fe9b..42d564c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -827,7 +827,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Initialize f2fs-specific inode info */
 	atomic_set(&fi->dirty_pages, 0);
 	fi->i_current_depth = 1;
-	fi->i_advise = 0;
 	init_rwsem(&fi->i_sem);
 	INIT_LIST_HEAD(&fi->dirty_list);
 	INIT_LIST_HEAD(&fi->gdirty_list);
@@ -839,10 +838,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_xattr_sem);
 
-#ifdef CONFIG_QUOTA
-	memset(&fi->i_dquot, 0, sizeof(fi->i_dquot));
-	fi->i_reserved_quota = 0;
-#endif
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
-- 
1.8.5.2
