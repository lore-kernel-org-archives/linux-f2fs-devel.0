From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs/crypto: drop crypto key at evict_inode only
Date: Wed, 11 Oct 2017 11:44:34 +0800
Message-ID: <6e12a05c-eba6-e59c-fce2-d9c197dfe48c@huawei.com>
References: <20171010175646.9211-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010175646.9211-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/11 1:56, Jaegeuk Kim wrote:
> This patch avoids dropping crypto key in f2fs_drop_inode, so we can guarantee
> it happens only at evict_inode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index dc05b16df514..f10a1b1380c2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -717,7 +717,6 @@ static int f2fs_drop_inode(struct inode *inode)
>  
>  			sb_end_intwrite(inode->i_sb);
>  
> -			fscrypt_put_encryption_info(inode, NULL);
>  			spin_lock(&inode->i_lock);
>  			atomic_dec(&inode->i_count);
>  		}
> 
