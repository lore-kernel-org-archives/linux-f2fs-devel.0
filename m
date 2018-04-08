From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: fix incorrect cold data location
Date: Sun, 8 Apr 2018 09:22:41 +0800
Message-ID: <61faf1ce-17b7-3a34-ba50-570346fd4550@huawei.com>
References: <20180404024914.60177-1-yuchao0@huawei.com>
 <20180405034730.GB50337@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f4z2x-0003ma-30
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 01:23:07 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f4z2v-00Enif-33
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 01:23:06 +0000
In-Reply-To: <20180405034730.GB50337@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/4/5 11:47, Jaegeuk Kim wrote:
> On 04/04, Chao Yu wrote:
>> If last_zone((total_zones >> 2)) is equal or less than
>> next_zone(CURSEG_COLD_NODE), cold data area will be located in the
>> same position with hot data, fixes it.
> 
> verify_cur_segs() will rearrage this?

Yes, finally, verify_cur_segs() will make sure there is no redundant segment
used by different log headers. But we'd better ensure log initial position is
correct at the first time, otherwise, verify_cur_segs() will use sequential
allocating to initialize log position, which is not match to our original design.

Thanks,

> 
> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  mkfs/f2fs_format.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index 65692bbe083a..8885f632371d 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -471,7 +471,7 @@ static int f2fs_prepare_super_block(void)
>>  		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
>>  		c.cur_seg[CURSEG_COLD_DATA] =
>>  				max(last_zone((total_zones >> 2)),
>> -					next_zone(CURSEG_COLD_NODE));
>> +					next_zone(CURSEG_HOT_DATA));
>>  		c.cur_seg[CURSEG_WARM_DATA] =
>>  				max(last_zone((total_zones >> 1)),
>>  					next_zone(CURSEG_COLD_DATA));
>> -- 
>> 2.15.0.55.gc2ece9dc4de6
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
