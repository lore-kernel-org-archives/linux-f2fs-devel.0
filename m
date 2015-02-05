From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 5/5 v3] f2fs: introduce a batched trim
Date: Thu, 05 Feb 2015 17:30:33 +0800
Message-ID: <006001d04126$895e3680$9c1aa380$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-5-git-send-email-jaegeuk@kernel.org>
 <003b01d03bc0$a5f23d20$f1d6b760$@samsung.com>
 <20150129214117.GB17521@jaegeuk-mac02>
 <006701d03c4b$a62ec0c0$f28c4240$@samsung.com>
 <20150202232803.GB34575@jaegeuk-mac02.mot.com> <20150203024822.GA8798@lcm>
 <20150203200904.GA43329@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150203200904.GA43329@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk, Changman,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, February 04, 2015 4:11 AM
> To: Changman Lee
> Cc: Chao Yu; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 5/5 v3] f2fs: introduce a batched trim
> 
> Hi Changman,
> 
> Good idea!
> 
> Change log from v2:
>  o add sysfs to change the # of sections for trimming.

Good idea!

> 
> Change log from v1:
>  o add description
>  o change the # of batched segments suggested by Chao
>  o make consistent for # of batched segments
> 
> This patch introduces a batched trimming feature, which submits split discard
> commands.
> 
> This is to avoid long latency due to huge trim commands.
> If fstrim was triggered ranging from 0 to the end of device, we should lock
> all the checkpoint-related mutexes, resulting in very long latency.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>  Documentation/filesystems/f2fs.txt      |  4 ++++
>  fs/f2fs/f2fs.h                          |  7 +++++++
>  fs/f2fs/segment.c                       | 18 +++++++++++++-----
>  fs/f2fs/super.c                         |  2 ++
>  5 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs
> b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 6f9157f..2c4cc42 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -74,3 +74,9 @@ Date:		March 2014
>  Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>  Description:
>  		 Controls the memory footprint used by f2fs.
> +
> +What:		/sys/fs/f2fs/<disk>/trim_sections
> +Date:		February 2015
> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> +Description:
> +		 Controls the trimming rate in batch mode.
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 6758aa3..dac11d7 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -199,6 +199,10 @@ Files in /sys/fs/f2fs/<devname>
>  			      checkpoint is triggered, and issued during the
>  			      checkpoint. By default, it is disabled with 0.
> 
> + trim_sections                This parameter controls the number of sections
> +                              to be trimmed out in batch mode when FITRIM
> +                              conducts. 32 sections is set by default.
> +
>   ipu_policy                   This parameter controls the policy of in-place
>                                updates in f2fs. There are five policies:
>                                 0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 964c240..6f57da1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -105,6 +105,10 @@ enum {
>  	CP_DISCARD,
>  };
> 
> +#define DEF_BATCHED_TRIM_SECTIONS	32
> +#define BATCHED_TRIM_SEGMENTS(sbi)	\
> +		(SM_I(sbi)->trim_sections * (sbi)->segs_per_sec)
> +
>  struct cp_control {
>  	int reason;
>  	__u64 trim_start;
> @@ -448,6 +452,9 @@ struct f2fs_sm_info {
>  	int nr_discards;			/* # of discards in the list */
>  	int max_discards;			/* max. discards to be issued */
> 
> +	/* for batched trimming */
> +	int trim_sections;			/* # of sections to trim */
> +
>  	struct list_head sit_entry_set;	/* sit entry set list */
> 
>  	unsigned int ipu_policy;	/* in-place-update policy */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 5ea57ec..c542f63 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1066,14 +1066,20 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>  	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
>  						GET_SEGNO(sbi, end);
>  	cpc.reason = CP_DISCARD;
> -	cpc.trim_start = start_segno;
> -	cpc.trim_end = end_segno;
>  	cpc.trim_minlen = range->minlen >> sbi->log_blocksize;
> 
>  	/* do checkpoint to issue discard commands safely */
> -	mutex_lock(&sbi->gc_mutex);
> -	write_checkpoint(sbi, &cpc);
> -	mutex_unlock(&sbi->gc_mutex);
> +	for (; start_segno <= end_segno;
> +				start_segno += BATCHED_TRIM_SEGMENTS(sbi)) {
> +		cpc.trim_start = start_segno;
> +		cpc.trim_end = min_t(unsigned int,
> +				start_segno + BATCHED_TRIM_SEGMENTS (sbi) - 1,

Actually what I mean is that in each trim we try to align start segment
to first segment of section as much as possible.

How about using:
		cpc.trim_end = min_t(unsigned int, rounddown(start_segno +
					BATCHED_TRIM_SEGMENTS(sbi),
					(sbi)->segs_per_sec) - 1, end_segno);
Thanks,

> +				end_segno);
> +
> +		mutex_lock(&sbi->gc_mutex);
> +		write_checkpoint(sbi, &cpc);
> +		mutex_unlock(&sbi->gc_mutex);
> +	}
>  out:
>  	range->len = cpc.trimmed << sbi->log_blocksize;
>  	return 0;
> @@ -2127,6 +2133,8 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
>  	sm_info->nr_discards = 0;
>  	sm_info->max_discards = 0;
> 
> +	sm_info->trim_sections = DEF_BATCHED_TRIM_SECTIONS;
> +
>  	INIT_LIST_HEAD(&sm_info->sit_entry_set);
> 
>  	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1e92c2e..f2fe666 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -195,6 +195,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time,
> no_gc_sleep_time);
>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, max_small_discards, max_discards);
> +F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
> @@ -210,6 +211,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(gc_idle),
>  	ATTR_LIST(reclaim_segments),
>  	ATTR_LIST(max_small_discards),
> +	ATTR_LIST(batched_trim_sections),
>  	ATTR_LIST(ipu_policy),
>  	ATTR_LIST(min_ipu_util),
>  	ATTR_LIST(min_fsync_blocks),
> --
> 2.1.1
