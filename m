From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: fix heap mode to reset it back
Date: Mon, 29 Jan 2018 16:31:26 +0800
Message-ID: <607de57c-f5d8-2f22-b79d-4966a8516d1e@huawei.com>
References: <1517197065-156255-1-git-send-email-yunlong.song@huawei.com>
 <f89279f2-f397-f8b6-57e7-2e5c39d6256f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <f89279f2-f397-f8b6-57e7-2e5c39d6256f@huawei.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

The old commit allocates hot data & nodes in the beginning of partition 
both for heap and
noheap mode. But from the commit message, the heap mode should be like 
before, i.e.,
allocate hot data & nodes from curseg to left.

On 2018/1/29 16:12, Chao Yu wrote:
> Hi Yunlong,
>
> On 2018/1/29 11:37, Yunlong Song wrote:
>> Commit 7a20b8a61eff81bdb7097a578752a74860e9d142 ("f2fs: allocate node
>> and hot data in the beginning of partition") introduces another mount
>> option, heap, to reset it back. But it does not do anything for heap
>> mode, so fix it.
> I think Jaegeuk did three things in that patch:
> a) add missing heap mount option handling in ->show_options.
> b) set noheap by default.
> c) change allocation policy to the one that allocate hotdata & nodes in the
> front of main are intensively.
>
> They could be separated, independent, and I don't see such intention that
> we can only use c) the new introduced allocation policy in noheap mode.
>
> Anyway, I think Jaegeuk can help to double check that.
>
> Thanks,
>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/gc.c      | 5 +++--
>>   fs/f2fs/segment.c | 3 ++-
>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index aa720cc..b9d93fd 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -191,8 +191,9 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>>   	if (gc_type != FG_GC && p->max_search > sbi->max_victim_search)
>>   		p->max_search = sbi->max_victim_search;
>>   
>> -	/* let's select beginning hot/small space first */
>> -	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
>> +	/* let's select beginning hot/small space first in no_heap mode*/
>> +	if (test_opt(sbi, NOHEAP) &&
>> +		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
>>   		p->offset = 0;
>>   	else
>>   		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index e5739ce..77a48c4 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2167,7 +2167,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>>   	if (sbi->segs_per_sec != 1)
>>   		return CURSEG_I(sbi, type)->segno;
>>   
>> -	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
>> +	if (test_opt(sbi, NOHEAP) &&
>> +		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
>>   		return 0;
>>   
>>   	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
>>
>
> .
>

-- 
Thanks,
Yunlong Song
