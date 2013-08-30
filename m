From: jin xu <jinuxstyle@gmail.com>
Subject: Re: [PATCH] f2fs: optimize gc for better performance
Date: Fri, 30 Aug 2013 08:18:51 +0800
Message-ID: <CAGchX6KQejQkBDbh1HEkw3JU_eHTPHJb3+MMvtfujMvFdY8yXQ@mail.gmail.com>
References: <1377737323-11803-1-git-send-email-jinuxstyle@gmail.com>
	<1377777368.2354.46.camel@kjgkr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8538355015878341376=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinuxstyle@gmail.com>) id 1VFCQV-0008WH-5a
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Aug 2013 00:18:59 +0000
Received: from mail-vc0-f173.google.com ([209.85.220.173])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VFCQT-0004KH-P4
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Aug 2013 00:18:59 +0000
Received: by mail-vc0-f173.google.com with SMTP id id13so856350vcb.32
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 29 Aug 2013 17:18:51 -0700 (PDT)
In-Reply-To: <1377777368.2354.46.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

--===============8538355015878341376==
Content-Type: multipart/alternative; boundary=047d7b3a8a8ed0380504e51f2a9e

--047d7b3a8a8ed0380504e51f2a9e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,

On Thu, Aug 29, 2013 at 7:56 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com>wrote=
:

