From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/2] f2fs: Reduce zoned block device memory
 usage
Date: Fri, 15 Mar 2019 18:20:19 +0000
Message-ID: <BYAPR04MB58169EE9CAACDE03AF696B82E7440@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190314163707.14364-1-damien.lemoal@wdc.com>
 <20190314163707.14364-3-damien.lemoal@wdc.com>
 <63308644-2b6c-65d1-88ca-70d3b7815f4c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=97066cdaa=Damien.LeMoal@wdc.com>)
 id 1h4rRW-0004wU-Py
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Mar 2019 18:20:30 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h4rRT-004Bhh-OG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Mar 2019 18:20:30 +0000
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
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Masato Suzuki <masato.suzuki@wdc.com>, Matias Bjorling <Matias.Bjorling@wdc.com>

On 2019/03/14 23:43, Chao Yu wrote:
> On 2019/3/15 0:37, Damien Le Moal wrote:
>> For zoned block devices, an array of zone types for each device is
>> allocated and initialized in order to determine if a section is stored
>> on a sequential zone (zone reset needed) or a conventional zone (no
>> zone reset needed and regular discard applies). Considering this usage,
>> the zone types stored in memory can be replaced with a bitmap to
>> indicate an equivalent information, that is, if a zone is sequential or
>> not. This reduces the memory usage for each zoned device by roughly 8:
>> on a 14TB disk with zones of 256 MB, the zone type array consumes
>> 13x4KB pages while the bitmap uses only 2x4KB pages.
>>
>> This patch changes the f2fs_dev_info structure blkz_type field to the
>> bitmap blkz_seq. Access to this bitmap is done using the helper
>> function f2fs_blkz_is_seq(), which is a rewrite of the function
>> get_blkz_type().
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  fs/f2fs/f2fs.h    | 14 +++++---------
>>  fs/f2fs/segment.c | 36 ++++++++++++++++--------------------
>>  fs/f2fs/super.c   | 13 ++++++++-----
>>  3 files changed, 29 insertions(+), 34 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 073f450af346..1a4a07e3ce05 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1066,8 +1066,8 @@ struct f2fs_dev_info {
>>  	block_t start_blk;
>>  	block_t end_blk;
>>  #ifdef CONFIG_BLK_DEV_ZONED
>> -	unsigned int nr_blkz;			/* Total number of zones */
>> -	u8 *blkz_type;				/* Array of zones type */
>> +	unsigned int nr_blkz;		/* Total number of zones */
>> +	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
>>  #endif
>>  };
>>  
>> @@ -3513,16 +3513,12 @@ F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
>>  F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
>>  
>>  #ifdef CONFIG_BLK_DEV_ZONED
>> -static inline int get_blkz_type(struct f2fs_sb_info *sbi,
>> -			struct block_device *bdev, block_t blkaddr)
>> +static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
>> +				    block_t blkaddr)
>>  {
>>  	unsigned int zno = blkaddr >> sbi->log_blocks_per_blkz;
>> -	int i;
>>  
>> -	for (i = 0; i < sbi->s_ndevs; i++)
>> -		if (FDEV(i).bdev == bdev)
>> -			return FDEV(i).blkz_type[zno];
>> -	return -EINVAL;
>> +	return test_bit(zno, FDEV(devi).blkz_seq);
>>  }
>>  #endif
>>  
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index d8f531b33350..f40148b735d7 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1701,40 +1701,36 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>>  
>>  	if (f2fs_is_multi_device(sbi)) {
>>  		devi = f2fs_target_device_index(sbi, blkstart);
>> +		if (blkstart < FDEV(devi).start_blk ||
>> +		    blkstart > FDEV(devi).end_blk) {
>> +			f2fs_msg(sbi->sb, KERN_ERR, "Invalid block %x",
>> +				 blkstart);
>> +			return -EIO;
>> +		}
>>  		blkstart -= FDEV(devi).start_blk;
>>  	}
>>  
>> -	/*
>> -	 * We need to know the type of the zone: for conventional zones,
>> -	 * use regular discard if the drive supports it. For sequential
>> -	 * zones, reset the zone write pointer.
>> -	 */
>> -	switch (get_blkz_type(sbi, bdev, blkstart)) {
>> -
>> -	case BLK_ZONE_TYPE_CONVENTIONAL:
>> -		if (!blk_queue_discard(bdev_get_queue(bdev)))
>> -			return 0;
>> -		return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
>> -	case BLK_ZONE_TYPE_SEQWRITE_REQ:
>> -	case BLK_ZONE_TYPE_SEQWRITE_PREF:
>> +	/* For sequential zones, reset the zone write pointer */
>> +	if (f2fs_blkz_is_seq(sbi, devi, blkstart)) {
>>  		sector = SECTOR_FROM_BLOCK(blkstart);
>>  		nr_sects = SECTOR_FROM_BLOCK(blklen);
>>  
>>  		if (sector & (bdev_zone_sectors(bdev) - 1) ||
>>  				nr_sects != bdev_zone_sectors(bdev)) {
>> -			f2fs_msg(sbi->sb, KERN_INFO,
>> -				"(%d) %s: Unaligned discard attempted (block %x + %x)",
>> +			f2fs_msg(sbi->sb, KERN_ERR,
>> +				"(%d) %s: Unaligned zone reset attempted (block %x + %x)",
>>  				devi, sbi->s_ndevs ? FDEV(devi).path: "",
>>  				blkstart, blklen);
>>  			return -EIO;
>>  		}
>>  		trace_f2fs_issue_reset_zone(bdev, blkstart);
>> -		return blkdev_reset_zones(bdev, sector,
>> -					  nr_sects, GFP_NOFS);
>> -	default:
>> -		/* Unknown zone type: broken device ? */
>> -		return -EIO;
>> +		return blkdev_reset_zones(bdev, sector, nr_sects, GFP_NOFS);
>>  	}
>> +
>> +	/* For conventional zones, use regular discard if supported */
>> +	if (!blk_queue_discard(bdev_get_queue(bdev)))
> 
> if (!f2fs_hw_support_discard())

Looking more into this, it turns out that f2fs_sb_has_blkzoned(),
f2fs_hw_should_discard() and f2fs_hw_support_discard() all behave the same and
look directly at the information attached to sbi, which excludes a per device
granularity for a multi-device mount. This is a problem for multi-device mounts
combining zoned and regular devices, which is possible and working now, but not
really handled safely I think. I.e. all segments on all disks should be the same
size, so all zoned devices should have the same zone size and that size used
also for the regular disks segments.

We may need additional patches to do all this safely. Combining regular and
zoned disks is a needed feature as that allows supporting zoned disks without
conventional zones: the fixed location metadata go onto a first regular device
(partition) of the mount and the sequential zone only disk can be added as a
second disk of the volume.

Thoughts ?

> 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
>> +		return 0;
>> +	return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
>>  }
>>  #endif
>>  
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index d1ccc52afc93..8d0caf4c5f2b 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1017,7 +1017,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>>  	for (i = 0; i < sbi->s_ndevs; i++) {
>>  		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
>>  #ifdef CONFIG_BLK_DEV_ZONED
>> -		kvfree(FDEV(i).blkz_type);
>> +		kvfree(FDEV(i).blkz_seq);
>>  #endif
>>  	}
>>  	kvfree(sbi->devs);
>> @@ -2765,9 +2765,11 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>  	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
>>  		FDEV(devi).nr_blkz++;
>>  
>> -	FDEV(devi).blkz_type = f2fs_kmalloc(sbi, FDEV(devi).nr_blkz,
>> -								GFP_KERNEL);
>> -	if (!FDEV(devi).blkz_type)
>> +	FDEV(devi).blkz_seq = f2fs_kzalloc(sbi,
>> +					BITS_TO_LONGS(FDEV(devi).nr_blkz)
>> +					* sizeof(unsigned long),
>> +					GFP_KERNEL);
>> +	if (!FDEV(devi).blkz_seq)
>>  		return -ENOMEM;
>>  
>>  #define F2FS_REPORT_NR_ZONES   4096
>> @@ -2794,7 +2796,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>  		}
>>  
>>  		for (i = 0; i < nr_zones; i++) {
>> -			FDEV(devi).blkz_type[n] = zones[i].type;
>> +			if (zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL)
>> +				set_bit(n, FDEV(devi).blkz_seq);
>>  			sector += zones[i].len;
>>  			n++;
>>  		}
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research
