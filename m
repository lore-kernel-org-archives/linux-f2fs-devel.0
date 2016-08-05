From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: do not use discard_map for non-discard case
Date: Fri, 5 Aug 2016 17:38:25 +0800
Message-ID: <f1f77f9c-0b2f-f0eb-3c5d-bb1a206d0895@huawei.com>
References: <20160804190438.14878-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804190438.14878-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/8/5 3:04, Jaegeuk Kim wrote:
> We don't need to keep discard_map, if f2fs has no discard mount option.

In trim_fs path, we will still use discard_map though, right?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |  2 ++
>  fs/f2fs/segment.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++---------
>  fs/f2fs/super.c   | 10 +++++++
>  3 files changed, 86 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 61cb83d..a400715 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2036,6 +2036,8 @@ int lookup_journal_in_cursum(struct f2fs_journal *, int, unsigned int, int);
>  void flush_sit_entries(struct f2fs_sb_info *, struct cp_control *);
>  int build_segment_manager(struct f2fs_sb_info *);
>  void destroy_segment_manager(struct f2fs_sb_info *);
> +int build_discard_map(struct f2fs_sb_info *);
> +void destroy_discard_map(struct f2fs_sb_info *);
>  int __init create_segment_manager_caches(void);
>  void destroy_segment_manager_caches(void);
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a46296f..66822d3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -660,11 +660,11 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	bool force = (cpc->reason == CP_DISCARD);
>  	int i;
>  
> -	if (se->valid_blocks == max_blocks)
> +	if (se->valid_blocks == max_blocks || !test_opt(sbi, DISCARD))
>  		return;
>  
>  	if (!force) {
> -		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
> +		if (!se->valid_blocks ||
>  		    SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards)
>  			return;
>  	}
> @@ -818,12 +818,14 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  	if (del > 0) {
>  		if (f2fs_test_and_set_bit(offset, se->cur_valid_map))
>  			f2fs_bug_on(sbi, 1);
> -		if (!f2fs_test_and_set_bit(offset, se->discard_map))
> +		if (test_opt(sbi, DISCARD) &&
> +			!f2fs_test_and_set_bit(offset, se->discard_map))
>  			sbi->discard_blks--;
>  	} else {
>  		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map))
>  			f2fs_bug_on(sbi, 1);
> -		if (f2fs_test_and_clear_bit(offset, se->discard_map))
> +		if (test_opt(sbi, DISCARD) &&
> +			f2fs_test_and_clear_bit(offset, se->discard_map))
>  			sbi->discard_blks++;
>  	}
>  	if (!f2fs_test_bit(offset, se->ckpt_valid_map))
> @@ -2096,6 +2098,55 @@ out:
>  	set_prefree_as_free_segments(sbi);
>  }
>  
> +static int __init_discard_map(struct f2fs_sb_info *sbi)
> +{
> +	struct sit_info *sit_i;
> +	unsigned int start;
> +
> +	if (!test_opt(sbi, DISCARD))
> +		return 0;
> +
> +	sit_i = SIT_I(sbi);
> +
> +	for (start = 0; start < MAIN_SEGS(sbi); start++) {
> +		sit_i->sentries[start].discard_map
> +				= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> +		if (!sit_i->sentries[start].discard_map)
> +			return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static void __build_discard_map(struct f2fs_sb_info *sbi)
> +{
> +	struct sit_info *sit_i;
> +	unsigned int start;
> +
> +	if (!test_opt(sbi, DISCARD))
> +		return;
> +
> +	sit_i = SIT_I(sbi);
> +
> +	for (start = 0; start < MAIN_SEGS(sbi); start++) {
> +		struct seg_entry *se = &sit_i->sentries[start];
> +
> +		memcpy(se->discard_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
> +		sbi->discard_blks += sbi->blocks_per_seg - se->valid_blocks;
> +	}
> +}
> +
> +int build_discard_map(struct f2fs_sb_info *sbi)
> +{
> +	int err;
> +
> +	err = __init_discard_map(sbi);
> +	if (err)
> +		return err;
> +
> +	__build_discard_map(sbi);
> +	return 0;
> +}
> +
>  static int build_sit_info(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
> @@ -2127,14 +2178,14 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
>  		sit_i->sentries[start].ckpt_valid_map
>  			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> -		sit_i->sentries[start].discard_map
> -			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
>  		if (!sit_i->sentries[start].cur_valid_map ||
> -				!sit_i->sentries[start].ckpt_valid_map ||
> -				!sit_i->sentries[start].discard_map)
> +				!sit_i->sentries[start].ckpt_valid_map)
>  			return -ENOMEM;
>  	}
>  
> +	if (__init_discard_map(sbi))
> +		return -ENOMEM;
> +
>  	sit_i->tmp_map = kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
>  	if (!sit_i->tmp_map)
>  		return -ENOMEM;
> @@ -2275,10 +2326,6 @@ got_it:
>  			check_block_count(sbi, start, &sit);
>  			seg_info_from_raw_sit(se, &sit);
>  
> -			/* build discard map only one time */
> -			memcpy(se->discard_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
> -			sbi->discard_blks += sbi->blocks_per_seg - se->valid_blocks;
> -
>  			if (sbi->segs_per_sec > 1) {
>  				struct sec_entry *e = get_sec_entry(sbi, start);
>  				e->valid_blocks += se->valid_blocks;
> @@ -2286,6 +2333,9 @@ got_it:
>  		}
>  		start_blk += readed;
>  	} while (start_blk < sit_blk_cnt);
> +
> +	/* build discard map only one time */
> +	__build_discard_map(sbi);
>  }
>  
>  static void init_free_segmap(struct f2fs_sb_info *sbi)
> @@ -2522,6 +2572,17 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
>  	kfree(free_i);
>  }
>  
> +void destroy_discard_map(struct f2fs_sb_info *sbi)
> +{
> +	struct sit_info *sit_i = SIT_I(sbi);
> +	unsigned int start;
> +
> +	for (start = 0; start < MAIN_SEGS(sbi); start++) {
> +		kfree(sit_i->sentries[start].discard_map);
> +		sit_i->sentries[start].discard_map = NULL;
> +	}
> +}
> +
>  static void destroy_sit_info(struct f2fs_sb_info *sbi)
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
> @@ -2534,8 +2595,8 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
>  		for (start = 0; start < MAIN_SEGS(sbi); start++) {
>  			kfree(sit_i->sentries[start].cur_valid_map);
>  			kfree(sit_i->sentries[start].ckpt_valid_map);
> -			kfree(sit_i->sentries[start].discard_map);
>  		}
> +		destroy_discard_map(sbi);
>  	}
>  	kfree(sit_i->tmp_map);
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7f863a6..eec5c95 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1001,6 +1001,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  	bool need_restart_gc = false;
>  	bool need_stop_gc = false;
>  	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
> +	bool no_discard = !test_opt(sbi, DISCARD);
>  
>  	/*
>  	 * Save the old mount options in case we
> @@ -1079,6 +1080,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  		if (err)
>  			goto restore_gc;
>  	}
> +
> +	/* initialize discard map structure */
> +	if (no_discard && test_opt(sbi, DISCARD)) {
> +		err = build_discard_map(sbi);
> +		if (err)
> +			goto restore_gc;
> +	} else if (!no_discard && !test_opt(sbi, DISCARD)) {
> +		destroy_discard_map(sbi);
> +	}
>  skip:
>  	/* Update the POSIXACL Flag */
>  	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
> 
