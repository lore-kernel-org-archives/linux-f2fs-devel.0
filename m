From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 7/7] f2fs: support data flush in checkpoint
Date: Wed, 16 Dec 2015 13:14:15 +0800
Message-ID: <014301d137c0$b3b2c0e0$1b1842a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, when finishing a checkpoint, we have persisted all fs meta
info including meta inode, node inode, dentry page of directory inode, so,
after a sudden power cut, f2fs can recover from last checkpoint with full
directory structure.

But during checkpoint, we didn't flush dirty pages of regular and symlink
inode, so such dirty datas still in memory will be lost in that moment of
power off.

In order to reduce the chance of lost data, this patch enables
f2fs_balance_fs_bg with the ability of data flushing. It will try to flush
user data before starting a checkpoint. So user's data written after last
checkpoint which may not be fsynced could be saved.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - trigger data flush in f2fs_balance_fs_bg.
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5fa519f..c247450 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -291,8 +291,11 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			!available_free_memory(sbi, INO_ENTRIES) ||
-			jiffies > sbi->cp_expires)
+			jiffies > sbi->cp_expires) {
+		if (test_opt(sbi, DATA_FLUSH))
+			sync_dirty_inodes(sbi, FILE_INODE);
 		f2fs_sync_fs(sbi->sb, true);
+	}
 }
 
 static int issue_flush_thread(void *data)
-- 
2.6.3
