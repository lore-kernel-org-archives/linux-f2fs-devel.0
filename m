From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: make set_de_type() static
Date: Wed, 30 May 2018 00:20:40 +0800
Message-ID: <20180529162041.16005-2-chao@kernel.org>
References: <20180529162041.16005-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529162041.16005-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c  | 2 +-
 fs/f2fs/f2fs.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index e20539ba0554..5b6996129e29 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -60,7 +60,7 @@ static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFLNK >> S_SHIFT]	= F2FS_FT_SYMLINK,
 };
 
-void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
+static void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
 {
 	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 18de7556dee8..ab6f1877069f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2713,7 +2713,6 @@ struct dentry *f2fs_get_parent(struct dentry *child);
 /*
  * dir.c
  */
-void set_de_type(struct f2fs_dir_entry *de, umode_t mode);
 unsigned char get_de_type(struct f2fs_dir_entry *de);
 struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *fname,
 			f2fs_hash_t namehash, int *max_slots,
-- 
2.16.2.17.g38e79b1fd
