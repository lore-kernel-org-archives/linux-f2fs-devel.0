From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: let checkpoint flush dnode page of
 regular
Date: Fri, 6 Jul 2018 15:34:10 -0700
Message-ID: <20180706223410.GB77984@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180703121253.44560-1-yuchao0@huawei.com>
 <20180703121253.44560-2-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fbZIx-0002VU-JE
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 22:34:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fbZIw-001yKP-7e
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 22:34:19 +0000
Content-Disposition: inline
In-Reply-To: <20180703121253.44560-2-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 07/03, Chao Yu wrote:
> Fsyncer will wait on all dnode pages of regular writeback before flushing,
> if there are async dnode pages blocked by IO scheduler, it may decrease
> fsync's performance.

So, it'd be better to keep tracking what we really need to wait for first.

> 
> In this patch, we choose to let f2fs_balance_fs_bg() to trigger checkpoint
> to flush these dnode pages of regular, so async IO of dnode page can be
> elimitnated, making fsyncer only need to wait for sync IO.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/node.c    | 8 +++++++-
>  fs/f2fs/node.h    | 5 +++++
>  fs/f2fs/segment.c | 4 +++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 0810c8117d46..eeee582cee32 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1384,6 +1384,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		goto redirty_out;
>  
> +	if (wbc->sync_mode == WB_SYNC_NONE &&
> +			IS_DNODE(page) && is_cold_node(page))
> +		goto redirty_out;
> +
>  	/* get old block addr of this node page */
>  	nid = nid_of_node(page);
>  	f2fs_bug_on(sbi, page->index != nid);
> @@ -1698,10 +1702,12 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>  	}
>  
>  	if (step < 2) {
> +		if (wbc->sync_mode == WB_SYNC_NONE && step == 1)
> +			goto out;
>  		step++;
>  		goto next_step;
>  	}
> -
> +out:
>  	if (nwritten)
>  		f2fs_submit_merged_write(sbi, NODE);
>  
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index b95e49e4a928..b0da4c26eebb 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -135,6 +135,11 @@ static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
>  	return NM_I(sbi)->nat_cnt >= DEF_NAT_CACHE_THRESHOLD;
>  }
>  
> +static inline bool excess_dirty_nodes(struct f2fs_sb_info *sbi)
> +{
> +	return get_pages(sbi, F2FS_DIRTY_NODES) >= sbi->blocks_per_seg * 8;
> +}
> +
>  enum mem_type {
>  	FREE_NIDS,	/* indicates the free nid list */
>  	NAT_ENTRIES,	/* indicates the cached nat entry */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index bbe6e1596611..13f5e3665bf0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -503,7 +503,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  	else
>  		f2fs_build_free_nids(sbi, false, false);
>  
> -	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
> +	if (!is_idle(sbi) &&
> +		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
>  		return;
>  
>  	/* checkpoint is the only way to shrink partial cached entries */
> @@ -511,6 +512,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  			!f2fs_available_free_memory(sbi, INO_ENTRIES) ||
>  			excess_prefree_segs(sbi) ||
>  			excess_dirty_nats(sbi) ||
> +			excess_dirty_nodes(sbi) ||
>  			f2fs_time_over(sbi, CP_TIME)) {
>  		if (test_opt(sbi, DATA_FLUSH)) {
>  			struct blk_plug plug;
> -- 
> 2.18.0.rc1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
