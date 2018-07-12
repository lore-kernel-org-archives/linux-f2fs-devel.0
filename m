From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 4/5] f2fs: disable small discard in lfs mode
Date: Thu, 12 Jul 2018 23:09:29 +0800
Message-ID: <1531408170-45758-5-git-send-email-yunlong.song@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In lfs mode, it is better to send the discard of the overall section
each time to avoid missing alignment with flash.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 3 ++-
 fs/f2fs/sysfs.c   | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fd38b61..f6c20e0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1766,7 +1766,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	atomic_set(&dcc->issing_discard, 0);
 	atomic_set(&dcc->discard_cmd_cnt, 0);
 	dcc->nr_discards = 0;
-	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
+	dcc->max_discards = test_opt(sbi, LFS) ? 0 :
+				MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
 	dcc->undiscard_blks = 0;
 	dcc->root = RB_ROOT;
 	dcc->rbtree_check = false;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 2e7e611..4b6c457 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -271,6 +271,10 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "max_small_discards") &&
+		test_opt(sbi, LFS))
+		return -EINVAL;
+
 	*ui = t;
 
 	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
-- 
1.8.5.2
