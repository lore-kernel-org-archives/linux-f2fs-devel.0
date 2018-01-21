From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to one
 checkpoint but obsolete to the other
Date: Sun, 21 Jan 2018 10:34:53 +0800
Message-ID: <927e0099-0bad-1a1c-1b03-ac5f935f3df5@kernel.org>
References: <20180119232903.40922-1-guoweichao@huawei.com>
 <6a06586a-7432-03c5-912a-410e4aa3b129@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <6a06586a-7432-03c5-912a-410e4aa3b129@kernel.org>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: guoweichao <guoweichao@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Weichao,

On 2018/1/20 23:50, guoweichao wrote:
> Hi Chao,
> 
> Yes, it is exactly what I mean.
> It seems that F2FS has no responsibility to cover hardware problems.
> However, file systems usually choose redundancy for super block fault tolerance.
> So I think we actually have considered some external errors when designing a file system.
> Our dual checkpoint mechanism is mainly designed to keep at least one stable
> CP pack while creating a new one in case of SPO. And it has fault tolerant effects.
> As CP pack is also very critical to F2FS, why not make checkpoint more robustness

I think you're trying to change basic design of A/B upgrade system to A/B/C one,
which can keep always two checkpoint valid. There will be no simple modification
to implement that one, in where we should cover not only prefree case but also
SSR case.

IMO, the biggest problem there is available space, since in checkpoint C, we can
only use invalid blocks in both checkpoint A and B, so in some cases there will
almost be no valid space we can use during allocation, result in frequently
checkpoint.

IMO, what we can do is trying to keep last valid checkpoint being integrity as
possible as we can. One way is that we can add mirror or parity for the
checkpoint which can help to do recovery once checkpoint is corrupted. At
least, I hope that with it in debug version we can help hardware staff to fix
their issue instead of wasting much time to troubleshoot filesystem issue.

Thanks,

