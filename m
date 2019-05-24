From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: update checkpoint data atomically
Date: Fri, 24 May 2019 16:26:40 +0800
Message-ID: <20190524082640.109172-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hU5Xi-0002xt-BF
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 08:27:10 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hU5Xg-0069v7-B4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 08:27:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

This patch keeps line with f2fs kernel module for checkpoint update:
1. writeback all blocks inside checkpoint except last cp_park block;
2. fsync;
3. write last cp_park block;
4. fsync;

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c  | 16 ++++++++++------
 fsck/mount.c |  7 ++++---
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6aed51d..3c0332c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2113,24 +2113,28 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		ASSERT(ret >= 0);
 	}
 
-	ret = dev_write_block(cp, cp_blk_no++);
-	ASSERT(ret >= 0);
-
 	/* Write nat bits */
 	if (flags & CP_NAT_BITS_FLAG)
 		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
+
+	ret = f2fs_fsync_device();
+	ASSERT(ret >= 0);
+
+	ret = dev_write_block(cp, cp_blk_no++);
+	ASSERT(ret >= 0);
+
+	ret = f2fs_fsync_device();
+	ASSERT(ret >= 0);
 }
 
 static void fix_checkpoints(struct f2fs_sb_info *sbi)
 {
-	int i, ret;
+	int i;
 
 	for (i = 0; i < 2; i++) {
 		/* write checkpoint out of place first */
 		sbi->cur_cp = sbi->cur_cp % 2 + 1;
 		fix_checkpoint(sbi);
-		ret = f2fs_fsync_device();
-		ASSERT(ret >= 0);
 	}
 }
 
diff --git a/fsck/mount.c b/fsck/mount.c
index bbb1af7..a627f1d 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2450,18 +2450,19 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	/* write the last cp */
 	ret = dev_write_block(cp, cp_blk_no++);
 	ASSERT(ret >= 0);
+
+	ret = f2fs_fsync_device();
+	ASSERT(ret >= 0);
 }
 
 void write_checkpoints(struct f2fs_sb_info *sbi)
 {
-	int i, ret;
+	int i;
 
 	for (i = 0; i < 2; i++) {
 		/* write checkpoint out of place first */
 		sbi->cur_cp = sbi->cur_cp % 2 + 1;
 		write_checkpoint(sbi);
-		ret = f2fs_fsync_device();
-		ASSERT(ret >= 0);
 	}
 }
 
-- 
2.18.0.rc1
