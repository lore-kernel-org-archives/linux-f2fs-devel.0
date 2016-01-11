From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: should unset atomic flag after successful
	commit
Date: Mon, 11 Jan 2016 15:25:11 +0800
Message-ID: <003601d14c41$4f884190$ee98c4b0$@samsung.com>
References: <1452388201-26706-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1452388201-26706-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Sunday, January 10, 2016 9:10 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH] f2fs: should unset atomic flag after successful commit
> 
> If there is an error during commit, we should keep the flag in order to
> abort it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index dfaed51..db0b2cb 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1374,10 +1374,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>  		return ret;
> 
>  	if (f2fs_is_atomic_file(inode)) {
> -		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);

It was added in 6282adbf932c ("f2fs: call set_page_dirty to attach i_wb for
cgroup ") to avoid panic in kernel with writeback supported cgroup. We
should keep it here.

>  		ret = commit_inmem_pages(inode, false);
>  		if (ret)
>  			goto err_out;
> +		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);

How about setting atomic flag if there occurs an error during committing.

Thanks,

>  	}
> 
>  	ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
> --
> 2.6.3
> 
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

