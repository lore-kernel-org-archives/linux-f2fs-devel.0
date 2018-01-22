From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to one
 checkpoint but obsolete to the other
Date: Mon, 22 Jan 2018 11:01:10 +0800
Message-ID: <6b660bed-25e9-e8df-3ac0-2ec475cd6262@huawei.com>
References: <20180119232903.40922-1-guoweichao@huawei.com>
 <ec3fd2c3-b5b9-fd2e-8eef-97090d853a68@huawei.com>
 <b5abe140-6d11-53ed-3095-4865b6fb2d21@aol.com>
 <3b476513-e45d-4508-0aa3-3cb8691e0dfb@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <3b476513-e45d-4508-0aa3-3cb8691e0dfb@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Gao Xiang <hsiangkao@aol.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Xiang,

On 2018/1/21 11:27, Gao Xiang wrote:
> Hi Weichao,
> 
> 
> On 2018/1/21 0:02, guoweichao wrote:
>> Hi Xiang,
>>
>> it's not related to SPOR. Just consider the case given by Chao Yu.
>>
> 
> (It seems this email was not sent successfully, I resend it just for reference only)
> Oh I see, I have considered the scenario what Chao said before.
> 
> 1. write data into segment x;
> 2. write checkpoint A;
> 3. remove data in segment x;
> 4. write checkpoint B;
> 5. issue discard or write data into segment x;
> 6. sudden power-cut
> 
> Since f2fs is designed for double backup, 5) and 6), I think, actually belongs to checkpoint C.
> and when we are in checkpoint C, checkpoint A becomes unsafe because the latest checkpoint is B.
> and I think in that case we cannot prevent data writeback or something to pollute checkpoint A.
We do not have to prevent data writeback, we could just delay to reuse the invalid blocks which are
valid to the older checkpoint.
> 
> However, node segments (another metadata) would be special,
> but I have no idea whether introducing PRE2 would make all cases safe or not.
By adding a PRE2 status, we could set prefree node segments in two steps: PRE->PRE2->FREE, and therefore
make sure using free segments are safe to both chepoints. I forgot to consider SSR at first, but the main
idea is similar: avoiding to use invalid blocks that are not invalid to the older checkpoint, writing a
new checkpoint if there is no other invalid blocks.
> 
> In addition, if some data segments change between checkpoint A and C,
> some weird data that it didn't have (new data or data from other files) would be gotten when switching back to checkpoint A.
Data blocks damage do not affect file system consistency.

Anyway, this is a hardware related problem. We could just keep unchanged and try to exposure hardware issues.

