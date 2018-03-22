From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: rebuild get_node_path function
Date: Thu, 22 Mar 2018 10:49:14 +0800
Message-ID: <1521686954-2906-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1eyqVW-0001wm-Mz
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Mar 2018 03:03:14 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1eyqVS-00AreU-8k
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Mar 2018 03:03:14 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: heyunlei@huawei.com

This patch rebuild get_node_path function, no logic changes.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c511ef6..33c8554 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -526,46 +526,31 @@ static int get_node_path(struct inode *inode, long block,
 
 	if (block < direct_index) {
 		offset[n] = block;
-		goto got;
-	}
-	block -= direct_index;
-	if (block < direct_blks) {
+	} else if (block -= direct_index < direct_blks) {
 		offset[n++] = NODE_DIR1_BLOCK;
 		noffset[n] = 1;
 		offset[n] = block;
 		level = 1;
-		goto got;
-	}
-	block -= direct_blks;
-	if (block < direct_blks) {
+	} else if (block -= direct_blks < direct_blks) {
 		offset[n++] = NODE_DIR2_BLOCK;
 		noffset[n] = 2;
 		offset[n] = block;
 		level = 1;
-		goto got;
-	}
-	block -= direct_blks;
-	if (block < indirect_blks) {
+	} else if (block -= direct_blks < indirect_blks) {
 		offset[n++] = NODE_IND1_BLOCK;
 		noffset[n] = 3;
 		offset[n++] = block / direct_blks;
 		noffset[n] = 4 + offset[n - 1];
 		offset[n] = block % direct_blks;
 		level = 2;
-		goto got;
-	}
-	block -= indirect_blks;
-	if (block < indirect_blks) {
+	} else if (block -= indirect_blks < indirect_blks) {
 		offset[n++] = NODE_IND2_BLOCK;
 		noffset[n] = 4 + dptrs_per_blk;
 		offset[n++] = block / direct_blks;
 		noffset[n] = 5 + dptrs_per_blk + offset[n - 1];
 		offset[n] = block % direct_blks;
 		level = 2;
-		goto got;
-	}
-	block -= indirect_blks;
-	if (block < dindirect_blks) {
+	} else if (block -= indirect_blks < dindirect_blks) {
 		offset[n++] = NODE_DIND_BLOCK;
 		noffset[n] = 5 + (dptrs_per_blk * 2);
 		offset[n++] = block / indirect_blks;
@@ -577,11 +562,10 @@ static int get_node_path(struct inode *inode, long block,
 			      offset[n - 1];
 		offset[n] = block % direct_blks;
 		level = 3;
-		goto got;
 	} else {
 		return -E2BIG;
 	}
-got:
+
 	return level;
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
