From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Make sanity_check_curseg static
Date: Sat, 25 May 2019 21:56:42 +0800
Message-ID: <33f73a57-285d-e37e-f911-6f3ad5cc6e01@kernel.org>
References: <20190525124809.17424-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525124809.17424-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Haibing,

Thanks for the patch, there is a similar report from 0-day project, but I forget
to fix my v1 patch.

Anyway, I prefer to merge this into original patch which has not upstreamed yet. :)

Thanks,

On 2019-5-25 20:48, YueHaibing wrote:
> Fix sparse warning:
> 
> fs/f2fs/segment.c:4246:5: warning:
>  symbol 'sanity_check_curseg' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1a83115284b9..51f57393ad5b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4243,7 +4243,7 @@ static int build_dirty_segmap(struct f2fs_sb_info *sbi)
>  	return init_victim_secmap(sbi);
>  }
>  
> -int sanity_check_curseg(struct f2fs_sb_info *sbi)
> +static int sanity_check_curseg(struct f2fs_sb_info *sbi)
>  {
>  	int i;
>  
> 
