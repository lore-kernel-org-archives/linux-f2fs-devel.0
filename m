From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: stop gc/discard thread after fs shutdown
Date: Thu, 18 Jan 2018 17:23:29 +0800
Message-ID: <20180118092329.96305-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Once filesystem shuts down, daemons like gc/discard thread should be
aware of it, and do exit, in addtion, drop all cached pending discard
commands and turn off real-time discard mode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to stop daemons with the right way.
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/file.c    | 7 +++++++
 fs/f2fs/segment.c | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5396583b7c85..057e987fa916 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2732,6 +2732,7 @@ void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
 						unsigned int granularity);
+void drop_discard_cmd(struct f2fs_sb_info *sbi);
 void stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f1b5cc6a86bd..d7721debebb9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1881,6 +1881,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		ret = -EINVAL;
 		goto out;
 	}
+
+	stop_gc_thread(sbi);
+	stop_discard_thread(sbi);
+
+	drop_discard_cmd(sbi);
+	clear_opt(sbi, DISCARD);
+
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 	mnt_drop_write_file(filp);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a0f36b2761e9..9f7a932c60f5 100644
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
-- 
2.15.0.55.gc2ece9dc4de6
