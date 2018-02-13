From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH v3] f2fs: introduce "fsync={posix,
 strict}" mount options
Date: Tue, 13 Feb 2018 18:57:14 +0800
Message-ID: <20180213105714.128197-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <zhengjunling@huawei.com>) id 1elYHS-00066p-GY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Feb 2018 10:57:46 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1elYHP-0006Ll-2O
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Feb 2018 10:57:46 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Commit "0a007b97aad6"(f2fs: recover directory operations by fsync)
fixed xfstest generic/342 case, but it also increased the written
data and caused the performance degradation. In most cases, there's
no need to do so heavy fsync actually.

So we introduce two new mount options "fsync={posix,strict}" to
control the policy of fsync. "fsync=posix" is set by default, and
means that f2fs uses a light fsync, which follows POSIX semantics.
And "fsync=strict" means that it's a heavy fsync, which behaves in
line with xfs, ext4 and btrfs, where generic/342 will pass, but the
performance will regress.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
Changes from v2:
 - Change to "fsync={posix,strict}" format
 - Set "fsync=posix" default
Changes from v1:
 - Add document modify
 - Add reviewer
 Documentation/filesystems/f2fs.txt |  7 +++++++
 fs/f2fs/dir.c                      |  3 ++-
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/file.c                     |  3 ++-
 fs/f2fs/namei.c                    |  9 ++++++---
 fs/f2fs/super.c                    | 10 ++++++++++
 6 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 0caf7da0a532..c00d40655bbc 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -180,6 +180,13 @@ whint_mode=%s          Control which write hints are passed down to block
                        down hints. In "user-based" mode, f2fs tries to pass
                        down hints given by users. And in "fs-based" mode, f2fs
                        passes down hints with its policy.
+fsync=%s               Control the policy of fsync. This supports "posix" and
+                       "strict" modes. In "posix" mode, which is default, fsync
+                       will follow POSIX semantics and does a light operation to
+                       improve the filesystem performance. In "strict" mode, fsync
+                       will be heavy and behaves in line with xfs, ext4 and btrfs,
+                       where xfstest generic/342 will pass, but the performance
+                       will regress.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f00b5ed8c011..37d1259f1b92 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -713,7 +713,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
 
-	add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
+	if (test_opt(F2FS_I_SB(dir), STRICT_FSYNC))
+		add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
 
 	if (f2fs_has_inline_dentry(dir))
 		return f2fs_delete_inline_entry(dentry, page, dir, inode);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dbe87c7a266e..8cf914d12f17 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -97,6 +97,7 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
 #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
+#define F2FS_MOUNT_STRICT_FSYNC		0x02000000
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 672a542e5464..509b3e045247 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -165,7 +165,8 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		cp_reason = CP_FASTBOOT_MODE;
 	else if (sbi->active_logs == 2)
 		cp_reason = CP_SPEC_LOG_NUM;
-	else if (need_dentry_mark(sbi, inode->i_ino) &&
+	else if (test_opt(sbi, STRICT_FSYNC) &&
+		need_dentry_mark(sbi, inode->i_ino) &&
 		exist_written_data(sbi, F2FS_I(inode)->i_pino, TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c4c94c7e9f4f..5a385b8ab172 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -936,7 +936,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		}
 		f2fs_i_links_write(old_dir, false);
 	}
-	add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
+	if (test_opt(sbi, STRICT_FSYNC))
+		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
 
 	f2fs_unlock_op(sbi);
 
@@ -1091,8 +1092,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 	f2fs_mark_inode_dirty_sync(new_dir, false);
 
-	add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-	add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
+	if (test_opt(sbi, STRICT_FSYNC)) {
+		add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
+		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
+	}
 
 	f2fs_unlock_op(sbi);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7966cf7bfb8e..8429e7b3cc7f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -130,6 +130,8 @@ enum {
 	Opt_jqfmt_vfsv0,
 	Opt_jqfmt_vfsv1,
 	Opt_whint,
+	Opt_posix_fsync,
+	Opt_strict_fsync,
 	Opt_err,
 };
 
@@ -184,6 +186,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
 	{Opt_whint, "whint_mode=%s"},
+	{Opt_posix_fsync, "fsync=posix"},
+	{Opt_strict_fsync, "fsync=strict"},
 	{Opt_err, NULL},
 };
 
@@ -700,6 +704,12 @@ static int parse_options(struct super_block *sb, char *options)
 			}
 			kfree(name);
 			break;
+		case Opt_posix_fsync:
+			clear_opt(sbi, STRICT_FSYNC);
+			break;
+		case Opt_strict_fsync:
+			set_opt(sbi, STRICT_FSYNC);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
-- 
2.15.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
