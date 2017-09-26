From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] Revert "f2fs: node segment is prior to data segment
 selected victim"
Date: Tue, 26 Sep 2017 18:44:07 +0800
Message-ID: <6b5c95de-9349-3ee6-ac46-34684bdf3cf1@huawei.com>
References: <1506157338-20441-1-git-send-email-yunlong.song@huawei.com>
 <ae11fe8d-6030-ed2a-1193-74dc43aa0279@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ae11fe8d-6030-ed2a-1193-74dc43aa0279@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/25 10:52, Chao Yu wrote:
> On 2017/9/23 17:02, Yunlong Song wrote:
>> This reverts commit b9cd20619e359d199b755543474c3d853c8e3415.
>>
>> That patch causes much fewer node segments (which can be used for SSR)
>> than before, and in the corner case (e.g. create and delete *.txt files in
>> one same directory, there will be very few node segments but many data
>> segments), if the reserved free segments are all used up during gc, then
>> the write_checkpoint can still flush dentry pages to data ssr segments,
>> but will probably fail to flush node pages to node ssr segments, since
>> there are not enough node ssr segments left (the left ones are all
>> full).
> 
> IMO, greedy algorithm wants to minimize price of moving one dirty segment, our
> behavior is accord with semantics of our algorithm to select victim with least
> valid blocks. Pengyang's patch tries to adjust greedy algorithm to consider
> minimizing total number of valid blocks in all selected victim segments during
> whole FGGC cycle, but its algorithm is corrupted, since if all valid data blocks
> in current victim segment is not belong to different dnode block, our selection
> may be incorrect.
> 
> Anyway, I agree to revert Pengyang's patch first before we got a entire scheme.

Please replace old commit message with above reason. :)

Thanks,

> 
> BTW, for SSR or LFS selection, there is a trade-off in between: a) SSR-write
> costs less free segment and move less data/node blocks, but it triggers random
> write which results in bad performance. b) LFS-write costs more free segment and
> move more data/node blocks, but it triggers sequential write which results in
> good performance. So I don't think more SSR we trigger, lower latency our FGGC
> faces.
> 
> Thanks,
> 
>>
>> So revert this patch to give a fair chance to let node segments remain
>> for SSR, which provides more robustness for corner cases.
>>
>> Conflicts:
>> 	fs/f2fs/gc.c
>> ---
>>  fs/f2fs/gc.c | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index bfe6a8c..f777e07 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -267,16 +267,6 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
>>  	return UINT_MAX - ((100 * (100 - u) * age) / (100 + u));
>>  }
>>  
>> -static unsigned int get_greedy_cost(struct f2fs_sb_info *sbi,
>> -						unsigned int segno)
>> -{
>> -	unsigned int valid_blocks =
>> -			get_valid_blocks(sbi, segno, true);
>> -
>> -	return IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
>> -				valid_blocks * 2 : valid_blocks;
>> -}
>> -
>>  static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
>>  			unsigned int segno, struct victim_sel_policy *p)
>>  {
>> @@ -285,7 +275,7 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
>>  
>>  	/* alloc_mode == LFS */
>>  	if (p->gc_mode == GC_GREEDY)
>> -		return get_greedy_cost(sbi, segno);
>> +		return get_valid_blocks(sbi, segno, true);
>>  	else
>>  		return get_cb_cost(sbi, segno);
>>  }
>>