> with simple modification in current design and little overhead except for FG_GC.
> Of cause, keep unchanged is OK. I just want to discuss this proposal. :)
> 
> Thanks,
> *From:*Chao Yu
> *To:*guoweichao,jaegeuk@kernel.org,
> *Cc:*linux-f2fs-devel@lists.sourceforge.net,linux-fsdevel@vger.kernel.org,heyunlei,
> *Date:*2018-01-20 15:43:23
> *Subject:*Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to one checkpoint but obsolete to the other
> 
> Hi Weichao,
> 
> On 2018/1/20 7:29, Weichao Guo wrote:
>> Currently, we set prefree segments as free ones after writing
>> a checkpoint, then believe the segments could be used safely.
>> However, if a sudden power-off coming and the newer checkpoint
>> corrupted due to hardware issues at the same time, we will try
>> to use the old checkpoint and may face an inconsistent file
>> system status.
> 
> IIUC, you mean:
> 
> 1. write nodes into segment x;
> 2. write checkpoint A;
> 3. remove nodes in segment x;
> 4. write checkpoint B;
> 5. issue discard or write datas into segment x;
> 6. sudden power-cut
> 
> But after reboot, we found checkpoint B is corrupted due to hardware, and
> then start to use checkpoint A, but nodes in segment x recorded as valid
> data in checkpoint A has been overcovered in step 5), so we will encounter
> inconsistent meta data, right?
> 
> Thanks,
> 
>>
>> How about add an PRE2 status for prefree segments, and make
>> sure the segments could be used safely to both checkpoints?
>> Or any better solutions? Or this is not a problem?
>>
>> Look forward to your comments!
>>
>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>> ---
>>  fs/f2fs/gc.c      | 11 +++++++++--
>>  fs/f2fs/segment.c | 21 ++++++++++++++++++---
>>  fs/f2fs/segment.h |  6 ++++++
>>  3 files changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 33e7969..153e3ea 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -1030,7 +1030,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>    * threshold, we can make them free by checkpoint. Then, we
>>    * secure free segments which doesn't need fggc any more.
>>    */
>> - if (prefree_segments(sbi)) {
>> + if (prefree_segments(sbi) || prefree2_segments(sbi)) {
>> + ret = write_checkpoint(sbi, &cpc);
>> + if (ret)
>> + goto stop;
>> + }
>> + if (has_not_enough_free_secs(sbi, 0, 0) && prefree2_segments(sbi)) {
>>   ret = write_checkpoint(sbi, &cpc);
>>   if (ret)
>>   goto stop;
>> @@ -1063,8 +1068,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>   goto gc_more;
>>   }
>>  
>> - if (gc_type == FG_GC)
>> + if (gc_type == FG_GC) {
>> + ret = write_checkpoint(sbi, &cpc);
>>   ret = write_checkpoint(sbi, &cpc);
>> + }
>>   }
>>  stop:
>>   SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 2e8e054d..9dec445 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1606,7 +1606,7 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
>>   unsigned int segno;
>>  
>>   mutex_lock(&dirty_i->seglist_lock);
>> - for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
>> + for_each_set_bit(segno, dirty_i->dirty_segmap[PRE2], MAIN_SEGS(sbi))
>>   __set_test_and_free(sbi, segno);
>>   mutex_unlock(&dirty_i->seglist_lock);
>>  }
>> @@ -1617,13 +1617,17 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   struct list_head *head = &dcc->entry_list;
>>   struct discard_entry *entry, *this;
>>   struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>> - unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
>> + unsigned long *prefree_map;
>>   unsigned int start = 0, end = -1;
>>   unsigned int secno, start_segno;
>>   bool force = (cpc->reason & CP_DISCARD);
>> + int phase = 0;
>> + enum dirty_type dirty_type = PRE2;
>>  
>>   mutex_lock(&dirty_i->seglist_lock);
>>  
>> +next_step:
>> + prefree_map = dirty_i->dirty_segmap[dirty_type];
>>   while (1) {
>>   int i;
>>   start = find_next_bit(prefree_map, MAIN_SEGS(sbi), end + 1);
>> @@ -1635,7 +1639,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   for (i = start; i < end; i++)
>>   clear_bit(i, prefree_map);
>>  
>> - dirty_i->nr_dirty[PRE] -= end - start;
>> + dirty_i->nr_dirty[dirty_type] -= end - start;
>>  
>>   if (!test_opt(sbi, DISCARD))
>>   continue;
>> @@ -1663,6 +1667,16 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   else
>>   end = start - 1;
>>   }
>> + if (phase == 0) {
>> + /* status change: PRE -> PRE2 */
>> + for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
>> + if (!test_and_set_bit(segno, prefree_map))
>> + dirty_i->nr_dirty[PRE2]++;
>> +
>> + phase = 1;
>> + dirty_type = PRE;
>> + goto next_step;
>> + }
>>   mutex_unlock(&dirty_i->seglist_lock);
>>  
>>   /* send small discards */
>> @@ -2245,6 +2259,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
>>  
>>   mutex_lock(&dirty_i->seglist_lock);
>>   __remove_dirty_segment(sbi, new_segno, PRE);
>> + __remove_dirty_segment(sbi, new_segno, PRE2);
>>   __remove_dirty_segment(sbi, new_segno, DIRTY);
>>   mutex_unlock(&dirty_i->seglist_lock);
>>  
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 71a2aaa..f702726 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -263,6 +263,7 @@ enum dirty_type {
>>   DIRTY_COLD_NODE, /* dirty segments assigned as cold node logs */
>>   DIRTY, /* to count # of dirty segments */
>>   PRE, /* to count # of entirely obsolete segments */
>> + PRE2, /* to count # of the segments free to one checkpoint but obsolete to the other checkpoint */
>>   NR_DIRTY_TYPE
>>  };
>>  
>> @@ -477,6 +478,11 @@ static inline unsigned int prefree_segments(struct f2fs_sb_info *sbi)
>>   return DIRTY_I(sbi)->nr_dirty[PRE];
>>  }
>>  
>> +static inline unsigned int prefree2_segments(struct f2fs_sb_info *sbi)
>> +{
>> + return DIRTY_I(sbi)->nr_dirty[PRE2];
>> +}
>> +
>>  static inline unsigned int dirty_segments(struct f2fs_sb_info *sbi)
>>  {
>>   return DIRTY_I(sbi)->nr_dirty[DIRTY_HOT_DATA] +
>>
