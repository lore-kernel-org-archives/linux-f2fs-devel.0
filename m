From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: fix stale ATOMIC_WRITTEN_PAGE private
	pointer
Date: Fri, 17 Mar 2017 10:09:05 +0800
Message-ID: <20170317020906.28165-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cohKR-0008TE-6A
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 02:09:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cohKQ-0005tA-4L
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 02:09:19 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

When I forced to enable atomic operations intentionally, I could hit the below
panic, since we didn't clear page->private in f2fs_invalidate_page called by
file truncation.

The panic occurs due to NULL mapping having page->private.

BUG: unable to handle kernel paging request at ffffffffffffffff
IP: drop_buffers+0x38/0xe0
PGD 5d00c067
PUD 5d00e067
PMD 0
CPU: 3 PID: 1648 Comm: fsstress Tainted: G      D    OE   4.10.0+ #5
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
task: ffff9151952863c0 task.stack: ffffaaec40db4000
RIP: 0010:drop_buffers+0x38/0xe0
RSP: 0018:ffffaaec40db74c8 EFLAGS: 00010292
Call Trace:
 ? page_referenced+0x8b/0x170
 try_to_free_buffers+0xc5/0xe0
 try_to_release_page+0x49/0x50
 shrink_page_list+0x8bc/0x9f0
 shrink_inactive_list+0x1dd/0x500
 ? shrink_active_list+0x2c0/0x430
 shrink_node_memcg+0x5eb/0x7c0
 shrink_node+0xe1/0x320
 do_try_to_free_pages+0xef/0x2e0
 try_to_free_pages+0xe9/0x190
 __alloc_pages_slowpath+0x390/0xe70
 __alloc_pages_nodemask+0x291/0x2b0
 alloc_pages_current+0x95/0x140
 __page_cache_alloc+0xc4/0xe0
 pagecache_get_page+0xab/0x2a0
 grab_cache_page_write_begin+0x20/0x40
 get_read_data_page+0x2e6/0x4c0 [f2fs]
 ? f2fs_mark_inode_dirty_sync+0x16/0x30 [f2fs]
 ? truncate_data_blocks_range+0x238/0x2b0 [f2fs]
 get_lock_data_page+0x30/0x190 [f2fs]
 __exchange_data_block+0xaaf/0xf40 [f2fs]
 f2fs_fallocate+0x418/0xd00 [f2fs]
 vfs_fallocate+0x157/0x220
 SyS_fallocate+0x48/0x80

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  2 +-
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 28 +++++++++++++++++++++-------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e07c60fb1033..f4b3006e3ecb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1967,7 +1967,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 
 	/* This is atomic written page, keep Private */
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
-		return;
+		drop_inmem_page(inode, page);
 
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e7b1a6c30d9e..9a06d0720351 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2173,6 +2173,7 @@ void destroy_node_manager_caches(void);
  */
 void register_inmem_page(struct inode *inode, struct page *page);
 void drop_inmem_pages(struct inode *inode);
+void drop_inmem_page(struct inode *inode, struct page *page);
 int commit_inmem_pages(struct inode *inode);
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 42727e40d17c..3e8d08722151 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -192,7 +192,7 @@ void register_inmem_page(struct inode *inode, struct page *page)
 	trace_f2fs_register_inmem_page(page, INMEM);
 }
 
-static int __revoke_inmem_pages(struct inode *inode,
+static int __revoke_inmem_pages(struct inode *inode, struct page *p,
 				struct list_head *head, bool drop, bool recover)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -205,7 +205,10 @@ static int __revoke_inmem_pages(struct inode *inode,
 		if (drop)
 			trace_f2fs_commit_inmem_page(page, INMEM_DROP);
 
-		lock_page(page);
+		if (!p)
+			lock_page(page);
+		else if (p != page)
+			continue;
 
 		if (recover) {
 			struct dnode_of_data dn;
@@ -229,7 +232,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 			ClearPageUptodate(page);
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
-		f2fs_put_page(page, 1);
+		f2fs_put_page(page, p ? 0 : 1);
 
 		list_del(&cur->list);
 		kmem_cache_free(inmem_entry_slab, cur);
@@ -243,13 +246,22 @@ void drop_inmem_pages(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	mutex_lock(&fi->inmem_lock);
-	__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
+	__revoke_inmem_pages(inode, NULL, &fi->inmem_pages, true, false);
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
 	stat_dec_atomic_write(inode);
 }
 
+void drop_inmem_page(struct inode *inode, struct page *page)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+
+	mutex_lock(&fi->inmem_lock);
+	__revoke_inmem_pages(inode, page, &fi->inmem_pages, true, false);
+	mutex_unlock(&fi->inmem_lock);
+}
+
 static int __commit_inmem_pages(struct inode *inode,
 					struct list_head *revoke_list)
 {
@@ -300,7 +312,7 @@ static int __commit_inmem_pages(struct inode *inode,
 							DATA, WRITE);
 
 	if (!err)
-		__revoke_inmem_pages(inode, revoke_list, false, false);
+		__revoke_inmem_pages(inode, NULL, revoke_list, false, false);
 
 	return err;
 }
@@ -330,12 +342,14 @@ int commit_inmem_pages(struct inode *inode)
 		 * recovery or rewrite & commit last transaction. For other
 		 * error number, revoking was done by filesystem itself.
 		 */
-		ret = __revoke_inmem_pages(inode, &revoke_list, false, true);
+		ret = __revoke_inmem_pages(inode, NULL, &revoke_list,
+							false, true);
 		if (ret)
 			err = ret;
 
 		/* drop all uncommitted pages */
-		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
+		__revoke_inmem_pages(inode, NULL, &fi->inmem_pages,
+							true, false);
 	}
 	mutex_unlock(&fi->inmem_lock);
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
