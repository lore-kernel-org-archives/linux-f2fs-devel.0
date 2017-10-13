From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: add bug_on when f2fs_gc even fails to get one victim
Date: Fri, 13 Oct 2017 21:31:40 +0800
Message-ID: <1507901500-162168-1-git-send-email-yunlong.song@huawei.com>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This can help us to debug on some corner case.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 197ebf4..2b03202 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		.ilist = LIST_HEAD_INIT(gc_list.ilist),
 		.iroot = RADIX_TREE_INIT(GFP_NOFS),
 	};
+	bool need_fggc = false;
 
 	trace_f2fs_gc_begin(sbi->sb, sync, background,
 				get_pages(sbi, F2FS_DIRTY_NODES),
@@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			if (ret)
 				goto stop;
 		}
-		if (has_not_enough_free_secs(sbi, 0, 0))
+		if (has_not_enough_free_secs(sbi, 0, 0)) {
 			gc_type = FG_GC;
+			need_fggc = true;
+		}
 	}
 
 	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
@@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		goto stop;
 	}
 	if (!__get_victim(sbi, &segno, gc_type)) {
+		f2fs_bug_on(sbi, !total_freed && need_fggc);
 		ret = -ENODATA;
 		goto stop;
 	}
-- 
1.8.5.2
