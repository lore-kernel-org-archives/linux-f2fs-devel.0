From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v4] f2fs: introduce mount option for fsync
 mode
Date: Wed, 28 Feb 2018 21:59:27 +0800
Message-ID: <1ad8d3cd-42e5-6da4-f0cb-29931f8b31e3@kernel.org>
References: <20180228120913.175915-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1er2Gt-001fRh-D4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 13:59:51 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1er2Gp-008S7C-11
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 13:59:49 +0000
In-Reply-To: <20180228120913.175915-1-zhengjunling@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/2/28 20:09, Junling Zheng wrote:
> Commit "0a007b97aad6"(f2fs: recover directory operations by fsync)
> fixed xfstest generic/342 case, but it also increased the written
> data and caused the performance degradation. In most cases, there's
> no need to do so heavy fsync actually.
> 
> So we introduce new mount option "fsync_mode={posix,strict}" to
> control the policy of fsync. "fsync_mode=posix" is set by default,
> and means that f2fs uses a light fsync, which follows POSIX semantics.
> And "fsync_mode=strict" means that it's a heavy fsync, which behaves
> in line with xfs, ext4 and btrfs, where generic/342 will pass, but
> the performance will regress.

Let's handle to recover old fsync_mode in error path of ->remount_fs.

Thanks,

> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> ---
> Changes from v3:
>  - add fsync_mode in sbi to record fsync mode
>  - keep the extensibility for fsync_mode
> Changes from v2:
>  - Change to "fsync={posix,strict}" format
>  - Set "fsync=posix" default
> Changes from v1:
>  - Add document modify
>  - Add reviewer
>  Documentation/filesystems/f2fs.txt |  7 +++++++
>  fs/f2fs/dir.c                      |  3 ++-
>  fs/f2fs/f2fs.h                     |  8 ++++++++
>  fs/f2fs/file.c                     |  3 ++-
>  fs/f2fs/namei.c                    |  9 ++++++---
>  fs/f2fs/super.c                    | 24 ++++++++++++++++++++++++
>  6 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 0409c47584ea..514e44983a8e 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -182,6 +182,13 @@ whint_mode=%s          Control which write hints are passed down to block
>                         passes down hints with its policy.
>  alloc_mode=%s          Adjust block allocation policy, which supports "reuse"
>                         and "default".
> +fsync_mode=%s          Control the policy of fsync. Currently supports "posix"
> +                       and "strict". In "posix" mode, which is default, fsync
> +                       will follow POSIX semantics and does a light operation
> +                       to improve the filesystem performance. In "strict" mode,
> +                       fsync will be heavy and behaves in line with xfs, ext4
> +                       and btrfs, where xfstest generic/342 will pass, but the
> +                       performance will regress.
>  
>  ================================================================================
>  DEBUGFS ENTRIES
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index f00b5ed8c011..cce8ce11c2cc 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -713,7 +713,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>  
>  	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
>  
> -	add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
> +	if (F2FS_I_SB(dir)->fsync_mode == FSYNC_MODE_STRICT)
> +		add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
>  
>  	if (f2fs_has_inline_dentry(dir))
>  		return f2fs_delete_inline_entry(dentry, page, dir, inode);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e4a782b23e66..b85dcfb30bac 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1052,6 +1052,11 @@ enum {
>  	ALLOC_MODE_REUSE,	/* reuse segments as much as possible */
>  };
>  
> +enum fsync_mode {
> +	FSYNC_MODE_POSIX,	/* fsync follows posix semantics */
> +	FSYNC_MODE_STRICT,	/* fsync behaves in line with ext4 */
> +};
> +
>  struct f2fs_sb_info {
>  	struct super_block *sb;			/* pointer to VFS super block */
>  	struct proc_dir_entry *s_proc;		/* proc entry */
> @@ -1241,6 +1246,9 @@ struct f2fs_sb_info {
>  
>  	/* segment allocation policy */
>  	int alloc_mode;
> +
> +	/* fsync policy */
> +	int fsync_mode;
>  };
>  
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6a202e5a6386..99fa207fc310 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -165,7 +165,8 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>  		cp_reason = CP_FASTBOOT_MODE;
>  	else if (sbi->active_logs == 2)
>  		cp_reason = CP_SPEC_LOG_NUM;
> -	else if (need_dentry_mark(sbi, inode->i_ino) &&
> +	else if (sbi->fsync_mode == FSYNC_MODE_STRICT &&
> +		need_dentry_mark(sbi, inode->i_ino) &&
>  		exist_written_data(sbi, F2FS_I(inode)->i_pino, TRANS_DIR_INO))
>  		cp_reason = CP_RECOVER_DIR;
>  
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 75135191a73d..010fc9a4a589 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -977,7 +977,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		}
>  		f2fs_i_links_write(old_dir, false);
>  	}
> -	add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
> +	if (sbi->fsync_mode == FSYNC_MODE_STRICT)
> +		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
>  
>  	f2fs_unlock_op(sbi);
>  
> @@ -1132,8 +1133,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	}
>  	f2fs_mark_inode_dirty_sync(new_dir, false);
>  
> -	add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
> -	add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
> +	if (sbi->fsync_mode == FSYNC_MODE_STRICT) {
> +		add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
> +		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
> +	}
>  
>  	f2fs_unlock_op(sbi);
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 359dc031fb8c..67c07de87dad 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -131,6 +131,7 @@ enum {
>  	Opt_jqfmt_vfsv1,
>  	Opt_whint,
>  	Opt_alloc,
> +	Opt_fsync,
>  	Opt_err,
>  };
>  
> @@ -186,6 +187,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
>  	{Opt_whint, "whint_mode=%s"},
>  	{Opt_alloc, "alloc_mode=%s"},
> +	{Opt_fsync, "fsync_mode=%s"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -719,6 +721,22 @@ static int parse_options(struct super_block *sb, char *options)
>  			}
>  			kfree(name);
>  			break;
> +		case Opt_fsync:
> +			name = match_strdup(&args[0]);
> +			if (!name)
> +				return -ENOMEM;
> +			if (strlen(name) == 5 &&
> +					!strncmp(name, "posix", 5)) {
> +				sbi->fsync_mode = FSYNC_MODE_POSIX;
> +			} else if (strlen(name) == 6 &&
> +					!strncmp(name, "strict", 6)) {
> +				sbi->fsync_mode = FSYNC_MODE_STRICT;
> +			} else {
> +				kfree(name);
> +				return -EINVAL;
> +			}
> +			kfree(name);
> +			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
>  				"Unrecognized mount option \"%s\" or missing value",
> @@ -1287,6 +1305,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_printf(seq, ",alloc_mode=%s", "default");
>  	else if (sbi->alloc_mode == ALLOC_MODE_REUSE)
>  		seq_printf(seq, ",alloc_mode=%s", "reuse");
> +
> +	if (sbi->fsync_mode == FSYNC_MODE_POSIX)
> +		seq_printf(seq, ",fsync_mode=%s", "posix");
> +	else if (sbi->fsync_mode == FSYNC_MODE_STRICT)
> +		seq_printf(seq, ",fsync_mode=%s", "strict");
>  	return 0;
>  }
>  
> @@ -1297,6 +1320,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	sbi->inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
>  	sbi->whint_mode = WHINT_MODE_OFF;
>  	sbi->alloc_mode = ALLOC_MODE_DEFAULT;
> +	sbi->fsync_mode = FSYNC_MODE_POSIX;
>  	sbi->readdir_ra = 1;
>  
>  	set_opt(sbi, BG_GC);
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
