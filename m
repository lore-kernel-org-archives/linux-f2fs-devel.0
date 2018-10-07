From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: spread f2fs_set_inode_flags()
Date: Sun,  7 Oct 2018 19:06:15 +0800
Message-ID: <20181007110615.6826-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch changes codes as below:
- use f2fs_set_inode_flags() to update i_flags atomically to avoid
potential race.
- synchronize F2FS_I(inode)->i_flags to inode->i_flags in
f2fs_new_inode().
- use f2fs_set_inode_flags() to simply codes in f2fs_quota_{on,off}.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/namei.c | 2 ++
 fs/f2fs/super.c | 5 ++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 188a14bc9fcd..de9a5507f2ae 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3411,7 +3411,7 @@ static inline void f2fs_set_encrypted_inode(struct inode *inode)
 {
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	file_set_encrypt(inode);
-	inode->i_flags |= S_ENCRYPTED;
+	f2fs_set_inode_flags(inode);
 #endif
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a285f3197bd7..4f8d4d8fc0e0 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -122,6 +122,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 
+	f2fs_set_inode_flags(inode);
+
 	trace_f2fs_new_inode(inode, 0);
 	return inode;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 79060c96da5b..5c561afbe376 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1939,8 +1939,7 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
-	inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
-					S_NOATIME | S_IMMUTABLE);
+	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 
@@ -1965,7 +1964,7 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags &= ~(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
-	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
+	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 out_put:
-- 
2.18.0
