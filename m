From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: treat volatile file's data as hot one
Date: Thu, 26 Apr 2018 17:05:50 +0800
Message-ID: <20180426090551.92364-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Volatile file's data will be updated oftenly, so it'd better to place
its data into hot data segment.

In addition, for atomic file, we change to check FI_ATOMIC_FILE instead
of FI_HOT_DATA to make code readability better.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c    | 2 --
 fs/f2fs/segment.c | 5 +++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e88d94846d50..05b2045888a3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1700,7 +1700,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (ret)
 		goto out;
 skip_flush:
-	set_inode_flag(inode, FI_HOT_DATA);
 	set_inode_flag(inode, FI_ATOMIC_FILE);
 	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
@@ -1744,7 +1743,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 		if (!ret) {
 			clear_inode_flag(inode, FI_ATOMIC_FILE);
-			clear_inode_flag(inode, FI_HOT_DATA);
 			stat_dec_atomic_write(inode);
 		}
 	} else {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1fc23572067d..e339a5ff381f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -314,7 +314,6 @@ void drop_inmem_pages(struct inode *inode)
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
-	clear_inode_flag(inode, FI_HOT_DATA);
 	stat_dec_atomic_write(inode);
 }
 
@@ -1637,7 +1636,9 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		if (is_cold_data(fio->page) || file_is_cold(inode))
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
-				is_inode_flag_set(inode, FI_HOT_DATA))
+				is_inode_flag_set(inode, FI_HOT_DATA) ||
+				is_inode_flag_set(inode, FI_ATOMIC_FILE) ||
+				is_inode_flag_set(inode, FI_VOLATILE_FILE))
 			return CURSEG_HOT_DATA;
 		return rw_hint_to_seg_type(inode->i_write_hint);
 	} else {
-- 
2.15.0.55.gc2ece9dc4de6
