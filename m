From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: clean up codes in get_ssr_segment
Date: Wed, 22 Feb 2017 16:41:14 -0800
Message-ID: <20170223004114.GF4003@jaegeuk.local>
References: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

This is NOT clean-up. What's your point here?

Thanks,

On 02/22, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index df2ff5c..80997f5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1541,7 +1541,7 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
>  	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
>  
> -	if (IS_NODESEG(type) || !has_not_enough_free_secs(sbi, 0, 0))
> +	if (IS_NODESEG(type))
>  		return v_ops->get_victim(sbi,
>  				&(curseg)->next_segno, BG_GC, type, SSR);
>  
> -- 
> 1.8.5.2
