From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: no need to create issue_discard_thread if it exists
Date: Thu, 6 Jul 2017 19:05:34 +0800
Message-ID: <1499339134-104480-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, sylinux@163.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4c246e3..b48d004 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1417,6 +1417,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 
 	if (SM_I(sbi)->dcc_info) {
 		dcc = SM_I(sbi)->dcc_info;
+		if (dcc->f2fs_issue_discard)
+			return err;
 		goto init_thread;
 	}
 
-- 
1.8.5.2
