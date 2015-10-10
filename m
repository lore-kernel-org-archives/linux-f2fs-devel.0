From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH 2/3] f2fs: add a tracepoint for background gc
Date: Sat, 10 Oct 2015 15:08:26 +0800
Message-ID: <5618B96A.50205@huawei.com>
References: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org>
	<1444085040-12843-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZkoH8-0001Bz-1C
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 10 Oct 2015 07:09:02 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZkoH3-0002Gh-Ac
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 10 Oct 2015 07:09:01 +0000
In-Reply-To: <1444085040-12843-2-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2015/10/6 6:43, Jaegeuk Kim wrote:
> This patch introduces a tracepoint to monitor background gc behaviors.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/gc.c                |  3 +++
>   include/trace/events/f2fs.h | 28 ++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e627c19..e7cec86 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -77,6 +77,9 @@ static int gc_thread_func(void *data)
>
>   		stat_inc_bggc_count(sbi);
>
> +		trace_f2fs_background_gc(sbi->sb, wait_ms,
> +				prefree_segments(sbi), free_segments(sbi));
> +
>   		/* if return value is not zero, no victim was selected */
>   		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC)))
>   			wait_ms = gc_th->no_gc_sleep_time;
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 6aa63d9..7de751d 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -514,6 +514,34 @@ TRACE_EVENT(f2fs_map_blocks,
>   		__entry->ret)
>   );
>
> +TRACE_EVENT(f2fs_background_gc,
> +
> +	TP_PROTO(struct super_block *sb, long wait_ms,
> +			unsigned int prefree, unsigned int free),
> +
> +	TP_ARGS(sb, wait_ms, prefree, free),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(long,	wait_ms)
> +		__field(unsigned int,	prefree)
> +		__field(unsigned int,	free)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= sb->s_dev;
> +		__entry->wait_ms	= wait_ms;
> +		__entry->prefree	= prefree;
> +		__entry->free		= free;
> +	),
> +
> +	TP_printk("dev = (%d,%d), wait_ms = %ld, prefree = %u, free = %u",
> +		show_dev(__entry),
> +		__entry->wait_ms,
> +		__entry->prefree,
> +		__entry->free)
> +);
> +
hi,
     I open f2fs_background_gc and f2fs_get_victim trace points, first, the partition has no dirty segment, so no victim is
selected, wait_ms is equal to 300s.

     f2fs_gc-8:33-2827  [001] ....  5014.608396: f2fs_background_gc: dev = (8,33), wait_ms = 300000, prefree = 0, free = 73
     f2fs_gc-8:33-2827  [000] ....  5314.793436: f2fs_background_gc: dev = (8,33), wait_ms = 300000, prefree = 0, free = 73

     then I made the partition satisfied the condition of has_enough_invalid_blocks, gc can get a victim and do garbage collection, wait_ms = 30s

     f2fs_gc-8:33-2827  [001] ....  5614.978486: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 54
     f2fs_gc-8:33-2827  [001] ....  5614.978538: f2fs_get_victim: dev = (8,33), type = No TYPE, policy = (Background GC, LFS-mode, Cost-Benefit), victim = 441 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 54
     f2fs_gc-8:33-2827  [000] ....  5644.996989: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 54
     f2fs_gc-8:33-2827  [000] ....  5644.997027: f2fs_get_victim: dev = (8,33), type = No TYPE, policy = (Background GC, LFS-mode, Cost-Benefit), victim = 97 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 54

     when there no dirty segments left, I think wait_ms could turn back to 300s

     f2fs_gc-8:33-2827  [000] ....  6305.596205: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 1, free = 64
     f2fs_gc-8:33-2827  [001] ....  6605.781281: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 65
     f2fs_gc-8:33-2827  [000] ....  6905.966301: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 65
     f2fs_gc-8:33-2827  [001] ....  7206.151344: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 65
	
     here, background gc triggers every 300s, but wait_ms is still 30s, I don't know why?

Best wishes,
Thanks
>   TRACE_EVENT(f2fs_get_victim,
>
>   	TP_PROTO(struct super_block *sb, int type, int gc_type,
>


------------------------------------------------------------------------------
