From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [RFC PATCH v2] mkfs.f2fs: recalculate sit_segments
 by max_sit_bitmap_size
Date: Tue, 23 Feb 2016 20:04:23 +0800
Message-ID: <56CC4AC7.3090403@huawei.com>
References: <1456199214-4865-1-git-send-email-zhengjunling@huawei.com>
	<009401d16dfb$24924680$6db6d380$@samsung.com>
	<56CC081A.3060503@huawei.com>
	<009701d16e1f$3c2982d0$b47c8870$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1aYBi1-0004G4-N9
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 12:04:53 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aYBhu-0007qG-4T
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 12:04:53 +0000
In-Reply-To: <009701d16e1f$3c2982d0$b47c8870$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On 2016/2/23 17:46, Chao Yu wrote:
> Hi Junling,
> 
>> -----Original Message-----
>> From: Junling Zheng [mailto:zhengjunling@huawei.com]
>> Sent: Tuesday, February 23, 2016 3:20 PM
>> To: Chao Yu; jaegeuk@kernel.org
>> Cc: linux-f2fs-devel@lists.sourceforge.net
>> Subject: Re: [f2fs-dev] [RFC PATCH v2] mkfs.f2fs: recalculate sit_segments by
>> max_sit_bitmap_size
>>
>> On 2016/2/23 13:28, Chao Yu wrote:
>>> Hi all,
>>>
>>>> -----Original Message-----
>>>> From: Junling Zheng [mailto:zhengjunling@huawei.com]
>>>> Sent: Tuesday, February 23, 2016 11:47 AM
>>>> To: linux-f2fs-devel@lists.sourceforge.net; jaegeuk@kernel.org
>>>> Subject: [f2fs-dev] [RFC PATCH v2] mkfs.f2fs: recalculate sit_segments by max_sit_bitmap_size
>>>>
>>>> In most cases, sit_bitmap_size is smaller than MAX_SIT_BITMAP_SIZE.
>>>>
>>>> However, in some extreme scenarios, such as 16TB, sit_bitmap_size
>>>> could be larger than MAX_SIT_BITMAP_SIZE.
>>>>
>>>> In this case, we should recalculate the sit_segments through
>>>> max_sit_bitmap_size to prevent sit_ver_bitmap_bytesize got from
>>>> segment_count_sit in f2fs_write_check_point_pack() being over
>>>> MAX_SIT_BITMAP_SIZE.
>>>>
>>>> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
>>>> ---
>>>>  mkfs/f2fs_format.c | 23 ++++++++++++++++-------
>>>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>> index 645c2aa..3a050e0 100644
>>>> --- a/mkfs/f2fs_format.c
>>>> +++ b/mkfs/f2fs_format.c
>>>> @@ -191,6 +191,22 @@ static int f2fs_prepare_super_block(void)
>>>>
>>>>  	sit_segments = SEG_ALIGN(blocks_for_sit);
>>>>
>>>> +	/*
>>>> +	 * In most cases, sit_bitmap_size is smaller than MAX_SIT_BITMAP_SIZE.
>>>> +	 * However, in an extreme scenario(16TB), sit_bitmap_size could be larger
>>>> +	 * than MAX_SIT_BITMAP_SIZE. Thus, we should recalculate the sit_segments
>>>> +	 * to prevent sit_ver_bitmap_bytesize got from segment_count_sit in
>>>> +	 * f2fs_write_check_point_pack() being over MAX_SIT_BITMAP_SIZE.
>>>> +	 */
>>>> +	sit_bitmap_size = (sit_segments << log_blks_per_seg) / 8;
>>>> +
>>>> +	if (sit_bitmap_size > MAX_SIT_BITMAP_SIZE) {
>>>> +		max_sit_bitmap_size = MAX_SIT_BITMAP_SIZE;
>>>> +		sit_segments = max_sit_bitmap_size * 8 >> log_blks_per_seg;
>>>> +		blocks_for_sit = sit_segments << log_blks_per_seg;
>>>> +	} else
>>>
>>> Still the minor coding style problem.
>>>
>>
>> Do you mean the "else" also needs {} even though it has only one sentence?
> 
> That's right.
> 
>>
>>> IMO, maybe it would be better to limit config.total_sectors with 16TB at
>>> very beginning, so more fields in sb like block_count, segment_count could
>>> be set correctly when we try to format a huge size image. Right?
>>>
>>
>> Limiting the disk at very beginning means not starting from 0 sector?
> 
> Oh, what I mean here is 'at very beginning time', f2fs can support a
> volume with size of 16 TB at most, so I'm thinking we'd better do the
> limitation for config.total_sectors, then most parameters in cp/sb
> calculated according to value of total_sectors could be limited or
> corrected too.
> 
> Anyway, that is a separate issue. :)
> 

