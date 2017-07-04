From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v2] f2fs: Do not issue small discards in LFS mode
Date: Tue, 4 Jul 2017 17:11:54 +0900
Message-ID: <19a7f120-1892-facd-e0ac-eeaab6aa7b81@wdc.com>
References: <20170526080440.11160-1-damien.lemoal@wdc.com>
 <9287ca85-e796-3216-6496-8ead3a786467@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <9287ca85-e796-3216-6496-8ead3a786467@huawei.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Jaegeuk,

On 5/26/17 17:16, Chao Yu wrote:
> On 2017/5/26 16:04, Damien Le Moal wrote:
>> clear_prefree_segments() issues small discards after discarding full
>> segments. These small discards may not be section aligned, so not zone
>> aligned on a zoned block device, causing __f2fs_iissue_discard_zone() to fail.
>> Fix this by not issuing small discards for a volume mounted with the BLKZONED
>> feature enabled.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> 
> This version looks good to me.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
>> ---
>>  fs/f2fs/segment.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 9684585..1279650 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1322,7 +1322,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>  					sbi->blocks_per_seg, cur_pos);
>>  			len = next_pos - cur_pos;
>>  
>> -			if (force && len < cpc->trim_minlen)
>> +			if (f2fs_sb_mounted_blkzoned(sbi->sb) ||
>> +			    (force && len < cpc->trim_minlen))
>>  				goto skip;
>>  
>>  			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
>>

It looks like this patch was not included in 4.12, so we are still
getting a lot of "unaligned discard" on zoned block devices.
Is there a problem with this patch or was that an oversight ?

Please consider adding this patch.

Best regards.

-- 
Damien Le Moal,
Western Digital
