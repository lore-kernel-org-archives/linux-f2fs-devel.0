From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/5] f2fs: detect bug_on in f2fs_wait_discard_bios
Date: Sun,  8 Jul 2018 22:16:53 +0800
Message-ID: <20180708141657.24641-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Add bug_on to detect potential non-empty discard wait list.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cbf8f3f9a8e7..e55188975fcc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1495,6 +1495,8 @@ bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 
 	/* just to make sure there is no pending discard commands */
 	__wait_all_discard_cmd(sbi, NULL);
+
+	f2fs_bug_on(sbi, atomic_read(&dcc->discard_cmd_cnt));
 	return dropped;
 }
 
-- 
2.16.2.17.g38e79b1fd
