From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] f2fs: Do not issue small discards in LFS mode
Date: Thu, 25 May 2017 23:08:11 +0900
Message-ID: <480a3e5d-f580-b67a-8fbd-d0ba550837d3@wdc.com>
References: <20170524050229.13213-1-damien.lemoal@wdc.com>
 <14e5d385-71ed-eb79-0e11-c0e9ef183df2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <14e5d385-71ed-eb79-0e11-c0e9ef183df2@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Chao,

On 5/24/17 20:13, Chao Yu wrote:
> Hi Damien,
> 
> On 2017/5/24 13:02, Damien Le Moal wrote:
>> clear_prefree_segments() issues small discards after discarding full
>> segments. These small discards may not be section aligned, so not zone
>> aligned when using a zoned block device, or more generally, when
>> mounted in LFS mode. So do not issue these small discards when mounted
>> in LFS mode.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  fs/f2fs/segment.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 9684585..3d190a7 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1322,7 +1322,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>  					sbi->blocks_per_seg, cur_pos);
>>  			len = next_pos - cur_pos;
>>  
>> -			if (force && len < cpc->trim_minlen)
>> +			if (test_opt(sbi, LFS) ||
> 
> Could we just check f2fs_sb_mounted_blkzoned here instead of F2FS_MOUNT_LFS here
> ? so a non-blkzoned device can enables small discard when user mount the device
> with LFS option. Right?

Sure, No problem. I will resend a v2.

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr Manager, System Software Group,
Western Digital Research
Damien.LeMoal@wdc.com
Tel: (+81) 0466-98-3593 (Ext. 51-3593)
1 kirihara-cho, Fujisawa, Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
