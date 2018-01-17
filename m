From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: stop gc/discard thread after fs shutdown
Date: Wed, 17 Jan 2018 22:28:53 +0800
Message-ID: <20180117142853.26584-2-chao@kernel.org>
References: <20180117142853.26584-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117142853.26584-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Once filesystem shuts down, daemons like gc/discard thread should be
aware of it, and do exit, in addtion, drop all pending discards in
cache and exit real-time discard mode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/file.c    | 4 ++++
 fs/f2fs/gc.c      | 2 ++
 fs/f2fs/segment.c | 7 +++++++
 4 files changed, 14 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fb4ec1f61925..580d6ce7c594 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2724,6 +2724,7 @@ void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
 						unsigned int granularity);
+void drop_discard_cmd(struct f2fs_sb_info *sbi);
 void stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 593a79447907..0a163c13e587 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1866,6 +1866,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		ret = -EINVAL;
 		goto out;
 	}
+
+	drop_discard_cmd(sbi);
+	clear_opt(sbi, DISCARD);
+
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 	mnt_drop_write_file(filp);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index aa720cc44509..b69743e4bd11 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -47,6 +47,8 @@ static int gc_thread_func(void *data)
 			continue;
 		if (kthread_should_stop())
 			break;
+		if (unlikely(f2fs_cp_error(sbi)))
+			break;
 
 		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
 			increase_sleep_time(gc_th, &wait_ms);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2e8e054db49d..23d9b8ba2673 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1263,6 +1263,11 @@ static bool __drop_discard_cmd(struct f2fs_sb_info *sbi)
 	return dropped;
 }
 
+void drop_discard_cmd(struct f2fs_sb_info *sbi)
+{
+	__drop_discard_cmd(sbi);
+}
+
 static unsigned int __wait_one_discard_bio(struct f2fs_sb_info *sbi,
 							struct discard_cmd *dc)
 {
@@ -1403,6 +1408,8 @@ static int issue_discard_thread(void *data)
 			continue;
 		if (kthread_should_stop())
 			return 0;
+		if (unlikely(f2fs_cp_error(sbi)))
+			break;
 
 		if (dcc->discard_wake) {
 			dcc->discard_wake = 0;
-- 
2.14.1.145.gb3622a4ee
