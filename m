From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: give random value to i_generation
Date: Tue, 26 Feb 2019 09:45:07 -0800
Message-ID: <20190226174507.76205-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This follows to give random number to i_generation along with commit
232530680290b ("ext4: improve smp scalability for inode generation")

This can be used for DUN for UFS HW encryption.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 --
 fs/f2fs/namei.c | 3 ++-
 fs/f2fs/super.c | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 19cbf17550c7..3007759dd2dd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1242,8 +1242,6 @@ struct f2fs_sb_info {
 
 	unsigned int nquota_files;		/* # of quota sysfile */
 
-	u32 s_next_generation;			/* for NFS support */
-
 	/* # of pages, see count_type */
 	atomic_t nr_pages[NR_COUNT_TYPE];
 	/* # of allocated blocks */
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 62d9829f3a6a..f218d9424d8b 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/sched.h>
 #include <linux/ctype.h>
+#include <linux/random.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
 #include <linux/quotaops.h>
@@ -50,7 +51,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	F2FS_I(inode)->i_crtime = inode->i_mtime;
-	inode->i_generation = sbi->s_next_generation++;
+	inode->i_generation = prandom_u32();
 
 	if (S_ISDIR(inode->i_mode))
 		F2FS_I(inode)->i_current_depth = 1;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 45121190a2ba..42eb5c86330a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3129,7 +3129,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_maxbytes = sbi->max_file_blocks <<
 				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;
-	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &f2fs_quota_operations;
-- 
2.19.0.605.g01d371f741-goog
