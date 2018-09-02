From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix unnecessary periodic wakeup of
 discard thread when dev is busy
Date: Sun, 2 Sep 2018 16:52:40 +0800
Message-ID: <ae0ec622-1fd3-d28a-019b-75a507e551f6@kernel.org>
References: <1535708366-11318-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535708366-11318-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/8/31 17:39, Sahitya Tummala wrote:
> When dev is busy, discard thread wake up timeout can be aligned with the
> exact time that it needs to wait for dev to come out of busy. This helps
> to avoid unnecessary periodic wakeups and thus save some power.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/segment.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8bcbb50..df14030 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1379,6 +1379,8 @@ static int issue_discard_thread(void *data)
>  	struct discard_policy dpolicy;
>  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
>  	int issued;
> +	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
> +	long delta;
>  
>  	set_freezable();
>  
> @@ -1410,7 +1412,11 @@ static int issue_discard_thread(void *data)
>  			__wait_all_discard_cmd(sbi, &dpolicy);
>  			wait_ms = dpolicy.min_interval;
>  		} else if (issued == -1){
> -			wait_ms = dpolicy.mid_interval;
> +			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;

I agree that we need to consider power consumption. One more consideration is
that discard thread may need different submission frequency comparing to garbage
collection thread, maybe a little fast, would it be better to split
sbi->interval_time[REQ_TIME] according to gc/discard type.

How do you think?

Thanks,

> +			if (delta > 0)
> +				wait_ms = jiffies_to_msecs(delta);
> +			else
> +				wait_ms = dpolicy.mid_interval;
>  		} else {
>  			wait_ms = dpolicy.max_interval;
>  		}
> 
