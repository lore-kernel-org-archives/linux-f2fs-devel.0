From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: avoid panic when truncating to max filesize
Date: Thu, 5 May 2016 19:13:03 +0800
Message-ID: <20160505111303.30783-2-yuchao0@huawei.com>
References: <20160505111303.30783-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160505111303.30783-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The following panic occurs when truncating inode which has inline
xattr to max filesize.

[<ffffffffa013d3be>] get_dnode_of_data+0x4e/0x580 [f2fs]
[<ffffffffa013aca1>] ? read_node_page+0x51/0x90 [f2fs]
[<ffffffffa013ad99>] ? get_node_page.part.34+0xb9/0x170 [f2fs]
[<ffffffffa01235b1>] truncate_blocks+0x131/0x3f0 [f2fs]
[<ffffffffa01238e3>] f2fs_truncate+0x73/0x100 [f2fs]
[<ffffffffa01239d2>] f2fs_setattr+0x62/0x2a0 [f2fs]
[<ffffffff811a72c8>] notify_change+0x158/0x300
[<ffffffff8118a42b>] do_truncate+0x6b/0xa0
[<ffffffff8118e539>] ? __sb_start_write+0x49/0x100
[<ffffffff8118a798>] do_sys_ftruncate.constprop.12+0x118/0x170
[<ffffffff8118a82e>] SyS_ftruncate+0xe/0x10
[<ffffffff8169efcf>] tracesys+0xe1/0xe6
[<ffffffffa0139ae0>] get_node_path+0x210/0x220 [f2fs]
 <ffff880206a89ce8>
--[ end trace 5fea664dfbcc6625 ]---

The reason is truncate_blocks tries to truncate all node and data blocks
start from specified block offset with value of (max filesize / block
size), but actually, our valid max block offset is (max filesize / block
size) - 1, so f2fs detects such invalid block offset with BUG_ON in
truncation path.

This patch lets f2fs skip truncating data which is exceeding max
filesize.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 87f1a72..00af85f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -601,6 +601,9 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 
 	free_from = (pgoff_t)F2FS_BYTES_TO_BLK(from + blocksize - 1);
 
+	if (free_from >= sbi->max_file_blocks)
+		goto free_partial;
+
 	if (lock)
 		f2fs_lock_op(sbi);
 
@@ -642,7 +645,7 @@ free_next:
 out:
 	if (lock)
 		f2fs_unlock_op(sbi);
-
+free_partial:
 	/* lastly zero out the first data page */
 	if (!err)
 		err = truncate_partial_data_page(inode, from, truncate_page);
-- 
2.8.2.311.gee88674
