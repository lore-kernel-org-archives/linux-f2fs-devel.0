From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: avoid f2fs_gc dead loop
Date: Mon, 25 Dec 2017 11:44:36 +0800
Message-ID: <4202ea25-f40a-a4da-787b-86f5aa9b0311@huawei.com>
References: <1514034550-149813-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514034550-149813-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/23 21:09, Yunlong Song wrote:
> For some corner case, f2fs_gc selects one target victim but cannot free
> that victim segment due to some reason (e.g. the segment has some blocks
> of atomic file which is not commited yet), in this case, the victim

File should not be atomic opened for long time since normally sqlite
transaction will finish quickly, so we can expect that gc loop could be
ended up soon, right?

Thanks,

> segment may probably be selected over and over, and then f2fs_gc will
> go to dead loop. This patch identifies the dead-loop segment, and skips
> it in __get_victim next time.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/f2fs.h  |  8 ++++++++
>  fs/f2fs/gc.c    | 34 ++++++++++++++++++++++++++++++++++
>  fs/f2fs/super.c |  3 +++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ca6b0c9..b75851b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -115,6 +115,13 @@ struct f2fs_mount_info {
>  	unsigned int	opt;
>  };
>  
> +struct gc_loop_info {
> +	int count;
> +	unsigned int segno;
> +	unsigned long *segmap;
> +};
> +#define GC_LOOP_MAX 10
> +
>  #define F2FS_FEATURE_ENCRYPT		0x0001
>  #define F2FS_FEATURE_BLKZONED		0x0002
>  #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
> @@ -1125,6 +1132,7 @@ struct f2fs_sb_info {
>  
>  	/* threshold for converting bg victims for fg */
>  	u64 fggc_threshold;
> +	struct gc_loop_info gc_loop;
>  
>  	/* maximum # of trials to find a victim segment for SSR and GC */
>  	unsigned int max_victim_search;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5d5bba4..4ee9e1b 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -229,6 +229,10 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
>  		if (no_fggc_candidate(sbi, secno))
>  			continue;
>  
> +		if (sbi->gc_loop.segmap &&
> +			test_bit(GET_SEG_FROM_SEC(sbi, secno), sbi->gc_loop.segmap))
> +			continue;
> +
>  		clear_bit(secno, dirty_i->victim_secmap);
>  		return GET_SEG_FROM_SEC(sbi, secno);
>  	}
> @@ -371,6 +375,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  		if (gc_type == FG_GC && p.alloc_mode == LFS &&
>  					no_fggc_candidate(sbi, secno))
>  			goto next;
> +		if (gc_type == FG_GC && p.alloc_mode == LFS &&
> +			sbi->gc_loop.segmap && test_bit(segno, sbi->gc_loop.segmap))
> +			goto next;
>  
>  		cost = get_gc_cost(sbi, segno, &p);
>  
> @@ -1042,6 +1049,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type);
>  	if (gc_type == FG_GC && seg_freed == sbi->segs_per_sec)
>  		sec_freed++;
> +	else if (gc_type == FG_GC && seg_freed == 0) {
> +		if (!sbi->gc_loop.segmap) {
> +			sbi->gc_loop.segmap =
> +				kvzalloc(f2fs_bitmap_size(MAIN_SEGS(sbi)), GFP_KERNEL);
> +			sbi->gc_loop.count = 0;
> +			sbi->gc_loop.segno = NULL_SEGNO;
> +		}
> +		if (segno == sbi->gc_loop.segno) {
> +			if (sbi->gc_loop.count > GC_LOOP_MAX) {
> +				f2fs_bug_on(sbi, 1);
> +				set_bit(segno, sbi->gc_loop.segmap);
> +				sbi->gc_loop.count = 0;
> +				sbi->gc_loop.segno = NULL_SEGNO;
> +			}
> +			else
> +				sbi->gc_loop.count++;
> +		} else {
> +			sbi->gc_loop.segno = segno;
> +			sbi->gc_loop.count = 0;
> +		}
> +	}
>  	total_freed += seg_freed;
>  
>  	if (gc_type == FG_GC)
> @@ -1075,6 +1103,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  
>  	if (sync)
>  		ret = sec_freed ? 0 : -EAGAIN;
> +	if (sbi->gc_loop.segmap) {
> +		kvfree(sbi->gc_loop.segmap);
> +		sbi->gc_loop.segmap = NULL;
> +		sbi->gc_loop.count = 0;
> +		sbi->gc_loop.segno = NULL_SEGNO;
> +	}
>  	return ret;
>  }
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 031cb26..76f0b72 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2562,6 +2562,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->last_valid_block_count = sbi->total_valid_block_count;
>  	sbi->reserved_blocks = 0;
>  	sbi->current_reserved_blocks = 0;
> +	sbi->gc_loop.segmap = NULL;
> +	sbi->gc_loop.count = 0;
> +	sbi->gc_loop.segno = NULL_SEGNO;
>  
>  	for (i = 0; i < NR_INODE_TYPE; i++) {
>  		INIT_LIST_HEAD(&sbi->inode_list[i]);
> 
