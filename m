From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix memory leak of write_io in fill_super()
Date: Wed, 5 Sep 2018 14:54:01 +0800
Message-ID: <20180905065402.52945-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It needs to release memory allocated for sbi->write_io in error path,
otherwise, it will cause memory leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1cd9138aa1e0..627b9a959714 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3095,7 +3095,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 					GFP_KERNEL);
 		if (!sbi->write_io[i]) {
 			err = -ENOMEM;
-			goto free_options;
+			goto free_bio_info;
 		}
 
 		for (j = HOT; j < n; j++) {
-- 
2.18.0.rc1
