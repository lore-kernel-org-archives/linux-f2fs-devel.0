From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH 1/2 v2] f2fs: fix a missing discard prefree
 segments
Date: Wed, 21 Dec 2016 11:35:14 +0800
Message-ID: <be410fe3-5c3d-38dd-a62b-37dd8bfcff70@huawei.com>
References: <20161220031135.18754-1-heyunlei@huawei.com>
	<97a3d89d-1e79-7c44-6500-bc4fc25a5590@huawei.com>
	<12c2b816-2bb5-d2c3-ee27-f81b95b25db2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cJY2D-0000Pe-3T
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Dec 2016 03:57:45 +0000
Received: from [45.249.212.191] (helo=dggrg05-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cJY2B-0007YW-Fm
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Dec 2016 03:57:45 +0000
In-Reply-To: <12c2b816-2bb5-d2c3-ee27-f81b95b25db2@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: heyunlei@huwei.com

Hi Chao,

On 2016/12/21 10:27, Chao Yu wrote:
> On 2016/12/21 10:02, Chao Yu wrote:
>> Hi Jaegeuk, Yunlei,
>>
>> On 2016/12/20 11:11, Yunlei He wrote:
>>> If userspace issue a fstrim with a range not involve prefree segments,
>>> it will reuse these segments without discard. This patch fix it.
>>
>> >From v1 patch, I guess originally Yunlei wants to skip clearing prefree segments
>> which is not be included in fstrim range, now v2 patch doesn't follow the
>> original intention.
>>
>> So I guess below modification is enough:
>>
>> -		if (force || !test_opt(sbi, DISCARD))
>> +		if (!test_opt(sbi, DISCARD))
>>
>> Only we should consider is whether we would send redundant discards though
>> fstrim when small discard is on.
>
> Oh, below condition has handling redundant case, sorry for my wrong understanding.
>
> if (force && start * sbi->blocks_per_seg >= cpc->trim_start &&
> 	end * sbi->blocks_per_seg <= cpc->trim_end)
> 		continue;
>
> But should fix end boundary judegment as below:
> (end - 1) * sbi->blocks_per_seg <= cpc->trim_end

For example:  if start=0, end=2, it means that the first and second segment is prefree,
but the third segment is not.

start block address of first segment = 0 * 512 = start * 512
end block address of secnod segment = (3-1) * 512 = end * 512

So, boundary judgement has no problem?

Thanks.

>
> Thanks,
>
>>
>> Thoughts?
>>
>>>
>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>> ---
>>>  fs/f2fs/segment.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 0738f48..a40a34b 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -916,7 +916,11 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>
>>>  		dirty_i->nr_dirty[PRE] -= end - start;
>>>
>>> -		if (force || !test_opt(sbi, DISCARD))
>>> +		if (!test_opt(sbi, DISCARD))
>>> +			continue;
>>> +
>>> +		if (force && start * sbi->blocks_per_seg >= cpc->trim_start &&
>>> +						end * sbi->blocks_per_seg <= cpc->trim_end)
>>>  			continue;
>>>
>>>  		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
>>>
>
>
> .
>


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/intel
