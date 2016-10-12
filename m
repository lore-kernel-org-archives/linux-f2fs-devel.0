From: Chao Yu <chao@kernel.org>
Subject: [RFC PATCH 1/2] f2fs: rename f2fs_update_time
Date: Thu, 13 Oct 2016 00:14:26 +0800
Message-ID: <20161012161427.24419-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1buMD3-0004Gn-Mo
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Oct 2016 16:16:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1buMD1-0001f2-Hp
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Oct 2016 16:16:49 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

For readability, no functionality change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       |  2 +-
 fs/f2fs/dir.c        |  6 +++---
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/file.c       | 24 ++++++++++++------------
 fs/f2fs/super.c      |  4 ++--
 fs/f2fs/xattr.c      |  2 +-
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 654f5d7..d95fada 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1275,7 +1275,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			"checkpoint: version = %llx", ckpt_ver);
 
 	/* do checkpoint periodically */
-	f2fs_update_time(sbi, CP_TIME);
+	f2fs_update_last_optime(sbi, CP_TIME);
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
 out:
 	mutex_unlock(&sbi->cp_mutex);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 983aa54e..165b69c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1705,7 +1705,7 @@ static int f2fs_write_end(struct file *file,
 		f2fs_i_size_write(inode, pos + copied);
 unlock_out:
 	f2fs_put_page(page, 1);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 	return copied;
 }
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a46079a..70e7c39 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -631,7 +631,7 @@ int __f2fs_do_add_link(struct inode *dir, struct fscrypt_name *fname,
 		err = f2fs_add_regular_entry(dir, &new_name, fname->usr_fname,
 							inode, ino, mode);
 
-	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(dir), REQ_TIME);
 	return err;
 }
 
@@ -671,7 +671,7 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 	clear_inode_flag(inode, FI_NEW_INODE);
 fail:
 	up_write(&F2FS_I(inode)->i_sem);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 	return err;
 }
 
@@ -710,7 +710,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
 	int i;
 
-	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(dir), REQ_TIME);
 
 	if (f2fs_has_inline_dentry(dir))
 		return f2fs_delete_inline_entry(dentry, page, dir, inode);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eaac7b4..5c19136 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -936,7 +936,7 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 (((u64)part_stat_read(s->sb->s_bdev->bd_part, sectors[1]) -		 \
 		s->sectors_written_start) >> 1)
 
-static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
+static inline void f2fs_update_last_optime(struct f2fs_sb_info *sbi, int type)
 {
 	sbi->last_time[type] = jiffies;
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0081c79..b46f6e1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -100,7 +100,7 @@ mapped:
 	clear_cold_data(page);
 out:
 	sb_end_pagefault(inode->i_sb);
-	f2fs_update_time(sbi, REQ_TIME);
+	f2fs_update_last_optime(sbi, REQ_TIME);
 	return block_page_mkwrite_return(err);
 }
 
@@ -282,7 +282,7 @@ flush_out:
 	remove_ino_entry(sbi, ino, UPDATE_INO);
 	clear_inode_flag(inode, FI_UPDATE_WRITE);
 	ret = f2fs_issue_flush(sbi);
-	f2fs_update_time(sbi, REQ_TIME);
+	f2fs_update_last_optime(sbi, REQ_TIME);
 out:
 	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
 	f2fs_trace_ios(NULL, 1);
@@ -539,7 +539,7 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	}
 	dn->ofs_in_node = ofs;
 
-	f2fs_update_time(sbi, REQ_TIME);
+	f2fs_update_last_optime(sbi, REQ_TIME);
 	trace_f2fs_truncate_data_blocks_range(dn->inode, dn->nid,
 					 dn->ofs_in_node, nr_free);
 	return nr_free;
@@ -1439,7 +1439,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (!ret) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		f2fs_mark_inode_dirty_sync(inode);
-		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+		f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 	}
 
 out:
@@ -1565,7 +1565,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 
 	if (!get_dirty_pages(inode))
 		goto out;
@@ -1637,7 +1637,7 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 		goto out;
 
 	set_inode_flag(inode, FI_VOLATILE_FILE);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
@@ -1697,7 +1697,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	inode_unlock(inode);
 
 	mnt_drop_write_file(filp);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 	return ret;
 }
 
@@ -1743,7 +1743,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		ret = -EINVAL;
 		goto out;
 	}
-	f2fs_update_time(sbi, REQ_TIME);
+	f2fs_update_last_optime(sbi, REQ_TIME);
 out:
 	mnt_drop_write_file(filp);
 	return ret;
@@ -1781,7 +1781,7 @@ static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 	if (copy_to_user((struct fstrim_range __user *)arg, &range,
 				sizeof(range)))
 		return -EFAULT;
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 	return 0;
 }
 
@@ -1823,7 +1823,7 @@ static int f2fs_ioc_keyctl(struct file *filp, unsigned long arg)
 		type = XATTR_REPLACE;
 	}
 
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 	ret = f2fs_setxattr(inode, F2FS_XATTR_INDEX_KEY,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
 				value, F2FS_KEY_SIZE, NULL, type);
@@ -1841,7 +1841,7 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 							sizeof(policy)))
 		return -EFAULT;
 
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_last_optime(F2FS_I_SB(inode), REQ_TIME);
 
 	return fscrypt_process_policy(filp, &policy);
 }
@@ -2129,7 +2129,7 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	}
 
 	err = f2fs_defragment_range(sbi, filp, &range);
-	f2fs_update_time(sbi, REQ_TIME);
+	f2fs_update_last_optime(sbi, REQ_TIME);
 	if (err < 0)
 		goto out;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bfa4414..e38c9d2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1868,8 +1868,8 @@ skip_recovery:
 			sbi->valid_super_block ? 1 : 2, err);
 	}
 
-	f2fs_update_time(sbi, CP_TIME);
-	f2fs_update_time(sbi, REQ_TIME);
+	f2fs_update_last_optime(sbi, CP_TIME);
+	f2fs_update_last_optime(sbi, REQ_TIME);
 	return 0;
 
 free_kobj:
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 83234dd..4b1983e 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -589,6 +589,6 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	up_write(&F2FS_I(inode)->i_sem);
 	f2fs_unlock_op(sbi);
 
-	f2fs_update_time(sbi, REQ_TIME);
+	f2fs_update_last_optime(sbi, REQ_TIME);
 	return err;
 }
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