> Hi,
>
> 2013-08-29 (=EB=AA=A9), 08:48 +0800, Jin Xu:
> > From: Jin Xu <jinuxstyle@gmail.com>
> >
> > This patch improves the foreground gc efficiency by optimizing the
> > victim selection policy. With this optimization, the random re-write
> > performance could increase up to 20%.
> >
> > For f2fs, foreground gc happens when disk is lack of free spaces,
> > it selects dirty segments and moves valid blocks around for making
> > more space available. The gc cost of a segment is determined by the
> > valid blocks in the segment. The less the valid blocks, the higher
> > the efficiency. The ideal victim segment is the one that has the
> > most garbage blocks.
> >
> > Currently, it searches up to 20 dirty segments for a victim segment.
> > The selected victim is not likely the best victim for gc when there
> > are much more dirty segments. Why not searching more dirty segments
> > for a better victim? The cost of searching dirty segments is
> > negligible in comparison to moving blocks.
> >
> > In this patch, it does not search a constant number of dirty segments
> > anymore, instead it calculates the number based on the total segments,
> > dirty segments and a threshold. Following is the pseudo formula.
> >               ,-- nr_dirty_segments, if total_segments < threshold
> > (# of search) =3D |
> >               `-- (nr_dirty_segments * threshold) / total_segments,
> >                         Otherwise
>
> Nice catch, but,
> I don't understand why we search the # of segments in proportion to the
> # of dirty segments.
> How about the case where threshold =3D 10 and total_segments =3D 100000?
> Or threshold =3D 1000000 and total_segments =3D 100?
> For this, we need to define additional MIN/MAX thresholds and another
> handling codes as your proposal.
>
>
Firstly, calculating the # of search this way could constraint the searchin=
g
overhead in a certain level even when the total segments is too many.
Secondly, when there are more dirty segments, the same # of garbage
blocks might be more  scattered than when there are less dirty segments.
So we search the # of the segments in proportion to the # of dirty segments=
.

It seems that we can obtain the performance gain just by setting the
> MAX_VICTIM_SEARCH to 4096, for example.
> So, how about just adding an ending criteria like below?
>
>
I agree that we could get the performance improvement by simply enlarging
the MAX_VICTIM_SEARCH to 4096, but I am concerning the scalability a little
bit. Because it might always searching the whole bitmap in some cases,
for example, when dirty segments is 4000 and total segments is 409600.

        if (p->max_search > MAX_VICTIM_SEARCH)
>                 p->max_search =3D MAX_VICTIM_SEARCH;
>


The optimization does not apply to SSR mode. There has a reason.
As noticed in the test, when SSR selected the segments that have most
garbage blocks, then when gc is needed, all the dirty segments might have
very less garbage blocks, thus the gc overhead is high. This might lead to
performance degradation. So the patch does not change the victim selection
policy for SSR.

What do you think now?


>
> #define MAX_VICTIM_SEARCH 4096 /* covers 8GB */
>
> >       p->offset =3D sbi->last_victim[p->gc_mode];
> > @@ -243,6 +245,8 @@ static int get_victim_by_default(struct f2fs_sb_inf=
o
> *sbi,
> >       struct victim_sel_policy p;
> >       unsigned int secno, max_cost;
> >       int nsearched =3D 0;
> > +     unsigned int max_search =3D MAX_VICTIM_SEARCH;
> > +     unsigned int nr_dirty;
> >
> >       p.alloc_mode =3D alloc_mode;
> >       select_policy(sbi, gc_type, type, &p);
> > @@ -258,6 +262,27 @@ static int get_victim_by_default(struct
> f2fs_sb_info *sbi,
> >                       goto got_it;
> >       }
> >
> > +     nr_dirty =3D dirty_i->nr_dirty[p.dirty_type];
> > +     if (p.gc_mode =3D=3D GC_GREEDY && p.alloc_mode !=3D SSR) {
> > +             if (TOTAL_SEGS(sbi) <=3D FULL_VICTIM_SEARCH_THRESH)
> > +                     max_search =3D nr_dirty; /* search all the dirty
> segs */
> > +             else {
> > +                     /*
> > +                      * With more dirty segments, garbage blocks are
> likely
> > +                      * more scattered, thus search harder for better
> > +                      * victim.
> > +                      */
> > +                     max_search =3D div_u64 ((nr_dirty *
> > +                             FULL_VICTIM_SEARCH_THRESH),
> TOTAL_SEGS(sbi));
> > +                     if (max_search < MIN_VICTIM_SEARCH_GREEDY)
> > +                             max_search =3D MIN_VICTIM_SEARCH_GREEDY;
> > +             }
> > +     }
> > +
> > +     /* no more than the total dirty segments */
> > +     if (max_search > nr_dirty)
> > +             max_search =3D nr_dirty;
> > +
> >       while (1) {
> >               unsigned long cost;
> >               unsigned int segno;
> > @@ -290,7 +315,7 @@ static int get_victim_by_default(struct f2fs_sb_inf=
o
> *sbi,
> >               if (cost =3D=3D max_cost)
> >                       continue;
> >
> > -             if (nsearched++ >=3D MAX_VICTIM_SEARCH) {
> > +             if (nsearched++ >=3D max_search) {
>
>                 if (nsearched++ >=3D p.max_search) {
>
> >                       sbi->last_victim[p.gc_mode] =3D segno;
> >                       break;
> >               }
> > diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> > index 2c6a6bd..2f525aa 100644
> > --- a/fs/f2fs/gc.h
> > +++ b/fs/f2fs/gc.h
> > @@ -20,7 +20,9 @@
> >  #define LIMIT_FREE_BLOCK     40 /* percentage over invalid + free spac=
e
> */
> >
> >  /* Search max. number of dirty segments to select a victim segment */
> > -#define MAX_VICTIM_SEARCH    20
> > +#define MAX_VICTIM_SEARCH            20
> > +#define MIN_VICTIM_SEARCH_GREEDY     20
> > +#define FULL_VICTIM_SEARCH_THRESH    4096
> >
> >  struct f2fs_gc_kthread {
> >       struct task_struct *f2fs_gc_task;
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 062424a..cd33f96 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -142,6 +142,7 @@ struct victim_sel_policy {
> >       int alloc_mode;                 /* LFS or SSR */
> >       int gc_mode;                    /* GC_CB or GC_GREEDY */
> >       unsigned long *dirty_segmap;    /* dirty segment bitmap */
> > +     int dirty_type;
>
>         int max_search;         /* maximum # of segments to search */
>
> >       unsigned int offset;            /* last scanned bitmap offset */
> >       unsigned int ofs_unit;          /* bitmap search unit */
> >       unsigned int min_cost;          /* minimum cost */
>
> --
> Jaegeuk Kim
> Samsung
>
>
Thanks,
Jin

--047d7b3a8a8ed0380504e51f2a9e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jaegeuk,<br><div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Thu, Aug 29, 2013 at 7:56 PM, Jaegeuk Kim <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jaegeuk.kim@samsung.com" target=3D"_blank">j=
aegeuk.kim@samsung.com</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
2013-08-29 (=EB=AA=A9), 08:48 +0800, Jin Xu:<br>
<div>&gt; From: Jin Xu &lt;<a href=3D"mailto:jinuxstyle@gmail.com" target=
=3D"_blank">jinuxstyle@gmail.com</a>&gt;<br>
&gt;<br>
&gt; This patch improves the foreground gc efficiency by optimizing the<br>
&gt; victim selection policy. With this optimization, the random re-write<b=
r>
&gt; performance could increase up to 20%.<br>
&gt;<br>
&gt; For f2fs, foreground gc happens when disk is lack of free spaces,<br>
&gt; it selects dirty segments and moves valid blocks around for making<br>
&gt; more space available. The gc cost of a segment is determined by the<br=
>
&gt; valid blocks in the segment. The less the valid blocks, the higher<br>
&gt; the efficiency. The ideal victim segment is the one that has the<br>
&gt; most garbage blocks.<br>
&gt;<br>
&gt; Currently, it searches up to 20 dirty segments for a victim segment.<b=
r>
&gt; The selected victim is not likely the best victim for gc when there<br=
>
&gt; are much more dirty segments. Why not searching more dirty segments<br=
>
&gt; for a better victim? The cost of searching dirty segments is<br>
&gt; negligible in comparison to moving blocks.<br>
&gt;<br>
&gt; In this patch, it does not search a constant number of dirty segments<=
br>
&gt; anymore, instead it calculates the number based on the total segments,=
<br>
&gt; dirty segments and a threshold. Following is the pseudo formula.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,-- nr_dirty_segments=
, if total_segments &lt; threshold<br>
&gt; (# of search) =3D |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `-- (nr_dirty_segment=
s * threshold) / total_segments,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Otherwise<br>
<br>
</div>Nice catch, but,<br>
I don&#39;t understand why we search the # of segments in proportion to the=
<br>
# of dirty segments.<br>
How about the case where threshold =3D 10 and total_segments =3D 100000?<br=
>
Or threshold =3D 1000000 and total_segments =3D 100?<br>
For this, we need to define additional MIN/MAX thresholds and another<br>
handling codes as your proposal.<br>
<div><br></div></blockquote><div><br>Firstly, calculating the # of search t=
his way could constraint the searching<br>overhead in a certain level even =
when the total segments is too many. <br>Secondly, when there are more dirt=
y segments, the same # of garbage <br>
blocks might be more=C2=A0 scattered than when there are less dirty segment=
s.<br>So we search the # of the segments in proportion to the # of dirty se=
gments.<br></div><div><br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">It seems that we ca=
n obtain the performance gain just by setting the<br>
MAX_VICTIM_SEARCH to 4096, for example.<br>
So, how about just adding an ending criteria like below?<br>
<br></blockquote><div><br></div><div>I agree that we could get the performa=
nce improvement by simply enlarging<br>the MAX_VICTIM_SEARCH to 4096, but I=
 am concerning the scalability a little<br>bit. Because it might always sea=
rching the whole bitmap in some cases,<br>
for example, when dirty segments is 4000 and total segments is 409600.<br><=
br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (p-&gt;max_search &gt; MAX_VICTIM_SEARCH)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;max_search =
=3D MAX_VICTIM_SEARCH;<br></blockquote><div><br></div><div><br>
The optimization does not apply to SSR mode. There has a reason. <br>As not=
iced in the test, when SSR selected the segments that have most <br>garbage=
 blocks, then when gc is needed, all the dirty segments might have <br>
very less garbage blocks, thus the gc overhead is high. This might lead to =
<br>performance degradation. So the patch does not change the victim select=
ion<br>policy for SSR.<br>
<br>
What do you think now?<br></div><div>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
#define MAX_VICTIM_SEARCH 4096 /* covers 8GB */<br>
<div><div><br>
&gt; =C2=A0 =C2=A0 =C2=A0 p-&gt;offset =3D sbi-&gt;last_victim[p-&gt;gc_mod=
e];<br>
&gt; @@ -243,6 +245,8 @@ static int get_victim_by_default(struct f2fs_sb_in=
fo *sbi,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 struct victim_sel_policy p;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 unsigned int secno, max_cost;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 int nsearched =3D 0;<br>
&gt; + =C2=A0 =C2=A0 unsigned int max_search =3D MAX_VICTIM_SEARCH;<br>
&gt; + =C2=A0 =C2=A0 unsigned int nr_dirty;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 p.alloc_mode =3D alloc_mode;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 select_policy(sbi, gc_type, type, &amp;p);<br>
&gt; @@ -258,6 +262,27 @@ static int get_victim_by_default(struct f2fs_sb_i=
nfo *sbi,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto got_it;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 nr_dirty =3D dirty_i-&gt;nr_dirty[p.dirty_type];<br>
&gt; + =C2=A0 =C2=A0 if (p.gc_mode =3D=3D GC_GREEDY &amp;&amp; p.alloc_mode=
 !=3D SSR) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (TOTAL_SEGS(sbi) &lt;=
=3D FULL_VICTIM_SEARCH_THRESH)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 max_search =3D nr_dirty; /* search all the dirty segs */<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /*<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* With more dirty segments, garbage blocks are likely<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* more scattered, thus search harder for better<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* victim.<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*/<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 max_search =3D div_u64 ((nr_dirty *<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FULL_VICTIM_SEARCH_THRESH), TOTAL_SEGS(sbi)=
);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (max_search &lt; MIN_VICTIM_SEARCH_GREEDY)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_search =3D MIN_VICTIM_SEARCH_GREEDY;<br=
>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* no more than the total dirty segments */<br>
&gt; + =C2=A0 =C2=A0 if (max_search &gt; nr_dirty)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_search =3D nr_dirty;<b=
r>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while (1) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long cost;<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int segno;<b=
r>
&gt; @@ -290,7 +315,7 @@ static int get_victim_by_default(struct f2fs_sb_in=
fo *sbi,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cost =3D=3D max_c=
ost)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 continue;<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nsearched++ &gt;=3D MA=
X_VICTIM_SEARCH) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nsearched++ &gt;=3D ma=
x_search) {<br>
<br>
</div></div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nse=
arched++ &gt;=3D p.max_search) {<br>
<div><br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sbi-&gt;last_victim[p.gc_mode] =3D segno;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h<br>
&gt; index 2c6a6bd..2f525aa 100644<br>
&gt; --- a/fs/f2fs/gc.h<br>
&gt; +++ b/fs/f2fs/gc.h<br>
&gt; @@ -20,7 +20,9 @@<br>
&gt; =C2=A0#define LIMIT_FREE_BLOCK =C2=A0 =C2=A0 40 /* percentage over inv=
alid + free space */<br>
&gt;<br>
&gt; =C2=A0/* Search max. number of dirty segments to select a victim segme=
nt */<br>
&gt; -#define MAX_VICTIM_SEARCH =C2=A0 =C2=A020<br>
&gt; +#define MAX_VICTIM_SEARCH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020=
<br>
&gt; +#define MIN_VICTIM_SEARCH_GREEDY =C2=A0 =C2=A0 20<br>
&gt; +#define FULL_VICTIM_SEARCH_THRESH =C2=A0 =C2=A04096<br>
&gt;<br>
&gt; =C2=A0struct f2fs_gc_kthread {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 struct task_struct *f2fs_gc_task;<br>
&gt; diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h<br>
&gt; index 062424a..cd33f96 100644<br>
&gt; --- a/fs/f2fs/segment.h<br>
&gt; +++ b/fs/f2fs/segment.h<br>
&gt; @@ -142,6 +142,7 @@ struct victim_sel_policy {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 int alloc_mode; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* LFS or SSR */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 int gc_mode; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* GC_CB or GC_GREEDY */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 unsigned long *dirty_segmap; =C2=A0 =C2=A0/* dirt=
y segment bitmap */<br>
&gt; + =C2=A0 =C2=A0 int dirty_type;<br>
<br>
</div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int max_search; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* maximum # of segments to search */<br>
<div><div><br>
&gt; =C2=A0 =C2=A0 =C2=A0 unsigned int offset; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* last scanned bitmap offset */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 unsigned int ofs_unit; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* bitmap search unit */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 unsigned int min_cost; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* minimum cost */<br>
<br>
--<br>
</div></div><span><font color=3D"#888888">Jaegeuk Kim<br>
Samsung<br>
<br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">Thank=
s,<br></div><div class=3D"gmail_extra">Jin<br></div></div></div>

--047d7b3a8a8ed0380504e51f2a9e--


--===============8538355015878341376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
--===============8538355015878341376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============8538355015878341376==--
