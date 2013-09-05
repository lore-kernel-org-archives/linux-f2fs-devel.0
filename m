From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: optimize gc for better performance
Date: Thu, 05 Sep 2013 13:49:55 +0900
Message-ID: <1378356595.2354.90.camel@kjgkr>
References: <1378356326-2915-1-git-send-email-jinuxstyle@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1378356326-2915-1-git-send-email-jinuxstyle@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jin Xu <jinuxstyle@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Merged.
Thank you,

2013-09-05 (=EB=AA=A9), 12:45 +0800, Jin Xu:
> From: Jin Xu <jinuxstyle@gmail.com>
>=20
> This patch improves the gc efficiency by optimizing the victim
> selection policy. With this optimization, the random re-write
> performance could increase up to 20%.
>=20
> For f2fs, when disk is in shortage of free spaces, gc will selects
> dirty segments and moves valid blocks around for making more space
> available. The gc cost of a segment is determined by the valid blocks
> in the segment. The less the valid blocks, the higher the efficiency.
> The ideal victim segment is the one that has the most garbage blocks.
>=20
> Currently, it searches up to 20 dirty segments for a victim segment.
> The selected victim is not likely the best victim for gc when there
> are much more dirty segments. Why not searching more dirty segments
> for a better victim? The cost of searching dirty segments is
> negligible in comparison to moving blocks.
>=20
> In this patch, it enlarges the MAX_VICTIM_SEARCH to 4096 to make
> the search more aggressively for a possible better victim. Since
> it also applies to victim selection for SSR, it will likely improve
> the SSR efficiency as well.
>=20
> The test case is simple. It creates as many files until the disk full=
=2E
> The size for each file is 32KB. Then it writes as many as 100000
> records of 4KB size to random offsets of random files in sync mode.
> The testing was done on a 2GB partition of a SDHC card. Let's see the
> test result of f2fs without and with the patch.
>=20
> ---------------------------------------
> 2GB partition, SDHC
> create 52023 files of size 32768 bytes
> random re-write 100000 records of 4KB
> ---------------------------------------
> | file creation (s) | rewrite time (s) | gc count | gc garbage blocks=
 |
> [no patch]  341         4227             1174          174840
> [patched]   324         2958             645           106682
>=20
> It's obvious that, with the patch, f2fs finishes the test in 20+% les=
s
> time than without the patch. And internally it does much less gc with
> higher efficiency than before.
>=20
> Since the performance improvement is related to gc, it might not be s=
o
> obvious for other tests that do not trigger gc as often as this one (
> This is because f2fs selects dirty segments for SSR use most of the
> time when free space is in shortage). The well-known iozone test tool
> was not used for benchmarking the patch becuase it seems do not have
> a test case that performs random re-write on a full disk.
>=20
> This patch is the revised version based on the suggestion from
> Jaegeuk Kim.
>=20
> Signed-off-by: Jin Xu <jinuxstyle@gmail.com>
> [Jaegeuk Kim: suggested simpler solution]
> Reviewed-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> ---
>  fs/f2fs/gc.c      |    8 +++++++-
>  fs/f2fs/gc.h      |    2 +-
>  fs/f2fs/segment.h |    1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 35f9b1a..a78b8e3 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -138,12 +138,18 @@ static void select_policy(struct f2fs_sb_info *=
sbi, int gc_type,
>  	if (p->alloc_mode =3D=3D SSR) {
>  		p->gc_mode =3D GC_GREEDY;
>  		p->dirty_segmap =3D dirty_i->dirty_segmap[type];
> +		p->max_search =3D dirty_i->nr_dirty[type];
>  		p->ofs_unit =3D 1;
>  	} else {
>  		p->gc_mode =3D select_gc_type(gc_type);
>  		p->dirty_segmap =3D dirty_i->dirty_segmap[DIRTY];
> +		p->max_search =3D dirty_i->nr_dirty[DIRTY];
>  		p->ofs_unit =3D sbi->segs_per_sec;
>  	}
> +
> +	if (p->max_search > MAX_VICTIM_SEARCH)
> +		p->max_search =3D MAX_VICTIM_SEARCH;
> +
>  	p->offset =3D sbi->last_victim[p->gc_mode];
>  }
> =20
> @@ -290,7 +296,7 @@ static int get_victim_by_default(struct f2fs_sb_i=
nfo *sbi,
>  		if (cost =3D=3D max_cost)
>  			continue;
> =20
> -		if (nsearched++ >=3D MAX_VICTIM_SEARCH) {
> +		if (nsearched++ >=3D p.max_search) {
>  			sbi->last_victim[p.gc_mode] =3D segno;
>  			break;
>  		}
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 2c6a6bd..f8ee8a8 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -20,7 +20,7 @@
>  #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space =
*/
> =20
>  /* Search max. number of dirty segments to select a victim segment *=
/
> -#define MAX_VICTIM_SEARCH	20
> +#define MAX_VICTIM_SEARCH 4096 /* covers 8GB */
> =20
>  struct f2fs_gc_kthread {
>  	struct task_struct *f2fs_gc_task;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 062424a..dca6379 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -142,6 +142,7 @@ struct victim_sel_policy {
>  	int alloc_mode;			/* LFS or SSR */
>  	int gc_mode;			/* GC_CB or GC_GREEDY */
>  	unsigned long *dirty_segmap;	/* dirty segment bitmap */
> +	unsigned int max_search;	/* maximum # of segments to search */
>  	unsigned int offset;		/* last scanned bitmap offset */
>  	unsigned int ofs_unit;		/* bitmap search unit */
>  	unsigned int min_cost;		/* minimum cost */

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
