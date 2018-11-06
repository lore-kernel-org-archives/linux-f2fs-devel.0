From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: stop discard thread during fstrim
Date: Tue, 6 Nov 2018 17:29:52 +0800
Message-ID: <063c9ec6-5324-9209-17a7-b1f72ccfb9ee@huawei.com>
References: <1541477338-638-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gJxgj-0003i6-Hq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Nov 2018 09:30:21 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gJxgW-002UPH-A0
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Nov 2018 09:30:21 +0000
In-Reply-To: <1541477338-638-1-git-send-email-heyunlei@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/11/6 12:08, Yunlei He wrote:
> Now, discard thread will issue discards in parallel with fstrim,
> which will cause problem as below:
> i.  maybe too many discards commands at some point
> ii. disturb the order of block address, which is continuous in fstrim

I'm not strongly against this patch, but one potential issue I can image is:
If fstrim is called from userspace periodically with large granularity, it
can cause kernel discard thread always skip issuing small granularity
discard, result in bad performance due to too many invalid mapping in
device. Not sure, it may create a chance for hacker to use this to trigger
a Dos attack on f2fs.

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/f2fs.h    | 1 +
>  fs/f2fs/segment.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 56204a8..fec596d2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -330,6 +330,7 @@ struct discard_cmd_control {
>  	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
>  	struct rb_root_cached root;		/* root of discard rb-tree */
>  	bool rbtree_check;			/* config for consistence check */
> +	atomic_t in_fstrim_cnt;			/* # of fstrim in progress */
>  };
>  
>  /* for the list of fsync inodes, used only during recovery */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6edcf83..cea1d27 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1655,7 +1655,8 @@ static int issue_discard_thread(void *data)
>  			continue;
>  		if (kthread_should_stop())
>  			return 0;
> -		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> +		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)
> +					|| atomic_read(&dcc->in_fstrim_cnt)) {
>  			wait_ms = dpolicy.max_interval;
>  			continue;
>  		}
> @@ -1996,6 +1997,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	atomic_set(&dcc->issued_discard, 0);
>  	atomic_set(&dcc->issing_discard, 0);
>  	atomic_set(&dcc->discard_cmd_cnt, 0);
> +	atomic_set(&dcc->in_fstrim_cnt, 0);
>  	dcc->nr_discards = 0;
>  	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>  	dcc->undiscard_blks = 0;
> @@ -2720,6 +2722,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>  	block_t start_block, end_block;
>  	struct cp_control cpc;
>  	struct discard_policy dpolicy;
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	unsigned long long trimmed = 0;
>  	int err = 0;
>  	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;
> @@ -2772,11 +2775,13 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>  	end_block = START_BLOCK(sbi, end_segno + 1);
>  
>  	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
> +	atomic_inc(&dcc->in_fstrim_cnt);
>  	trimmed = __issue_discard_cmd_range(sbi, &dpolicy,
>  					start_block, end_block);
>  
>  	trimmed += __wait_discard_cmd_range(sbi, &dpolicy,
>  					start_block, end_block);
> +	atomic_dec(&dcc->in_fstrim_cnt);
>  out:
>  	if (!err)
>  		range->len = F2FS_BLK_TO_BYTES(trimmed);
> 
