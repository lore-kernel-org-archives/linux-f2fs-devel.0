From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: wake up discard_thread iff there is a
 candidate
Date: Mon, 28 Aug 2017 17:45:15 +0800
Message-ID: <84a825c2-4630-d066-2dc2-ab2a0a8dcea6@huawei.com>
References: <20170824190312.10883-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824190312.10883-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/25 3:03, Jaegeuk Kim wrote:
> This patch fixes to avoid needless wake ups.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c |  3 +--
>  fs/f2fs/segment.h | 25 +++++++++++++++++++++++++
>  fs/f2fs/sysfs.c   |  6 +-----
>  3 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8306beace7cb..8375257b6b26 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1494,8 +1494,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		kmem_cache_free(discard_entry_slab, entry);
>  	}
>  
> -	dcc->discard_wake = 1;
> -	wake_up_interruptible_all(&dcc->discard_wait_queue);
> +	wake_up_discard_thread(sbi, false);
>  }
>  
>  static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index b9b4f85ffeb6..5099e12ee808 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -798,3 +798,28 @@ static inline long nr_pages_to_write(struct f2fs_sb_info *sbi, int type,
>  	wbc->nr_to_write = desired;
>  	return desired - nr_to_write;
>  }
> +
> +static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	bool wakeup = false> +	int i;
> +
> +	if (force)
> +		goto wake_up;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +	for (i = MAX_PLIST_NUM - 1;
> +			i >= 0 && plist_issue(dcc->pend_list_tag[i]); i--) {
> +		if (!list_empty(&dcc->pend_list[i])) {
> +			wakeup = true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&dcc->cmd_lock);
> +	if (wakeup)

if (!wakeup)

Other part looks good to me,

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> +		return;
> +wake_up:
> +	dcc->discard_wake = 1;
> +	wake_up_interruptible_all(&dcc->discard_wait_queue);
> +}
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index b9ad9041559f..962735dc9c63 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -178,13 +178,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>  	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>  		f2fs_reset_iostat(sbi);
>  	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
> -		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -
>  		sbi->gc_thread->gc_wake = 1;
>  		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
> -
> -		dcc->discard_wake = 1;
> -		wake_up_interruptible_all(&dcc->discard_wait_queue);
> +		wake_up_discard_thread(sbi, true);
>  	}
>  
>  	return count;
> 
