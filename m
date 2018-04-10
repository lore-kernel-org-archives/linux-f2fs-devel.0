From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: turn down IO priority of discard from background
Date: Tue, 10 Apr 2018 15:26:08 +0800
Message-ID: <20180410072608.12323-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In order to interfere normal r/w IO, let's turn down IO priority of
discard issued from background.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index aabe0d6b8307..5e708debeb9c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1723,6 +1723,7 @@ void init_discard_policy(struct discard_policy *dpolicy,
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
 		dpolicy->io_aware = true;
+		dpolicy->sync = false;
 	} else if (discard_type == DPOLICY_FORCE) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
-- 
2.15.0.55.gc2ece9dc4de6
