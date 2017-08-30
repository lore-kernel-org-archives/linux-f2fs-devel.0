From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: update i_flags correctly
Date: Wed, 30 Aug 2017 18:04:47 +0800
Message-ID: <20170830100448.2569-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs enables hash-indexed directory by default, so we need to tag
FS_INDEX_FL in inode::i_flags during directory creataion, in order
to show correct status of inode in lsattr:

Before:
------------------- /mnt/f2fs/dir/
After:
-----------I------- /mnt/f2fs/dir/

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e241c1b2c636..a4dab98c4b7b 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -100,6 +100,9 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	F2FS_I(inode)->i_flags =
 		f2fs_mask_flags(mode, F2FS_I(dir)->i_flags & F2FS_FL_INHERITED);
 
+	if (S_ISDIR(inode->i_mode))
+		F2FS_I(inode)->i_flags |= FS_INDEX_FL;
+
 	if (F2FS_I(inode)->i_flags & FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 
-- 
2.13.1.388.g69e6b9b4f4a9
