From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 1/2] f2fs: do not update REQ_TIME in case of error conditions
Date: Fri,  5 Oct 2018 10:47:39 +0530
Message-ID: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The REQ_TIME should be updated only in case of success cases
as followed at all other places in the file system.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/dir.c  | 2 +-
 fs/f2fs/file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c77a580..e02db5d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -655,9 +655,9 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 	f2fs_put_page(page, 1);
 
 	clear_inode_flag(inode, FI_NEW_INODE);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 fail:
 	up_write(&F2FS_I(inode)->i_sem);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return err;
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b1aaa73..543c742 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -106,6 +106,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		SetPageUptodate(page);
 
 	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
+	f2fs_update_time(sbi, REQ_TIME);
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 out_sem:
@@ -114,7 +115,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_balance_fs(sbi, dn.node_changed);
 
 	sb_end_pagefault(inode->i_sb);
-	f2fs_update_time(sbi, REQ_TIME);
 err:
 	return block_page_mkwrite_return(err);
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
