From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: check hot_data for roll-forward recovery
Date: Tue, 15 Aug 2017 20:37:00 +0800
Message-ID: <08788823-d67f-90e0-216b-cac32cb62919@huawei.com>
References: <20170813043416.89230-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170813043416.89230-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/13 12:34, Jaegeuk Kim wrote:
> We need to check HOT_DATA to truncate any previous data block when doing
> roll-forward recovery.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/recovery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index f707d810c87d..9626758bc762 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -317,7 +317,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
>  		return 0;
>  
>  	/* Get the previous summary */
> -	for (i = CURSEG_WARM_DATA; i <= CURSEG_COLD_DATA; i++) {
> +	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
>  		struct curseg_info *curseg = CURSEG_I(sbi, i);
>  		if (curseg->segno == segno) {
>  			sum = curseg->sum_blk->entries[blkoff];
> 
