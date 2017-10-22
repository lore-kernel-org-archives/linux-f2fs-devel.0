From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: retry ENOMEM for quota_read|write
Date: Sun, 22 Oct 2017 23:02:18 +0800
Message-ID: <3000c803-d3a4-209f-d1eb-88bc61bd316b@kernel.org>
References: <20171019165617.79128-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019165617.79128-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/20 0:56, Jaegeuk Kim wrote:
> This gives another chance to read or write quota data.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/super.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fc3b74e53670..2c6e9adce464 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1351,8 +1351,13 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>  		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
>  repeat:
>  		page = read_mapping_page(mapping, blkidx, NULL);
> -		if (IS_ERR(page))
> +		if (IS_ERR(page)) {
> +			if (PTR_ERR(page) == -ENOMEM) {
> +				congestion_wait(BLK_RW_ASYNC, HZ/50);
> +				goto repeat;
> +			}
>  			return PTR_ERR(page);
> +		}
>  
>  		lock_page(page);
>  
> @@ -1395,10 +1400,14 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
>  	while (towrite > 0) {
>  		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
>  								towrite);
> -
> +retry:
>  		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
>  							&page, NULL);
>  		if (unlikely(err)) {
> +			if (err == -ENOMEM) {
> +				congestion_wait(BLK_RW_ASYNC, HZ/50);
> +				goto retry;
> +			}
>  			if (len == towrite)
>  				return err;
>  			break;
> 
