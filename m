From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not change the valid_block value if
 cur_valid_map was wrongly set or cleared
Date: Sat, 5 Aug 2017 09:23:48 +0800
Message-ID: <421ee9e7-89af-d414-9b12-7bc47dc7bc69@kernel.org>
References: <1501680013-48861-1-git-send-email-yunlong.song@huawei.com>
 <1501683414-54834-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1501683414-54834-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/2 22:16, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/segment.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 40e40c5..9e3249a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1540,6 +1540,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  			f2fs_msg(sbi->sb, KERN_ERR,
>  				"Bitmap was wrongly set, blk:%u", blkaddr);
>  			f2fs_bug_on(sbi, 1);
> +			se->valid_blocks--;
> +			del = 0;
>  		}
>  
>  		if (f2fs_discard_en(sbi) &&
> @@ -1567,6 +1569,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  			f2fs_msg(sbi->sb, KERN_ERR,
>  				"Bitmap was wrongly cleared, blk:%u", blkaddr);
>  			f2fs_bug_on(sbi, 1);
> +			se->valid_blocks++;
> +			del = 0;
>  		}
>  
>  		if (f2fs_discard_en(sbi) &&
> 
