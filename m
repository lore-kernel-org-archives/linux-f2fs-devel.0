From: Phillip Potter <phil@philpotter.co.uk>
Subject: [RFC][PATCH v5 06/09] f2fs: use common file type
 conversion
Date: Mon, 21 Jan 2019 00:54:34 +0000
Message-ID: <20190121005434.GA32358@pathfinder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <phil@philpotter.co.uk>) id 1glOHb-0002Xx-MA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Jan 2019 01:21:47 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1glOHZ-004fmo-5V
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Jan 2019 01:21:47 +0000
Received: by mail-wr1-f67.google.com with SMTP id j2so21500676wrw.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 20 Jan 2019 17:21:44 -0800 (PST)
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, viro@zeniv.linux.org.uk, linux-f2fs-devel@lists.sourceforge.net

Deduplicate the f2fs file type conversion implementation and remove
F2FS_FT_* definitions - file systems that use the same file types
as defined by POSIX do not need to define their own versions and can
use the common helper functions decared in fs_types.h and implemented
in fs_types.c

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/f2fs/dir.c           | 27 ++-------------------------
 fs/f2fs/inline.c        |  2 +-
 include/linux/f2fs_fs.h | 15 ---------------
 3 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 50d0d36280fa..797e926388ea 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -36,37 +36,14 @@ static unsigned int bucket_blocks(unsigned int level)
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
+	de->file_type = fs_umode_to_ftype(mode);
 }
 
 unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de)
 {
-	if (de->file_type < F2FS_FT_MAX)
-		return f2fs_filetype_table[de->file_type];
-	return DT_UNKNOWN;
+	return fs_ftype_to_dtype(de->file_type);
 }
 
 static unsigned long dir_block_index(unsigned int level,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d636cbcf68f2..8b4648221820 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -458,7 +458,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 		new_name.len = le16_to_cpu(de->name_len);
 
 		ino = le32_to_cpu(de->ino);
-		fake_mode = f2fs_get_de_type(de) << S_SHIFT;
+		fake_mode = f2fs_get_de_type(de) << S_DT_SHIFT;
 
 		err = f2fs_add_regular_entry(dir, &new_name, NULL, NULL,
 							ino, fake_mode);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d7711048ef93..2961c3477e95 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -524,21 +524,6 @@ struct f2fs_dentry_block {
 	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
 } __packed;
 
-/* file types used in inode_info->flags */
-enum {
-	F2FS_FT_UNKNOWN,
-	F2FS_FT_REG_FILE,
-	F2FS_FT_DIR,
-	F2FS_FT_CHRDEV,
-	F2FS_FT_BLKDEV,
-	F2FS_FT_FIFO,
-	F2FS_FT_SOCK,
-	F2FS_FT_SYMLINK,
-	F2FS_FT_MAX
-};
-
-#define S_SHIFT 12
-
 #define	F2FS_DEF_PROJID		0	/* default project ID */
 
 #endif  /* _LINUX_F2FS_FS_H */
-- 
2.20.1
