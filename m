From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: avoid selinux denial on CAP_SYS_RESOURCE
Date: Fri, 9 Mar 2018 14:22:09 +0800
Message-ID: <5ec9338e-1522-2b6a-99c2-ffe70b7a06a9@huawei.com>
References: <20180309044900.39677-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309044900.39677-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/3/9 12:49, Jaegeuk Kim wrote:
> This fixes CAP_SYS_RESOURCE denial of selinux when using resgid.

A little confusion, if capable(CAP_SYS_RESOURCE) is false, we still have chance
to return true for below resuid & resgid cases, right?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f6dc70666ebb..3d12277fbe9e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1607,13 +1607,13 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
>  		return false;
>  	if (IS_NOQUOTA(inode))
>  		return true;
> -	if (capable(CAP_SYS_RESOURCE))
> -		return true;
>  	if (uid_eq(sbi->s_resuid, current_fsuid()))
>  		return true;
>  	if (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) &&
>  					in_group_p(sbi->s_resgid))
>  		return true;
> +	if (capable(CAP_SYS_RESOURCE))
> +		return true;
>  	return false;
>  }
>  
> 
