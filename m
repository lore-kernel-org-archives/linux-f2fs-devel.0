From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: do checkpoint when umount flag is not
	set
Date: Fri, 23 Jan 2015 18:39:25 +0800
Message-ID: <000501d036f8$f5e99660$e1bcc320$@samsung.com>
References: <1421971730-17024-1-git-send-email-jaegeuk@kernel.org>
 <1421971730-17024-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1421971730-17024-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, January 23, 2015 8:09 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/2] f2fs: do checkpoint when umount flag is not set
> 
> If the previous checkpoint was done without CP_UMOUNT flag, it needs to do
> checkpoint with CP_UMOUNT for the next fast boot.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/checkpoint.c | 3 ++-
>  fs/f2fs/super.c      | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 9f5317c..231d8c9 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1043,7 +1043,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> 
>  	mutex_lock(&sbi->cp_mutex);
> 
> -	if (!sbi->s_dirty && cpc->reason != CP_DISCARD)
> +	if (!sbi->s_dirty &&
> +			cpc->reason != CP_DISCARD && cpc->reason != CP_UMOUNT)
>  		goto out;
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		goto out;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 84f95cd..6ef1458 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -448,7 +448,8 @@ static void f2fs_put_super(struct super_block *sb)
>  	stop_gc_thread(sbi);
> 
>  	/* We don't need to do checkpoint when it's clean */

Better to update the annotation above.

Thanks,
Yu

> -	if (sbi->s_dirty) {
> +	if (sbi->s_dirty ||
> +			!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG)) {
>  		struct cp_control cpc = {
>  			.reason = CP_UMOUNT,
>  		};
> --
> 2.1.1
> 

