From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: fix to reorder set_page_dirty and wait_on_page_writeback
Date: Wed, 12 Dec 2018 18:12:30 +0800
Message-ID: <20181212101232.54289-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch reorders flow from

- update page
- set_page_dirty
- wait_on_page_writeback

to

- wait_on_page_writeback
- update page
- set_page_dirty

The reason is:
- set_page_dirty will increase reference of dirty page, the reference
should be cleared before wait_on_page_writeback to keep its consistency.
- some devices need stable page during page writebacking, so we
should not change page's data.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 7 ++++---
 fs/f2fs/gc.c         | 5 +++--
 fs/f2fs/node.c       | 5 +++--
 fs/f2fs/segment.c    | 3 ++-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3a25cf22d732..4f02461f348c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1290,11 +1290,12 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
 	int err;
 
-	memcpy(page_address(page), src, PAGE_SIZE);
-	set_page_dirty(page);
-
 	f2fs_wait_on_page_writeback(page, META, true);
 	f2fs_bug_on(sbi, PageWriteback(page));
+
+	memcpy(page_address(page), src, PAGE_SIZE);
+
+	set_page_dirty(page);
 	if (unlikely(!clear_page_dirty_for_io(page)))
 		f2fs_bug_on(sbi, 1);
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 71462f2e47d4..666518eb7293 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -829,8 +829,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	}
 
 write_page:
-	set_page_dirty(fio.encrypted_page);
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true);
+	set_page_dirty(fio.encrypted_page);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
 
@@ -924,8 +924,9 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		bool is_dirty = PageDirty(page);
 
 retry:
-		set_page_dirty(page);
 		f2fs_wait_on_page_writeback(page, DATA, true);
+
+		set_page_dirty(page);
 		if (clear_page_dirty_for_io(page)) {
 			inode_dec_dirty_pages(inode);
 			f2fs_remove_dirty_inode(inode);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a2273340991f..c09df777f66f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1598,10 +1598,11 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 			.for_reclaim = 0,
 		};
 
-		set_page_dirty(node_page);
 		f2fs_wait_on_page_writeback(node_page, NODE, true);
-
 		f2fs_bug_on(F2FS_P_SB(node_page), PageWriteback(node_page));
+
+		set_page_dirty(node_page);
+
 		if (!clear_page_dirty_for_io(node_page)) {
 			err = -EAGAIN;
 			goto out_page;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 204d31e58967..e2e971e89b2d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -387,8 +387,9 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
 		if (page->mapping == inode->i_mapping) {
 			trace_f2fs_commit_inmem_page(page, INMEM);
 
-			set_page_dirty(page);
 			f2fs_wait_on_page_writeback(page, DATA, true);
+
+			set_page_dirty(page);
 			if (clear_page_dirty_for_io(page)) {
 				inode_dec_dirty_pages(inode);
 				f2fs_remove_dirty_inode(inode);
-- 
2.18.0.rc1
