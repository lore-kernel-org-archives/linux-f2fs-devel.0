From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: introduce zone align for main area
Date: Fri, 8 Jan 2016 10:28:57 +0800
Message-ID: <568F1EE9.6000105@huawei.com>
References: <1452066877-8554-1-git-send-email-heyunlei@huawei.com>
	<20160107232957.GA8623@jaegeuk.aosp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aHMo1-0005hU-0l
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 08 Jan 2016 02:29:33 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aHMnw-00053N-AR
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 08 Jan 2016 02:29:32 +0000
In-Reply-To: <20160107232957.GA8623@jaegeuk.aosp>
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

On 2016/1/8 7:29, Jaegeuk Kim wrote:
> Hi Yunlei,
>
> Could you rebase the patch based on f2fs-tools.git?
> I can't merge this.
>
> Thanks,
Hi Kim,

I am sorry that, I have sent a new one.

Thanks,
>
> On Wed, Jan 06, 2016 at 03:54:37PM +0800, Yunlei He wrote:
>> This patch calculate main area begin from a new zone,
>> avoid misalign if segments per zone is not 1.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
>> ---
>>   mkfs/f2fs_format.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index 66d7342..fe45322 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -126,7 +126,8 @@ static int f2fs_prepare_super_block(void)
>>   	u_int32_t sit_segments;
>>   	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
>>   	u_int32_t total_valid_blks_available;
>> -	u_int64_t zone_align_start_offset, diff, total_meta_segments;
>> +	u_int64_t zone_align_start_offset, diff;
>> +	u_int64_t total_meta_zones, total_meta_segments;
>>   	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
>>   	u_int32_t max_nat_bitmap_size, max_nat_segments;
>>   	u_int32_t total_zones;
>> @@ -259,16 +260,17 @@ static int f2fs_prepare_super_block(void)
>>   		set_sb(segment_count_ssa, get_sb(segment_count_ssa) +
>>   			(config.segs_per_zone - diff));
>>
>> -	set_sb(main_blkaddr, get_sb(ssa_blkaddr) + get_sb(segment_count_ssa) *
>> -			 config.blks_per_seg);
>> +	total_meta_zones = ZONE_ALIGN(total_meta_segments *
>> +						config.blks_per_seg);
>>
>> -	set_sb(segment_count_main, get_sb(segment_count) -
>> -			(get_sb(segment_count_ckpt) +
>> -			 get_sb(segment_count_sit) +
>> -			 get_sb(segment_count_nat) +
>> -			 get_sb(segment_count_ssa)));
>> +	set_sb(main_blkaddr, get_sb(segment0_blkaddr) + total_meta_zones *
>> +								config.segs_per_zone * config.blks_per_seg);
>> +
>> +	total_zones = get_sb(segment_count) / (config.segs_per_zone) -
>> +							total_meta_zones;
>>
>> -	set_sb(section_count, get_sb(segment_count_main) / config.segs_per_sec);
>> +	set_sb(section_count, total_zones * config.secs_per_zone);
>>
>>   	set_sb(segment_count_main, get_sb(section_count) * config.segs_per_sec);
>>
>> @@ -297,7 +299,6 @@ static int f2fs_prepare_super_block(void)
>>   	set_sb(meta_ino, 2);
>>   	set_sb(root_ino, 3);
>>
>> -	total_zones = get_sb(segment_count_main) / (config.segs_per_zone);
>>   	if (total_zones <= 6) {
>>   		MSG(1, "\tError: %d zones: Need more zones \
>>   			by shrinking zone size\n", total_zones);
>> --
>> 1.9.1
>
> .
>


------------------------------------------------------------------------------
