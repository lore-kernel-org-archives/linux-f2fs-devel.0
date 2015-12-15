From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: don't grab super block buffer header
	all the time
Date: Tue, 15 Dec 2015 17:19:26 +0800
Message-ID: <010501d13719$cb711170$62533450$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8lmP-0000H9-0R
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 09:20:21 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8lmL-00051Z-VF
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 09:20:20 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZE004DQ792V270@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 18:20:10 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yunlei He <heyunlei@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We have already got one copy of valid super block in memory, do not grab
buffer header of super block all the time.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/file.c  |  8 ++----
 fs/f2fs/super.c | 81 +++++++++++++++++++++++++--------------------------------
 3 files changed, 38 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ee1f0a8..c5d130a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -723,8 +723,8 @@ enum {
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
-	struct buffer_head *raw_super_buf;	/* buffer head of raw sb */
 	struct f2fs_super_block *raw_super;	/* raw super block pointer */
+	int valid_super_block;			/* valid super block no */
 	int s_flag;				/* flags for sbi */
 
 	/* for node-related operations */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c6d909e..0301551 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1591,20 +1591,16 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 		return err;
 
 	/* update superblock with uuid */
-	lock_buffer(sbi->raw_super_buf);
 	generate_random_uuid(sbi->raw_super->encrypt_pw_salt);
-	unlock_buffer(sbi->raw_super_buf);
 
 	err = f2fs_commit_super(sbi, false);
-
-	mnt_drop_write_file(filp);
 	if (err) {
 		/* undo new data */
-		lock_buffer(sbi->raw_super_buf);
 		memset(sbi->raw_super->encrypt_pw_salt, 0, 16);
-		unlock_buffer(sbi->raw_super_buf);
+		mnt_drop_write_file(filp);
 		return err;
 	}
+	mnt_drop_write_file(filp);
 got_it:
 	if (copy_to_user((__u8 __user *)arg, sbi->raw_super->encrypt_pw_salt,
 									16))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a6eb79a..2d4fed8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -577,7 +577,6 @@ static void f2fs_put_super(struct super_block *sb)
 	wait_for_completion(&sbi->s_kobj_unregister);
 
 	sb->s_fs_info = NULL;
-	brelse(sbi->raw_super_buf);
 	kfree(sbi->raw_super);
 	kfree(sbi);
 }
