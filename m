From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix wrong AUTO_RECOVER condition
Date: Mon, 28 Nov 2016 16:31:25 -0800
Message-ID: <20161129003125.GA15941@jaegeuk>
References: <20161117232958.10931-1-jaegeuk@kernel.org>
	<20161117232958.10931-2-jaegeuk@kernel.org>
	<d5ae9fc5-d1be-8eb6-ed24-210fdcba73a2@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cBWKg-00075I-Js
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Nov 2016 00:31:38 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cBWKb-0005V0-Sh
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Nov 2016 00:31:38 +0000
Content-Disposition: inline
In-Reply-To: <d5ae9fc5-d1be-8eb6-ed24-210fdcba73a2@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Fri, Nov 25, 2016 at 11:40:58PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> isize AUTO_RECOVER still be corrupted..., try below case:
> 
> 1. xfs_io -f /mnt/f2fs/file -c "pwrite 0 4096" -c "fsync"
> 2. xfs_io -f /mnt/f2fs/file -c "falloc -k 4096 4096" -c "fsync"
> 3. md5sum /mnt/f2fs/file;
> 4. godown /mnt/f2fs/
> 5. umount /mnt/f2fs/
> 6. mount -t f2fs /dev/sdx /mnt/f2fs
> 7. md5sum /mnt/f2fs/file
> 
> It's hard to deside to recover isize or not when current recovered block is
> fallocated, as we can allocate block inside or outside of isize.
> 
> Any thoughts?

Could you take a look at this patch?

>From a370aa1e8926958e143757465083923fff92bb79 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 28 Nov 2016 15:33:38 -0800
Subject: [PATCH] f2fs: do not activate auto_recovery for fallocated i_size

If a file needs to keep its i_size by fallocate, we need to turn off auto
recovery during roll-forward recovery.

This will resolve the below scenario.

1. xfs_io -f /mnt/f2fs/file -c "pwrite 0 4096" -c "fsync"
2. xfs_io -f /mnt/f2fs/file -c "falloc -k 4096 4096" -c "fsync"
3. md5sum /mnt/f2fs/file;
4. godown /mnt/f2fs/
5. umount /mnt/f2fs/
6. mount -t f2fs /dev/sdx /mnt/f2fs
7. md5sum /mnt/f2fs/file

Reported-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h     | 38 +++++++++++++++++++++-----------------
 fs/f2fs/file.c     |  2 ++
 fs/f2fs/recovery.c | 11 ++++++++---
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 593cd6d..8a65949 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -401,6 +401,7 @@ struct f2fs_map_blocks {
 #define FADVISE_LOST_PINO_BIT	0x02
 #define FADVISE_ENCRYPT_BIT	0x04
 #define FADVISE_ENC_NAME_BIT	0x08
+#define FADVISE_KEEP_SIZE_BIT	0x10
 
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
 #define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
@@ -413,6 +414,8 @@ struct f2fs_map_blocks {
 #define file_clear_encrypt(inode) clear_file(inode, FADVISE_ENCRYPT_BIT)
 #define file_enc_name(inode)	is_file(inode, FADVISE_ENC_NAME_BIT)
 #define file_set_enc_name(inode) set_file(inode, FADVISE_ENC_NAME_BIT)
+#define file_keep_isize(inode)	is_file(inode, FADVISE_KEEP_SIZE_BIT)
+#define file_set_keep_isize(inode) set_file(inode, FADVISE_KEEP_SIZE_BIT)
 
 #define DEF_DIR_LEVEL		0
 
@@ -1716,23 +1719,6 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
 
-static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
-{
-	if (dsync) {
-		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-		bool ret;
-
-		spin_lock(&sbi->inode_lock[DIRTY_META]);
-		ret = list_empty(&F2FS_I(inode)->gdirty_list);
-		spin_unlock(&sbi->inode_lock[DIRTY_META]);
-		return ret;
-	}
-	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
-			i_size_read(inode) & PAGE_MASK)
-		return false;
-	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
-}
-
 static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
 {
 	F2FS_I(inode)->i_current_depth = depth;
@@ -1885,6 +1871,24 @@ static inline void clear_file(struct inode *inode, int type)
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
+static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
+{
+	if (dsync) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		bool ret;
+
+		spin_lock(&sbi->inode_lock[DIRTY_META]);
+		ret = list_empty(&F2FS_I(inode)->gdirty_list);
+		spin_unlock(&sbi->inode_lock[DIRTY_META]);
+		return ret;
+	}
+	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
+			file_keep_isize(inode) ||
+			i_size_read(inode) & PAGE_MASK)
+		return false;
+	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
+}
+
 static inline int f2fs_readonly(struct super_block *sb)
 {
 	return sb->s_flags & MS_RDONLY;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b43d164..22a3f76 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1399,6 +1399,8 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (!ret) {
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 		f2fs_mark_inode_dirty_sync(inode, false);
+		if (mode & FALLOC_FL_KEEP_SIZE)
+			file_set_keep_isize(inode);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 687c176..981a958 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -187,6 +187,8 @@ static void recover_inode(struct inode *inode, struct page *page)
 	inode->i_ctime.tv_nsec = le32_to_cpu(raw->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
 
+	F2FS_I(inode)->i_advise = raw->i_advise;
+
 	if (file_enc_name(inode))
 		name = "<encrypted>";
 	else
@@ -425,7 +427,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 			continue;
 		}
 
-		if (i_size_read(inode) <= (start << PAGE_SHIFT))
+		if (!file_keep_isize(inode) &&
+				(i_size_read(inode) <= (start << PAGE_SHIFT)))
 			f2fs_i_size_write(inode, (start + 1) << PAGE_SHIFT);
 
 		/*
@@ -478,8 +481,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_msg(sbi->sb, KERN_NOTICE,
-		"recover_data: ino = %lx, recovered = %d blocks, err = %d",
-		inode->i_ino, recovered, err);
+		"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d",
+		inode->i_ino,
+		file_keep_isize(inode) ? "keep" : "recover",
+		recovered, err);
 	return err;
 }
 
-- 
2.8.3


------------------------------------------------------------------------------
