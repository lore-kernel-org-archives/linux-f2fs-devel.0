From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Date: Wed, 13 Feb 2019 11:42:23 +0800
Message-ID: <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212023343.52215-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/2/12 10:33, Jaegeuk Kim wrote:
> If we met this once, let fsck.f2fs clear this only.
> Note that, this addresses all the subtle fault injection test.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 03fea4efd64b..10a3ada28715 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> -	else
> -		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);

I didn't get it, previously, if we didn't persist all quota file's data in
checkpoint, then we will tag CP_QUOTA_NEED_FSCK_FLAG in CP area, but in current
checkpoint, we have persisted all quota file's data, quota files are consistent
with all other files in filesystem, why we can't remove this NEED_FSCK flag..?

Thanks,

>  
>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 