@@ -1146,65 +1145,53 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
  */
 static int read_raw_super_block(struct super_block *sb,
 			struct f2fs_super_block **raw_super,
-			struct buffer_head **raw_super_buf,
-			int *recovery)
+			int *valid_super_block, int *recovery)
 {
 	int block = 0;
-	struct buffer_head *buffer;
-	struct f2fs_super_block *super;
+	struct buffer_head *bh;
+	struct f2fs_super_block *super, *buf;
 	int err = 0;
 
 	super = kzalloc(sizeof(struct f2fs_super_block), GFP_KERNEL);
 	if (!super)
 		return -ENOMEM;
 retry:
-	buffer = sb_bread(sb, block);
-	if (!buffer) {
+	bh = sb_bread(sb, block);
+	if (!bh) {
 		*recovery = 1;
 		f2fs_msg(sb, KERN_ERR, "Unable to read %dth superblock",
 				block + 1);
-		if (block == 0) {
-			block++;
-			goto retry;
-		} else {
-			err = -EIO;
-			goto out;
-		}
+		err = -EIO;
+		goto next;
 	}
 
-	memcpy(super, buffer->b_data + F2FS_SUPER_OFFSET, sizeof(*super));
+	buf = (struct f2fs_super_block *)(bh->b_data + F2FS_SUPER_OFFSET);
 
 	/* sanity checking of raw super */
-	if (sanity_check_raw_super(sb, super)) {
-		brelse(buffer);
+	if (sanity_check_raw_super(sb, buf)) {
+		brelse(bh);
 		*recovery = 1;
 		f2fs_msg(sb, KERN_ERR,
 			"Can't find valid F2FS filesystem in %dth superblock",
 								block + 1);
-		if (block == 0) {
-			block++;
-			goto retry;
-		} else {
-			err = -EINVAL;
-			goto out;
-		}
+		err = -EINVAL;
+		goto next;
 	}
 
 	if (!*raw_super) {
-		*raw_super_buf = buffer;
+		memcpy(super, buf, sizeof(*super));
+		*valid_super_block = block;
 		*raw_super = super;
-	} else {
-		/* already have a valid superblock */
-		brelse(buffer);
 	}
+	brelse(bh);
 
+next:
 	/* check the validity of the second superblock */
 	if (block == 0) {
 		block++;
 		goto retry;
 	}
 
-out:
 	/* No valid superblock */
 	if (!*raw_super) {
 		kfree(super);
@@ -1217,18 +1204,16 @@ out:
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
 	struct f2fs_super_block *super = F2FS_RAW_SUPER(sbi);
-	struct buffer_head *sbh = sbi->raw_super_buf;
 	struct buffer_head *bh;
 	int err;
 
 	/* write back-up superblock first */
-	bh = sb_getblk(sbi->sb, sbh->b_blocknr ? 0 : 1);
+	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0 : 1);
 	if (!bh)
 		return -EIO;
 
 	lock_buffer(bh);
 	memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
-	WARN_ON(sbh->b_size != F2FS_BLKSIZE);
 	set_buffer_uptodate(bh);
 	set_buffer_dirty(bh);
 	unlock_buffer(bh);
@@ -1241,33 +1226,37 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	if (recover || err)
 		return err;
 
+	bh = sb_getblk(sbi->sb, sbi->valid_super_block);
+	if (!bh)
+		return -EIO;
+
 	/* write current valid superblock */
-	lock_buffer(sbh);
-	if (memcmp(sbh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super))) {
-		f2fs_msg(sbi->sb, KERN_INFO, "Write modified valid superblock");
-		memcpy(sbh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
-	}
-	set_buffer_dirty(sbh);
-	unlock_buffer(sbh);
+	lock_buffer(bh);
+	memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
+	set_buffer_uptodate(bh);
+	set_buffer_dirty(bh);
+	unlock_buffer(bh);
 
-	return __sync_dirty_buffer(sbh, WRITE_FLUSH_FUA);
+	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
+	brelse(bh);
+
+	return err;
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct f2fs_sb_info *sbi;
 	struct f2fs_super_block *raw_super;
-	struct buffer_head *raw_super_buf;
 	struct inode *root;
 	long err;
 	bool retry = true, need_fsck = false;
 	char *options = NULL;
-	int recovery, i;
+	int recovery, i, valid_super_block;
 
 try_onemore:
 	err = -EINVAL;
 	raw_super = NULL;
-	raw_super_buf = NULL;
+	valid_super_block = -1;
 	recovery = 0;
 
 	/* allocate memory for f2fs-specific super block info */
@@ -1281,7 +1270,8 @@ try_onemore:
 		goto free_sbi;
 	}
 
-	err = read_raw_super_block(sb, &raw_super, &raw_super_buf, &recovery);
+	err = read_raw_super_block(sb, &raw_super, &valid_super_block,
+								&recovery);
 	if (err)
 		goto free_sbi;
 
@@ -1314,7 +1304,7 @@ try_onemore:
 	/* init f2fs-specific super block info */
 	sbi->sb = sb;
 	sbi->raw_super = raw_super;
-	sbi->raw_super_buf = raw_super_buf;
+	sbi->valid_super_block = valid_super_block;
 	mutex_init(&sbi->gc_mutex);
 	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
@@ -1522,7 +1512,6 @@ free_meta_inode:
 free_options:
 	kfree(options);
 free_sb_buf:
-	brelse(raw_super_buf);
 	kfree(raw_super);
 free_sbi:
 	kfree(sbi);
-- 
2.6.3



------------------------------------------------------------------------------
