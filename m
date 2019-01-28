From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 227/258] f2fs: fix use-after-free
 issue when accessing sbi->stat_info
Date: Mon, 28 Jan 2019 10:58:53 -0500
Message-ID: <20190128155924.51521-227-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1go9US-0008Mu-O1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 16:10:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1go9UM-003uI7-W1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 16:10:28 +0000
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

From: Sahitya Tummala <stummala@codeaurora.org>

[ Upstream commit 60aa4d5536ab7fe32433ca1173bd9d6633851f27 ]

iput() on sbi->node_inode can update sbi->stat_info
in the below context, if the f2fs_write_checkpoint()
has failed with error.

f2fs_balance_fs_bg+0x1ac/0x1ec
f2fs_write_node_pages+0x4c/0x260
do_writepages+0x80/0xbc
__writeback_single_inode+0xdc/0x4ac
writeback_single_inode+0x9c/0x144
write_inode_now+0xc4/0xec
iput+0x194/0x22c
f2fs_put_super+0x11c/0x1e8
generic_shutdown_super+0x70/0xf4
kill_block_super+0x2c/0x5c
kill_f2fs_super+0x44/0x50
deactivate_locked_super+0x60/0x8c
deactivate_super+0x68/0x74
cleanup_mnt+0x40/0x78

Fix this by moving f2fs_destroy_stats() further below iput() in
both f2fs_put_super() and f2fs_fill_super() paths.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 338138b34993..c9639ef0e8d5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1039,9 +1039,6 @@ static void f2fs_put_super(struct super_block *sb)
 		f2fs_write_checkpoint(sbi, &cpc);
 	}
 
-	/* f2fs_write_checkpoint can update stat informaion */
-	f2fs_destroy_stats(sbi);
-
 	/*
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
@@ -1061,6 +1058,12 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->node_inode);
 	iput(sbi->meta_inode);
 
+	/*
+	 * iput() can update stat information, if f2fs_write_checkpoint()
+	 * above failed with error.
+	 */
+	f2fs_destroy_stats(sbi);
+
 	/* destroy f2fs internal modules */
 	f2fs_destroy_node_manager(sbi);
 	f2fs_destroy_segment_manager(sbi);
@@ -2980,30 +2983,30 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	f2fs_build_gc_manager(sbi);
 
+	err = f2fs_build_stats(sbi);
+	if (err)
+		goto free_nm;
+
 	/* get an inode for node space */
 	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
 	if (IS_ERR(sbi->node_inode)) {
 		f2fs_msg(sb, KERN_ERR, "Failed to read node inode");
 		err = PTR_ERR(sbi->node_inode);
-		goto free_nm;
+		goto free_stats;
 	}
 
-	err = f2fs_build_stats(sbi);
-	if (err)
-		goto free_node_inode;
-
 	/* read root inode and dentry */
 	root = f2fs_iget(sb, F2FS_ROOT_INO(sbi));
 	if (IS_ERR(root)) {
 		f2fs_msg(sb, KERN_ERR, "Failed to read root inode");
 		err = PTR_ERR(root);
-		goto free_stats;
+		goto free_node_inode;
 	}
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks ||
 			!root->i_size || !root->i_nlink) {
 		iput(root);
 		err = -EINVAL;
-		goto free_stats;
+		goto free_node_inode;
 	}
 
 	sb->s_root = d_make_root(root); /* allocate root dentry */
@@ -3121,12 +3124,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
-free_stats:
-	f2fs_destroy_stats(sbi);
 free_node_inode:
 	f2fs_release_ino_entry(sbi, true);
 	truncate_inode_pages_final(NODE_MAPPING(sbi));
 	iput(sbi->node_inode);
+free_stats:
+	f2fs_destroy_stats(sbi);
 free_nm:
 	f2fs_destroy_node_manager(sbi);
 free_sm:
-- 
2.19.1
