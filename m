From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid false positive of free secs check
Date: Wed, 29 Nov 2017 19:56:35 +0800
Message-ID: <ee9ea493-1c61-2b19-f2ea-ec9278ae6543@kernel.org>
References: <1511765699-47553-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511765699-47553-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/11/27 14:54, Yunlong Song wrote:
> Sometimes f2fs_gc is called with no target victim (e.g. xfstest
> generic/027, ndirty_node:545 ndiry_dent:1 ndirty_imeta:513 rsvd_segs:21
> free_segs:27, has_not_enough_free_secs will return true). This patch
> first merges pages and then converts into sections.

I don't think this could be right, IMO, instead, it would be better to
account dirty hot/warm/cold nodes or imeta separately, as actually, they
will use different section, but currently, our calculation way is based
on that they could be written to same section.

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/f2fs.h    |  9 ---------
>  fs/f2fs/segment.c | 12 +++++++-----
>  fs/f2fs/segment.h | 13 +++++++++----
>  3 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ca6b0c9..e89cff7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1675,15 +1675,6 @@ static inline int get_dirty_pages(struct inode *inode)
>  	return atomic_read(&F2FS_I(inode)->dirty_pages);
>  }
>  
> -static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
> -{
> -	unsigned int pages_per_sec = sbi->segs_per_sec * sbi->blocks_per_seg;
> -	unsigned int segs = (get_pages(sbi, block_type) + pages_per_sec - 1) >>
> -						sbi->log_blocks_per_seg;
> -
> -	return segs / sbi->segs_per_sec;
> -}
> -
>  static inline block_t valid_user_blocks(struct f2fs_sb_info *sbi)
>  {
>  	return sbi->total_valid_block_count;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c117e09..603f805 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -171,17 +171,19 @@ static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
>  
>  bool need_SSR(struct f2fs_sb_info *sbi)
>  {
> -	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
> -	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> -	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> +	s64 node_pages = get_pages(sbi, F2FS_DIRTY_NODES);
> +	s64 dent_pages = get_pages(sbi, F2FS_DIRTY_DENTS);
> +	s64 imeta_pages = get_pages(sbi, F2FS_DIRTY_IMETA);
>  
>  	if (test_opt(sbi, LFS))
>  		return false;
>  	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
>  		return true;
>  
> -	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
> -			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
> +	return free_sections(sbi) <=
> +		(PAGE2SEC(sbi, node_pages + imeta_pages) +
> +		PAGE2SEC(sbi, 2 * dent_pages) +
> +		SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
>  }
>  
>  void register_inmem_page(struct inode *inode, struct page *page)
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index d1d394c..723d79e 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -115,6 +115,10 @@
>  #define SECTOR_TO_BLOCK(sectors)					\
>  	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
>  
> +#define PAGE2SEC(sbi, pages)				\
> +	((((pages) + BLKS_PER_SEC(sbi) - 1)		\
> +	>> sbi->log_blocks_per_seg) / sbi->segs_per_sec)
> +
>  /*
>   * indicate a block allocation direction: RIGHT and LEFT.
>   * RIGHT means allocating new sections towards the end of volume.
> @@ -527,9 +531,9 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi)
>  static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>  					int freed, int needed)
>  {
> -	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
> -	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> -	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> +	s64 node_pages = get_pages(sbi, F2FS_DIRTY_NODES);
> +	s64 dent_pages = get_pages(sbi, F2FS_DIRTY_DENTS);
> +	s64 imeta_pages = get_pages(sbi, F2FS_DIRTY_IMETA);
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		return false;
> @@ -538,7 +542,8 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>  			has_curseg_enough_space(sbi))
>  		return false;
>  	return (free_sections(sbi) + freed) <=
> -		(node_secs + 2 * dent_secs + imeta_secs +
> +		(PAGE2SEC(sbi, node_pages + imeta_pages) +
> +		PAGE2SEC(sbi, 2 * dent_pages) +
>  		reserved_sections(sbi) + needed);
>  }
>  
> 
