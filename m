From: Gao Xiang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to
 one checkpoint but obsolete to the other
Date: Sun, 21 Jan 2018 11:27:06 +0800
Message-ID: <3b476513-e45d-4508-0aa3-3cb8691e0dfb@aol.com>
References: <20180119232903.40922-1-guoweichao@huawei.com>
 <ec3fd2c3-b5b9-fd2e-8eef-97090d853a68@huawei.com>
 <b5abe140-6d11-53ed-3095-4865b6fb2d21@aol.com>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hsiangkao@aol.com>) id 1ed6Hu-0007Jj-2o
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 21 Jan 2018 03:27:18 +0000
Received: from omr-m005e.mx.aol.com ([204.29.186.5])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) id 1ed6Hs-0000N8-Mc
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 21 Jan 2018 03:27:18 +0000
In-Reply-To: <b5abe140-6d11-53ed-3095-4865b6fb2d21@aol.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: guoweichao <guoweichao@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Weichao,


On 2018/1/21 0:02, guoweichao wrote:
> Hi Xiang,
>
> it's not related to SPOR. Just consider the case given by Chao Yu.
>

(It seems this email was not sent successfully, I resend it just for =

reference only)
Oh I see, I have considered the scenario what Chao said before.

1. write data into segment x;
2. write checkpoint A;
3. remove data in segment x;
4. write checkpoint B;
5. issue discard or write data into segment x;
6. sudden power-cut

Since f2fs is designed for double backup, 5) and 6), I think, actually belo=
ngs to checkpoint C.
and when we are in checkpoint C, checkpoint A becomes unsafe because the la=
test checkpoint is B.
and I think in that case we cannot prevent data writeback or something to p=
ollute checkpoint A.

However, node segments (another metadata) would be special,
but I have no idea whether introducing PRE2 would make all cases safe or no=
t.

In addition, if some data segments change between checkpoint A and C,
some weird data that it didn't have (new data or data from other files) wou=
ld be gotten when switching back to checkpoint A.


Thanks,

> Thanks,
> *From:*Gao Xiang
> *To:*guoweichao,
> *Cc:*linux-f2fs-devel@lists.sourceforge.net,heyunlei,
> *Date:*2018-01-20 11:49:22
> *Subject:*Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to one =

> checkpoint but obsolete to the other
>
> Hi Weichao,
>
>
> On 2018/1/19 23:47, guoweichao wrote:
> > A critical case is using the free segments as data segments which
> > are previously node segments to the old checkpoint. With fault injecting
> > of the newer CP pack, fsck can find errors when checking the sanity =

> of nid.
> Sorry to interrupt because I'm just curious about this scenario and the
> detail.
>
> As far as I know, if the whole blocks in a segment become invalid,
> the segment will become PREFREE, and then if a checkpoint is followed,
> we can reuse this segment or
> discard the whole segment safely after this checkpoint was done
> (I think It makes sure that this segment is certainly FREE and not
> reused in this checkpoint).
>
> If the segment in the old checkpoint is a node segment, and node blocks
> in the segment are all invalid until the new checkpoint.
> It seems no danger to reuse the FREE node segment as a data segment in
> the next checkpoint?
>
> or something related to SPOR? In my mind f2fs-tools ignores POR node
> chain...
>
> Thanks,
> > On 2018/1/20 7:29, Weichao Guo wrote:
> >> Currently, we set prefree segments as free ones after writing
> >> a checkpoint, then believe the segments could be used safely.
> >> However, if a sudden power-off coming and the newer checkpoint
> >> corrupted due to hardware issues at the same time, we will try
> >> to use the old checkpoint and may face an inconsistent file
> >> system status.
> >>
> >> How about add an PRE2 status for prefree segments, and make
> >> sure the segments could be used safely to both checkpoints?
> >> Or any better solutions? Or this is not a problem?
> >>
> >> Look forward to your comments!
> >>
> >> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> >> ---
> >>=A0=A0 fs/f2fs/gc.c=A0=A0=A0=A0=A0 | 11 +++++++++--
> >>=A0=A0 fs/f2fs/segment.c | 21 ++++++++++++++++++---
> >>=A0=A0 fs/f2fs/segment.h |=A0 6 ++++++
> >>=A0=A0 3 files changed, 33 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index 33e7969..153e3ea 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -1030,7 +1030,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * threshold, we can make =
them free by checkpoint. =

> Then, we
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * secure free segments wh=
ich doesn't need fggc any more.
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (prefree_segments(sbi)) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (prefree_segments(sbi) || prefre=
e2_segments(sbi)) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D wri=
te_checkpoint(sbi, &cpc);
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 goto stop;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (has_not_enough_free_secs(sbi, 0=
, 0) && =

> prefree2_segments(sbi)) {
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =
=3D write_checkpoint(sbi, &cpc);
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (=
ret)
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 goto stop;
> >> @@ -1063,8 +1068,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 gc_more;
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >>
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gc_type =3D=3D FG_GC)
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gc_type =3D=3D FG_GC) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D wri=
te_checkpoint(sbi, &cpc);
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =
=3D write_checkpoint(sbi, &cpc);
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >>=A0=A0=A0=A0=A0=A0 }
> >>=A0=A0 stop:
> >>=A0=A0=A0=A0=A0=A0 SIT_I(sbi)->last_victim[ALLOC_NEXT] =3D 0;
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index 2e8e054d..9dec445 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -1606,7 +1606,7 @@ static void =

> set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
> >>=A0=A0=A0=A0=A0=A0 unsigned int segno;
> >>
> >>=A0=A0=A0=A0=A0=A0 mutex_lock(&dirty_i->seglist_lock);
> >> -=A0=A0=A0 for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], =

