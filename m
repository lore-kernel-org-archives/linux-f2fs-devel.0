From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 1/2] fsck.f2fs: check extent of inline
 data/dentry inode
Date: Tue, 3 Jul 2018 18:10:04 +0800
Message-ID: <20180703101005.200396-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1faIGn-0006Up-5q
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Jul 2018 10:10:49 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1faIGj-00Byni-EW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Jul 2018 10:10:49 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, wen.xu@gatech.edu
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Check extent for inline data/dentry inode. If an inode contains inline
data/dentry, it should have no extent.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200175
Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c | 16 +++++++++++-----
 fsck/fsck.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6fd9dc2..15264b2 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -584,6 +584,9 @@ static void check_extent_info(struct child_info *child,
 	if (child->state & FSCK_UNMATCHED_EXTENT)
 		return;
 
+	if ((child->state & FSCK_INLINE_INODE) && ei->len)
+		goto unmatched;
+
 	if (last) {
 		/* hole exist in the back of extent */
 		if (child->last_blk != ei->blk + ei->len - 1)
@@ -735,6 +738,10 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	}
 	ofs = get_extra_isize(node_blk);
 
+	/* init extent info */
+	get_extent_info(&child.ei, &node_blk->i.i_ext);
+	child.last_blk = 0;
+
 	if ((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
 		if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
 			/* should fix this bug all the time */
@@ -756,6 +763,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			}
 		}
 		DBG(3, "ino[0x%x] has inline data!\n", nid);
+		child.state |= FSCK_INLINE_INODE;
 		goto check;
 	}
 
@@ -775,13 +783,10 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			/* should fix this bug all the time */
 			need_fix = 1;
 		}
+		child.state |= FSCK_INLINE_INODE;
 		goto check;
 	}
 
-	/* init extent info */
-	get_extent_info(&child.ei, &node_blk->i.i_ext);
-	child.last_blk = 0;
-
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i);
 						idx++, child.pgofs++) {
@@ -851,6 +856,7 @@ skip:
 
 	}
 
+check:
 	/* check uncovered range in the back of extent */
 	check_extent_info(&child, 0, 1);
 
@@ -860,7 +866,7 @@ skip:
 		if (c.fix_on)
 			need_fix = 1;
 	}
-check:
+
 	if (i_blocks != *blk_cnt) {
 		ASSERT_MSG("ino: 0x%x has i_blocks: %08"PRIx64", "
 				"but has %u blocks",
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 5530aff..f620912 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -16,6 +16,7 @@
 struct quota_ctx;
 
 #define FSCK_UNMATCHED_EXTENT		0x00000001
+#define FSCK_INLINE_INODE		0x00000002
 
 enum {
 	PREEN_MODE_0,
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
