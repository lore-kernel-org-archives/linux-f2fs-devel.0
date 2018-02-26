From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: add auto tuning for small devices
Date: Mon, 26 Feb 2018 09:47:28 -0800
Message-ID: <20180226174731.26679-2-jaegeuk@kernel.org>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226174731.26679-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If f2fs is running on top of very small devices, it's worth to avoid abusing
free LBAs. In order to achieve that, this patch introduces some parameter
tuning.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h |  2 ++
 fs/f2fs/super.c   | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index f11c4bc82c78..dbb774aaf387 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -596,6 +596,8 @@ static inline int utilization(struct f2fs_sb_info *sbi)
 #define DEF_MIN_FSYNC_BLOCKS	8
 #define DEF_MIN_HOT_BLOCKS	16
 
+#define SMALL_VOLUME_SEGMENTS	(16 * 512)	/* 16GB */
+
 enum {
 	F2FS_IPU_FORCE,
 	F2FS_IPU_SSR,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b7c0bdd1e532..9515c10eebad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2512,6 +2512,18 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_sm_info *sm_i = SM_I(sbi);
+
+	/* adjust parameters according to the volume size */
+	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
+		sbi->alloc_mode = ALLOC_MODE_REUSE;
+		sm_i->dcc_info->discard_granularity = 1;
+		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE;
+	}
+}
+
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct f2fs_sb_info *sbi;
@@ -2864,6 +2876,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	f2fs_join_shrinker(sbi);
 
+	f2fs_tuning_parameters(sbi);
+
 	f2fs_msg(sbi->sb, KERN_NOTICE, "Mounted with checkpoint version = %llx",
 				cur_cp_version(F2FS_CKPT(sbi)));
 	f2fs_update_time(sbi, CP_TIME);
-- 
2.15.0.531.g2ccb3012c9-goog
