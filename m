From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix incorrect free inode count in ->statfs
Date: Fri, 18 Nov 2016 22:27:41 +0800
Message-ID: <20161118142741.5165-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

While calculating inode count that we can create at most in the left space,
we should consider space which data/node blocks occupied, since we create
data/node mixly in main area. So fix the wrong calculation in ->statfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4ccbb86..2852a0b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -852,7 +852,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi);
 
 	buf->f_files = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
-	buf->f_ffree = buf->f_files - valid_inode_count(sbi);
+	buf->f_ffree = min(buf->f_files - valid_node_count(sbi),
+							buf->f_bavail);
 
 	buf->f_namelen = F2FS_NAME_LEN;
 	buf->f_fsid.val[0] = (u32)id;
-- 
2.10.1
