From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: skip new checkpoint when doing fstrim
 without fs change
Date: Thu, 18 Aug 2016 17:12:56 +0800
Message-ID: <986aa03d-370c-8d88-5659-d2249b924c38@huawei.com>
References: <1471506941-10563-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1baJOB-0000Ku-O2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Aug 2016 09:13:27 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1baJO6-0005Q2-0r
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Aug 2016 09:13:27 +0000
In-Reply-To: <1471506941-10563-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: heyunlei@huwei.com

Hi Yunlei,

Seems in this patch there are two parts, fstrim opitimization and sys entry of
f2fs status enhancement, it's better to do one thing in one patch, could you
split this patch into two?

Thanks,

On 2016/8/18 15:55, Yunlei He wrote:
> This patch enables to do fstrim without checkpoint, if there is no fs
> change.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 11 +++++++++++
>  fs/f2fs/debug.c      | 10 ++++++++--
>  fs/f2fs/f2fs.h       |  7 ++++++-
>  3 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index be1c54b..1207b91 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1188,6 +1188,17 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	f2fs_flush_merged_bios(sbi);
>  
> +	/* this is the case of multiple fstrims without any changes */
> +	if (cpc->reason == CP_DISCARD && !is_sbi_flag_set(sbi, SBI_IS_DIRTY)) {
> +		f2fs_bug_on(sbi, NM_I(sbi)->dirty_nat_cnt);
> +		f2fs_bug_on(sbi, SIT_I(sbi)->dirty_sentries);
> +		f2fs_bug_on(sbi, prefree_segments(sbi));
> +		flush_sit_entries(sbi, cpc);
> +		clear_prefree_segments(sbi, cpc);
> +		unblock_operations(sbi);
> +		goto out;
> +	}
> +
>  	/*
>  	 * update checkpoint pack index
>  	 * Increase the version number so that
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index badd407..07bee48 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -54,6 +54,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  	si->rsvd_segs = reserved_segments(sbi);
>  	si->overp_segs = overprovision_segments(sbi);
>  	si->valid_count = valid_user_blocks(sbi);
> +	si->discard_blks = discard_blocks(sbi);
>  	si->valid_node_count = valid_node_count(sbi);
>  	si->valid_inode_count = valid_inode_count(sbi);
>  	si->inline_xattr = atomic_read(&sbi->inline_xattr);
> @@ -228,8 +229,13 @@ static int stat_show(struct seq_file *s, void *v)
>  			   si->ssa_area_segs, si->main_area_segs);
>  		seq_printf(s, "(OverProv:%d Resv:%d)]\n\n",
>  			   si->overp_segs, si->rsvd_segs);
> -		seq_printf(s, "Utilization: %d%% (%d valid blocks)\n",
> -			   si->utilization, si->valid_count);
> +		if (test_opt(si->sbi, DISCARD))
> +			seq_printf(s, "Utilization: %u%% (%u valid blocks, %u discard blocks)\n",
> +				si->utilization, si->valid_count, si->discard_blks);
> +		else
> +			seq_printf(s, "Utilization: %u%% (%u valid blocks)\n",
> +				si->utilization, si->valid_count);
> +
>  		seq_printf(s, "  - Node: %u (Inode: %u, ",
>  			   si->valid_node_count, si->valid_inode_count);
>  		seq_printf(s, "Other: %u)\n  - Data: %u\n",
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3098109..e691ff0 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1242,6 +1242,11 @@ static inline block_t valid_user_blocks(struct f2fs_sb_info *sbi)
>  	return sbi->total_valid_block_count;
>  }
>  
> +static inline block_t discard_blocks(struct f2fs_sb_info *sbi)
> +{
> +	return sbi->discard_blks;
> +}
> +
>  static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
>  {
>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> @@ -2128,7 +2133,7 @@ struct f2fs_stat_info {
>  	int total_count, utilization;
>  	int bg_gc, wb_bios;
>  	int inline_xattr, inline_inode, inline_dir, orphans;
> -	unsigned int valid_count, valid_node_count, valid_inode_count;
> +	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
>  	unsigned int bimodal, avg_vblocks;
>  	int util_free, util_valid, util_invalid;
>  	int rsvd_segs, overp_segs;
> 


------------------------------------------------------------------------------
