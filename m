From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: put allocate_segment after refresh_sit_entry
Date: Fri, 24 Feb 2017 09:33:16 +0800
Message-ID: <00a9826a-f6a7-cba5-ba3f-e740b060e03c@huawei.com>
References: <1487667566-2110-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1487667566-2110-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, cm224.lee@samsung.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/2/21 16:59, Yunlong Song wrote:
> SIT information should be updated before segment allocation, since SSR needs
> latest valid block information. Current code does not update the old_blkaddr
> info in sit_entry, so adjust the allocate_segment to its proper location. Commit
> 5e443818fa0b2a2845561ee25bec181424fb2889 ("f2fs: handle dirty segments inside
> refresh_sit_entry") puts it into wrong location.

Not a big deal, because we only count invalid block which has been checkpointed,
so current order won't change the result of allocation with SSR.

Anyway, it's OK to me. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index df2ff5c..89052df 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1743,14 +1743,15 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  
>  	stat_inc_block_count(sbi, curseg);
>  
> -	if (!__has_curseg_space(sbi, type))
> -		sit_i->s_ops->allocate_segment(sbi, type, false);
>  	/*
>  	 * SIT information should be updated before segment allocation,
>  	 * since SSR needs latest valid block information.
>  	 */
>  	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
>  
> +	if (!__has_curseg_space(sbi, type))
> +		sit_i->s_ops->allocate_segment(sbi, type, false);
> +
>  	mutex_unlock(&sit_i->sentry_lock);
>  
>  	if (page && IS_NODESEG(type))
> 
