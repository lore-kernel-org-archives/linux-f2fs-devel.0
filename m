From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: skip committing valid superblock
Date: Mon, 08 Jun 2015 13:28:03 +0800
Message-ID: <004601d0a1ac$07f97460$17ec5d20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In recovery procedure for superblock, we try to write data of valid
superblock into invalid one for recovery, work should be finished here,
but then still we will write the valid one with its original data.
This operation is not needed. Let's skip doing this unnecessary work.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/file.c  | 2 +-
 fs/f2fs/super.c | 8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1a0716c..a8327ed 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1624,7 +1624,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 /*
  * super.c
  */
-int f2fs_commit_super(struct f2fs_sb_info *);
+int f2fs_commit_super(struct f2fs_sb_info *, bool);
 int f2fs_sync_fs(struct super_block *, int);
 extern __printf(3, 4)
 void f2fs_msg(struct super_block *, const char *, const char *, ...);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 85f97af..4c8885d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1530,7 +1530,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 	/* update superblock with uuid */
 	generate_random_uuid(sbi->raw_super->encrypt_pw_salt);
 
-	err = f2fs_commit_super(sbi);
+	err = f2fs_commit_super(sbi, false);
 
 	mnt_drop_write_file(filp);
 	if (err) {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f0be6a6..fbbf785 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1035,7 +1035,7 @@ out:
 	return 0;
 }
 
-int f2fs_commit_super(struct f2fs_sb_info *sbi)
+int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
 	struct buffer_head *sbh = sbi->raw_super_buf;
 	sector_t block = sbh->b_blocknr;
@@ -1047,7 +1047,9 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi)
 	err = sync_dirty_buffer(sbh);
 
 	sbh->b_blocknr = block;
-	if (err)
+
+	/* if we are in recovery path, skip writing valid superblock */
+	if (recover || err)
 		goto out;
 
 	/* write current valid superblock */
@@ -1291,7 +1293,7 @@ try_onemore:
 	/* recover broken superblock */
 	if (recovery && !f2fs_readonly(sb) && !bdev_read_only(sb->s_bdev)) {
 		f2fs_msg(sb, KERN_INFO, "Recover invalid superblock");
-		f2fs_commit_super(sbi);
+		f2fs_commit_super(sbi, true);
 	}
 
 	return 0;
-- 
2.4.2
