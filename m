From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: enforce fsync_mode=strict for
 renamed directory
Date: Wed, 25 Apr 2018 21:04:52 +0800
Message-ID: <42858ef4-c1b8-c83e-4b47-39e28e161e16@kernel.org>
References: <20180425054613.2700-1-jaegeuk@kernel.org>
 <20180425054613.2700-5-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425054613.2700-5-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/25 13:46, Jaegeuk Kim wrote:
> This is to give a option for user to be able to recover B/foo in the below
> case.
> 
> mkdir A
> sync()
> rename(A, B)
> creat (B/foo)
> fsync (B/foo)
> ---crash---

That makes sense, IMO, it will be better to cover cross rename case as well?

Thanks,

> 
> Sugessted-by: Velayudhan Pillai <vijay@cs.utexas.edu>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index b5f404674cad..fef6e3ab2135 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -973,8 +973,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  			f2fs_put_page(old_dir_page, 0);
>  		f2fs_i_links_write(old_dir, false);
>  	}
> -	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> +	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
>  		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
> +		if (S_ISDIR(old_inode->i_mode))
> +			add_ino_entry(sbi, old_inode->i_ino, TRANS_DIR_INO);
> +	}
>  
>  	f2fs_unlock_op(sbi);
>  
> 
