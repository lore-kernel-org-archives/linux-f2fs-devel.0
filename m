From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/7] f2fs: fix error handling in fill_super
Date: Thu, 30 Nov 2017 19:28:20 +0800
Message-ID: <20171130112823.100494-4-yuchao0@huawei.com>
References: <20171130112823.100494-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN1O-00026Q-K6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:50 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN1N-0000ep-7m
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:50 +0000
In-Reply-To: <20171130112823.100494-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In fill_super, if we fail to call f2fs_build_stats(), it needs to detach
from global f2fs shrink list, otherwise once system starts to shrink slab
cache, we will encounter below panic:

BUG: unable to handle kernel paging request at 00007d35
Oops: 0002 [#1] PREEMPT SMP
EIP: __lock_acquire+0x70/0x12c0
Call Trace:
 lock_acquire+0xae/0x220
 mutex_trylock+0xc5/0xf0
 f2fs_shrink_count+0x32/0xb0 [f2fs]
 shrink_slab+0xf1/0x5b0
 drop_slab_node+0x35/0x60
 drop_slab+0xf/0x20
 drop_caches_sysctl_handler+0x79/0xc0
 proc_sys_call_handler+0xa4/0xc0
 proc_sys_write+0x1f/0x30
 __vfs_write+0x24/0x150
 SyS_write+0x44/0x90
 do_fast_syscall_32+0xa1/0x1ca
 entry_SYSENTER_32+0x4c/0x7b

In addition, this patch relocates f2fs_join_shrinker in fill_super to
avoid unneeded error handling of it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2a4b469a5bda..fc4f8e134a39 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2620,18 +2620,16 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_nm;
 	}
 
-	f2fs_join_shrinker(sbi);
-
 	err = f2fs_build_stats(sbi);
 	if (err)
-		goto free_nm;
+		goto free_node_inode;
 
 	/* read root inode and dentry */
 	root = f2fs_iget(sb, F2FS_ROOT_INO(sbi));
 	if (IS_ERR(root)) {
 		f2fs_msg(sb, KERN_ERR, "Failed to read root inode");
 		err = PTR_ERR(root);
-		goto free_node_inode;
+		goto free_stats;
 	}
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
 		iput(root);
@@ -2727,6 +2725,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->valid_super_block ? 1 : 2, err);
 	}
 
+	f2fs_join_shrinker(sbi);
+
 	f2fs_msg(sbi->sb, KERN_NOTICE, "Mounted with checkpoint version = %llx",
 				cur_cp_version(F2FS_CKPT(sbi)));
 	f2fs_update_time(sbi, CP_TIME);
@@ -2753,14 +2753,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
+free_stats:
+	f2fs_destroy_stats(sbi);
 free_node_inode:
-	truncate_inode_pages_final(NODE_MAPPING(sbi));
-	mutex_lock(&sbi->umount_mutex);
 	release_ino_entry(sbi, true);
-	f2fs_leave_shrinker(sbi);
+	truncate_inode_pages_final(NODE_MAPPING(sbi));
 	iput(sbi->node_inode);
-	mutex_unlock(&sbi->umount_mutex);
-	f2fs_destroy_stats(sbi);
 free_nm:
 	destroy_node_manager(sbi);
 free_sm:
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
