From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] resize.f2fs: add more information in debug
	messages
Date: Wed,  2 Nov 2016 17:01:45 -0700
Message-ID: <20161103000146.64292-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c25Th-0001V6-9z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 00:01:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c25Tg-0003gA-BS
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 00:01:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Print more information.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/resize.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 565555c..b8d3f39 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -171,7 +171,9 @@ static void migrate_main(struct f2fs_sb_info *sbi,
 		}
 	}
 	free(raw);
-	DBG(0, "Info: Done to migrate data and node blocks\n");
+	DBG(0, "Info: Done to migrate Main area: main_blkaddr = 0x%x -> 0x%x\n",
+				START_BLOCK(sbi, 0),
+				START_BLOCK(sbi, 0) + offset);
 }
 
 static void move_ssa(struct f2fs_sb_info *sbi, unsigned int segno,
@@ -214,7 +216,8 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
 			move_ssa(sbi, segno, new_sum_blkaddr + segno - offset);
 	}
 
-	DBG(0, "Info: Done to migrate SSA blocks\n");
+	DBG(0, "Info: Done to migrate SSA blocks: sum_blkaddr = 0x%x -> 0x%x\n",
+				old_sum_blkaddr, new_sum_blkaddr);
 }
 
 static int shrink_nats(struct f2fs_sb_info *sbi,
@@ -323,9 +326,10 @@ static void migrate_nat(struct f2fs_sb_info *sbi,
 				(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
 		ret = dev_write_block(nat_block, block_addr);
 		ASSERT(ret >= 0);
-		DBG(1, "Write NAT: %lx\n", block_addr);
+		DBG(3, "Write NAT: %lx\n", block_addr);
 	}
-	DBG(0, "Info: Done to migrate NAT blocks\n");
+	DBG(0, "Info: Done to migrate NAT blocks: nat_blkaddr = 0x%x -> 0x%x\n",
+			old_nat_blkaddr, new_nat_blkaddr);
 }
 
 static void migrate_sit(struct f2fs_sb_info *sbi,
@@ -347,7 +351,7 @@ static void migrate_sit(struct f2fs_sb_info *sbi,
 	for (index = 0; index < sit_blks; index++) {
 		ret = dev_write_block(sit_blk, get_newsb(sit_blkaddr) + index);
 		ASSERT(ret >= 0);
-		DBG(1, "Write zero sit: %x\n", get_newsb(sit_blkaddr) + index);
+		DBG(3, "Write zero sit: %x\n", get_newsb(sit_blkaddr) + index);
 	}
 
 	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
@@ -382,7 +386,8 @@ static void migrate_sit(struct f2fs_sb_info *sbi,
 	ASSERT(ret >= 0);
 
 	free(sit_blk);
-	DBG(0, "Info: Done to migrate SIT blocks\n");
+	DBG(0, "Info: Done to restore new SIT blocks: 0x%x\n",
+					get_newsb(sit_blkaddr));
 }
 
 static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
@@ -545,10 +550,8 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
 		}
 	}
 
-	c.dbg_lv = 1;
 	print_raw_sb_info(sb);
 	print_raw_sb_info(new_sb);
-	c.dbg_lv = 0;
 
 	old_main_blkaddr = get_sb(main_blkaddr);
 	new_main_blkaddr = get_newsb(main_blkaddr);
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
