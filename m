From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: cleanup if-statement of phase in gc_data_segment
Date: Thu, 27 Nov 2014 16:03:08 +0900
Message-ID: <1417071788-21013-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Little cleanup to distinguish each phase easily

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/gc.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 81686b2..de00713 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -602,27 +602,28 @@ next_step:
 
 			data_page = find_data_page(inode,
 					start_bidx + ofs_in_node, false);
-			if (IS_ERR(data_page))
-				goto next_iput;
+			if (IS_ERR(data_page)) {
+				iput(inode);
+				continue;
+			}
 
 			f2fs_put_page(data_page, 0);
 			add_gc_inode(inode, ilist);
-		} else {
-			inode = find_gc_inode(dni.ino, ilist);
-			if (inode) {
-				start_bidx = start_bidx_of_node(nofs,
-								F2FS_I(inode));
-				data_page = get_lock_data_page(inode,
-						start_bidx + ofs_in_node);
-				if (IS_ERR(data_page))
-					continue;
-				move_data_page(inode, data_page, gc_type);
-				stat_inc_data_blk_count(sbi, 1);
-			}
+			continue;
+		}
+
+		/* phase 3 */
+		inode = find_gc_inode(dni.ino, ilist);
+		if (inode) {
+			start_bidx = start_bidx_of_node(nofs,
+							F2FS_I(inode));
+			data_page = get_lock_data_page(inode,
+					start_bidx + ofs_in_node);
+			if (IS_ERR(data_page))
+				continue;
+			move_data_page(inode, data_page, gc_type);
+			stat_inc_data_blk_count(sbi, 1);
 		}
-		continue;
-next_iput:
-		iput(inode);
 	}
 
 	if (++phase < 4)
-- 
1.9.1

