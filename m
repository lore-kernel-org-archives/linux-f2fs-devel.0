From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: avoid redundant f2fs_flush after remount
Date: Sat, 24 Jun 2017 15:57:19 +0800
Message-ID: <1498291039-142563-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, sylinux@163.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

create_flush_cmd_control will create redundant issue_flush_thread after each
remount with flush_merge option.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a6d7738..57f9edc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -555,6 +555,8 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 
 	if (SM_I(sbi)->fcc_info) {
 		fcc = SM_I(sbi)->fcc_info;
+		if (fcc->f2fs_issue_flush)
+			return err;
 		goto init_thread;
 	}
 
-- 
1.8.5.2
