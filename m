From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: Reduce zoned block device memory
 usage
Date: Thu, 7 Mar 2019 09:19:39 +0800
Message-ID: <2a6be0fe-f7be-8b55-36b1-d4dede47f745@huawei.com>
References: <20190306062711.14456-1-damien.lemoal@wdc.com>
 <bd1454a0-52b0-76ed-3eb7-2f83bfd0f8a0@kernel.org>
 <BYAPR04MB5816532C600CAB457DC05714E7730@BYAPR04MB5816.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h1hhS-0007tX-M8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Mar 2019 01:19:54 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h1hhO-00FFLY-Mo
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Mar 2019 01:19:54 +0000
In-Reply-To: <BYAPR04MB5816532C600CAB457DC05714E7730@BYAPR04MB5816.namprd04.prod.outlook.com>
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
To: Damien Le Moal <Damien.LeMoal@wdc.com>, Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Matias Bjorling <Matias.Bjorling@wdc.com>

On 2019/3/7 2:15, Damien Le Moal wrote:
> On 2019/03/06 23:32, Chao Yu wrote:
>> On 2019-3-6 14:27, Damien Le Moal wrote:
>>> For zoned block devices, an array of zone types for each device is
>>> allocated and initialized in order to determine if a section is stored
>>> on a sequential zone (zone reset needed) or a conventional zone (no
>>> zone reset needed and regular discard applies). Considering this usage,
>>> the zone types stored in memory can be replaced with a bitmap to
>>> indicate an equivalent information, that is, if a zone is sequential or
>>> not. This reduces the memory usage for each zoned device by roughly 8:
>>> on a 14TB disk with zones of 256 MB, the zone type array consumes
>>> 13x4KB pages while the bitmap uses only 2x4KB pages.
>>>
>>> This patch changes the f2fs_dev_info structure blkz_type field to the
>>> bitmap blkz_seq. Access to this bitmap is done using the helper
>>> function f2fs_blkz_is_seq(), which is a rewrite of the function
>>> get_blkz_type().
>>>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> ---
>>> Changes from v1:
>>> * Use kvfree() instead of kfree() to free the zone bitmap
>>>
>>>  fs/f2fs/f2fs.h    | 13 +++++++------
>>>  fs/f2fs/segment.c | 23 +++++++----------------
>>>  fs/f2fs/super.c   | 13 ++++++++-----
>>>  3 files changed, 22 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 12fabd6735dd..d7b2de930352 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1067,8 +1067,8 @@ struct f2fs_dev_info {
>>>  	block_t start_blk;
>>>  	block_t end_blk;
>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>> -	unsigned int nr_blkz;			/* Total number of zones */
>>> -	u8 *blkz_type;				/* Array of zones type */
>>> +	unsigned int nr_blkz;		/* Total number of zones */
>>> +	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
>>>  #endif
>>>  };
>>>  
>>> @@ -3508,16 +3508,17 @@ F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
>>>  F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
>>>  
>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>> -static inline int get_blkz_type(struct f2fs_sb_info *sbi,
>>> -			struct block_device *bdev, block_t blkaddr)
>>> +static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi,
>>> +				    struct block_device *bdev, block_t blkaddr)
>>>  {
>>>  	unsigned int zno = blkaddr >> sbi->log_blocks_per_blkz;
>>>  	int i;
>>>  
>>>  	for (i = 0; i < sbi->s_ndevs; i++)
>>>  		if (FDEV(i).bdev == bdev)
>>> -			return FDEV(i).blkz_type[zno];
>>> -	return -EINVAL;
>>> +			return test_bit(zno, FDEV(i).blkz_seq);
>>> +	WARN_ON_ONCE(1);
>>> +	return false;
>>
>> How about just handling this case as previous instead of treating device as
>> conventional zone?
> 
> Before this patch, if the device is not found, an error was returned, which was
> propagated up by __f2fs_issue_discard_zone() as an -EIO. Do you mean to do the
> same here too ?

Yes.

> 
> Now that I look at this again, another possible change that I think actually may
> make more sense is to pass the devi (device index) variable set by
> __f2fs_issue_discard_zone() to this function. No need for the device search loop
> doing so and invalid block numbers leading to invalid device indexes can/should
> be handled in __f2fs_issue_discard_zone().
> 
> What do you think ?

That will be better, please go ahead. :)

