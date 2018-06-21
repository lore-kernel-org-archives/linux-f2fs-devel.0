From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: disable f2fs_check_rb_tree_consistence
Date: Thu, 21 Jun 2018 12:03:05 -0700
Message-ID: <20180621190305.GB77164@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180621033936.108796-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621033936.108796-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Yunlei He <heyunlei@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 06/21, Chao Yu wrote:
> If there is millions of discard entries cached in rb tree, each
> sanity check of it can cause very long latency as held cmd_lock
> blocking other lock grabbers.
> 
> In other aspect, we have enabled the check very long time, as
> we see, there is no such inconsistent condition caused by bugs.
> 
> But still we do not choose to kill it directly, instead, adding
> an flag to disable the check now, if there is related code change,
> we can reuse it to detect bugs.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 49c687173923..412e907920c2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -309,6 +309,7 @@ struct discard_cmd_control {
>  	atomic_t issing_discard;		/* # of issing discard */
>  	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
>  	struct rb_root root;			/* root of discard rb-tree */
> +	bool rbtree_check;			/* config for consistence check */
>  };
>  
>  /* for the list of fsync inodes, used only during recovery */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6dbdf2c48fba..8c1d6c546fa0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1199,8 +1199,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  		mutex_lock(&dcc->cmd_lock);
>  		if (list_empty(pend_list))
>  			goto next;
> -		f2fs_bug_on(sbi,
> -			!f2fs_check_rb_tree_consistence(sbi, &dcc->root));
> +		if (dcc->rbtree_check)

		unlikely()?

> +			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
> +								&dcc->root));
>  		blk_start_plug(&plug);
>  		list_for_each_entry_safe(dc, tmp, pend_list, list) {
>  			f2fs_bug_on(sbi, dc->state != D_PREP);
> @@ -1752,6 +1753,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>  	dcc->undiscard_blks = 0;
>  	dcc->root = RB_ROOT;
> +	dcc->rbtree_check = false;
>  
>  	init_waitqueue_head(&dcc->discard_wait_queue);
>  	SM_I(sbi)->dcc_info = dcc;
> @@ -2381,7 +2383,9 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
>  	issued = 0;
>  
>  	mutex_lock(&dcc->cmd_lock);
> -	f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi, &dcc->root));
> +	if (dcc->rbtree_check)

		unlikely()?

> +		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
> +								&dcc->root));
>  
>  	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
>  					NULL, start,
> -- 
> 2.18.0.rc1