> MAIN_SEGS(sbi))
> >> +=A0=A0=A0 for_each_set_bit(segno, dirty_i->dirty_segmap[PRE2], =

> MAIN_SEGS(sbi))
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __set_test_and_free(sbi, seg=
no);
> >>=A0=A0=A0=A0=A0=A0 mutex_unlock(&dirty_i->seglist_lock);
> >>=A0=A0 }
> >> @@ -1617,13 +1617,17 @@ void clear_prefree_segments(struct =

> f2fs_sb_info *sbi, struct cp_control *cpc)
> >>=A0=A0=A0=A0=A0=A0 struct list_head *head =3D &dcc->entry_list;
> >>=A0=A0=A0=A0=A0=A0 struct discard_entry *entry, *this;
> >>=A0=A0=A0=A0=A0=A0 struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
> >> -=A0=A0=A0 unsigned long *prefree_map =3D dirty_i->dirty_segmap[PRE];
> >> +=A0=A0=A0 unsigned long *prefree_map;
> >>=A0=A0=A0=A0=A0=A0 unsigned int start =3D 0, end =3D -1;
> >>=A0=A0=A0=A0=A0=A0 unsigned int secno, start_segno;
> >>=A0=A0=A0=A0=A0=A0 bool force =3D (cpc->reason & CP_DISCARD);
> >> +=A0=A0=A0 int phase =3D 0;
> >> +=A0=A0=A0 enum dirty_type dirty_type =3D PRE2;
> >>
> >>=A0=A0=A0=A0=A0=A0 mutex_lock(&dirty_i->seglist_lock);
> >>
> >> +next_step:
> >> +=A0=A0=A0 prefree_map =3D dirty_i->dirty_segmap[dirty_type];
> >>=A0=A0=A0=A0=A0=A0 while (1) {
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int i;
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 start =3D find_next_bit(pref=
ree_map, MAIN_SEGS(sbi), =

> end + 1);
> >> @@ -1635,7 +1639,7 @@ void clear_prefree_segments(struct =

> f2fs_sb_info *sbi, struct cp_control *cpc)
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D start; i < end; i=
++)
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clea=
r_bit(i, prefree_map);
> >>
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dirty_i->nr_dirty[PRE] -=3D end - s=
tart;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dirty_i->nr_dirty[dirty_type] -=3D =
end - start;
> >>
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!test_opt(sbi, DISCARD))
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cont=
inue;
> >> @@ -1663,6 +1667,16 @@ void clear_prefree_segments(struct =

> f2fs_sb_info *sbi, struct cp_control *cpc)
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 end =
=3D start - 1;
> >>=A0=A0=A0=A0=A0=A0 }
> >> +=A0=A0=A0 if (phase =3D=3D 0) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* status change: PRE -> PRE2 */
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for_each_set_bit(segno, dirty_i->di=
rty_segmap[PRE], =

> MAIN_SEGS(sbi))
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!test_a=
nd_set_bit(segno, prefree_map))
> >> + dirty_i->nr_dirty[PRE2]++;
> >> +
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 phase =3D 1;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dirty_type =3D PRE;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto next_step;
> >> +=A0=A0=A0 }
> >>=A0=A0=A0=A0=A0=A0 mutex_unlock(&dirty_i->seglist_lock);
> >>
> >>=A0=A0=A0=A0=A0=A0 /* send small discards */
> >> @@ -2245,6 +2259,7 @@ static void change_curseg(struct f2fs_sb_info =

> *sbi, int type)
> >>
> >>=A0=A0=A0=A0=A0=A0 mutex_lock(&dirty_i->seglist_lock);
> >>=A0=A0=A0=A0=A0=A0 __remove_dirty_segment(sbi, new_segno, PRE);
> >> +=A0=A0=A0 __remove_dirty_segment(sbi, new_segno, PRE2);
> >>=A0=A0=A0=A0=A0=A0 __remove_dirty_segment(sbi, new_segno, DIRTY);
> >>=A0=A0=A0=A0=A0=A0 mutex_unlock(&dirty_i->seglist_lock);
> >>
> >> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> >> index 71a2aaa..f702726 100644
> >> --- a/fs/f2fs/segment.h
> >> +++ b/fs/f2fs/segment.h
> >> @@ -263,6 +263,7 @@ enum dirty_type {
> >>=A0=A0=A0=A0=A0=A0 DIRTY_COLD_NODE,=A0=A0=A0=A0=A0=A0=A0 /* dirty segme=
nts assigned as cold =

> node logs */
> >>=A0=A0=A0=A0=A0=A0 DIRTY,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 /* to count # of dirty segments */
> >>=A0=A0=A0=A0=A0=A0 PRE,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 /* to count # of entirely obsolete =

> segments */
> >> +=A0=A0=A0 PRE2,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /* to count # of the segments free to =

> one checkpoint but obsolete to the other checkpoint */
> >>=A0=A0=A0=A0=A0=A0 NR_DIRTY_TYPE
> >>=A0=A0 };
> >>
> >> @@ -477,6 +478,11 @@ static inline unsigned int =

> prefree_segments(struct f2fs_sb_info *sbi)
> >>=A0=A0=A0=A0=A0=A0 return DIRTY_I(sbi)->nr_dirty[PRE];
> >>=A0=A0 }
> >>
> >> +static inline unsigned int prefree2_segments(struct f2fs_sb_info *sbi)
> >> +{
> >> +=A0=A0=A0 return DIRTY_I(sbi)->nr_dirty[PRE2];
> >> +}
> >> +
> >>=A0=A0 static inline unsigned int dirty_segments(struct f2fs_sb_info *s=
bi)
> >>=A0=A0 {
> >>=A0=A0=A0=A0=A0=A0 return DIRTY_I(sbi)->nr_dirty[DIRTY_HOT_DATA] +
> >>
>


---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
