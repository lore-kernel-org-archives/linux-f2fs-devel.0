From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: retry to revoke atomic commit in -ENOMEM case
Date: Tue, 8 Aug 2017 19:09:08 +0800
Message-ID: <20170808110908.108562-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

During atomic committing, if we encounter -ENOMEM in revoke path, it's
better to give a chance to retry revoking.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 45fb53411032..682ae68b9ef7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -213,9 +213,15 @@ static int __revoke_inmem_pages(struct inode *inode,
 			struct node_info ni;
 
 			trace_f2fs_commit_inmem_page(page, INMEM_REVOKE);
-
+retry:
 			set_new_dnode(&dn, inode, NULL, NULL, 0);
-			if (get_dnode_of_data(&dn, page->index, LOOKUP_NODE)) {
+			err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
+			if (err) {
+				if (err == -ENOMEM) {
+					congestion_wait(BLK_RW_ASYNC, HZ/50);
+					cond_resched();
+					goto retry;
+				}
 				err = -EAGAIN;
 				goto next;
 			}
-- 
2.13.1.388.g69e6b9b4f4a9
