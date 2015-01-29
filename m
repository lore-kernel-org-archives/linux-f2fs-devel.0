From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 4/5] f2fs: should fail mount when trying to recover data on
 read-only dev
Date: Thu, 29 Jan 2015 20:16:38 +0800
Message-ID: <002d01d03bbd$8b533c10$a1f9b430$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1422401503-4769-4-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: linux-fsdevel-owner@vger.kernel.org [mailto:linux-fsdevel-owner@vger.kernel.org] On
> Behalf Of Jaegeuk Kim
> Sent: Wednesday, January 28, 2015 7:32 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [PATCH 4/5] f2fs: should fail mount when trying to recover data on read-only dev
> 
> If device is read-only, we should not proceed data recovery.
> But, if the previous checkpoint was done by normal clean shutdown, it's safe to
> proceed the recovery, since there will be no data to be recovered.

Now, with 'fastboot' option, f2fs will write cp with CP_UMOUNT_FLAG, but we count not
guarantee there is no abnormally power cut after data fsynced.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0ca1fb2..7039969 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1149,6 +1149,15 @@ try_onemore:
> 
>  	/* recover fsynced data */
>  	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
> +		/*
> +		 * mount should be failed, when device has readonly mode, and
> +		 * previous checkpoint was not done by clean system shutdown.
> +		 */
> +		if (bdev_read_only(sb->s_bdev) &&
> +				!is_set_ckpt_flags(sbi->ckpt, CP_UMOUNT_FLAG)) {
> +			err = -EROFS;
> +			goto free_kobj;
> +		}
>  		err = recover_fsync_data(sbi);
>  		if (err) {
>  			f2fs_msg(sb, KERN_ERR,
> --
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
