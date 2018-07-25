From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
Date: Wed, 25 Jul 2018 23:50:17 +0800
Message-ID: <76daeb43-ee9d-3747-7b35-8de0c8228edc@kernel.org>
References: <20180725032228.63492-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725032228.63492-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/25 11:22, Jaegeuk Kim wrote:
> The f2fs_gc() called by f2fs_balance_fs() requires to be called outside of
> fi->i_gc_rwsem[WRITE], since f2fs_gc() can try to grab it in a loop.

It seems there are other paths having the same issue, how about fixing all of
them in this patch?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c    | 2 ++
>  fs/f2fs/segment.c | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 84293423f830..3a5c35fa0603 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1754,6 +1754,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>  	if (ret)
>  		return ret;
>  
> +	f2fs_balance_fs(F2FS_I_SB(inode), true);
> +
>  	inode_lock(inode);
>  
>  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d28fa03a115f..17354089b4ab 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -445,7 +445,6 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	int err;
>  
> -	f2fs_balance_fs(sbi, true);
>  	f2fs_lock_op(sbi);
>  
>  	set_inode_flag(inode, FI_ATOMIC_COMMIT);
> 
