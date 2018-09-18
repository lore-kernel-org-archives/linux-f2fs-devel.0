From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid f2fs_bug_on if
 f2fs_get_meta_page_nofail got EIO
Date: Tue, 18 Sep 2018 21:16:02 +0800
Message-ID: <4ac0b893-7437-c5f3-e710-64156df09ced@kernel.org>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <20180918021805.85032-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918021805.85032-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/18 10:18, Jaegeuk Kim wrote:
> This patch avoids BUG_ON when f2fs_get_meta_page_nofail got EIO during
> xfstests/generic/475.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  2 +-
>  fs/f2fs/gc.c         |  2 ++
>  fs/f2fs/node.c       | 12 ++++++++++--
>  fs/f2fs/recovery.c   |  2 ++
>  fs/f2fs/segment.c    |  3 +++
>  5 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 01e0d8f5bbbe..6ce3cb6502dd 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -121,7 +121,7 @@ struct page *f2fs_get_meta_page_nofail(struct f2fs_sb_info *sbi, pgoff_t index)
>  			goto retry;
>  
>  		f2fs_stop_checkpoint(sbi, false);
> -		f2fs_bug_on(sbi, 1);
> +		return NULL;

How about propagate PTR_ERR(page) to caller?

>  	}
>  
>  	return page;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4bcc8a59fdef..d049865887cf 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1070,6 +1070,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  	/* reference all summary page */
>  	while (segno < end_segno) {
>  		sum_page = f2fs_get_sum_page(sbi, segno++);
> +		if (!sum_page)
> +			return -EIO;

Well, for large section, we need to release all referenced sum page by
f2fs_put_page().

>  		unlock_page(sum_page);
>  	}
>  
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index fa2381c0bc47..b3595522c35b 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -126,6 +126,8 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
>  
>  	/* get current nat block page with lock */
>  	src_page = get_current_nat_page(sbi, nid);
> +	if (!src_page)
> +		return NULL;
>  	dst_page = f2fs_grab_meta_page(sbi, dst_off);
>  	f2fs_bug_on(sbi, PageDirty(src_page));
>  
> @@ -2265,8 +2267,12 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
>  						nm_i->nat_block_bitmap)) {
>  			struct page *page = get_current_nat_page(sbi, nid);
>  
> -			ret = scan_nat_page(sbi, page, nid);
> -			f2fs_put_page(page, 1);
> +			if (page) {
> +				ret = scan_nat_page(sbi, page, nid);
> +				f2fs_put_page(page, 1);
> +			} else {
> +				ret = -EIO;
> +			}
>  
>  			if (ret) {
>  				up_read(&nm_i->nat_tree_lock);

Should propagate the error to f2fs_alloc_nid()?

> @@ -2724,6 +2730,8 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  		down_write(&curseg->journal_rwsem);
>  	} else {
>  		page = get_next_nat_page(sbi, start_nid);
> +		if (!page)
> +			return;

Ditto, propagate such error to write_checkpoint()?

>  		nat_blk = page_address(page);
>  		f2fs_bug_on(sbi, !nat_blk);
>  	}
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 56d34193a74b..a3dce16bfd6c 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -355,6 +355,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
>  	}
>  
>  	sum_page = f2fs_get_sum_page(sbi, segno);
> +	if (!sum_page)
> +		return -EIO;
>  	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
>  	sum = sum_node->entries[blkoff];
>  	f2fs_put_page(sum_page, 1);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index aa96a371aaf8..cfc9eb492da1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2487,6 +2487,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
>  	__next_free_blkoff(sbi, curseg, 0);
>  
>  	sum_page = f2fs_get_sum_page(sbi, new_segno);
> +	f2fs_bug_on(sbi, !sum_page);

Well, next time we may panic here...

In product, for EIO case, usually we just reboot cell phone directly to avoid
potential data loss later.

So I just set DEFAULT_RETRY_IO_COUNT to 32 temporarily to pass xfstest IO error
injection cases.

Thanks,

>  	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
>  	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
>  	f2fs_put_page(sum_page, 1);
> @@ -3971,6 +3972,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  
>  			se = &sit_i->sentries[start];
>  			page = get_current_sit_page(sbi, start);
> +			if (!page)
> +				return err;
>  			sit_blk = (struct f2fs_sit_block *)page_address(page);
>  			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
>  			f2fs_put_page(page, 1);
> 
