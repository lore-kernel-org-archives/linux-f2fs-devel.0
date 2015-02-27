From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH] f2fs: fix block_ops trace point
Date: Fri, 27 Feb 2015 15:56:16 +0800
Message-ID: <1425023776-12383-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

block operations is used to flush all dirty node and dentry blocks in 
the page cache and suspend ordinary writing activities, however, there
are some facts such like cp error or mount read-only etc which lead to 
block operations can't be invoked. Current trace point print block_ops 
start premature even if block_ops doesn't have opportunity to execute.
This patch fix it by move block_ops trace point just before block_ops.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/checkpoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3c9d677..c17a0d7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1047,8 +1047,6 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	unsigned long long ckpt_ver;
 
-	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "start block_ops");
-
 	mutex_lock(&sbi->cp_mutex);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
@@ -1058,6 +1056,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		goto out;
 	if (f2fs_readonly(sbi->sb))
 		goto out;
+
+	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "start block_ops");
+
 	if (block_operations(sbi))
 		goto out;
 
-- 
1.9.1
