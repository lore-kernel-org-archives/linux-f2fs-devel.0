From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: show precise # of blocks that
 user/root can use
Date: Thu, 4 Jan 2018 09:12:52 +0800
Message-ID: <71c112da-4e2b-71b2-164e-96524a4517c0@huawei.com>
References: <20180103185845.29953-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103185845.29953-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/4 2:58, Jaegeuk Kim wrote:
> Let's show precise # of blocks that user/root can use through bavail and bfree
> respectively.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0a820ba55b10..4c1c99cf54ef 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1005,9 +1005,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_bsize = sbi->blocksize;
>  
>  	buf->f_blocks = total_count - start_count;
> -	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;

Clean up unused ovp_count in this patch?

Thanks,

> -	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
> +	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
>  						sbi->current_reserved_blocks;
> +	buf->f_bavail = buf->f_bfree;
>  
>  	avail_node_count = sbi->total_node_count - sbi->nquota_files -
>  						F2FS_RESERVED_NODE_NUM;
> 
