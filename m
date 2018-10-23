From: Phillip Potter <phil@philpotter.co.uk>
Subject: [RFC][PATCH v2 08/10] f2fs: use common file type conversion
Date: Tue, 23 Oct 2018 21:20:02 +0100
Message-ID: <20181023202002.GA15738@pathfinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, amir73il@gmail.com, viro@zeniv.linux.org.uk, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Deduplicate the f2fs file type conversion implementation.

Original patch by Amir Goldstein.

v2:
- Rebased against Linux 4.19 by Phillip Potter
- Compile-time checks added by Phillip Potter to make
  sure the F2FS_FT_x enum values stay same as FT_x values

v1:
- Initial implementation

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/f2fs/dir.c           | 43 +++++++++++++++++------------------------
 fs/f2fs/inline.c        |  2 +-
 include/linux/f2fs_fs.h |  8 +++++---
 3 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ecc3a4e2be96..dcb503da0d86 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -39,37 +39,30 @@ static unsigned int bucket_blocks(unsigned int level)
 		return 4;
 }
 
-static unsigned char f2fs_filetype_table[F2FS_FT_MAX] = {
-	[F2FS_FT_UNKNOWN]	= DT_UNKNOWN,
-	[F2FS_FT_REG_FILE]	= DT_REG,
-	[F2FS_FT_DIR]		= DT_DIR,
-	[F2FS_FT_CHRDEV]	= DT_CHR,
-	[F2FS_FT_BLKDEV]	= DT_BLK,
-	[F2FS_FT_FIFO]		= DT_FIFO,
-	[F2FS_FT_SOCK]		= DT_SOCK,
-	[F2FS_FT_SYMLINK]	= DT_LNK,
-};
-
-static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
-	[S_IFREG >> S_SHIFT]	= F2FS_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]	= F2FS_FT_DIR,
-	[S_IFCHR >> S_SHIFT]	= F2FS_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]	= F2FS_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]	= F2FS_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT]	= F2FS_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]	= F2FS_FT_SYMLINK,
-};
-
 static void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
 {
-	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
+	/*
+	 * compile-time asserts that generic FT_x types
+	 * still match F2FS_FT_x types - no need to list
+	 * in other functions as well as build will
+	 * fail either way
+	 */
+	BUILD_BUG_ON(F2FS_FT_UNKNOWN != FT_UNKNOWN);
+	BUILD_BUG_ON(F2FS_FT_REG_FILE != FT_REG_FILE);
+	BUILD_BUG_ON(F2FS_FT_DIR != FT_DIR);
+	BUILD_BUG_ON(F2FS_FT_CHRDEV != FT_CHRDEV);
+	BUILD_BUG_ON(F2FS_FT_BLKDEV != FT_BLKDEV);
+	BUILD_BUG_ON(F2FS_FT_FIFO != FT_FIFO);
+	BUILD_BUG_ON(F2FS_FT_SOCK != FT_SOCK);
+	BUILD_BUG_ON(F2FS_FT_SYMLINK != FT_SYMLINK);
+	BUILD_BUG_ON(F2FS_FT_MAX != FT_MAX);
+
+	de->file_type = fs_umode_to_ftype(mode);
 }
 
 unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de)
 {
-	if (de->file_type < F2FS_FT_MAX)
-		return f2fs_filetype_table[de->file_type];
-	return DT_UNKNOWN;
+	return fs_dtype(de->file_type);
 }
 
 static unsigned long dir_block_index(unsigned int level,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 115dc219344b..d47448904f66 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -460,7 +460,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 		new_name.len = le16_to_cpu(de->name_len);
 
 		ino = le32_to_cpu(de->ino);
-		fake_mode = f2fs_get_de_type(de) << S_SHIFT;
+		fake_mode = f2fs_get_de_type(de) << S_DT_SHIFT;
 
 		err = f2fs_add_regular_entry(dir, &new_name, NULL, NULL,
 							ino, fake_mode);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f70f8ac9c4f4..fb8ad4d87132 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -524,7 +524,11 @@ struct f2fs_dentry_block {
 	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
 } __packed;
 
-/* file types used in inode_info->flags */
+/*
+ * file types used in inode_info->flags
+ *
+ * Values should match common file type values in file_type.h.
+ */
 enum {
 	F2FS_FT_UNKNOWN,
 	F2FS_FT_REG_FILE,
@@ -537,8 +541,6 @@ enum {
 	F2FS_FT_MAX
 };
 
-#define S_SHIFT 12
-
 #define	F2FS_DEF_PROJID		0	/* default project ID */
 
 #endif  /* _LINUX_F2FS_FS_H */
-- 
2.17.2
