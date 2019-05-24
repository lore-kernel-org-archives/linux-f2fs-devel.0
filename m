From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: write checkpoint with OPU mode
Date: Fri, 24 May 2019 15:56:27 +0800
Message-ID: <20190524075627.107151-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hU54R-0006I3-Cr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 07:56:55 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hU54P-005hFR-IU
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 07:56:55 +0000
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

This original patch was from Weichao Guo.

We may encounter both checkpoints invalid in such a case:
1. kernel writes CP A;
2. power-cut when kernel writes CP B, then CP B is corrupted;
3. fsck: load CP A, fix meta/data;
4. power-cut when fsck writes CP A in-place, then CP A is corrupted too;

To avoid both checkpoints being invalid, this patch changes to enables
fsck to write checkpoint with out-place-update method first, and then
write checkpoint in original place.

This can make sure during fsck repairing, even there is sudden power-cut,
filesystem will still have at least one valid checkpoint.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- clean up codes
- cover flush_journal_entries() case
- update commet message
 fsck/fsck.c  | 17 +++++++++++++++--
 fsck/fsck.h  |  1 +
 fsck/mount.c | 15 ++++++++++++++-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6f0f262..6aed51d 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2121,6 +2121,19 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
 }
 
+static void fix_checkpoints(struct f2fs_sb_info *sbi)
+{
+	int i, ret;
+
+	for (i = 0; i < 2; i++) {
+		/* write checkpoint out of place first */
+		sbi->cur_cp = sbi->cur_cp % 2 + 1;
+		fix_checkpoint(sbi);
+		ret = f2fs_fsync_device();
+		ASSERT(ret >= 0);
+	}
+}
+
 int check_curseg_offset(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2771,10 +2784,10 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 			rewrite_sit_area_bitmap(sbi);
 			fix_curseg_info(sbi);
 			fix_checksum(sbi);
-			fix_checkpoint(sbi);
+			fix_checkpoints(sbi);
 		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG) ||
 			is_set_ckpt_flags(cp, CP_QUOTA_NEED_FSCK_FLAG)) {
-			write_checkpoint(sbi);
+			write_checkpoints(sbi);
 		}
 	}
 	return ret;
diff --git a/fsck/fsck.h b/fsck/fsck.h
index d38e8de..8fe5db1 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -192,6 +192,7 @@ extern void move_curseg_info(struct f2fs_sb_info *, u64, int);
 extern void write_curseg_info(struct f2fs_sb_info *);
 extern int find_next_free_block(struct f2fs_sb_info *, u64 *, int, int);
 extern void write_checkpoint(struct f2fs_sb_info *);
+extern void write_checkpoints(struct f2fs_sb_info *);
 extern void update_superblock(struct f2fs_super_block *, int);
 extern void update_data_blkaddr(struct f2fs_sb_info *, nid_t, u16, block_t);
 extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, nid_t, block_t);
diff --git a/fsck/mount.c b/fsck/mount.c
index 1c5cd93..bbb1af7 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2127,7 +2127,7 @@ void flush_journal_entries(struct f2fs_sb_info *sbi)
 	int n_sits = flush_sit_journal_entries(sbi);
 
 	if (n_nats || n_sits)
-		write_checkpoint(sbi);
+		write_checkpoints(sbi);
 }
 
 void flush_sit_entries(struct f2fs_sb_info *sbi)
@@ -2452,6 +2452,19 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	ASSERT(ret >= 0);
 }
 
+void write_checkpoints(struct f2fs_sb_info *sbi)
+{
+	int i, ret;
+
+	for (i = 0; i < 2; i++) {
+		/* write checkpoint out of place first */
+		sbi->cur_cp = sbi->cur_cp % 2 + 1;
+		write_checkpoint(sbi);
+		ret = f2fs_fsync_device();
+		ASSERT(ret >= 0);
+	}
+}
+
 void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-- 
2.18.0.rc1
