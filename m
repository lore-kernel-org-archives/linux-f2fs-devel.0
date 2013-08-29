From: jin xu <jinuxstyle@gmail.com>
Subject: Re: [PATCH] f2fs: optimize gc for better performance
Date: Thu, 29 Aug 2013 13:00:08 +0800
Message-ID: <CAGchX6JPZbi66PzrWjucXpmtFKs9A9o=mLxQm7Mwmu4kU5QsgA@mail.gmail.com>
References: <1377737323-11803-1-git-send-email-jinuxstyle@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4556718458997884008=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinuxstyle@gmail.com>) id 1VEuLA-0007GU-AX
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Aug 2013 05:00:16 +0000
Received: from mail-oa0-f41.google.com ([209.85.219.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VEuL8-0005HJ-Dh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Aug 2013 05:00:16 +0000
Received: by mail-oa0-f41.google.com with SMTP id j17so3843766oag.28
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 28 Aug 2013 22:00:08 -0700 (PDT)
In-Reply-To: <1377737323-11803-1-git-send-email-jinuxstyle@gmail.com>
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
Cc: linux-fsdevel@vger.kernel.org, jinuxstyle@gmail.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

--===============4556718458997884008==
Content-Type: multipart/alternative; boundary=089e0158adfee814d504e50efa05

--089e0158adfee814d504e50efa05
Content-Type: text/plain; charset=ISO-8859-1

Correct the wrongly placed gc statistics in the test result part:

----without the patch----
created 52023 files of size 32768 bytes in 341 seconds
finished 100000 loops in 4204 seconds
(internally, 1255 gc were done, 181101 garbage blocks were reclaimed)

----with the patch----
created 52023 files of size 32768 bytes in 326 seconds
finished 100000 loops in 3067 seconds
(internally, 722 gc were done, 115939 garbage blocks were reclaimed)

And the formula is not formatted well in gmail, it should be like this,

                           ,-- nr_dirty_segments, if total_segments <
threshold
(# of search) = |
                           `-- (nr_dirty_segments * threshold) /
total_segments,
                                   Otherwise
--
Regards,
Jin


On Thu, Aug 29, 2013 at 8:48 AM, Jin Xu <jinuxstyle@gmail.com> wrote:

> From: Jin Xu <jinuxstyle@gmail.com>
>
> This patch improves the foreground gc efficiency by optimizing the
> victim selection policy. With this optimization, the random re-write
> performance could increase up to 20%.
>
> For f2fs, foreground gc happens when disk is lack of free spaces,
> it selects dirty segments and moves valid blocks around for making
> more space available. The gc cost of a segment is determined by the
> valid blocks in the segment. The less the valid blocks, the higher
> the efficiency. The ideal victim segment is the one that has the
> most garbage blocks.
>
> Currently, it searches up to 20 dirty segments for a victim segment.
> The selected victim is not likely the best victim for gc when there
> are much more dirty segments. Why not searching more dirty segments
> for a better victim? The cost of searching dirty segments is
> negligible in comparison to moving blocks.
>
> In this patch, it does not search a constant number of dirty segments
> anymore, instead it calculates the number based on the total segments,
> dirty segments and a threshold. Following is the pseudo formula.
>                 ,-- nr_dirty_segments, if total_segments < threshold
> (# of search) = |
>                 `-- (nr_dirty_segments * threshold) / total_segments,
>                         Otherwise
>
> The test case is simple. It creates as many files until the disk full.
> The size for each file is 32KB. Then it writes as many as 100000
> records of 4KB size to random offsets of random files in sync mode.
> The testing was done on a 2GB partition of a SDHC card. Let's see the
> test result of f2fs without and with the patch.
>
> ----without the patch----
> created 52023 files of size 32768 bytes in 341 seconds
> finished 100000 loops in 4204 seconds
> (internally, 722 gc were done, 115939 garbage blocks were reclaimed)
>
> ----with the patch----
> created 52023 files of size 32768 bytes in 326 seconds
> finished 100000 loops in 3067 seconds
> (internally, 1255 gc were done, 181101 garbage blocks were reclaimed)
>
> It's obvious that, with the patch, f2fs finishes the test in 20+% less
> time than without the patch.
>
> Since the performance improvement is related to gc, it might not be so
> obvious for other tests that do not trigger gc as often as this one (
> This is because f2fs selects dirty segments for SSR use most of the
> time when free space is in shortage). The well-known iozone test tool
> was not used for benchmarking the patch becuase it seems do not have
> a test case that performs random re-write on a full disk.
>
> Signed-off-by: Jin Xu <jinuxstyle@gmail.com>
> ---
>  fs/f2fs/gc.c      |   27 ++++++++++++++++++++++++++-
>  fs/f2fs/gc.h      |    4 +++-
>  fs/f2fs/segment.h |    1 +
>  3 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 35f9b1a..4e045e6 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -138,10 +138,12 @@ static void select_policy(struct f2fs_sb_info *sbi,
> int gc_type,
>         if (p->alloc_mode == SSR) {
>                 p->gc_mode = GC_GREEDY;
>                 p->dirty_segmap = dirty_i->dirty_segmap[type];
> +               p->dirty_type = type;
>                 p->ofs_unit = 1;
>         } else {
>                 p->gc_mode = select_gc_type(gc_type);
>                 p->dirty_segmap = dirty_i->dirty_segmap[DIRTY];
> +               p->dirty_type = DIRTY;
>                 p->ofs_unit = sbi->segs_per_sec;
>         }
>         p->offset = sbi->last_victim[p->gc_mode];
> @@ -243,6 +245,8 @@ static int get_victim_by_default(struct f2fs_sb_info
> *sbi,
>         struct victim_sel_policy p;
>         unsigned int secno, max_cost;
>         int nsearched = 0;
> +       unsigned int max_search = MAX_VICTIM_SEARCH;
> +       unsigned int nr_dirty;
>
>         p.alloc_mode = alloc_mode;
>         select_policy(sbi, gc_type, type, &p);
> @@ -258,6 +262,27 @@ static int get_victim_by_default(struct f2fs_sb_info
> *sbi,
>                         goto got_it;
>         }
>
> +       nr_dirty = dirty_i->nr_dirty[p.dirty_type];
> +       if (p.gc_mode == GC_GREEDY && p.alloc_mode != SSR) {
> +               if (TOTAL_SEGS(sbi) <= FULL_VICTIM_SEARCH_THRESH)
> +                       max_search = nr_dirty; /* search all the dirty
> segs */
> +               else {
> +                       /*
> +                        * With more dirty segments, garbage blocks are
> likely
> +                        * more scattered, thus search harder for better
> +                        * victim.
> +                        */
> +                       max_search = div_u64 ((nr_dirty *
> +                               FULL_VICTIM_SEARCH_THRESH),
> TOTAL_SEGS(sbi));
> +                       if (max_search < MIN_VICTIM_SEARCH_GREEDY)
> +                               max_search = MIN_VICTIM_SEARCH_GREEDY;
> +               }
> +       }
> +
> +       /* no more than the total dirty segments */
> +       if (max_search > nr_dirty)
> +               max_search = nr_dirty;
> +
>         while (1) {
>                 unsigned long cost;
>                 unsigned int segno;
> @@ -290,7 +315,7 @@ static int get_victim_by_default(struct f2fs_sb_info
> *sbi,
>                 if (cost == max_cost)
>                         continue;
>
> -               if (nsearched++ >= MAX_VICTIM_SEARCH) {
> +               if (nsearched++ >= max_search) {
>                         sbi->last_victim[p.gc_mode] = segno;
>                         break;
>                 }
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 2c6a6bd..2f525aa 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -20,7 +20,9 @@
>  #define LIMIT_FREE_BLOCK       40 /* percentage over invalid + free space
> */
>
>  /* Search max. number of dirty segments to select a victim segment */
> -#define MAX_VICTIM_SEARCH      20
> +#define MAX_VICTIM_SEARCH              20
> +#define MIN_VICTIM_SEARCH_GREEDY       20
> +#define FULL_VICTIM_SEARCH_THRESH      4096
>
>  struct f2fs_gc_kthread {
>         struct task_struct *f2fs_gc_task;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 062424a..cd33f96 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -142,6 +142,7 @@ struct victim_sel_policy {
>         int alloc_mode;                 /* LFS or SSR */
>         int gc_mode;                    /* GC_CB or GC_GREEDY */
>         unsigned long *dirty_segmap;    /* dirty segment bitmap */
> +       int dirty_type;
>         unsigned int offset;            /* last scanned bitmap offset */
>         unsigned int ofs_unit;          /* bitmap search unit */
>         unsigned int min_cost;          /* minimum cost */
> --
> 1.7.9.5
>
>

--089e0158adfee814d504e50efa05
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Correct the wrongly placed gc statistics in the test =
result part:<br><br><div style=3D"margin-left:40px">----without the patch--=
--<br>
created 52023 files of size 32768 bytes in 341 seconds<br>
finished 100000 loops in 4204 seconds<br>(internally, 1255 gc were done, 18=
1101 garbage blocks were reclaimed)<br><br>
----with the patch----<br>
created 52023 files of size 32768 bytes in 326 seconds<br>
finished 100000 loops in 3067 seconds<br>(internally, 722 gc were done, 115=
939 garbage blocks were reclaimed)<br></div>

<br>And the formula is not formatted well in gmail, it should be like this,=
 <br><br><div style=3D"margin-left:40px">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ,-- nr_dirty_segments, if tot=
al_segments &lt; threshold<br>
(# of search) =3D |<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `-- (nr_di=
rty_segments * threshold) / total_segments,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Otherwise<br></div>--<br></div><div>Regards,<br></div>Jin<br>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu,=
 Aug 29, 2013 at 8:48 AM, Jin Xu <span dir=3D"ltr">&lt;<a href=3D"mailto:ji=
nuxstyle@gmail.com" target=3D"_blank">jinuxstyle@gmail.com</a>&gt;</span> w=
rote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">From: Jin Xu &lt;<a href=3D"mailto:jinuxstyl=
e@gmail.com">jinuxstyle@gmail.com</a>&gt;<br>
<br>
This patch improves the foreground gc efficiency by optimizing the<br>
victim selection policy. With this optimization, the random re-write<br>
performance could increase up to 20%.<br>
<br>
For f2fs, foreground gc happens when disk is lack of free spaces,<br>
it selects dirty segments and moves valid blocks around for making<br>
more space available. The gc cost of a segment is determined by the<br>
valid blocks in the segment. The less the valid blocks, the higher<br>
the efficiency. The ideal victim segment is the one that has the<br>
most garbage blocks.<br>
<br>
Currently, it searches up to 20 dirty segments for a victim segment.<br>
The selected victim is not likely the best victim for gc when there<br>
are much more dirty segments. Why not searching more dirty segments<br>
for a better victim? The cost of searching dirty segments is<br>
negligible in comparison to moving blocks.<br>
<br>
In this patch, it does not search a constant number of dirty segments<br>
anymore, instead it calculates the number based on the total segments,<br>
dirty segments and a threshold. Following is the pseudo formula.<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,-- nr_dirty_segments, if total_segments &l=
t; threshold<br>
(# of search) =3D |<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 `-- (nr_dirty_segments * threshold) / total=
_segments,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Otherwise<br>
<br>
The test case is simple. It creates as many files until the disk full.<br>
The size for each file is 32KB. Then it writes as many as 100000<br>
records of 4KB size to random offsets of random files in sync mode.<br>
The testing was done on a 2GB partition of a SDHC card. Let&#39;s see the<b=
r>
test result of f2fs without and with the patch.<br>
<br>
----without the patch----<br>
created 52023 files of size 32768 bytes in 341 seconds<br>
finished 100000 loops in 4204 seconds<br>
(internally, 722 gc were done, 115939 garbage blocks were reclaimed)<br>
<br>
----with the patch----<br>
created 52023 files of size 32768 bytes in 326 seconds<br>
finished 100000 loops in 3067 seconds<br>
(internally, 1255 gc were done, 181101 garbage blocks were reclaimed)<br>
<br>
It&#39;s obvious that, with the patch, f2fs finishes the test in 20+% less<=
br>
time than without the patch.<br>
<br>
Since the performance improvement is related to gc, it might not be so<br>
obvious for other tests that do not trigger gc as often as this one (<br>
This is because f2fs selects dirty segments for SSR use most of the<br>
time when free space is in shortage). The well-known iozone test tool<br>
was not used for benchmarking the patch becuase it seems do not have<br>
a test case that performs random re-write on a full disk.<br>
<br>
Signed-off-by: Jin Xu &lt;<a href=3D"mailto:jinuxstyle@gmail.com">jinuxstyl=
e@gmail.com</a>&gt;<br>
---<br>
=A0fs/f2fs/gc.c =A0 =A0 =A0| =A0 27 ++++++++++++++++++++++++++-<br>
=A0fs/f2fs/gc.h =A0 =A0 =A0| =A0 =A04 +++-<br>
=A0fs/f2fs/segment.h | =A0 =A01 +<br>
=A03 files changed, 30 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c<br>
index 35f9b1a..4e045e6 100644<br>
--- a/fs/f2fs/gc.c<br>
+++ b/fs/f2fs/gc.c<br>
@@ -138,10 +138,12 @@ static void select_policy(struct f2fs_sb_info *sbi, i=
nt gc_type,<br>
=A0 =A0 =A0 =A0 if (p-&gt;alloc_mode =3D=3D SSR) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;gc_mode =3D GC_GREEDY;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;dirty_segmap =3D dirty_i-&gt;dirty_se=
gmap[type];<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;dirty_type =3D type;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;ofs_unit =3D 1;<br>
=A0 =A0 =A0 =A0 } else {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;gc_mode =3D select_gc_type(gc_type);<=
br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;dirty_segmap =3D dirty_i-&gt;dirty_se=
gmap[DIRTY];<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;dirty_type =3D DIRTY;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;ofs_unit =3D sbi-&gt;segs_per_sec;<br=
>
=A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 p-&gt;offset =3D sbi-&gt;last_victim[p-&gt;gc_mode];<br>
@@ -243,6 +245,8 @@ static int get_victim_by_default(struct f2fs_sb_info *s=
bi,<br>
=A0 =A0 =A0 =A0 struct victim_sel_policy p;<br>
=A0 =A0 =A0 =A0 unsigned int secno, max_cost;<br>
=A0 =A0 =A0 =A0 int nsearched =3D 0;<br>
+ =A0 =A0 =A0 unsigned int max_search =3D MAX_VICTIM_SEARCH;<br>
+ =A0 =A0 =A0 unsigned int nr_dirty;<br>
<br>
=A0 =A0 =A0 =A0 p.alloc_mode =3D alloc_mode;<br>
=A0 =A0 =A0 =A0 select_policy(sbi, gc_type, type, &amp;p);<br>
@@ -258,6 +262,27 @@ static int get_victim_by_default(struct f2fs_sb_info *=
sbi,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto got_it;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
+ =A0 =A0 =A0 nr_dirty =3D dirty_i-&gt;nr_dirty[p.dirty_type];<br>
+ =A0 =A0 =A0 if (p.gc_mode =3D=3D GC_GREEDY &amp;&amp; p.alloc_mode !=3D S=
SR) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TOTAL_SEGS(sbi) &lt;=3D FULL_VICTIM_SEARC=
H_THRESH)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_search =3D nr_dirty; /* s=
earch all the dirty segs */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* With more dirty segments=
, garbage blocks are likely<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* more scattered, thus sea=
rch harder for better<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* victim.<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_search =3D div_u64 ((nr_d=
irty *<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FULL_VICTIM_S=
EARCH_THRESH), TOTAL_SEGS(sbi));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_search &lt; MIN_VICTI=
M_SEARCH_GREEDY)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_search =
=3D MIN_VICTIM_SEARCH_GREEDY;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* no more than the total dirty segments */<br>
+ =A0 =A0 =A0 if (max_search &gt; nr_dirty)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_search =3D nr_dirty;<br>
+<br>
=A0 =A0 =A0 =A0 while (1) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long cost;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int segno;<br>
@@ -290,7 +315,7 @@ static int get_victim_by_default(struct f2fs_sb_info *s=
bi,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cost =3D=3D max_cost)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nsearched++ &gt;=3D MAX_VICTIM_SEARCH) {<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nsearched++ &gt;=3D max_search) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sbi-&gt;last_victim[p.gc_mo=
de] =3D segno;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h<br>
index 2c6a6bd..2f525aa 100644<br>
--- a/fs/f2fs/gc.h<br>
+++ b/fs/f2fs/gc.h<br>
@@ -20,7 +20,9 @@<br>
=A0#define LIMIT_FREE_BLOCK =A0 =A0 =A0 40 /* percentage over invalid + fre=
e space */<br>
<br>
=A0/* Search max. number of dirty segments to select a victim segment */<br=
>
-#define MAX_VICTIM_SEARCH =A0 =A0 =A020<br>
+#define MAX_VICTIM_SEARCH =A0 =A0 =A0 =A0 =A0 =A0 =A020<br>
+#define MIN_VICTIM_SEARCH_GREEDY =A0 =A0 =A0 20<br>
+#define FULL_VICTIM_SEARCH_THRESH =A0 =A0 =A04096<br>
<br>
=A0struct f2fs_gc_kthread {<br>
=A0 =A0 =A0 =A0 struct task_struct *f2fs_gc_task;<br>
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h<br>
index 062424a..cd33f96 100644<br>
--- a/fs/f2fs/segment.h<br>
+++ b/fs/f2fs/segment.h<br>
@@ -142,6 +142,7 @@ struct victim_sel_policy {<br>
=A0 =A0 =A0 =A0 int alloc_mode; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* LFS or S=
SR */<br>
=A0 =A0 =A0 =A0 int gc_mode; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* GC_C=
B or GC_GREEDY */<br>
=A0 =A0 =A0 =A0 unsigned long *dirty_segmap; =A0 =A0/* dirty segment bitmap=
 */<br>
+ =A0 =A0 =A0 int dirty_type;<br>
=A0 =A0 =A0 =A0 unsigned int offset; =A0 =A0 =A0 =A0 =A0 =A0/* last scanned=
 bitmap offset */<br>
=A0 =A0 =A0 =A0 unsigned int ofs_unit; =A0 =A0 =A0 =A0 =A0/* bitmap search =
unit */<br>
=A0 =A0 =A0 =A0 unsigned int min_cost; =A0 =A0 =A0 =A0 =A0/* minimum cost *=
/<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.9.5<br>
<br>
</font></span></blockquote></div><br></div>

--089e0158adfee814d504e50efa05--


--===============4556718458997884008==
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
--===============4556718458997884008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============4556718458997884008==--
