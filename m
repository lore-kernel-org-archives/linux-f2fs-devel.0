From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/5] f2fs: clear the remaining prefree_map of
 the section
Date: Fri, 13 Jul 2018 11:42:25 +0800
Message-ID: <12f3c3d2-6586-ca73-8770-8f97b436d643@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-3-git-send-email-yunlong.song@huawei.com>
 <c9a3972b-dc52-19ca-7ed0-2f754d89ab33@huawei.com>
 <75dc9cad-8166-82c5-e085-88c9623f5c5e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fdoyf-0007RZ-KT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 03:42:41 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fdoye-002AYA-58
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 03:42:41 +0000
In-Reply-To: <75dc9cad-8166-82c5-e085-88c9623f5c5e@huawei.com>
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
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

On 2018/7/13 11:28, Yunlong Song wrote:
> round 1: section bitmap : 1 1 1 1 1, all valid, prefree_map: 0 0 0 0 0
> then rm data block NO.2, block NO.2 becomes invalid, prefree_map: 0 0 1 0 0
> write_checkpoint: section bitmap: 1 1 0 1 1, prefree_map: 0 0 0 0 0, 
> prefree of NO.2 is cleared, and no discard issued
> 
> round2: rm data block NO.0, NO.1, NO.3, NO.4
> all invalid, but prefree bit of NO.2 is set and cleared in round1, then 
> prefree_map: 1 1 0 1 1
> write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1, no 

Why prefree_map is not 0 0 0 0 0?

Thanks,

> valid blocks of this section, so discard issued
> but this time prefree bit of NO.3 and NO.4 is skipped...
> 
> round3:
> write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1 - > 
> 0 0 0 0 0, no valid blocks of this section, so discard issued
> this time prefree bit of NO.3 and NO.4 is cleared, but the discard of 
> this section is sent again...
> 
> On 2018/7/13 11:13, Chao Yu wrote:
>> On 2018/7/12 23:09, Yunlong Song wrote:
>>> For the case when sbi->segs_per_sec > 1, take section:segment = 5 for
>>> example, if the section prefree_map is ...previous section | current
>>> section (1 1 0 1 1) | next section..., then the start = x, end = x + 1,
>>> after start = start_segno + sbi->segs_per_sec, start = x + 5, then it
>>> will skip x + 3 and x + 4, but their bitmap is still set, which will
>>> cause duplicated f2fs_issue_discard of this same section in the next
>>> write_checkpoint, so fix it.
>> I didn't get it, if # 2 segment is not prefree state, so it still has valid
>> blocks there, so we won't issue discard due to below condition, right?
>>
>> 		if (!IS_CURSEC(sbi, secno) &&
>> 			!get_valid_blocks(sbi, start, true))
>>
>> Thanks,
>>
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>   fs/f2fs/segment.c | 19 +++++++++++++++++--
>>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 47b6595..fd38b61 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1684,8 +1684,23 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>   		start = start_segno + sbi->segs_per_sec;
>>>   		if (start < end)
>>>   			goto next;
>>> -		else
>>> -			end = start - 1;
>>> +		else {
>>> +			start_segno = start;
>>> +
>>> +			while (1) {
>>> +				start = find_next_bit(prefree_map, start_segno,
>>> +									end + 1);
>>> +				if (start >= start_segno)
>>> +					break;
>>> +				end = find_next_zero_bit(prefree_map, start_segno,
>>> +										start + 1);
>>> +				for (i = start; i < end; i++)
>>> +					clear_bit(i, prefree_map);
>>> +				dirty_i->nr_dirty[PRE] -= end - start;
>>> +			}
>>> +
>>> +			end = start_segno - 1;
>>> +		}
>>>   	}
>>>   	mutex_unlock(&dirty_i->seglist_lock);
>>>   
>>>
>>
>> .
>>
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
