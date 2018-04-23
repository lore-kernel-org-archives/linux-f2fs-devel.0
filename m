From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: clean up commit_inmem_pages()
Date: Mon, 23 Apr 2018 10:36:14 +0800
Message-ID: <20180423023615.33247-2-yuchao0@huawei.com>
References: <20180423023615.33247-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fARLb-0006zT-3D
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 02:36:55 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fARLZ-00B8tM-Dx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 02:36:55 +0000
In-Reply-To: <20180423023615.33247-1-yuchao0@huawei.com>
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

This patch moves error handling from commit_inmem_pages() into
__commit_inmem_page() for cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 24299f81f80d..dcb4fcb8b1b0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -347,8 +347,7 @@ void drop_inmem_page(struct inode *inode, struct page *page)
 	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
 }
 
-static int __commit_inmem_pages(struct inode *inode,
-					struct list_head *revoke_list)
+static int __commit_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -361,9 +360,12 @@ static int __commit_inmem_pages(struct inode *inode,
 		.op_flags = REQ_SYNC | REQ_PRIO,
 		.io_type = FS_DATA_IO,
 	};
+	struct list_head revoke_list;
 	pgoff_t last_idx = ULONG_MAX;
 	int err = 0;
 
+	INIT_LIST_HEAD(&revoke_list);
+
 	list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list) {
 		struct page *page = cur->page;
 
@@ -397,14 +399,28 @@ static int __commit_inmem_pages(struct inode *inode,
 			last_idx = page->index;
 		}
 		unlock_page(page);
-		list_move_tail(&cur->list, revoke_list);
+		list_move_tail(&cur->list, &revoke_list);
 	}
 
 	if (last_idx != ULONG_MAX)
 		f2fs_submit_merged_write_cond(sbi, inode, 0, last_idx, DATA);
 
-	if (!err)
-		__revoke_inmem_pages(inode, revoke_list, false, false);
+	if (err) {
+		/*
+		 * try to revoke all committed pages, but still we could fail
+		 * due to no memory or other reason, if that happened, EAGAIN
+		 * will be returned, which means in such case, transaction is
+		 * already not integrity, caller should use journal to do the
+		 * recovery or rewrite & commit last transaction. For other
+		 * error number, revoking was done by filesystem itself.
+		 */
+		err = __revoke_inmem_pages(inode, &revoke_list, false, true);
+
+		/* drop all uncommitted pages */
+		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
+	} else {
+		__revoke_inmem_pages(inode, &revoke_list, false, false);
+	}
 
 	return err;
 }
@@ -413,34 +429,16 @@ int commit_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct list_head revoke_list;
 	int err;
 
-	INIT_LIST_HEAD(&revoke_list);
 	f2fs_balance_fs(sbi, true);
 	f2fs_lock_op(sbi);
 
 	set_inode_flag(inode, FI_ATOMIC_COMMIT);
 
 	mutex_lock(&fi->inmem_lock);
-	err = __commit_inmem_pages(inode, &revoke_list);
-	if (err) {
-		int ret;
-		/*
-		 * try to revoke all committed pages, but still we could fail
-		 * due to no memory or other reason, if that happened, EAGAIN
-		 * will be returned, which means in such case, transaction is
-		 * already not integrity, caller should use journal to do the
-		 * recovery or rewrite & commit last transaction. For other
-		 * error number, revoking was done by filesystem itself.
-		 */
-		ret = __revoke_inmem_pages(inode, &revoke_list, false, true);
-		if (ret)
-			err = ret;
+	err = __commit_inmem_pages(inode);
 
-		/* drop all uncommitted pages */
-		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
-	}
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (!list_empty(&fi->inmem_ilist))
 		list_del_init(&fi->inmem_ilist);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
