From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: give another chance to issue discard with
 current granularity
Date: Fri, 6 Jul 2018 15:49:02 -0700
Message-ID: <20180706224902.GD77984@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180705061551.2961-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705061551.2961-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/05, Chao Yu wrote:
> If discard IOs are blocked by user IO, do not skip to select and issue
> discard with lower granularity, retry with current granularity.

We need to stop as soon as possible since user activity comes. Later, discard
thread will try it again in another idle time. What's your concern?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - fix deadloop.
>  fs/f2fs/segment.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1f9ae8270f86..6e2b2e717a40 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1191,7 +1191,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  	struct discard_cmd *dc, *tmp;
>  	struct blk_plug plug;
>  	int i, iter = 0, issued = 0;
> -	bool io_interrupted = false;
> +	bool io_interrupted = false, end_up = false;
>  
>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>  		if (i + 1 < dpolicy->granularity)
> @@ -1199,6 +1199,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  		pend_list = &dcc->pend_list[i];
>  
>  		mutex_lock(&dcc->cmd_lock);
> +retry:
>  		if (list_empty(pend_list))
>  			goto next;
>  		if (unlikely(dcc->rbtree_check))
> @@ -1217,14 +1218,23 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  			__submit_discard_cmd(sbi, dpolicy, dc);
>  			issued++;
>  skip:
> -			if (++iter >= dpolicy->max_requests)
> +			if (++iter >= dpolicy->max_requests) {
> +				end_up = true;
>  				break;
> +			}
>  		}
>  		blk_finish_plug(&plug);
> +
> +		/*
> +		 * if discard IO was interrupted by user IOs, give another
> +		 * chance to issue discard with current granularity.
> +		 */
> +		if (io_interrupted && !end_up)
> +			goto retry;
>  next:
>  		mutex_unlock(&dcc->cmd_lock);
>  
> -		if (iter >= dpolicy->max_requests)
> +		if (end_up)
>  			break;
>  	}
>  
> -- 
> 2.18.0.rc1
