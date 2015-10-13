From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: add a tracepoint for background gc
Date: Tue, 13 Oct 2015 10:03:08 -0700
Message-ID: <20151013170308.GB60592@jaegeuk-mac02.mot.com>
References: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org>
 <1444085040-12843-2-git-send-email-jaegeuk@kernel.org>
 <5618B96A.50205@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5618B96A.50205@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: He YunLei <heyunlei@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Oct 10, 2015 at 03:08:26PM +0800, He YunLei wrote:
> On 2015/10/6 6:43, Jaegeuk Kim wrote:
> > This patch introduces a tracepoint to monitor background gc behaviors.
> >
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/gc.c                |  3 +++
> >   include/trace/events/f2fs.h | 28 ++++++++++++++++++++++++++++
> >   2 files changed, 31 insertions(+)
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e627c19..e7cec86 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -77,6 +77,9 @@ static int gc_thread_func(void *data)
> >
> >   		stat_inc_bggc_count(sbi);
> >
> > +		trace_f2fs_background_gc(sbi->sb, wait_ms,
> > +				prefree_segments(sbi), free_segments(sbi));
> > +
> >   		/* if return value is not zero, no victim was selected */
> >   		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC)))
> >   			wait_ms = gc_th->no_gc_sleep_time;
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index 6aa63d9..7de751d 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -514,6 +514,34 @@ TRACE_EVENT(f2fs_map_blocks,
> >   		__entry->ret)
> >   );
> >
> > +TRACE_EVENT(f2fs_background_gc,
> > +
> > +	TP_PROTO(struct super_block *sb, long wait_ms,
> > +			unsigned int prefree, unsigned int free),
> > +
> > +	TP_ARGS(sb, wait_ms, prefree, free),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,	dev)
> > +		__field(long,	wait_ms)
> > +		__field(unsigned int,	prefree)
> > +		__field(unsigned int,	free)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		= sb->s_dev;
> > +		__entry->wait_ms	= wait_ms;
> > +		__entry->prefree	= prefree;
> > +		__entry->free		= free;
> > +	),
> > +
> > +	TP_printk("dev = (%d,%d), wait_ms = %ld, prefree = %u, free = %u",
> > +		show_dev(__entry),
> > +		__entry->wait_ms,
> > +		__entry->prefree,
> > +		__entry->free)
> > +);
> > +
> hi,
>      I open f2fs_background_gc and f2fs_get_victim trace points, first, the partition has no dirty segment, so no victim is
> selected, wait_ms is equal to 300s.
> 
>      f2fs_gc-8:33-2827  [001] ....  5014.608396: f2fs_background_gc: dev = (8,33), wait_ms = 300000, prefree = 0, free = 73
>      f2fs_gc-8:33-2827  [000] ....  5314.793436: f2fs_background_gc: dev = (8,33), wait_ms = 300000, prefree = 0, free = 73
> 
>      then I made the partition satisfied the condition of has_enough_invalid_blocks, gc can get a victim and do garbage collection, wait_ms = 30s
> 
>      f2fs_gc-8:33-2827  [001] ....  5614.978486: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 54
>      f2fs_gc-8:33-2827  [001] ....  5614.978538: f2fs_get_victim: dev = (8,33), type = No TYPE, policy = (Background GC, LFS-mode, Cost-Benefit), victim = 441 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 54
>      f2fs_gc-8:33-2827  [000] ....  5644.996989: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 54
>      f2fs_gc-8:33-2827  [000] ....  5644.997027: f2fs_get_victim: dev = (8,33), type = No TYPE, policy = (Background GC, LFS-mode, Cost-Benefit), victim = 97 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 54
> 
>      when there no dirty segments left, I think wait_ms could turn back to 300s
> 
>      f2fs_gc-8:33-2827  [000] ....  6305.596205: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 1, free = 64
>      f2fs_gc-8:33-2827  [001] ....  6605.781281: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 65
>      f2fs_gc-8:33-2827  [000] ....  6905.966301: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 65
>      f2fs_gc-8:33-2827  [001] ....  7206.151344: f2fs_background_gc: dev = (8,33), wait_ms = 30000, prefree = 0, free = 65
> 	
>      here, background gc triggers every 300s, but wait_ms is still 30s, I don't know why?

Oh, it's due to the tracepoint timing.
In gc_thread_func(),
	do {
		wait with wait_ms = 300s

		decrease_sleep_time(&wait_ms); -> wait_ms = 30s
		tracepoint with wait_ms = 30s

		after f2fs_gc() call, wait_ms becomes 300s again.
	}

So, this patch should fix that.

>From 84e4214f0868ae77771837d0ed4cc6eff10738ba Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 13 Oct 2015 10:00:53 -0700
Subject: [PATCH] f2fs: relocate the tracepoint for background_gc

Once f2fs_gc is done, wait_ms is changed once more.
So, its tracepoint would be located after it.

Reported-by: He YunLei <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index af7c24c..fedbf67 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -77,13 +77,13 @@ static int gc_thread_func(void *data)
 
 		stat_inc_bggc_count(sbi);
 
-		trace_f2fs_background_gc(sbi->sb, wait_ms,
-				prefree_segments(sbi), free_segments(sbi));
-
 		/* if return value is not zero, no victim was selected */
 		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC)))
 			wait_ms = gc_th->no_gc_sleep_time;
 
+		trace_f2fs_background_gc(sbi->sb, wait_ms,
+				prefree_segments(sbi), free_segments(sbi));
+
 		/* balancing f2fs's metadata periodically */
 		f2fs_balance_fs_bg(sbi);
 
-- 
2.1.1


