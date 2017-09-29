From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: drop FI_UPDATE_WRITE tag after f2fs_issue_flush
Date: Fri, 29 Sep 2017 13:59:36 +0800
Message-ID: <20170929055939.39937-2-yuchao0@huawei.com>
References: <20170929055939.39937-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929055939.39937-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we failed to issue flush in ->fsync, we need to keep FI_UPDATE_WRITE
flag to make sure triggering flush in next ->fsync.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 224379a9848c..18ca8b305699 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -294,10 +294,12 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	remove_ino_entry(sbi, ino, APPEND_INO);
 	clear_inode_flag(inode, FI_APPEND_WRITE);
 flush_out:
-	remove_ino_entry(sbi, ino, UPDATE_INO);
-	clear_inode_flag(inode, FI_UPDATE_WRITE);
 	if (!atomic)
 		ret = f2fs_issue_flush(sbi);
+	if (!ret) {
+		remove_ino_entry(sbi, ino, UPDATE_INO);
+		clear_inode_flag(inode, FI_UPDATE_WRITE);
+	}
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
-- 
2.13.1.388.g69e6b9b4f4a9
