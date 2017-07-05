From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v2] f2fs: Do not issue small discards in LFS mode
Date: Wed, 5 Jul 2017 10:01:06 +0900
Message-ID: <2a9a0bcf-4b7b-7b59-6a56-0caee723aa24@wdc.com>
References: <20170526080440.11160-1-damien.lemoal@wdc.com>
 <9287ca85-e796-3216-6496-8ead3a786467@huawei.com>
 <19a7f120-1892-facd-e0ac-eeaab6aa7b81@wdc.com>
 <20170704092143.GA81163@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170704092143.GA81163@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Jaegeuk,

On 7/4/17 18:21, Jaegeuk Kim wrote:
> Hi Damien,
> 
> On 07/04, Damien Le Moal wrote:
>> Jaegeuk,
>>
>> On 5/26/17 17:16, Chao Yu wrote:
>>> On 2017/5/26 16:04, Damien Le Moal wrote:
>>>> clear_prefree_segments() issues small discards after discarding full
>>>> segments. These small discards may not be section aligned, so not zone
>>>> aligned on a zoned block device, causing __f2fs_iissue_discard_zone() to fail.
>>>> Fix this by not issuing small discards for a volume mounted with the BLKZONED
>>>> feature enabled.
>>>>
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>>
>>> This version looks good to me.
>>>
>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>
>>> Thanks,
>>>
>>>> ---
>>>>  fs/f2fs/segment.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 9684585..1279650 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -1322,7 +1322,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>  					sbi->blocks_per_seg, cur_pos);
>>>>  			len = next_pos - cur_pos;
>>>>  
>>>> -			if (force && len < cpc->trim_minlen)
>>>> +			if (f2fs_sb_mounted_blkzoned(sbi->sb) ||
>>>> +			    (force && len < cpc->trim_minlen))
>>>>  				goto skip;
>>>>  
>>>>  			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
>>>>
>>
>> It looks like this patch was not included in 4.12, so we are still
>> getting a lot of "unaligned discard" on zoned block devices.
>> Is there a problem with this patch or was that an oversight ?
> 
> Ah, I filed the patch towards 4.13-rc1, and marked it to be merged into the
> stable kernel for v4.12. I'm planning pull-request this week, so expect it'll be
> merged after then.

Since it is a bug fix, I thought it would go into 4.12-rc. But with the
cc to stable, we are fine. Thanks !

-- 
Damien Le Moal,
Western Digital
