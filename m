From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: clear FI_HOT_DATA correctly
Date: Fri, 18 Aug 2017 23:37:36 +0800
Message-ID: <20170818153736.8020-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch fixes to clear FI_HOT_DATA correctly in below path:
- error handling in f2fs_ioc_start_atomic_write
- after commit atomic write in f2fs_ioc_commit_atomic_write
- after drop atomic write in drop_inmem_pages

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c    | 2 ++
 fs/f2fs/segment.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3eebd49c3348..8f0d32a57b52 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1640,6 +1640,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret) {
 		clear_inode_flag(inode, FI_ATOMIC_FILE);
+		clear_inode_flag(inode, FI_HOT_DATA);
 		goto out;
 	}
 
@@ -1678,6 +1679,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 		if (!ret) {
 			clear_inode_flag(inode, FI_ATOMIC_FILE);
+			clear_inode_flag(inode, FI_HOT_DATA);
 			stat_dec_atomic_write(inode);
 		}
 	} else {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8c90b69dcd6d..dd97d2f282a6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -254,6 +254,7 @@ void drop_inmem_pages(struct inode *inode)
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
+	clear_inode_flag(inode, FI_HOT_DATA);
 	stat_dec_atomic_write(inode);
 }
 
-- 
2.14.1.145.gb3622a4ee
