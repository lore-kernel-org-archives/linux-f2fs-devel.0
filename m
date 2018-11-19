From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 1/2] f2fs: remove stale inode entry before
 eviction from gdirty_list
Date: Mon, 19 Nov 2018 11:32:56 +0530
Message-ID: <1542607377-25446-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <riteshh@codeaurora.org>) id 1gOceW-00046z-Cw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 06:03:20 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gOceS-005ycP-Dn
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 06:03:20 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com

This is seen when CP_ERROR_FLAG is not set & FS may be corrupted.
There is a case observed where dirty stale inode pointer data is still
present in the gdirty_list causing panic on access while doing
checkpoint operation.

WARNING: CPU: 3 PID: 1827 at
kernel/msm-4.14/fs/f2fs/inode.c:567
f2fs_evict_inode+0x364/0x37c
<...>
[42246.776289] BUG: spinlock bad magic on CPU#4, 1245
[42246.782674] Unable to handle kernel paging request at virtual address 6b6b6b6b6b713b
<...>
[42246.896370] task: ffffffc0f0434080 task.stack: ffffff8023ea0000
[42246.902465] pc : spin_bug+0x80/0xb8
[42246.906055] lr : spin_bug+0x64/0xb8
<...>
[42247.122346] Call trace:
[42247.124876]  spin_bug+0x80/0xb8
[42247.128110]  do_raw_spin_lock+0xe8/0x118
[42247.132144]  _raw_spin_lock+0x24/0x30
[42247.135916]  igrab+0x20/0x6c
[42247.138894]  f2fs_sync_inode_meta+0x58/0xc0
[42247.143199]  write_checkpoint+0x1c4/0xecc
[42247.147322]  f2fs_sync_fs+0x118/0x170
[42247.151096]  f2fs_do_sync_file+0x4f0/0x798
[42247.155311]  f2fs_sync_file+0x54/0x6c
[42247.159087]  vfs_fsync_range+0x90/0xac
[42247.162950]  vfs_fsync+0x2c/0x38
[42247.166278]  do_fsync+0x3c/0x78
[42247.169515]  SyS_fdatasync+0x20/0x30

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 fs/f2fs/inode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 91ceee0..c57f636 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -702,11 +702,13 @@ void f2fs_evict_inode(struct inode *inode)
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
 
-	if (likely(!is_set_ckpt_flags(sbi, CP_ERROR_FLAG) &&
-				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
-	else
+	if (unlikely(is_inode_flag_set(inode, FI_DIRTY_INODE))) {
 		f2fs_inode_synced(inode);
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			 "inconsistent dirty inode:%u entry found during eviction\n",
+			 inode->i_ino);
+		f2fs_bug_on(sbi, 1);
+	}
 
 	/* ino == 0, if f2fs_new_inode() was failed t*/
 	if (inode->i_ino)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
