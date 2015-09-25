From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: remove unneeded f2fs_{,un}lock_op in do_recover_data()
Date: Fri, 25 Sep 2015 17:54:56 +0800
Message-ID: <01c101d0f778$5455cdf0$fd0169d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Protecting recovery flow by using cp_rwsem is not needed, since we have
prevent triggering any checkpoint by locking cp_mutex previously.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/recovery.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index acc21f2..c5daec5 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -383,15 +383,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	start = start_bidx_of_node(ofs_of_node(page), fi);
 	end = start + ADDRS_PER_PAGE(page, fi);
 
-	f2fs_lock_op(sbi);
-
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 
 	err = get_dnode_of_data(&dn, start, ALLOC_NODE);
-	if (err) {
-		f2fs_unlock_op(sbi);
+	if (err)
 		goto out;
-	}
 
 	f2fs_wait_on_page_writeback(dn.node_page, NODE);
 
@@ -456,7 +452,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	set_page_dirty(dn.node_page);
 err:
 	f2fs_put_dnode(&dn);
-	f2fs_unlock_op(sbi);
 out:
 	f2fs_msg(sbi->sb, KERN_NOTICE,
 		"recover_data: ino = %lx, recovered = %d blocks, err = %d",
-- 
2.5.2
