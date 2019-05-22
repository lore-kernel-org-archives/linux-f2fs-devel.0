From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add missing sysfs entries in
 documentation
Date: Wed, 22 May 2019 20:26:58 +0800
Message-ID: <b2877b64-e552-2968-04ba-952f6291824f@kernel.org>
References: <20190521180606.10461-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521180606.10461-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-5-22 2:06, Jaegeuk Kim wrote:
> This patch cleans up documentation to cover missing sysfs entries.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/filesystems/f2fs.txt | 88 +++++++++++++++++++++++++++---
>  1 file changed, 79 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index f7b5e4ff0de3..0a0820d10d61 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -246,11 +246,14 @@ Files in /sys/fs/f2fs/<devname>
>  ..............................................................................
>   File                         Content
>  
> - gc_max_sleep_time            This tuning parameter controls the maximum sleep
> + gc_urgent_sleep_time         This parameter controls sleep time for gc_urgent.
> +                              500 ms is set by default. See above gc_urgent.
> +
> + gc_min_sleep_time            This tuning parameter controls the minimum sleep
>                                time for the garbage collection thread. Time is
>                                in milliseconds.
>  
> - gc_min_sleep_time            This tuning parameter controls the minimum sleep
> + gc_max_sleep_time            This tuning parameter controls the maximum sleep
>                                time for the garbage collection thread. Time is
>                                in milliseconds.
>  
> @@ -270,9 +273,6 @@ Files in /sys/fs/f2fs/<devname>
>                                to 1, background thread starts to do GC by given
>                                gc_urgent_sleep_time interval.
>  
> - gc_urgent_sleep_time         This parameter controls sleep time for gc_urgent.
> -                              500 ms is set by default. See above gc_urgent.
> -
>   reclaim_segments             This parameter controls the number of prefree
>                                segments to be reclaimed. If the number of prefree
>  			      segments is larger than the number of segments
> @@ -287,7 +287,15 @@ Files in /sys/fs/f2fs/<devname>
>  			      checkpoint is triggered, and issued during the
>  			      checkpoint. By default, it is disabled with 0.
>  
> - trim_sections                This parameter controls the number of sections
> + discard_granularity	      This parameter controls the granularity of discard
> +			      command size. It will issue discard commands iif
> +			      the size is larger than given granularity.
> +			      By default, 16KB.

By default: 16KB, Unit: 4KB, Maxsize: 512

> +
> + reserved_blocks	      This parameter indicates the number of blocks that
> +			      f2fs reserves internally for root.
> +
> + batched_trim_sections	      This parameter controls the number of sections
>                                to be trimmed out in batch mode when FITRIM
>                                conducts. 32 sections is set by default.
>  
> @@ -309,11 +317,35 @@ Files in /sys/fs/f2fs/<devname>
>  			      the number is less than this value, it triggers
>  			      in-place-updates.
>  
> + min_seq_blocks		      This parameter controls the threshold to serialize
> +			      write IOs issued by multiple threads in parallel.
> +
> + min_hot_blocks		      This parameter controls the threshold to allocate
> +			      a hot data log for pending data blocks to write.
> +
> + min_ssr_section	      This parameter adds the threshold when deciding

min_ssr_sections

> +			      SSR block allocation. If this is large, SSR mode
> +			      will be enabled early.
> +
> + ram_thresh                   This parameter controls the memory footprint used
> +			      by free nids and cached nat entries. By default,
> +			      10 is set, which indicates 10 MB / 1 GB RAM.
> +
> + ra_nid_pges		      When building free nids, F2FS reads NAT blocks

ra_nid_pages

> +			      ahead for speed up. Default is 0.
> +
> + dirty_nats_ratio	      Given dirty ratio of cached nat entries, F2FS
> +			      determines flushing them in background.
> +
>   max_victim_search	      This parameter controls the number of trials to
>  			      find a victim segment when conducting SSR and
>  			      cleaning operations. The default value is 4096
>  			      which covers 8GB block address range.
>  
> + migration_granularity	      For large-sized sections, F2FS can stop GC given
> +			      this granularity instead of reclaiming entire
> +			      section.
> +
>   dir_level                    This parameter controls the directory level to
>  			      support large directory. If a directory has a
>  			      number of files, it can reduce the file lookup
> @@ -321,9 +353,47 @@ Files in /sys/fs/f2fs/<devname>
>  			      Otherwise, it needs to decrease this value to
>  			      reduce the space overhead. The default value is 0.
>  
> - ram_thresh                   This parameter controls the memory footprint used
> -			      by free nids and cached nat entries. By default,
> -			      10 is set, which indicates 10 MB / 1 GB RAM.
> + cp_interval		      F2FS tries to do checkpoint periodically, 60 secs
> +			      by default.
> +
> + idle_interval		      F2FS detects system is idle, if there's no F2FS
> +			      operations during given interval, 5 secs by
> +			      default.
> +
> + discard_idle_interval	      F2FS detects the discard thread is idle, given
> +			      time interval. Default is 5 secs.
> +
> + gc_idle_interval	      F2FS detects the GC thread is idle, given time
> +			      interval. Default is 5 secs.
> +
> + umount_discard_timeout       When unmounting the disk, F2FS waits for finishing
> +			      queued discard commands which can take huge time.
> +			      This gives time out for it, 5 secs by default.
> +
> + iostat_enable		      This controls to enable/disable iostat in F2FS.
> +
> + readdir_ra		      This enables/disabled readahead in readdir, and

readahead of sub-inodes in readdir?

> +			      default is enabled.
> +
> + gc_pin_file_thresh	      This indicates how many GC can be failed for the
> +			      pinned file. If it exceeds this, F2FS doesn't
> +			      guarantee its pinning state. 2048 trials is set
> +			      by default.
> +
> + extension_list		      This enables to change extension_list for hot/cold
> +			      files in runtime.
> +
> + inject_rate		      This controls injection rate of arbitrary faults.
> +
> + inject_type		      This controls injection type of arbitrary faults.
> +
> + dirty_segments 	      This shows # of dirty segments.
> +
> + lifetime_write_kbytes	      This shows # of data written to the disk.
> +
> + features		      This shows current features enabled on F2FS.
> +
> + current_reserved_blocks      This shows # of blocks currently reserved.

Will be better to stay with "reserved_blocks".

Thanks,

>  
>  ================================================================================
>  USAGE
> 
