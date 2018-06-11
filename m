From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix error path of fill_super
Date: Mon, 11 Jun 2018 18:02:02 +0800
Message-ID: <20180611100202.68674-2-yuchao0@huawei.com>
References: <20180611100202.68674-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611100202.68674-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In fill_super, if root inode's attribute is incorrect, we need to
call f2fs_destroy_stats to release stats memory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19ef966a99e9..a790dae6c16f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2914,7 +2914,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
 		iput(root);
 		err = -EINVAL;
-		goto free_node_inode;
+		goto free_stats;
 	}
 
 	sb->s_root = d_make_root(root); /* allocate root dentry */
-- 
2.18.0.rc1
