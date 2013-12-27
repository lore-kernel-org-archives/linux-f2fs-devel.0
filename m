From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: [PATCH] f2fs: fix build warning for f2fs_has_inline_data()
Date: Fri, 27 Dec 2013 14:45:08 +0800
Message-ID: <1388126708-27839-1-git-send-email-haicheng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, Haicheng Li <haicheng.lee@gmail.com>, Fengguang Wu <fengguang.wu@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Huajun Li <huajun.li@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch is to fix the issue reported by Fengguang Wu:
> Note: the f2fs/linux-3.4 HEAD 22a48d188024830d61365ce97a0a8a0bedd494a9 builds fine.
>       It only hurts bisectibility.
>
> All error/warnings:
>
>    In file included from fs/f2fs/data.c:22:0:
>    fs/f2fs/data.c: In function 'f2fs_direct_IO':
> >> fs/f2fs/f2fs.h:1302:12: error: inlining failed in call to
> >> always_inline 'f2fs_has_inline_data': function body not available
>     inline int f2fs_has_inline_data(struct inode *);
..snip..

Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Cc: Huajun Li <huajun.li@intel.com>
---
 fs/f2fs/f2fs.h   |    5 ++++-
 fs/f2fs/inline.c |    5 -----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6991a28..e143ca1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1314,7 +1314,10 @@ extern const struct inode_operations f2fs_special_inode_operations;
 /*
  * inline.c
  */
-inline int f2fs_has_inline_data(struct inode *);
+static inline int f2fs_has_inline_data(struct inode *inode)
+{
+	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_DATA);
+}
 bool f2fs_may_inline(struct inode *);
 int f2fs_read_inline_data(struct inode *, struct page *);
 int f2fs_convert_inline_data(struct inode *, pgoff_t);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0e940ce..bcc6f65 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -13,11 +13,6 @@
 
 #include "f2fs.h"
 
-inline int f2fs_has_inline_data(struct inode *inode)
-{
-	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_DATA);
-}
-
 bool f2fs_may_inline(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-- 
1.7.9.5
