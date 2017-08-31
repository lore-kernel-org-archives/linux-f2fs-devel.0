From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: constify super_operations
Date: Thu, 31 Aug 2017 18:56:48 +0800
Message-ID: <c0820f21-01f0-1fd1-02b1-ffb62388f538@huawei.com>
References: <668bb6351adb54694cee5e94f213f5f4c63f96bd.1504171894.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <668bb6351adb54694cee5e94f213f5f4c63f96bd.1504171894.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/31 17:36, Arvind Yadav wrote:
> super_operations are not supposed to change at runtime.
> "struct super_block" working with super_operations provided
> by <linux/fs.h> work with const super_operations. So mark
> the non-const structs as const
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 32e4c02..2bf0869 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1199,7 +1199,7 @@ static inline void f2fs_quota_off_umount(struct super_block *sb)
>  }
>  #endif
>  
> -static struct super_operations f2fs_sops = {
> +static const struct super_operations f2fs_sops = {
>  	.alloc_inode	= f2fs_alloc_inode,
>  	.drop_inode	= f2fs_drop_inode,
>  	.destroy_inode	= f2fs_destroy_inode,
> 
