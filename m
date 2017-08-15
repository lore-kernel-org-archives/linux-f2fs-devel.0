From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: let fill_super handle roll-forward errors
Date: Tue, 15 Aug 2017 09:44:24 +0800
Message-ID: <b3aea107-b582-6949-a558-a94558a1f253@huawei.com>
References: <20170811004204.24078-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811004204.24078-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/8/11 8:42, Jaegeuk Kim wrote:
> If we set CP_ERROR_FLAG in roll-forward error, f2fs is no longer to proceed
> any IOs due to f2fs_cp_error(). But, for example, if some stale data is involved
> on roll-forward process, we're able to get -ENOENT, getting fs stuck.
> If we get any error, let fill_super set SBI_NEED_FSCK and try to recover back
> to stable point.

Before that, we have cleaned up all node/meta page cache, so we will get back to
last checkpoint status, means losing fsynced datas for ever.

Would it be better to just leave message reminding user to mount with
disable_roll_forward or run fsck offline.

Thanks,

> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/recovery.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index a3d02613934a..f707d810c87d 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -649,8 +649,6 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  	}
>  
>  	clear_sbi_flag(sbi, SBI_POR_DOING);
> -	if (err)
> -		set_ckpt_flags(sbi, CP_ERROR_FLAG);
>  	mutex_unlock(&sbi->cp_mutex);
>  
>  	/* let's drop all the directory inodes for clean checkpoint */
> 
