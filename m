From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/7] f2fs: show pending allocated nids count
	in debugfs
Date: Tue, 11 Oct 2016 10:20:56 -0700
Message-ID: <20161011172056.GC82199@jaegeuk>
References: <20161011143136.2107-1-chao@kernel.org>
	<20161011143136.2107-4-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bu0jj-00048f-Sy
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 17:21:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bu0jj-0002Dl-1A
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 17:21:07 +0000
Content-Disposition: inline
In-Reply-To: <20161011143136.2107-4-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

This must be merged into original split patch (maybe representing a list array).

Thanks,

On Tue, Oct 11, 2016 at 10:31:33PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Add to show pending allocated nids count in debugfs.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/debug.c | 7 ++++---
>  fs/f2fs/f2fs.h  | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 9789138..05a70b4 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -74,7 +74,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
>  	si->sits = MAIN_SEGS(sbi);
>  	si->dirty_sits = SIT_I(sbi)->dirty_sentries;
> -	si->fnids = NM_I(sbi)->free_nid_cnt;
> +	si->free_nids = NM_I(sbi)->free_nid_cnt;
> +	si->alloc_nids = NM_I(sbi)->alloc_nid_cnt;
>  	si->bg_gc = sbi->bg_gc;
>  	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
>  		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
> @@ -325,8 +326,8 @@ static int stat_show(struct seq_file *s, void *v)
>  			   si->ndirty_imeta);
>  		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
>  			   si->dirty_nats, si->nats, si->dirty_sits, si->sits);
> -		seq_printf(s, "  - free_nids: %9d\n",
> -			   si->fnids);
> +		seq_printf(s, "  - free_nids: %9d, alloc_nids: %9d\n",
> +			   si->free_nids, si->alloc_nids);
>  		seq_puts(s, "\nDistribution of User Blocks:");
>  		seq_puts(s, " [ valid | invalid | free ]\n");
>  		seq_puts(s, "  [");
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d6dff15..a726e47 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2206,7 +2206,7 @@ struct f2fs_stat_info {
>  	s64 ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
>  	s64 inmem_pages;
>  	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
> -	int nats, dirty_nats, sits, dirty_sits, fnids;
> +	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
>  	int total_count, utilization;
>  	int bg_gc, wb_bios;
>  	int inline_xattr, inline_inode, inline_dir, orphans;
> -- 
> 2.10.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
