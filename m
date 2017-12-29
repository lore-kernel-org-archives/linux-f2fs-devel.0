From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: recover directory operations by fsync
Date: Fri, 29 Dec 2017 16:45:50 +0800
Message-ID: <3a36802c-3de2-5361-5f66-df868d3ed9a1@huawei.com>
References: <20171228162217.42041-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228162217.42041-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/29 0:22, Jaegeuk Kim wrote:
> This fixes generic/342 which doesn't recover renamed file which was fsynced
> before. It will be done via another fsync on newly created file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/dir.c   | 2 ++
>  fs/f2fs/f2fs.h  | 2 ++
>  fs/f2fs/file.c  | 3 +++
>  fs/f2fs/namei.c | 4 ++++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 724304dc6143..f00b5ed8c011 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -713,6 +713,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>  
>  	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
>  
> +	add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
> +
>  	if (f2fs_has_inline_dentry(dir))
>  		return f2fs_delete_inline_entry(dentry, page, dir, inode);
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 398ed95d4036..b32eacf11270 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -181,6 +181,7 @@ enum {
>  	ORPHAN_INO,		/* for orphan ino list */
>  	APPEND_INO,		/* for append ino list */
>  	UPDATE_INO,		/* for update ino list */
> +	TRANS_DIR_INO,		/* for trasactions dir ino list */
>  	FLUSH_INO,		/* for multiple device flushing */
>  	MAX_INO_ENTRY,		/* max. list */
>  };
> @@ -930,6 +931,7 @@ enum cp_reason_type {
>  	CP_NODE_NEED_CP,
>  	CP_FASTBOOT_MODE,
>  	CP_SPEC_LOG_NUM,
> +	CP_RECOVER_DIR,

Need to add description of CP_RECOVER_DIR in show_fsync_cpreason?

Otherwise, looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  };
>  
>  enum iostat_type {
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5a3b9a07d72d..66a51e9fbe83 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -165,6 +165,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>  		cp_reason = CP_FASTBOOT_MODE;
>  	else if (sbi->active_logs == 2)
>  		cp_reason = CP_SPEC_LOG_NUM;
> +	else if (need_dentry_mark(sbi, inode->i_ino) &&
> +		exist_written_data(sbi, F2FS_I(inode)->i_pino, TRANS_DIR_INO))
> +		cp_reason = CP_RECOVER_DIR;
>  
>  	return cp_reason;
>  }
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index e3a0f4f65851..a885c6e659f8 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -935,6 +935,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		}
>  		f2fs_i_links_write(old_dir, false);
>  	}
> +	add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
>  
>  	f2fs_unlock_op(sbi);
>  
> @@ -1089,6 +1090,9 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	}
>  	f2fs_mark_inode_dirty_sync(new_dir, false);
>  
> +	add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
> +	add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);> +
>  	f2fs_unlock_op(sbi);
>  
>  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
> 
