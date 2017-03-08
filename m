From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: remove the redundant cur_victim_sec /
 sec_usage_check()
Date: Wed, 8 Mar 2017 20:37:12 +0800
Message-ID: <4ffbde45-c544-4264-c76f-16dae1ea1959@huawei.com>
References: <9047C53C18267742AB12E43B65C7F9F70B16AE08@SZXEMI502-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1claqV-0004tQ-Gb
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:37:35 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1claqS-00028g-MN
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:37:35 +0000
In-Reply-To: <9047C53C18267742AB12E43B65C7F9F70B16AE08@SZXEMI502-MBS.china.huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "gaoxiang (P)" <gaoxiang25@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: Zhouxiyu <zhouxiyu@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 2017/3/7 19:06, gaoxiang (P) wrote:
> It seems that cur_victim_sec is useless and hard for us to understand its meaning now.
> This patch removes cur_victim_sec variable / sec_usage_check() and
> renames confusing victim_secmap to bg_victim_secmap.

IIRC, cur_victim_sec is used for avoiding that one victim being selected as
target by both SSR allocator and foreground GC.

Thanks,

> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  fs/f2fs/f2fs.h              |  1 -
>  fs/f2fs/gc.c                | 28 +++++++++++++---------------
>  fs/f2fs/segment.c           | 16 ++++++++--------
>  fs/f2fs/segment.h           |  9 +--------
>  fs/f2fs/super.c             |  1 -
>  include/trace/events/f2fs.h | 12 ++++++------
>  6 files changed, 28 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7e29249..d01af23 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -890,7 +890,6 @@ struct f2fs_sb_info {
>  	/* for cleaning operations */
>  	struct mutex gc_mutex;			/* mutex for GC */
>  	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
> -	unsigned int cur_victim_sec;		/* current victim section num */
>  
>  	/* threshold for converting bg victims for fg */
>  	u64 fggc_threshold;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 418fd98..7b37b77 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -199,14 +199,15 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
>  	 * selected by background GC before.
>  	 * Those segments guarantee they have small valid blocks.
>  	 */
> -	for_each_set_bit(secno, dirty_i->victim_secmap, MAIN_SECS(sbi)) {
> -		if (sec_usage_check(sbi, secno))
> +	for_each_set_bit(secno, dirty_i->bg_victim_secmap, MAIN_SECS(sbi)) {
> +		if (no_fggc_candidate(sbi, secno))
>  			continue;
>  
> -		if (no_fggc_candidate(sbi, secno))
> +		clear_bit(secno, dirty_i->bg_victim_secmap);
> +
> +		if (unlikely(IS_CURSEC(sbi, secno)))
>  			continue;
>  
> -		clear_bit(secno, dirty_i->victim_secmap);
>  		return secno * sbi->segs_per_sec;
>  	}
>  	return NULL_SEGNO;
> @@ -341,9 +342,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  
>  		secno = GET_SECNO(sbi, segno);
>  
> -		if (sec_usage_check(sbi, secno))
> +		if (IS_CURSEC(sbi, secno))
>  			goto next;
> -		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
> +		if (gc_type == BG_GC && test_bit(secno, dirty_i->bg_victim_secmap))
>  			goto next;
>  		if (gc_type == FG_GC && p.alloc_mode == LFS &&
>  					no_fggc_candidate(sbi, secno))
> @@ -366,17 +367,17 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  	}
>  	if (p.min_segno != NULL_SEGNO) {
>  got_it:
> +		secno = GET_SECNO(sbi, p.min_segno);
> +		clear_bit(secno, dirty_i->bg_victim_secmap);
> +
>  		if (p.alloc_mode == LFS) {
> -			secno = GET_SECNO(sbi, p.min_segno);
> -			if (gc_type == FG_GC)
> -				sbi->cur_victim_sec = secno;
> -			else
> -				set_bit(secno, dirty_i->victim_secmap);
> +			if (gc_type != FG_GC)
> +				set_bit(secno, dirty_i->bg_victim_secmap);
>  		}
>  		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
>  
>  		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
> -				sbi->cur_victim_sec,
> +				last_victim,
>  				prefree_segments(sbi), free_segments(sbi));
>  	}
>  out:
> @@ -977,9 +978,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
>  			gc_type == FG_GC)
>  		sec_freed++;
>  
> -	if (gc_type == FG_GC)
> -		sbi->cur_victim_sec = NULL_SEGNO;
> -
>  	if (!sync) {
>  		if (has_not_enough_free_secs(sbi, sec_freed, 0))
>  			goto gc_more;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4bd7a8b..95bf8bf 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -599,7 +599,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>  
>  		if (get_valid_blocks(sbi, segno, sbi->segs_per_sec) == 0)
>  			clear_bit(GET_SECNO(sbi, segno),
> -						dirty_i->victim_secmap);
> +						dirty_i->bg_victim_secmap);
>  	}
>  }
>  
> @@ -2753,13 +2753,13 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
>  	}
>  }
>  
> -static int init_victim_secmap(struct f2fs_sb_info *sbi)
> +static int init_bg_victim_secmap(struct f2fs_sb_info *sbi)
>  {
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  	unsigned int bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
>  
> -	dirty_i->victim_secmap = f2fs_kvzalloc(bitmap_size, GFP_KERNEL);
> -	if (!dirty_i->victim_secmap)
> +	dirty_i->bg_victim_secmap = f2fs_kvzalloc(bitmap_size, GFP_KERNEL);
> +	if (!dirty_i->bg_victim_secmap)
>  		return -ENOMEM;
>  	return 0;
>  }
> @@ -2786,7 +2786,7 @@ static int build_dirty_segmap(struct f2fs_sb_info *sbi)
>  	}
>  
>  	init_dirty_segmap(sbi);
> -	return init_victim_secmap(sbi);
> +	return init_bg_victim_secmap(sbi);
>  }
>  
>  /*
> @@ -2894,10 +2894,10 @@ static void discard_dirty_segmap(struct f2fs_sb_info *sbi,
>  	mutex_unlock(&dirty_i->seglist_lock);
>  }
>  
> -static void destroy_victim_secmap(struct f2fs_sb_info *sbi)
> +static void destroy_bg_victim_secmap(struct f2fs_sb_info *sbi)
>  {
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> -	kvfree(dirty_i->victim_secmap);
> +	kvfree(dirty_i->bg_victim_secmap);
>  }
>  
>  static void destroy_dirty_segmap(struct f2fs_sb_info *sbi)
> @@ -2912,7 +2912,7 @@ static void destroy_dirty_segmap(struct f2fs_sb_info *sbi)
>  	for (i = 0; i < NR_DIRTY_TYPE; i++)
>  		discard_dirty_segmap(sbi, i);
>  
> -	destroy_victim_secmap(sbi);
> +	destroy_bg_victim_secmap(sbi);
>  	SM_I(sbi)->dirty_info = NULL;
>  	kfree(dirty_i);
>  }
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 5e8ad42..c52423b 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -256,7 +256,7 @@ struct dirty_seglist_info {
>  	unsigned long *dirty_segmap[NR_DIRTY_TYPE];
>  	struct mutex seglist_lock;		/* lock for segment bitmaps */
>  	int nr_dirty[NR_DIRTY_TYPE];		/* # of dirty segments */
> -	unsigned long *victim_secmap;		/* background GC victims */
> +	unsigned long *bg_victim_secmap;	/* background GC victims */
>  };
>  
>  /* victim selection function for cleaning and SSR */
> @@ -725,13 +725,6 @@ static inline bool no_fggc_candidate(struct f2fs_sb_info *sbi,
>  	return false;
>  }
>  
> -static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
> -{
> -	if (IS_CURSEC(sbi, secno) || (sbi->cur_victim_sec == secno))
> -		return true;
> -	return false;
> -}
> -
>  /*
>   * It is very important to gather dirty pages and write at once, so that we can
>   * submit a big bio without interfering other data writes.
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2d494d5..570d44d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1550,7 +1550,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->root_ino_num = le32_to_cpu(raw_super->root_ino);
>  	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
>  	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
> -	sbi->cur_victim_sec = NULL_SECNO;
>  	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
>  
>  	sbi->dir_level = DEF_DIR_LEVEL;
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index c80fcad0..ae81fe8 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -560,10 +560,10 @@ TRACE_EVENT(f2fs_background_gc,
>  TRACE_EVENT(f2fs_get_victim,
>  
>  	TP_PROTO(struct super_block *sb, int type, int gc_type,
> -			struct victim_sel_policy *p, unsigned int pre_victim,
> +			struct victim_sel_policy *p, unsigned int last_victim,
>  			unsigned int prefree, unsigned int free),
>  
> -	TP_ARGS(sb, type, gc_type, p, pre_victim, prefree, free),
> +	TP_ARGS(sb, type, gc_type, p, last_victim, prefree, free),
>  
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
> @@ -574,7 +574,7 @@ TRACE_EVENT(f2fs_get_victim,
>  		__field(unsigned int,	victim)
>  		__field(unsigned int,	cost)
>  		__field(unsigned int,	ofs_unit)
> -		__field(unsigned int,	pre_victim)
> +		__field(unsigned int,	last_victim)
>  		__field(unsigned int,	prefree)
>  		__field(unsigned int,	free)
>  	),
> @@ -588,14 +588,14 @@ TRACE_EVENT(f2fs_get_victim,
>  		__entry->victim		= p->min_segno;
>  		__entry->cost		= p->min_cost;
>  		__entry->ofs_unit	= p->ofs_unit;
> -		__entry->pre_victim	= pre_victim;
> +		__entry->last_victim	= last_victim;
>  		__entry->prefree	= prefree;
>  		__entry->free		= free;
>  	),
>  
>  	TP_printk("dev = (%d,%d), type = %s, policy = (%s, %s, %s), "
>  		"victim = %u, cost = %u, ofs_unit = %u, "
> -		"pre_victim_secno = %d, prefree = %u, free = %u",
> +		"last_victim_secno = %u, prefree = %u, free = %u",
>  		show_dev(__entry->dev),
>  		show_data_type(__entry->type),
>  		show_gc_type(__entry->gc_type),
> @@ -604,7 +604,7 @@ TRACE_EVENT(f2fs_get_victim,
>  		__entry->victim,
>  		__entry->cost,
>  		__entry->ofs_unit,
> -		(int)__entry->pre_victim,
> +		__entry->last_victim,
>  		__entry->prefree,
>  		__entry->free)
>  );
> 


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
