From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v3 RESEND] f2fs: add bug_on when f2fs_gc even fails to get one victim
Date: Fri, 17 Nov 2017 09:09:08 +0800
Message-ID: <1510880948-154538-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This can help to find potential bugs on some corner case.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5d5bba4..c89128b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1035,6 +1035,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		goto stop;
 	}
 	if (!__get_victim(sbi, &segno, gc_type)) {
+		f2fs_bug_on(sbi, !total_freed && has_not_enough_free_secs(sbi, 0, 0));
 		ret = -ENODATA;
 		goto stop;
 	}
-- 
1.8.5.2
