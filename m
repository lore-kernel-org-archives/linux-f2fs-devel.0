From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 13/13] f2fs: don't recovery orphan inode on readonly device
Date: Mon, 15 Apr 2019 15:30:54 +0800
Message-ID: <20190415073054.2577-5-yuchao0@huawei.com>
References: <20190415073054.2577-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415073054.2577-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As JuHyung Park reported in mailing list:

https://sourceforge.net/p/linux-f2fs/mailman/message/36639787/

generic_make_request: Trying to write to read-only block-device loop0 (partno 0)
WARNING: CPU: 0 PID: 23437 at block/blk-core.c:2174 generic_make_request_checks+0x594/0x630

 generic_make_request+0x46/0x3d0
 submit_bio+0x30/0x110
 __submit_merged_bio+0x68/0x390
 f2fs_submit_page_write+0x1bb/0x7f0
 f2fs_do_write_meta_page+0x7f/0x160
 __f2fs_write_meta_page+0x70/0x140
 f2fs_sync_meta_pages+0x140/0x250
 f2fs_write_checkpoint+0x5c5/0x17b0
 f2fs_sync_fs+0x9c/0x110
 sync_filesystem+0x66/0x80
 f2fs_recover_fsync_data+0x790/0xa30
 f2fs_fill_super+0xe4e/0x1980
 mount_bdev+0x518/0x610
 mount_fs+0x34/0x13f
 vfs_kern_mount.part.11+0x4f/0x120
 do_mount+0x2d1/0xe40
 __x64_sys_mount+0xbf/0xe0
 do_syscall_64+0x4a/0xf0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

print_req_error: I/O error, dev loop0, sector 4096

If block device is readonly, we should never trigger write IO from
filesystem layer, but previously, orphan recovery didn't consider
such condition, result in triggering above warning, fix it.

Reported-by: JuHyung Park <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a7ad1b1e5750..90e1bab86269 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -674,6 +674,12 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
+	if (bdev_read_only(sbi->sb->s_bdev)) {
+		f2fs_msg(sbi->sb, KERN_INFO, "write access "
+			"unavailable, skipping orphan cleanup");
+		return 0;
+	}
+
 	if (s_flags & SB_RDONLY) {
 		f2fs_msg(sbi->sb, KERN_INFO, "orphan cleanup on readonly fs");
 		sbi->sb->s_flags &= ~SB_RDONLY;
-- 
2.18.0.rc1
