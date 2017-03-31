From: heyunlei <heyunlei@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: write small sized IO to hot log
Date: Fri, 31 Mar 2017 11:38:08 +0800
Message-ID: <8f440bb4-2450-3d54-d560-198eb5dd7019@huawei.com>
References: <20170329204815.9175-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329204815.9175-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/3/30 4:48, Jaegeuk Kim wrote:
> It would better split small and large IOs separately in order to get more
> consecutive big writes.
>
> The default threshold is set to 64KB, but configurable by sysfs/min_hot_blocks.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c    |  9 +++++++++
>  fs/f2fs/f2fs.h    |  2 ++
>  fs/f2fs/segment.c | 13 ++++++-------
>  fs/f2fs/segment.h |  1 +
>  fs/f2fs/super.c   |  2 ++
>  5 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 090413236b27..8f36080b47c4 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1432,6 +1432,8 @@ static int __write_data_page(struct page *page, bool *submitted,
>  		need_balance_fs = true;
>  	else if (has_not_enough_free_secs(sbi, 0, 0))
>  		goto redirty_out;
> +	else
> +		set_inode_flag(inode, FI_HOT_DATA);

Why here we need this, can you explain more about this?

Thanks.

>
>  	err = -EAGAIN;
>  	if (f2fs_has_inline_data(inode)) {
> @@ -1457,6 +1459,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>  	if (wbc->for_reclaim) {
>  		f2fs_submit_merged_bio_cond(sbi, inode, 0, page->index,
>  						DATA, WRITE);
> +		clear_inode_flag(inode, FI_HOT_DATA);
>  		remove_dirty_inode(inode);
>  		submitted = NULL;
>  	}
> @@ -1511,6 +1514,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>
>  	pagevec_init(&pvec, 0);
>
> +	if (get_dirty_pages(mapping->host) <=
> +				SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
> +		set_inode_flag(mapping->host, FI_HOT_DATA);
> +	else
> +		clear_inode_flag(mapping->host, FI_HOT_DATA);
> +
>  	if (wbc->range_cyclic) {
>  		writeback_index = mapping->writeback_index; /* prev offset */
>  		index = writeback_index;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5a49518ee786..32d6f674c114 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -678,6 +678,7 @@ struct f2fs_sm_info {
>  	unsigned int ipu_policy;	/* in-place-update policy */
>  	unsigned int min_ipu_util;	/* in-place-update threshold */
>  	unsigned int min_fsync_blocks;	/* threshold for fsync */
> +	unsigned int min_hot_blocks;	/* threshold for hot block allocation */
>
>  	/* for flush command control */
>  	struct flush_cmd_control *fcc_info;
> @@ -1717,6 +1718,7 @@ enum {
>  	FI_DO_DEFRAG,		/* indicate defragment is running */
>  	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
>  	FI_NO_PREALLOC,		/* indicate skipped preallocated blocks */
> +	FI_HOT_DATA,		/* indicate file is hot */
>  };
>
>  static inline void __mark_inode_dirty_flag(struct inode *inode,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b5b2a4745328..bff3f3bc7827 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1841,18 +1841,16 @@ static int __get_segment_type_6(struct page *page, enum page_type p_type)
>  	if (p_type == DATA) {
>  		struct inode *inode = page->mapping->host;
>
> -		if (S_ISDIR(inode->i_mode))
> -			return CURSEG_HOT_DATA;
> -		else if (is_cold_data(page) || file_is_cold(inode))
> +		if (is_cold_data(page) || file_is_cold(inode))
>  			return CURSEG_COLD_DATA;
> -		else
> -			return CURSEG_WARM_DATA;
> +		if (is_inode_flag_set(inode, FI_HOT_DATA))
> +			return CURSEG_HOT_DATA;
> +		return CURSEG_WARM_DATA;
>  	} else {
>  		if (IS_DNODE(page))
>  			return is_cold_node(page) ? CURSEG_WARM_NODE :
>  						CURSEG_HOT_NODE;
> -		else
> -			return CURSEG_COLD_NODE;
> +		return CURSEG_COLD_NODE;
>  	}
>  }
>
> @@ -2959,6 +2957,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
>  		sm_info->ipu_policy = 1 << F2FS_IPU_FSYNC;
>  	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
>  	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
> +	sm_info->min_hot_blocks = DEF_MIN_HOT_BLOCKS;
>
>  	sm_info->trim_sections = DEF_BATCHED_TRIM_SECTIONS;
>
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 31846b0fcb95..57e36c1ce7bd 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -540,6 +540,7 @@ static inline int utilization(struct f2fs_sb_info *sbi)
>   */
>  #define DEF_MIN_IPU_UTIL	70
>  #define DEF_MIN_FSYNC_BLOCKS	8
> +#define DEF_MIN_HOT_BLOCKS	16
>
>  enum {
>  	F2FS_IPU_FORCE,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b4c5c6298698..2d78f3c76d18 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -296,6 +296,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
> +F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_hot_blocks, min_hot_blocks);
>  F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
>  F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
>  F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
> @@ -321,6 +322,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(ipu_policy),
>  	ATTR_LIST(min_ipu_util),
>  	ATTR_LIST(min_fsync_blocks),
> +	ATTR_LIST(min_hot_blocks),
>  	ATTR_LIST(max_victim_search),
>  	ATTR_LIST(dir_level),
>  	ATTR_LIST(ram_thresh),
>
