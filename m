From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/6] f2fs: make f2fs_filetype_table static
Date: Sun, 18 Sep 2016 23:30:03 +0800
Message-ID: <1474212608-6930-1-git-send-email-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

There is no more user of f2fs_filetype_table outside of dir.c, make it
static.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c  | 2 +-
 fs/f2fs/f2fs.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 2fb20fc..39a850b 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -37,7 +37,7 @@ static unsigned int bucket_blocks(unsigned int level)
 		return 4;
 }
 
-unsigned char f2fs_filetype_table[F2FS_FT_MAX] = {
+static unsigned char f2fs_filetype_table[F2FS_FT_MAX] = {
 	[F2FS_FT_UNKNOWN]	= DT_UNKNOWN,
 	[F2FS_FT_REG_FILE]	= DT_REG,
 	[F2FS_FT_DIR]		= DT_DIR,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index af06303..9b4bbf2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1946,7 +1946,6 @@ struct dentry *f2fs_get_parent(struct dentry *child);
 /*
  * dir.c
  */
-extern unsigned char f2fs_filetype_table[F2FS_FT_MAX];
 void set_de_type(struct f2fs_dir_entry *, umode_t);
 unsigned char get_de_type(struct f2fs_dir_entry *);
 struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *,
-- 
2.7.2
