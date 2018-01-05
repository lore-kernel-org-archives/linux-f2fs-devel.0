From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add reserved blocks for root user
Date: Fri, 5 Jan 2018 16:04:49 +0800
Message-ID: <805948ce-6ce7-5fb3-ab8a-38494e6a6fb1@huawei.com>
References: <20180103185845.29953-1-jaegeuk@kernel.org>
 <20180103185845.29953-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103185845.29953-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: miaoxie@huawei.com, "Yuchao (T)" <yuchao0@huawei.com>, chao <chao@kernel.org>, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei <heyunlei@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net



On 2018/1/4 2:58, Jaegeuk Kim wrote:
> @@ -1590,11 +1598,17 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>   	sbi->total_valid_block_count += (block_t)(*count);
>   	avail_user_block_count = sbi->user_block_count -
>   					sbi->current_reserved_blocks;
> +
> +	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
> +		avail_user_block_count -= sbi->root_reserved_blocks;

Should better be:

+	if (test_opt(sbi, RESERVE_ROOT) && !capable(CAP_SYS_RESOURCE))
+		avail_user_block_count -= sbi->root_reserved_blocks;

> @@ -1783,9 +1797,13 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>   
>   	spin_lock(&sbi->stat_lock);
>   
> -	valid_block_count = sbi->total_valid_block_count + 1;
> -	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
> -						sbi->user_block_count)) {
> +	valid_block_count = sbi->total_valid_block_count +
> +					sbi->current_reserved_blocks + 1;
> +

> +	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
> +		valid_block_count += sbi->root_reserved_blocks;
> +
should better be:

+	if (test_opt(sbi, RESERVE_ROOT) && !capable(CAP_SYS_RESOURCE))
+		valid_block_count += sbi->root_reserved_blocks;


> +	if (unlikely(valid_block_count > sbi->user_block_count)) {
>   		spin_unlock(&sbi->stat_lock);
>   		goto enospc;
>   	}
>

-- 
Thanks,
Yunlong Song