Thanks,
> 
> 
> Thanks,
> 
>> Thanks,
>> *From:*Gao Xiang
>> *To:*guoweichao,
>> *Cc:*linux-f2fs-devel@lists.sourceforge.net,heyunlei,
>> *Date:*2018-01-20 11:49:22
>> *Subject:*Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to one checkpoint but obsolete to the other
>>
>> Hi Weichao,
>>
>>
>> On 2018/1/19 23:47, guoweichao wrote:
>> > A critical case is using the free segments as data segments which
>> > are previously node segments to the old checkpoint. With fault injecting
>> > of the newer CP pack, fsck can find errors when checking the sanity of nid.
>> Sorry to interrupt because I'm just curious about this scenario and the
>> detail.
>>
>> As far as I know, if the whole blocks in a segment become invalid,
>> the segment will become PREFREE, and then if a checkpoint is followed,
>> we can reuse this segment or
>> discard the whole segment safely after this checkpoint was done
>> (I think It makes sure that this segment is certainly FREE and not
>> reused in this checkpoint).
>>
>> If the segment in the old checkpoint is a node segment, and node blocks
>> in the segment are all invalid until the new checkpoint.
>> It seems no danger to reuse the FREE node segment as a data segment in
>> the next checkpoint?
>>
>> or something related to SPOR? In my mind f2fs-tools ignores POR node
>> chain...
>>
>> Thanks,
>> > On 2018/1/20 7:29, Weichao Guo wrote:
>> >> Currently, we set prefree segments as free ones after writing
>> >> a checkpoint, then believe the segments could be used safely.
>> >> However, if a sudden power-off coming and the newer checkpoint
>> >> corrupted due to hardware issues at the same time, we will try
>> >> to use the old checkpoint and may face an inconsistent file
>> >> system status.
>> >>
>> >> How about add an PRE2 status for prefree segments, and make
>> >> sure the segments could be used safely to both checkpoints?
>> >> Or any better solutions? Or this is not a problem?
>> >>
>> >> Look forward to your comments!
>> >>
>> >> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>> >> ---
>> >>   fs/f2fs/gc.c      | 11 +++++++++--
>> >>   fs/f2fs/segment.c | 21 ++++++++++++++++++---
>> >>   fs/f2fs/segment.h |  6 ++++++
>> >>   3 files changed, 33 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> >> index 33e7969..153e3ea 100644
>> >> --- a/fs/f2fs/gc.c
>> >> +++ b/fs/f2fs/gc.c
>> >> @@ -1030,7 +1030,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>> >>                * threshold, we can make them free by checkpoint. Then, we
>> >>                * secure free segments which doesn't need fggc any more.
>> >>                */
>> >> -            if (prefree_segments(sbi)) {
>> >> +            if (prefree_segments(sbi) || prefree2_segments(sbi)) {
>> >> +                    ret = write_checkpoint(sbi, &cpc);
>> >> +                    if (ret)
>> >> +                            goto stop;
>> >> +            }
>> >> +            if (has_not_enough_free_secs(sbi, 0, 0) && prefree2_segments(sbi)) {
>> >>                       ret = write_checkpoint(sbi, &cpc);
>> >>                       if (ret)
>> >>                               goto stop;
>> >> @@ -1063,8 +1068,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>> >>                       goto gc_more;
>> >>               }
>> >>
>> >> -            if (gc_type == FG_GC)
>> >> +            if (gc_type == FG_GC) {
>> >> +                    ret = write_checkpoint(sbi, &cpc);
>> >>                       ret = write_checkpoint(sbi, &cpc);
>> >> +            }
>> >>       }
>> >>   stop:
>> >>       SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
>> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> >> index 2e8e054d..9dec445 100644
>> >> --- a/fs/f2fs/segment.c
>> >> +++ b/fs/f2fs/segment.c
>> >> @@ -1606,7 +1606,7 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
>> >>       unsigned int segno;
>> >>
>> >>       mutex_lock(&dirty_i->seglist_lock);
>> >> -    for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
>> >> +    for_each_set_bit(segno, dirty_i->dirty_segmap[PRE2], MAIN_SEGS(sbi))
>> >>               __set_test_and_free(sbi, segno);
>> >>       mutex_unlock(&dirty_i->seglist_lock);
>> >>   }
>> >> @@ -1617,13 +1617,17 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>> >>       struct list_head *head = &dcc->entry_list;
>> >>       struct discard_entry *entry, *this;
>> >>       struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>> >> -    unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
>> >> +    unsigned long *prefree_map;
>> >>       unsigned int start = 0, end = -1;
>> >>       unsigned int secno, start_segno;
>> >>       bool force = (cpc->reason & CP_DISCARD);
>> >> +    int phase = 0;
>> >> +    enum dirty_type dirty_type = PRE2;
>> >>
>> >>       mutex_lock(&dirty_i->seglist_lock);
>> >>
>> >> +next_step:
>> >> +    prefree_map = dirty_i->dirty_segmap[dirty_type];
>> >>       while (1) {
>> >>               int i;
>> >>               start = find_next_bit(prefree_map, MAIN_SEGS(sbi), end + 1);
>> >> @@ -1635,7 +1639,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>> >>               for (i = start; i < end; i++)
>> >>                       clear_bit(i, prefree_map);
>> >>
>> >> -            dirty_i->nr_dirty[PRE] -= end - start;
>> >> +            dirty_i->nr_dirty[dirty_type] -= end - start;
>> >>
>> >>               if (!test_opt(sbi, DISCARD))
>> >>                       continue;
>> >> @@ -1663,6 +1667,16 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>> >>               else
>> >>                       end = start - 1;
>> >>       }
>> >> +    if (phase == 0) {
>> >> +            /* status change: PRE -> PRE2 */
>> >> +            for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
>> >> +                    if (!test_and_set_bit(segno, prefree_map))
>> >> + dirty_i->nr_dirty[PRE2]++;
>> >> +
>> >> +            phase = 1;
>> >> +            dirty_type = PRE;
>> >> +            goto next_step;
>> >> +    }
>> >>       mutex_unlock(&dirty_i->seglist_lock);
>> >>
>> >>       /* send small discards */
>> >> @@ -2245,6 +2259,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
>> >>
>> >>       mutex_lock(&dirty_i->seglist_lock);
>> >>       __remove_dirty_segment(sbi, new_segno, PRE);
>> >> +    __remove_dirty_segment(sbi, new_segno, PRE2);
>> >>       __remove_dirty_segment(sbi, new_segno, DIRTY);
>> >>       mutex_unlock(&dirty_i->seglist_lock);
>> >>
>> >> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> >> index 71a2aaa..f702726 100644
>> >> --- a/fs/f2fs/segment.h
>> >> +++ b/fs/f2fs/segment.h
>> >> @@ -263,6 +263,7 @@ enum dirty_type {
>> >>       DIRTY_COLD_NODE,        /* dirty segments assigned as cold node logs */
>> >>       DIRTY,                  /* to count # of dirty segments */
>> >>       PRE,                    /* to count # of entirely obsolete segments */
>> >> +    PRE2,                   /* to count # of the segments free to one checkpoint but obsolete to the other checkpoint */
>> >>       NR_DIRTY_TYPE
>> >>   };
>> >>
>> >> @@ -477,6 +478,11 @@ static inline unsigned int prefree_segments(struct f2fs_sb_info *sbi)
>> >>       return DIRTY_I(sbi)->nr_dirty[PRE];
>> >>   }
>> >>
>> >> +static inline unsigned int prefree2_segments(struct f2fs_sb_info *sbi)
>> >> +{
>> >> +    return DIRTY_I(sbi)->nr_dirty[PRE2];
>> >> +}
>> >> +
>> >>   static inline unsigned int dirty_segments(struct f2fs_sb_info *sbi)
>> >>   {
>> >>       return DIRTY_I(sbi)->nr_dirty[DIRTY_HOT_DATA] +
>> >>
>>
> 
> 
> .
> 
