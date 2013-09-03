From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: optimize gc for better performance
Date: Tue, 03 Sep 2013 09:45:18 +0900
Message-ID: <1378169118.2354.56.camel@kjgkr>
References: <1377737323-11803-1-git-send-email-jinuxstyle@gmail.com>
 <1377777368.2354.46.camel@kjgkr> <52201A4F.9020808@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <52201A4F.9020808@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Xu <jinuxstyle@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jin,

> [...]
> >
> > It seems that we can obtain the performance gain just by setting the
> > MAX_VICTIM_SEARCH to 4096, for example.
> > So, how about just adding an ending criteria like below?
> >
> 
> I agree that we could get the performance improvement by simply
> enlarging the MAX_VICTIM_SEARCH to 4096, but I am concerning the
> scalability a little bit. Because it might always searching the whole
> bitmap in some cases, for example, when dirty segments is 4000 and
> total segments is 409600.
> > [snip]
> [...]
> >
> > 	if (p->max_search > MAX_VICTIM_SEARCH)
> > 		p->max_search = MAX_VICTIM_SEARCH;
> >
> 
> The optimization does not apply to SSR mode. There has a reason.
> As noticed in the test, when SSR selected the segments that have most
> garbage blocks, then when gc is needed, all the dirty segments might
> have very less garbage blocks, thus the gc overhead is high. This might
> lead to performance degradation. So the patch does not change the
> victim selection policy for SSR.

I think it doesn't care.
GC is only triggered during the direct node block allocation.
What it means that we need to consider the number of GC triggers where
the GC triggers more frequently during the normal data allocation than
the node block allocation.
So, I think it would not degrade performance significatly.

BTW, could you show some numbers for this?
Or could you test what I suggested?

Thanks,

> 
> What do you think now?
> 
> > #define MAX_VICTIM_SEARCH 4096 /* covers 8GB */
> >
> >>   	p->offset = sbi->last_victim[p->gc_mode];
> >> @@ -243,6 +245,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >>   	struct victim_sel_policy p;
> >>   	unsigned int secno, max_cost;
> >>   	int nsearched = 0;
> >> +	unsigned int max_search = MAX_VICTIM_SEARCH;
> >> +	unsigned int nr_dirty;
> >>
> >>   	p.alloc_mode = alloc_mode;
> >>   	select_policy(sbi, gc_type, type, &p);
> >> @@ -258,6 +262,27 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >>   			goto got_it;
> >>   	}
> >>
> >> +	nr_dirty = dirty_i->nr_dirty[p.dirty_type];
> >> +	if (p.gc_mode == GC_GREEDY && p.alloc_mode != SSR) {
> >> +		if (TOTAL_SEGS(sbi) <= FULL_VICTIM_SEARCH_THRESH)
> >> +			max_search = nr_dirty; /* search all the dirty segs */
> >> +		else {
> >> +			/*
> >> +			 * With more dirty segments, garbage blocks are likely
> >> +			 * more scattered, thus search harder for better
> >> +			 * victim.
> >> +			 */
> >> +			max_search = div_u64 ((nr_dirty *
> >> +				FULL_VICTIM_SEARCH_THRESH), TOTAL_SEGS(sbi));
> >> +			if (max_search < MIN_VICTIM_SEARCH_GREEDY)
> >> +				max_search = MIN_VICTIM_SEARCH_GREEDY;
> >> +		}
> >> +	}
> >> +
> >> +	/* no more than the total dirty segments */
> >> +	if (max_search > nr_dirty)
> >> +		max_search = nr_dirty;
> >> +
> >>   	while (1) {
> >>   		unsigned long cost;
> >>   		unsigned int segno;
> >> @@ -290,7 +315,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >>   		if (cost == max_cost)
> >>   			continue;
> >>
> >> -		if (nsearched++ >= MAX_VICTIM_SEARCH) {
> >> +		if (nsearched++ >= max_search) {
> >
> > 		if (nsearched++ >= p.max_search) {
> >
> >>   			sbi->last_victim[p.gc_mode] = segno;
> >>   			break;
> >>   		}
> >> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> >> index 2c6a6bd..2f525aa 100644
> >> --- a/fs/f2fs/gc.h
> >> +++ b/fs/f2fs/gc.h
> >> @@ -20,7 +20,9 @@
> >>   #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
> >>
> >>   /* Search max. number of dirty segments to select a victim segment */
> >> -#define MAX_VICTIM_SEARCH	20
> >> +#define MAX_VICTIM_SEARCH		20
> >> +#define MIN_VICTIM_SEARCH_GREEDY	20
> >> +#define FULL_VICTIM_SEARCH_THRESH	4096
> >>
> >>   struct f2fs_gc_kthread {
> >>   	struct task_struct *f2fs_gc_task;
> >> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> >> index 062424a..cd33f96 100644
> >> --- a/fs/f2fs/segment.h
> >> +++ b/fs/f2fs/segment.h
> >> @@ -142,6 +142,7 @@ struct victim_sel_policy {
> >>   	int alloc_mode;			/* LFS or SSR */
> >>   	int gc_mode;			/* GC_CB or GC_GREEDY */
> >>   	unsigned long *dirty_segmap;	/* dirty segment bitmap */
> >> +	int dirty_type;
> >
> > 	int max_search;		/* maximum # of segments to search */
> >
> >>   	unsigned int offset;		/* last scanned bitmap offset */
> >>   	unsigned int ofs_unit;		/* bitmap search unit */
> >>   	unsigned int min_cost;		/* minimum cost */
> >
> 

-- 
Jaegeuk Kim
Samsung
