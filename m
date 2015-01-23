From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: use f2fs_radix_tree_insert to clean codes
Date: Fri, 23 Jan 2015 20:37:53 +0800
Message-ID: <000701d03709$8916a3a0$9b43eae0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

No modification in functionality, just clean codes with f2fs_radix_tree_insert.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 40887d3..180b161 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -356,11 +356,9 @@ static void add_gc_inode(struct gc_inode_list *gc_list, struct inode *inode)
 	}
 	new_ie = f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
 	new_ie->inode = inode;
-retry:
-	if (radix_tree_insert(&gc_list->iroot, inode->i_ino, new_ie)) {
-		cond_resched();
-		goto retry;
-	}
+
+	f2fs_radix_tree_insert(&gc_list->iroot, inode->i_ino, new_ie);
+
 	list_add_tail(&new_ie->list, &gc_list->ilist);
 }
 
-- 
2.2.1
