From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: optimize gc for better performance
Date: Wed, 04 Sep 2013 18:40:35 +0900
Message-ID: <1378287635.2354.84.camel@kjgkr>
References: <1377737323-11803-1-git-send-email-jinuxstyle@gmail.com>
 <1377777368.2354.46.camel@kjgkr> <52201A4F.9020808@gmail.com>
 <1378169118.2354.56.camel@kjgkr> <522677ED.8090203@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <522677ED.8090203@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Xu <jinuxstyle@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jin,

2013-09-04 (=EC=88=98), 07:59 +0800, Jin Xu:
> Hi Jaegeuk,
>=20
> On 03/09/2013 08:45, Jaegeuk Kim wrote:
> > Hi Jin,
> >
> >> [...]
> >>>
> >>> It seems that we can obtain the performance gain just by setting =
the
> >>> MAX_VICTIM_SEARCH to 4096, for example.
> >>> So, how about just adding an ending criteria like below?
> >>>
> >>
> >> I agree that we could get the performance improvement by simply
> >> enlarging the MAX_VICTIM_SEARCH to 4096, but I am concerning the
> >> scalability a little bit. Because it might always searching the wh=
ole
> >> bitmap in some cases, for example, when dirty segments is 4000 and
> >> total segments is 409600.
> >>> [snip]
> >> [...]
> >>>
> >>> 	if (p->max_search > MAX_VICTIM_SEARCH)
> >>> 		p->max_search =3D MAX_VICTIM_SEARCH;
> >>>
> >>
> >> The optimization does not apply to SSR mode. There has a reason.
> >> As noticed in the test, when SSR selected the segments that have m=
ost
> >> garbage blocks, then when gc is needed, all the dirty segments mig=
ht
> >> have very less garbage blocks, thus the gc overhead is high. This =
might
> >> lead to performance degradation. So the patch does not change the
> >> victim selection policy for SSR.
> >
> > I think it doesn't care.
> > GC is only triggered during the direct node block allocation.
> > What it means that we need to consider the number of GC triggers wh=
ere
> > the GC triggers more frequently during the normal data allocation t=
han
> > the node block allocation.
> > So, I think it would not degrade performance significatly.
> >
> > BTW, could you show some numbers for this?
> > Or could you test what I suggested?
> >
> > Thanks,
> >
>=20
> I re-ran the test and got the following result:
>=20
> ---------------------------------------
> 2GB SDHC
> create 52023 files of size 32768 bytes
> random re-write 100000 records of 4KB
> ---------------------------------------
>=20
> | file creation (s) | rewrite time (s) | gc count | gc garbage blocks=
 |
>=20
> no patch       341         4227             1174          174840
> patched        296         2995             634           109314
> patched (KIM)  324         2958             645           106682
>=20
> In this test, it does not show the minor performance degradation caus=
ed
> by applying the patch to SSR mode. Instead, the performance is a litt=
le=20
> better with what you suggested.
>=20
> I agree that the performance degradation would not be significant eve=
n
> it does degrade. I ever saw the minor degradation in some workloads, =
but
> I didn't save the data.
>=20
> So, I agree that we can apply the patch to SSR mode as well.
>=20
> And do you still have concerns about the formula for calculating the =
#
> of search?

Thank you for the test. :)
What I've concerned is that, if it is really important to get a victim
more accurately for the performance as you described, it doesn't need t=
o
calculate the number of searches IMO. Just let's select nr_dirty. Why
not?
Only the thing that we should consider is to handle the case where the
nr_dirty is too large.
=46or this, we can just limit the # of searches to avoid performance
degradation.

Still actually, I'm not convincing the effectiveness of your formula.
If possible, could you show it with numbers?

Thanks,

