From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix an endian conversion bug detected by sparse
Date: Mon, 24 Jun 2013 07:51:45 +0900
Message-ID: <1372027905-24393-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch should fix the following bug reported by kbuild test robot.

fs/f2fs/recovery.c:233:33: sparse: incorrect type in assignment
(different base types)

parse warnings: (new ones prefixed by >>)

>> fs/f2fs/recovery.c:233:33: sparse: incorrect type in assignment (different base types)
   fs/f2fs/recovery.c:233:33:    expected unsigned int [unsigned] [assigned] ofs_in_node
   fs/f2fs/recovery.c:233:33:    got restricted __le16 [assigned] [usertype] ofs_in_node
>> fs/f2fs/recovery.c:238:33: sparse: incorrect type in assignment (different base types)
   fs/f2fs/recovery.c:238:33:    expected unsigned int [unsigned] ofs_in_node
   fs/f2fs/recovery.c:238:33:    got restricted __le16 [assigned] [usertype] ofs_in_node

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/recovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ddde14f..9db8239 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -246,12 +246,12 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 		struct dnode_of_data tdn = *dn;
 		tdn.nid = nid;
 		tdn.node_page = dn->inode_page;
-		tdn.ofs_in_node = sum.ofs_in_node;
+		tdn.ofs_in_node = le16_to_cpu(sum.ofs_in_node);
 		truncate_data_blocks_range(&tdn, 1);
 		return 0;
 	} else if (dn->nid == nid) {
 		struct dnode_of_data tdn = *dn;
-		tdn.ofs_in_node = sum.ofs_in_node;
+		tdn.ofs_in_node = le16_to_cpu(sum.ofs_in_node);
 		truncate_data_blocks_range(&tdn, 1);
 		return 0;
 	}
-- 
1.8.3.1.437.g0dbd812

