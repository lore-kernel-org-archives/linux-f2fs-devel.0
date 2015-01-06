From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: add adaptive ssr/ipu policy as valid
 blocks in dirty segments
Date: Tue, 6 Jan 2015 15:07:00 -0800
Message-ID: <20150106230700.GE54001@jaegeuk-mac02>
References: <1420002922-6482-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y8dDU-0002qj-71
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 23:07:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y8dDS-0007l1-Sk for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 23:07:12 +0000
Content-Disposition: inline
In-Reply-To: <1420002922-6482-1-git-send-email-cm224.lee@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Changman,

On Wed, Dec 31, 2014 at 02:15:22PM +0900, Changman Lee wrote:
> If there is not enough invalid area in dirty segments, SSR won't get any
> gains. In the case, IPU could be better than SSR. This patch is for
> changing write style into IPU or SSR according to valid blocks in dirty segments.
> 
> Under 98% untilization, performance grows over 5.6%.
> 
> [FIO randwrite performance]
> before : 338512KB/s, 307784KB/s, 296553KB/s, 287964KB/s, 283813KB/s
> after  : 337842KB/s, 321810KB/s, 319700KB/s, 320000KB/s, 320902KB/s
> 
> [before]
> IPU: 0 blocks
> SSR: 1492820 blocks in 17278 segments
> LFS: 517638 blocks in 1009 segments
> BDF: 80, avg. vblocks: 457
> 
> [after]
> IPU: 1256249 blocks
> SSR: 251079 blocks in 891 segments
> LFS: 490825 blocks in 957 segments
> BDF: 86, avg. vblocks: 380
> 
> Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> ---
>  Documentation/filesystems/f2fs.txt |  2 +-
>  fs/f2fs/data.c                     |  2 +-
>  fs/f2fs/debug.c                    | 11 +++++++
>  fs/f2fs/f2fs.h                     |  4 +++
>  fs/f2fs/segment.c                  | 18 +++++++++---
>  fs/f2fs/segment.h                  | 60 ++++++++++++++++++++++++++++++++++++--
>  fs/f2fs/super.c                    |  2 ++
>  7 files changed, 91 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index e0950c4..b832720 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -201,7 +201,7 @@ Files in /sys/fs/f2fs/<devname>
>                                updates in f2fs. There are five policies:
>                                 0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
>                                 0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
> -                               0x10: F2FS_IPU_FSYNC.
> +                               0x10: F2FS_IPU_FSYNC, 0x20: F2FS_IPU_SSR_ADAP.
>  
>   min_ipu_util                 This parameter controls the threshold to trigger
>                                in-place-updates. The number indicates percentage
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6308435..80f42da 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -779,7 +779,7 @@ int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
>  	 */
>  	if (unlikely(fio->blk_addr != NEW_ADDR &&
>  			!is_cold_data(page) &&
> -			need_inplace_update(inode))) {
> +			need_inplace_update(inode, page))) {
>  		rewrite_data_page(page, fio);
>  		set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
>  	} else {
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index dd7835b..c7e6ef8 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -81,6 +81,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  	}
>  
>  	si->inplace_count = atomic_read(&sbi->inplace_count);
> +
> +	for (i = 0; i < DIRTY; i++)
> +		si->ssr_area[i] = get_ssr_area(sbi, i);
>  }
>  
>  /*
> @@ -290,6 +293,14 @@ static int stat_show(struct seq_file *s, void *v)
>  		seq_printf(s, "\nBDF: %u, avg. vblocks: %u\n",
>  			   si->bimodal, si->avg_vblocks);
>  
> +		seq_puts(s, "SSR area: ");
> +		seq_printf(s, "%u/%u/%u, ", si->ssr_area[DIRTY_HOT_DATA],
> +				si->ssr_area[DIRTY_WARM_DATA],
> +				si->ssr_area[DIRTY_COLD_DATA]);
> +		seq_printf(s, "%u/%u/%u\n", si->ssr_area[DIRTY_HOT_NODE],
> +				si->ssr_area[DIRTY_WARM_NODE],
> +				si->ssr_area[DIRTY_COLD_NODE]);
> +
>  		/* memory footprint */
>  		update_mem_info(si->sbi);
>  		seq_printf(s, "\nMemory: %u KB = static: %u + cached: %u\n",
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c48847e..81f88d3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -450,6 +450,8 @@ struct f2fs_sm_info {
>  	unsigned int ipu_policy;	/* in-place-update policy */
>  	unsigned int min_ipu_util;	/* in-place-update threshold */
>  	unsigned int min_fsync_blocks;	/* threshold for fsync */
> +	unsigned int min_ssr_area;	/* in-place-update under value */
> +	unsigned int vblocks_in_dirty[NR_CURSEG_TYPE];
>  	/* for flush command control */
>  	struct flush_cmd_control *cmd_control_info;
> @@ -1417,6 +1419,7 @@ void clear_prefree_segments(struct f2fs_sb_info *);
>  void release_discard_addrs(struct f2fs_sb_info *);
>  void discard_next_dnode(struct f2fs_sb_info *, block_t);
>  int npages_for_summary_flush(struct f2fs_sb_info *, bool);
> +int get_segment_type(struct page *, enum page_type);
>  void allocate_new_segments(struct f2fs_sb_info *);
>  int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
>  struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
> @@ -1525,6 +1528,7 @@ struct f2fs_stat_info {
>  	int curseg[NR_CURSEG_TYPE];
>  	int cursec[NR_CURSEG_TYPE];
>  	int curzone[NR_CURSEG_TYPE];
> +	unsigned int ssr_area[NR_CURSEG_TYPE];
>  
>  	unsigned int segment_count[2];
>  	unsigned int block_count[2];
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f995a85..3987e65 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -398,8 +398,10 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>  			f2fs_bug_on(sbi, 1);
>  			return;
>  		}
> -		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[t]))
> +		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[t])) {
>  			dirty_i->nr_dirty[t]++;
> +			add_vblocks_in_dirty(sbi, sentry);
> +		}
>  	}
>  }
>  
> @@ -415,8 +417,10 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>  		struct seg_entry *sentry = get_seg_entry(sbi, segno);
>  		enum dirty_type t = sentry->type;
>  
> -		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
> +		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t])) {
>  			dirty_i->nr_dirty[t]--;
> +			del_vblocks_in_dirty(sbi, sentry);
> +		}
>  
>  		if (get_valid_blocks(sbi, segno, sbi->segs_per_sec) == 0)
>  			clear_bit(GET_SECNO(sbi, segno),
> @@ -658,6 +662,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  	f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
>  				(new_vblocks > sbi->blocks_per_seg)));
>  
> +	update_vblocks_in_dirty(sbi, se, segno, del);

If we do not use F2FS_IPU_SSR_ADAP, these functions incur another overheads.

Please, avoid this first.

Thanks,

------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