>=20
> >>
> >> What do you think now?
> >>
> >>> #define MAX_VICTIM_SEARCH 4096 /* covers 8GB */
> >>>
> >>>>    	p->offset =3D sbi->last_victim[p->gc_mode];
> >>>> @@ -243,6 +245,8 @@ static int get_victim_by_default(struct f2fs=
_sb_info *sbi,
> >>>>    	struct victim_sel_policy p;
> >>>>    	unsigned int secno, max_cost;
> >>>>    	int nsearched =3D 0;
> >>>> +	unsigned int max_search =3D MAX_VICTIM_SEARCH;
> >>>> +	unsigned int nr_dirty;
> >>>>
> >>>>    	p.alloc_mode =3D alloc_mode;
> >>>>    	select_policy(sbi, gc_type, type, &p);
> >>>> @@ -258,6 +262,27 @@ static int get_victim_by_default(struct f2f=
s_sb_info *sbi,
> >>>>    			goto got_it;
> >>>>    	}
> >>>>
> >>>> +	nr_dirty =3D dirty_i->nr_dirty[p.dirty_type];
> >>>> +	if (p.gc_mode =3D=3D GC_GREEDY && p.alloc_mode !=3D SSR) {
> >>>> +		if (TOTAL_SEGS(sbi) <=3D FULL_VICTIM_SEARCH_THRESH)
> >>>> +			max_search =3D nr_dirty; /* search all the dirty segs */
> >>>> +		else {
> >>>> +			/*
> >>>> +			 * With more dirty segments, garbage blocks are likely
> >>>> +			 * more scattered, thus search harder for better
> >>>> +			 * victim.
> >>>> +			 */
> >>>> +			max_search =3D div_u64 ((nr_dirty *
> >>>> +				FULL_VICTIM_SEARCH_THRESH), TOTAL_SEGS(sbi));
> >>>> +			if (max_search < MIN_VICTIM_SEARCH_GREEDY)
> >>>> +				max_search =3D MIN_VICTIM_SEARCH_GREEDY;
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>> +	/* no more than the total dirty segments */
> >>>> +	if (max_search > nr_dirty)
> >>>> +		max_search =3D nr_dirty;
> >>>> +
> >>>>    	while (1) {
> >>>>    		unsigned long cost;
> >>>>    		unsigned int segno;
> >>>> @@ -290,7 +315,7 @@ static int get_victim_by_default(struct f2fs=
_sb_info *sbi,
> >>>>    		if (cost =3D=3D max_cost)
> >>>>    			continue;
> >>>>
> >>>> -		if (nsearched++ >=3D MAX_VICTIM_SEARCH) {
> >>>> +		if (nsearched++ >=3D max_search) {
> >>>
> >>> 		if (nsearched++ >=3D p.max_search) {
> >>>
> >>>>    			sbi->last_victim[p.gc_mode] =3D segno;
> >>>>    			break;
> >>>>    		}
> >>>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> >>>> index 2c6a6bd..2f525aa 100644
> >>>> --- a/fs/f2fs/gc.h
> >>>> +++ b/fs/f2fs/gc.h
> >>>> @@ -20,7 +20,9 @@
> >>>>    #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free=
 space */
> >>>>
> >>>>    /* Search max. number of dirty segments to select a victim se=
gment */
> >>>> -#define MAX_VICTIM_SEARCH	20
> >>>> +#define MAX_VICTIM_SEARCH		20
> >>>> +#define MIN_VICTIM_SEARCH_GREEDY	20
> >>>> +#define FULL_VICTIM_SEARCH_THRESH	4096
> >>>>
> >>>>    struct f2fs_gc_kthread {
> >>>>    	struct task_struct *f2fs_gc_task;
> >>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> >>>> index 062424a..cd33f96 100644
> >>>> --- a/fs/f2fs/segment.h
> >>>> +++ b/fs/f2fs/segment.h
> >>>> @@ -142,6 +142,7 @@ struct victim_sel_policy {
> >>>>    	int alloc_mode;			/* LFS or SSR */
> >>>>    	int gc_mode;			/* GC_CB or GC_GREEDY */
> >>>>    	unsigned long *dirty_segmap;	/* dirty segment bitmap */
> >>>> +	int dirty_type;
> >>>
> >>> 	int max_search;		/* maximum # of segments to search */
> >>>
> >>>>    	unsigned int offset;		/* last scanned bitmap offset */
> >>>>    	unsigned int ofs_unit;		/* bitmap search unit */
> >>>>    	unsigned int min_cost;		/* minimum cost */
> >>>
> >>
> >
>=20
> --
> Thanks,
> Jin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdev=
el" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jaegeuk Kim
Samsung
