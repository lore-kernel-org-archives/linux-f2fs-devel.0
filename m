From: Chao Yu <chao@kernel.org>
Subject: [PATCH 6/6] f2fs: give up CP_TRIMMED_FLAG if it drops discards
Date: Tue, 19 Sep 2017 23:30:16 +0800
Message-ID: <20170919153016.4116-6-chao@kernel.org>
References: <20170919153016.4116-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919153016.4116-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In ->umount, once we drop remained discard entries, we should not
set CP_TRIMMED_FLAG with another checkpoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 15 +++++++++++----
 fs/f2fs/super.c   |  5 +++--
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6f88171cbc9..7138610beacb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2563,7 +2563,7 @@ void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
 						unsigned int granularity);
 void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
 void stop_discard_thread(struct f2fs_sb_info *sbi);
-void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
+bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void release_discard_addrs(struct f2fs_sb_info *sbi);
 int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 85f909419b69..8c9040960b29 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1168,12 +1168,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	return issued;
 }
 
-static void __drop_discard_cmd(struct f2fs_sb_info *sbi)
+static bool __drop_discard_cmd(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	int i;
+	bool dropped = false;
 
 	mutex_lock(&dcc->cmd_lock);
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
@@ -1181,9 +1182,12 @@ static void __drop_discard_cmd(struct f2fs_sb_info *sbi)
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 			__remove_discard_cmd(sbi, dc);
+			dropped = true;
 		}
 	}
 	mutex_unlock(&dcc->cmd_lock);
+
+	return dropped;
 }
 
 static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
@@ -1278,15 +1282,18 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
 }
 
 /* This comes from f2fs_put_super */
-void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
+bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_policy dpolicy;
+	bool dropped;
 
 	init_discard_policy(&dpolicy, DPOLICY_UMOUNT, dcc->discard_granularity);
 	__issue_discard_cmd(sbi, &dpolicy);
-	__drop_discard_cmd(sbi);
+	dropped = __drop_discard_cmd(sbi);
 	__wait_all_discard_cmd(sbi, &dpolicy);
+
+	return dropped;
 }
 
 static int issue_discard_thread(void *data)
@@ -1631,7 +1638,7 @@ void init_discard_policy(struct discard_policy *dpolicy,
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
 		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
 		dpolicy->io_aware_gran = MAX_PLIST_NUM;
-		dpolicy->io_aware = false;
+		dpolicy->io_aware = true;
 	} else if (discard_type == DPOLICY_FSTRIM) {
 		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
 		dpolicy->io_aware_gran = MAX_PLIST_NUM;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f4a5407e9998..b4152ef723b0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -807,6 +807,7 @@ static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int i;
+	bool dropped;
 
 	f2fs_quota_off_umount(sb);
 
@@ -827,9 +828,9 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 
 	/* be sure to wait for any on-going discard commands */
-	f2fs_wait_discard_bios(sbi);
+	dropped = f2fs_wait_discard_bios(sbi);
 
-	if (f2fs_discard_en(sbi) && !sbi->discard_blks) {
+	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
-- 
2.14.1.145.gb3622a4ee