Thanks,

> 
>>
>> Thanks,
>>
>>>  }
>>>  #endif
>>>  
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 9b79056d705d..65941070776c 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1703,19 +1703,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>>>  		blkstart -= FDEV(devi).start_blk;
>>>  	}
>>>  
>>> -	/*
>>> -	 * We need to know the type of the zone: for conventional zones,
>>> -	 * use regular discard if the drive supports it. For sequential
>>> -	 * zones, reset the zone write pointer.
>>> -	 */
>>> -	switch (get_blkz_type(sbi, bdev, blkstart)) {
>>> -
>>> -	case BLK_ZONE_TYPE_CONVENTIONAL:
>>> -		if (!blk_queue_discard(bdev_get_queue(bdev)))
>>> -			return 0;
>>> -		return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
>>> -	case BLK_ZONE_TYPE_SEQWRITE_REQ:
>>> -	case BLK_ZONE_TYPE_SEQWRITE_PREF:
>>> +	/* For sequential zones, reset the zone write pointer */
>>> +	if (f2fs_blkz_is_seq(sbi, bdev, blkstart)) {
>>>  		sector = SECTOR_FROM_BLOCK(blkstart);
>>>  		nr_sects = SECTOR_FROM_BLOCK(blklen);
>>>  
>>> @@ -1730,10 +1719,12 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>>>  		trace_f2fs_issue_reset_zone(bdev, blkstart);
>>>  		return blkdev_reset_zones(bdev, sector,
>>>  					  nr_sects, GFP_NOFS);
>>> -	default:
>>> -		/* Unknown zone type: broken device ? */
>>> -		return -EIO;
>>>  	}
>>> +
>>> +	 /* For conventional zones, use regular discard if supported */
>>> +	if (!blk_queue_discard(bdev_get_queue(bdev)))
>>> +		return 0;
>>> +	return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
>>>  }
>>>  #endif
>>>  
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index c46a1d4318d4..91d7429be554 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -1017,7 +1017,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>>>  	for (i = 0; i < sbi->s_ndevs; i++) {
>>>  		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>> -		kvfree(FDEV(i).blkz_type);
>>> +		kvfree(FDEV(i).blkz_seq);
>>>  #endif
>>>  	}
>>>  	kvfree(sbi->devs);
>>> @@ -2765,9 +2765,11 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>>  	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
>>>  		FDEV(devi).nr_blkz++;
>>>  
>>> -	FDEV(devi).blkz_type = f2fs_kmalloc(sbi, FDEV(devi).nr_blkz,
>>> -								GFP_KERNEL);
>>> -	if (!FDEV(devi).blkz_type)
>>> +	FDEV(devi).blkz_seq = f2fs_kzalloc(sbi,
>>> +					BITS_TO_LONGS(FDEV(devi).nr_blkz)
>>> +					* sizeof(unsigned long),
>>> +					GFP_KERNEL);
>>> +	if (!FDEV(devi).blkz_seq)
>>>  		return -ENOMEM;
>>>  
>>>  #define F2FS_REPORT_NR_ZONES   4096
>>> @@ -2794,7 +2796,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>>  		}
>>>  
>>>  		for (i = 0; i < nr_zones; i++) {
>>> -			FDEV(devi).blkz_type[n] = zones[i].type;
>>> +			if (zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL)
>>> +				set_bit(n, FDEV(devi).blkz_seq);
>>>  			sector += zones[i].len;
>>>  			n++;
>>>  		}
>>>
>>
> 
> 
