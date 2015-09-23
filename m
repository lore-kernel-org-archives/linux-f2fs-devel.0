From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH RESEND] f2fs:Fix concurrent access issue in the function
 recover_dentry
Date: Wed, 23 Sep 2015 13:37:49 -0700
Message-ID: <20150923203749.GA36564@jaegeuk-mac02.mot.com>
References: <1443037550-3627-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443037550-3627-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: cm224.lee@samsung.com, chao2.yu@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Sep 23, 2015 at 03:45:50PM -0400, Nicholas Krause wrote:
> This fixes a concurrent access in the function recover_dentry by
> locking the superblock representation in memory with f2fs_lock_op
> before calling the function __f2fs_add_link and unlocking the
> superblock afterwards with f2fs_unlock_op in order to avoid
> concurrent access here as neither recover_dentry nor its callers

It doesn't need to do this.
IIRC, this was explained twice by Chao.
Please, do not ignore any opinions.

Thanks,

> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  fs/f2fs/recovery.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index faec2ca..6bb03f8 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -70,6 +70,7 @@ static struct fsync_inode_entry *get_fsync_inode(struct list_head *head,
>  static int recover_dentry(struct inode *inode, struct page *ipage)
>  {
>  	struct f2fs_inode *raw_inode = F2FS_INODE(ipage);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	nid_t pino = le32_to_cpu(raw_inode->i_pino);
>  	struct f2fs_dir_entry *de;
>  	struct qstr name;
> @@ -119,9 +120,15 @@ retry:
>  		iput(einode);
>  		goto retry;
>  	}
> +
> +
> +	f2fs_lock_op(sbi);
>  	err = __f2fs_add_link(dir, &name, inode, inode->i_ino, inode->i_mode);
> -	if (err)
> +	if (err) {
> +		f2fs_unlock_op(sbi);
>  		goto out_err;
> +	}
> +	f2fs_unlock_op(sbi);
>  
>  	if (is_inode_flag_set(F2FS_I(dir), FI_DELAY_IPUT)) {
>  		iput(dir);
> -- 
> 2.1.4
