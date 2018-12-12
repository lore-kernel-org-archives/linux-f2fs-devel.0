From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: check PageWriteback flag for ordered case
Date: Wed, 12 Dec 2018 18:12:31 +0800
Message-ID: <20181212101232.54289-2-yuchao0@huawei.com>
References: <20181212101232.54289-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212101232.54289-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

For all ordered cases in f2fs_wait_on_page_writeback(), we need to
check PageWriteback status, so let's clean up to relocate the check
into f2fs_wait_on_page_writeback().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 1 -
 fs/f2fs/node.c       | 3 ---
 fs/f2fs/segment.c    | 6 ++++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4f02461f348c..0a6b5dc0d717 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1291,7 +1291,6 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	int err;
 
 	f2fs_wait_on_page_writeback(page, META, true);
-	f2fs_bug_on(sbi, PageWriteback(page));
 
 	memcpy(page_address(page), src, PAGE_SIZE);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c09df777f66f..30a4427aaa94 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1599,7 +1599,6 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 		};
 
 		f2fs_wait_on_page_writeback(node_page, NODE, true);
-		f2fs_bug_on(F2FS_P_SB(node_page), PageWriteback(node_page));
 
 		set_page_dirty(node_page);
 
@@ -1691,7 +1690,6 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			}
 
 			f2fs_wait_on_page_writeback(page, NODE, true);
-			BUG_ON(PageWriteback(page));
 
 			set_fsync_mark(page, 0);
 			set_dentry_mark(page, 0);
@@ -1825,7 +1823,6 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			f2fs_wait_on_page_writeback(page, NODE, true);
 
-			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e2e971e89b2d..007a6f6c74c7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3281,10 +3281,12 @@ void f2fs_wait_on_page_writeback(struct page *page,
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
 		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
-		if (ordered)
+		if (ordered) {
 			wait_on_page_writeback(page);
-		else
+			f2fs_bug_on(sbi, PageWriteback(page));
+		} else {
 			wait_for_stable_page(page);
+		}
 	}
 }
 
-- 
2.18.0.rc1
