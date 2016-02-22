From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/5] f2fs: try to flush inode after merging inline data
Date: Mon, 22 Feb 2016 18:35:46 +0800
Message-ID: <004901d16d5c$e207b5f0$a61721d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When flushing node pages, if current node page is an inline inode page, we
will try to merge inline data from data page into inline inode page, then
skip flushing current node page, it will decrease the number of nodes to
be flushed in batch in this round, which may lead to worse performance.

This patch gives a chance to flush just merged inline inode pages for
performance.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 966176b..82cde7a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1275,6 +1275,7 @@ next_step:
 			 * If an fsync mode,
 			 * we should not skip writing node pages.
 			 */
+lock_node:
 			if (ino && ino_of_node(page) == ino)
 				lock_page(page);
 			else if (!trylock_page(page))
@@ -1298,7 +1299,7 @@ continue_unlock:
 				clear_inline_node(page);
 				unlock_page(page);
 				flush_inline_data(sbi, ino_of_node(page));
-				continue;
+				goto lock_node;
 			}
 
 			f2fs_wait_on_page_writeback(page, NODE, true);
-- 
2.7.0
