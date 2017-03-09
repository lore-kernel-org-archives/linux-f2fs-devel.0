From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix wrong error injection for
 evict_inode
Date: Thu, 9 Mar 2017 16:53:29 +0800
Message-ID: <231281e5-15b5-6214-4e73-8008b49a0fd8@huawei.com>
References: <20170307221303.6757-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170307221303.6757-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/3/8 6:13, Jaegeuk Kim wrote:
> The previous one was not a proper location to inject an error, since there
> is no point to get errors. Instead, we can emulate EIO during truncation,
> and the below logic should handle it correctly.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/inode.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index ef8610bf950f..2520fa72b23f 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -372,13 +372,6 @@ void f2fs_evict_inode(struct inode *inode)
>  	if (inode->i_nlink || is_bad_inode(inode))
>  		goto no_delete;
>  
> -#ifdef CONFIG_F2FS_FAULT_INJECTION
> -	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
> -		f2fs_show_injection_info(FAULT_EVICT_INODE);
> -		goto no_delete;
> -	}
> -#endif
> -
>  	remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
>  	remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
>  
> @@ -389,6 +382,12 @@ void f2fs_evict_inode(struct inode *inode)
>  	if (F2FS_HAS_BLOCKS(inode))

In addition, how about add below code to emulate error came from f2fs_truncate?

	if (F2FS_HAS_BLOCKS(inode)) {
#ifdef CONFIG_F2FS_FAULT_INJECTION
		if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
			f2fs_show_injection_info(FAULT_EVICT_INODE);
			err = -EIO;
		}
#endif
		if (!err)
			err = f2fs_truncate(inode);
	}

Thanks,

>  		err = f2fs_truncate(inode);
>  
> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> +	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
> +		f2fs_show_injection_info(FAULT_EVICT_INODE);
> +		err = -EIO;
> +	}
> +#endif
>  	if (!err) {
>  		f2fs_lock_op(sbi);
>  		err = remove_inode_page(inode);
> 
