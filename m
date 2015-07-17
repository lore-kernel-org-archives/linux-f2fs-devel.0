From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: fix to wait all atomic written pages writeback
Date: Fri, 17 Jul 2015 18:05:21 +0800
Message-ID: <01a401d0c078$32519400$96f4bc00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes the incorrect range (0, LONG_MAX) which is used
in ranged fsync. If we use LONG_MAX as the parameter for indicating
the end of file we want to synchronize, in 32-bits architecture
machine, these datas after 4GB offset may not be persisted in
storage after ->fsync returned.

Here, we alter LONG_MAX to LLONG_MAX to fix this issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9989616..1bb1d6e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1355,7 +1355,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	if (f2fs_is_atomic_file(inode))
 		commit_inmem_pages(inode, false);
 
-	ret = f2fs_sync_file(filp, 0, LONG_MAX, 0);
+	ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
 	mnt_drop_write_file(filp);
 	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 	return ret;
-- 
2.4.2
