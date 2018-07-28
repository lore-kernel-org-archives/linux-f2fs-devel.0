From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to reset i_gc_failures correctly
Date: Sat, 28 Jul 2018 18:37:58 +0800
Message-ID: <20180728103758.8499-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Let's reset i_gc_failures to zero when we unset pinned state for file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ed5c9b0e0d0c..22c83da0d5e2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2818,7 +2818,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 
 	if (!pin) {
 		clear_inode_flag(inode, FI_PIN_FILE);
-		F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] = 1;
+		f2fs_i_gc_failures_write(inode, 0);
 		goto done;
 	}
 
-- 
2.18.0.rc1
