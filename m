From: Hou Pengyang <houpengyang@huawei.com>
Subject: Re: [RFC] add ovp valid_blocks check for bg gc victim to
 fg_gc
Date: Fri, 17 Feb 2017 13:09:59 +0800
Message-ID: <58A685A7.3000601@huawei.com>
References: <20170216123431.14811-1-houpengyang@huawei.com>
	<20170216234813.GA64229@jaegeuk.local>
	<58A660F2.1070201@huawei.com>
	<20170217025411.GA79127@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1ceaoG-0002vR-4C
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 05:10:20 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ceaoD-0008N6-AN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 05:10:20 +0000
In-Reply-To: <20170217025411.GA79127@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/17 10:54, Jaegeuk Kim wrote:
> On 02/17, Hou Pengyang wrote:
>> On 2017/2/17 7:48, Jaegeuk Kim wrote:
>>> Hi Pengyang,
>>>
>>> Nice
>> Hi Jaegeuk,
>> catch!
>>>
>>> I think fggc_threshold needs to be revised, and we need to consider about
>>> general victim selection as well.
>>>
>>> Could you take a look at this?
>>>
>>>>  From 23b265f5ca6405032d092e240c94a827f743e42b Mon Sep 17 00:00:00 2001
>>> From: Hou Pengyang <houpengyang@huawei.com>
>>> Date: Thu, 16 Feb 2017 12:34:31 +0000
>>> Subject: [PATCH] f2fs: add ovp valid_blocks check for bg gc victim to fg_gc
>>>
>>> For foreground gc, greedy algorithm should be adapted, which makes
>>> this formula work well:
>>>
>>> 	(2 * (100 / config.overprovision + 1) + 6)
>>>
>>> But currently, we fg_gc have a prior to select bg_gc victim segments to gc first,
>>> these victims are selected by cost-benefit algorithm, we can't guarantee such segments
>>> have the small valid blocks, which may destroy the f2fs rule, on the worstest case, would
>>> consume all the free segments.
>>>
>>> This patch fix this by add a filter in check_bg_victims, if segment's has # of valid blocks
>>> over overprovision ratio, skip such segments.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/f2fs.h    |  3 +++
>>>    fs/f2fs/gc.c      | 22 ++++++++++++++++++++--
>>>    fs/f2fs/segment.h |  9 +++++++++
>>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index cc22dc458896..1c9f0cc8f027 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -888,6 +888,9 @@ struct f2fs_sb_info {
>>>    	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
>>>    	unsigned int cur_victim_sec;		/* current victim section num */
>>>
>>> +	/* threshold for converting bg victims for fg */
>>> +	u64 fggc_threshold;
>>> +
>>>    	/* maximum # of trials to find a victim segment for SSR and GC */
>>>    	unsigned int max_victim_search;
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 88e5e7b10ab6..fd4e479820e6 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -166,7 +166,8 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>>>    		p->ofs_unit = sbi->segs_per_sec;
>>>    	}
>>>
>>> -	if (p->max_search > sbi->max_victim_search)
>>> +	/* we need to check every dirty segments in the FG_GC case */
>>> +	if (gc_type != FG_GC && p->max_search > sbi->max_victim_search)
>>>    		p->max_search = sbi->max_victim_search;
>>>
>>>    	p->offset = sbi->last_victim[p->gc_mode];
>>> @@ -199,6 +200,10 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
>>>    	for_each_set_bit(secno, dirty_i->victim_secmap, MAIN_SECS(sbi)) {
>>>    		if (sec_usage_check(sbi, secno))
>>>    			continue;
>>> +
>>> +		if (no_fggc_candidate(sbi, secno))
>>> +			continue;
>>> +
>>>    		clear_bit(secno, dirty_i->victim_secmap);
>>>    		return secno * sbi->segs_per_sec;
>>>    	}
>>> @@ -322,13 +327,15 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>>>    			nsearched++;
>>>    		}
>>>
>>> -
>>>    		secno = GET_SECNO(sbi, segno);
>>>
>>>    		if (sec_usage_check(sbi, secno))
>>>    			goto next;
>>>    		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>>>    			goto next;
>>> +		if (gc_type == FG_GC && p.alloc_mode == LFS &&
>>> +					no_fggc_candidate(sbi, secno))
>>> +			goto next;
>>>
>>>    		cost = get_gc_cost(sbi, segno, &p);
>>>
>>> @@ -989,5 +996,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
>>>
>>>    void build_gc_manager(struct f2fs_sb_info *sbi)
>>>    {
>>> +	u64 user_block_count, ovp_count, blocks_per_sec, th;
>>> +
>>>    	DIRTY_I(sbi)->v_ops = &default_v_ops;
>>> +
>>> +	/* threshold of # of valid blocks in a section for victims of FG_GC */
>>> +	user_block_count = sbi->user_block_count;
>>> +	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
>>
>> About the ovp_count calculation,
>>
>> in mkfs.f2fs, we get ovp_segment by
>>
>>      set_cp(overprov_segment_count, (get_sb(segment_count_main) -
>>             get_cp(rsvd_segment_count)) *
>>              config.overprovision / 100);
>>
>>      set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
>>              get_cp(rsvd_segment_count));
>>
>> where the overprov calculation is based on the space excluding the
>> rsvd segment, and the final overprov_segment is sum of the REAL
>> overprov segments and the rsvd ones.
>>
>> So, when to calculate the overprov ratio, the rsvd segments should
>> be subtracted from the ckpt->overprov_semgents?
>
> I just got calculation from fresh mounted image. What I could confirm was that
> user can see (main_segments - ovp_segments).

I add some log into mkfs.f2fs, and get the config.overprovision,
rsvd/ovrp segments, user_block_count, and use the mkfs.f2fs to 
formatting a 512M disk, where:

config.overprovision: 10

ovrp : 50 segments(25600 blocks)
rsvd : 28 segments(14336 blocks)
user_block_count: 101376 blocks

Use ovrp/rsvd/user_block_count to get the ovrp ratio info reversely :

1) user_block_count/(user_block_count + ovrp blocks)

   101376/(101376+25600) = 79%

2) user_block_count/(user_block_count + ovrp_blocks - rsvd_blocks)

   101376/(101376+25600-14336) = 90% = 1-10%

By 2), 1-90%, we can get the original config.overprovion when mkfs.f2fs
So I think we should use 2) to calculate ovrp ratio. Anything I miss
in 2)?

Thanks,

> BTW, it's worth to verify reserved_segments with that.
>


>>
>> Thanks,
>>
>>> +	blocks_per_sec = sbi->blocks_per_seg * sbi->segs_per_sec;
>>> +
>>> +	th = user_block_count * 100 * blocks_per_sec /
>>> +			((user_block_count + ovp_count) * 100);
>>> +	sbi->fggc_threshold = th;
>>>    }
>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index 5cb5755c75d9..f4020f141d83 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -716,6 +716,15 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
>>>    				- (base + 1) + type;
>>>    }
>>>
>>> +static inline bool no_fggc_candidate(struct f2fs_sb_info *sbi,
>>> +						unsigned int secno)
>>> +{
>>> +	if (get_valid_blocks(sbi, secno, sbi->segs_per_sec) >=
>>> +						sbi->fggc_threshold)
>>> +		return true;
>>> +	return false;
>>> +}
>>> +
>>>    static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
>>>    {
>>>    	if (IS_CURSEC(sbi, secno) || (sbi->cur_victim_sec == secno))
>>>
>>
>
> .
>



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
