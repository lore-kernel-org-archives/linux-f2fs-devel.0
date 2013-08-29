From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: optimize gc for better performance
Date: Thu, 29 Aug 2013 20:56:08 +0900
Message-ID: <1377777368.2354.46.camel@kjgkr>
References: <1377737323-11803-1-git-send-email-jinuxstyle@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1377737323-11803-1-git-send-email-jinuxstyle@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Xu <jinuxstyle@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-08-29 (=EB=AA=A9), 08:48 +0800, Jin Xu:
> From: Jin Xu <jinuxstyle@gmail.com>
>=20
> This patch improves the foreground gc efficiency by optimizing the
> victim selection policy. With this optimization, the random re-write
> performance could increase up to 20%.
>=20
> For f2fs, foreground gc happens when disk is lack of free spaces,
> it selects dirty segments and moves valid blocks around for making
> more space available. The gc cost of a segment is determined by the
> valid blocks in the segment. The less the valid blocks, the higher
> the efficiency. The ideal victim segment is the one that has the
> most garbage blocks.
>=20
> Currently, it searches up to 20 dirty segments for a victim segment.
> The selected victim is not likely the best victim for gc when there
> are much more dirty segments. Why not searching more dirty segments
> for a better victim? The cost of searching dirty segments is
> negligible in comparison to moving blocks.
>=20
> In this patch, it does not search a constant number of dirty segments
> anymore, instead it calculates the number based on the total segments=
,
> dirty segments and a threshold. Following is the pseudo formula.
> 		,-- nr_dirty_segments, if total_segments < threshold
> (# of search) =3D |
> 		`-- (nr_dirty_segments * threshold) / total_segments,
>                         Otherwise

Nice catch, but,
I don't understand why we search the # of segments in proportion to the
# of dirty segments.
How about the case where threshold =3D 10 and total_segments =3D 100000=
?
Or threshold =3D 1000000 and total_segments =3D 100?
=46or this, we need to define additional MIN/MAX thresholds and another
handling codes as your proposal.

>=20
> The test case is simple. It creates as many files until the disk full=
=2E
> The size for each file is 32KB. Then it writes as many as 100000
> records of 4KB size to random offsets of random files in sync mode.
> The testing was done on a 2GB partition of a SDHC card. Let's see the
> test result of f2fs without and with the patch.

It seems that we can obtain the performance gain just by setting the
MAX_VICTIM_SEARCH to 4096, for example.
So, how about just adding an ending criteria like below?

[snip]

> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 35f9b1a..4e045e6 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -138,10 +138,12 @@ static void select_policy(struct f2fs_sb_info *=
sbi, int gc_type,
>  	if (p->alloc_mode =3D=3D SSR) {
>  		p->gc_mode =3D GC_GREEDY;
>  		p->dirty_segmap =3D dirty_i->dirty_segmap[type];
> +		p->dirty_type =3D type;

		p->max_search =3D dirty_i->nr_dirty[type];

>  		p->ofs_unit =3D 1;
>  	} else {
>  		p->gc_mode =3D select_gc_type(gc_type);
>  		p->dirty_segmap =3D dirty_i->dirty_segmap[DIRTY];
> +		p->dirty_type =3D DIRTY;

		p->max_search =3D dirty_i->nr_dirty[DIRTY];

>  		p->ofs_unit =3D sbi->segs_per_sec;
>  	}

	if (p->max_search > MAX_VICTIM_SEARCH)
		p->max_search =3D MAX_VICTIM_SEARCH;

#define MAX_VICTIM_SEARCH 4096 /* covers 8GB */

>  	p->offset =3D sbi->last_victim[p->gc_mode];
> @@ -243,6 +245,8 @@ static int get_victim_by_default(struct f2fs_sb_i=
nfo *sbi,
>  	struct victim_sel_policy p;
>  	unsigned int secno, max_cost;
>  	int nsearched =3D 0;
> +	unsigned int max_search =3D MAX_VICTIM_SEARCH;
> +	unsigned int nr_dirty;
> =20
>  	p.alloc_mode =3D alloc_mode;
>  	select_policy(sbi, gc_type, type, &p);
> @@ -258,6 +262,27 @@ static int get_victim_by_default(struct f2fs_sb_=
info *sbi,
>  			goto got_it;
>  	}
> =20
> +	nr_dirty =3D dirty_i->nr_dirty[p.dirty_type];
> +	if (p.gc_mode =3D=3D GC_GREEDY && p.alloc_mode !=3D SSR) {
> +		if (TOTAL_SEGS(sbi) <=3D FULL_VICTIM_SEARCH_THRESH)
> +			max_search =3D nr_dirty; /* search all the dirty segs */
> +		else {
> +			/*
> +			 * With more dirty segments, garbage blocks are likely
> +			 * more scattered, thus search harder for better
> +			 * victim.
> +			 */
> +			max_search =3D div_u64 ((nr_dirty *
> +				FULL_VICTIM_SEARCH_THRESH), TOTAL_SEGS(sbi));
> +			if (max_search < MIN_VICTIM_SEARCH_GREEDY)
> +				max_search =3D MIN_VICTIM_SEARCH_GREEDY;
> +		}
> +	}
> +
> +	/* no more than the total dirty segments */
> +	if (max_search > nr_dirty)
> +		max_search =3D nr_dirty;
> +
>  	while (1) {
>  		unsigned long cost;
>  		unsigned int segno;
> @@ -290,7 +315,7 @@ static int get_victim_by_default(struct f2fs_sb_i=
nfo *sbi,
>  		if (cost =3D=3D max_cost)
>  			continue;
> =20
> -		if (nsearched++ >=3D MAX_VICTIM_SEARCH) {
> +		if (nsearched++ >=3D max_search) {

		if (nsearched++ >=3D p.max_search) {

>  			sbi->last_victim[p.gc_mode] =3D segno;
>  			break;
>  		}
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 2c6a6bd..2f525aa 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -20,7 +20,9 @@
>  #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space =
*/
> =20
>  /* Search max. number of dirty segments to select a victim segment *=
/
> -#define MAX_VICTIM_SEARCH	20
> +#define MAX_VICTIM_SEARCH		20
> +#define MIN_VICTIM_SEARCH_GREEDY	20
> +#define FULL_VICTIM_SEARCH_THRESH	4096
> =20
>  struct f2fs_gc_kthread {
>  	struct task_struct *f2fs_gc_task;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 062424a..cd33f96 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -142,6 +142,7 @@ struct victim_sel_policy {
>  	int alloc_mode;			/* LFS or SSR */
>  	int gc_mode;			/* GC_CB or GC_GREEDY */
>  	unsigned long *dirty_segmap;	/* dirty segment bitmap */
> +	int dirty_type;

	int max_search;		/* maximum # of segments to search */

>  	unsigned int offset;		/* last scanned bitmap offset */
>  	unsigned int ofs_unit;		/* bitmap search unit */
>  	unsigned int min_cost;		/* minimum cost */

--=20
Jaegeuk Kim
Samsung