Good idea! I'll send another patch later:)

>> Does it amount to reducing the size of disk to keep sit_bitmap_size smaller
>> than MAX_SIT_BITMAP_SIZE? It looks to be helpful:)
>>
>> Indeed, the data in sb have no problem. Just the difference of calculating
>> methods between sit_bitmap_size and MAX_SIT_BITMAP_SIZE:
>>
>> F2FS_MAX_SEGMENT:
>>     16 * 1024 * 1024 / 2 = 8388608
>> max blocks_for_sit:
>>     ALIGN(F2FS_MAX_SEGMENT, SIT_ENTRY_PER_BLOCK) = 152521	// Upward here, not all blocks are
>> used, some are redundant.
>> max sit_segments:
>>     ALIGN(blocks_for_sit, config.blks_per_seg) = 298		// Upward here, not all segments are
>> used, some are redundant.
>> max segment_count_sit:
>>     sit_segments * 2 = 596
>> max sit_ver_bitmap_bytesize:
>>     ((segment_count_sit / 2) << log_blocks_per_seg) / 8 = 19072	// Here, bitmap size is too
>> large because of the redundant blocks and segments.
>>
>> However, MAX_SIT_BITMAP_SIZE is defined as:
>>     ((F2FS_MAX_SEGMENT / SIT_ENTRY_PER_BLOCK) / 8) = 19065	// Downward here, abandon the
>> redundant segments.
>>
>> So, the best way is to unify the two calculating method:)
> 
> Agreed. :)
> 

So I'll resend a fix by redefining MAX_SIT_BITMAP_SIZE as the following instead of
recalculating segment_count_sit:)

SEG_ALIGN(ALIGN(F2FS_MAX_SEGMENT, SIT_ENTRY_PER_BLOCK)) * config.blks_per_seg / 8

Thanks,

> Thanks,
> 
>>
>> Thanks,
>>
>>> Thanks,
>>>
>>>> +		max_sit_bitmap_size = sit_bitmap_size;
>>>> +
>>>>  	set_sb(segment_count_sit, sit_segments * 2);
>>>>
>>>>  	set_sb(nat_blkaddr, get_sb(sit_blkaddr) + get_sb(segment_count_sit) *
>>>> @@ -208,13 +224,6 @@ static int f2fs_prepare_super_block(void)
>>>>  	 * This number resizes NAT bitmap area in a CP page.
>>>>  	 * So the threshold is determined not to overflow one CP page
>>>>  	 */
>>>> -	sit_bitmap_size = ((get_sb(segment_count_sit) / 2) <<
>>>> -				log_blks_per_seg) / 8;
>>>> -
>>>> -	if (sit_bitmap_size > MAX_SIT_BITMAP_SIZE)
>>>> -		max_sit_bitmap_size = MAX_SIT_BITMAP_SIZE;
>>>> -	else
>>>> -		max_sit_bitmap_size = sit_bitmap_size;
>>>>
>>>>  	/*
>>>>  	 * It should be reserved minimum 1 segment for nat.
>>>> --
>>>> 1.9.1
>>>>
>>>>
>>>> ------------------------------------------------------------------------------
>>>> Site24x7 APM Insight: Get Deep Visibility into Application Performance
>>>> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
>>>> Monitor end-to-end web transactions and take corrective actions now
>>>> Troubleshoot faster and improve end-user experience. Signup Now!
>>>> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
>>>
>>> .
>>>
>>
> 
> 
> 
> .
> 



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
