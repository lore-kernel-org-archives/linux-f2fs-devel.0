From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 4/5] f2fs-tools: Allow using host-aware
 devices as regular devices
Date: Thu, 21 Mar 2019 09:29:17 +0000
Message-ID: <BYAPR04MB581680081781D788BC646807E7420@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190318063959.21369-1-damien.lemoal@wdc.com>
 <20190318063959.21369-5-damien.lemoal@wdc.com>
 <a2201b9a-9fa0-a01f-d44f-03120f3d4d8f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9769e70d0=Damien.LeMoal@wdc.com>)
 id 1h6u0z-0005Zu-71
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 09:29:33 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h6u0r-00DMJd-GU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 09:29:33 +0000
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

On 2019/03/21 17:32, Chao Yu wrote:
> On 2019/3/18 14:39, Damien Le Moal wrote:
>> Host-aware zoned block devices can accept random writes anywhere and so
>> do not require to be handled under F2FS_ZONED_HM mode. Allow host aware
>> disks to be treated as regular devices if c.zoned_mode is false, that
>> is, if the -m option is not specified in mkfs.f2fs.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  lib/libf2fs.c | 43 ++++++++++++++++++++++++++++++-------------
>>  1 file changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
>> index 5ca1bb0..214c921 100644
>> --- a/lib/libf2fs.c
>> +++ b/lib/libf2fs.c
>> @@ -933,9 +933,21 @@ int get_device_info(int i)
>>  	}
>>  
>>  	if (dev->zoned_model != F2FS_ZONED_NONE) {
>> -		if (dev->zoned_model == F2FS_ZONED_HM)
>> +		if (dev->zoned_model == F2FS_ZONED_HM) {
>>  			c.zoned_model = F2FS_ZONED_HM;
>> +		} else {
>> +			/* F2FS_ZONED_HA */
>> +			if (c.zoned_mode) {
>> +				c.zoned_model = F2FS_ZONED_HM;
> 
> May I ask why we change the model from F2FS_ZONED_HA to F2FS_ZONED_HM?
> 
> Thanks,

There is some confusion I think in the code between disk zoned model and f2fs
zoned mode. Currently, F2FS_ZONED_HA is not tested anywhere to drive the check
against c.zoned_mode. Before this patch, the code was:

	if (dev->zoned_model != F2FS_ZONED_NONE) {
		if (dev->zoned_model == F2FS_ZONED_HM)
			c.zoned_model = F2FS_ZONED_HM;

So only HM disks end up setting "c.zoned_model = F2FS_ZONED_HM" which requires
c.zoned_mode to be set. For an F2FS_ZONED_HA disk, c.zoned_model stays as NONE
and c.zone_blocks is set, regardless of c.zoned_mode setting. The end result is
that the HA disk will be used as a regular disk when -m is not specified on mkfs
command line, and as a zoned disk when -m is specified. However, many areas of
the code check for c.zoned_model == F2FS_ZONED_HM, and that is always false for
HA disks.

The idea here is to allow a cleaner control over HA disk use: either use them as
regular disks and ignore that they are zoned, or use them in the same manner as
HM disks, ignoring the fact that HA disks can accept random writes. Anything in
between these 2 modes does not really make sense.

Now, rereading the code and explaining all this, I realize that the commit
message is actually not correct at all and misleading to the intent of the
patch. I will revisit it and check again this patch. We could actually drop it
for now and I can resend later.

In any case, I am sending a v2 for this series.

Thanks for your review !


> 
>> +			} else {
>> +				MSG(0, "Info: treating host-aware zoned block "
>> +				    "device as regular device\n");
>> +				dev->zoned_model = F2FS_ZONED_NONE;
>> +			}
>> +		}
>> +	}
>>  
>> +	if (c.zoned_model == F2FS_ZONED_HM) {
>>  		if (f2fs_get_zone_blocks(i)) {
>>  			MSG(0, "\tError: Failed to get number of blocks per zone\n");
>>  			free(stat_buf);
>> @@ -1071,6 +1083,7 @@ int get_device_info(int i)
>>  
>>  int f2fs_get_device_info(void)
>>  {
>> +	bool zoned = false;
>>  	int i;
>>  
>>  	for (i = 0; i < c.ndevs; i++)
>> @@ -1089,22 +1102,26 @@ int f2fs_get_device_info(void)
>>  		return -1;
>>  	}
>>  
>> +	/* For zoned devices, the zones sizes must be equal */
>>  	for (i = 0; i < c.ndevs; i++) {
>> -		if (c.devices[i].zoned_model != F2FS_ZONED_NONE) {
>> -			if (c.zone_blocks &&
>> -				c.zone_blocks != c.devices[i].zone_blocks) {
>> -				MSG(0, "\tError: not support different zone sizes!!!\n");
>> -				return -1;
>> -			}
>> -			c.zone_blocks = c.devices[i].zone_blocks;
>> +		if (c.devices[i].zoned_model != F2FS_ZONED_HM)
>> +			continue;
>> +
>> +		zoned = true;
>> +
>> +		if (c.zone_blocks &&
>> +		    c.zone_blocks != c.devices[i].zone_blocks) {
>> +			MSG(0, "\tError: zones of different size are not supported\n");
>> +			return -1;
>>  		}
>> +		c.zone_blocks = c.devices[i].zone_blocks;
>>  	}
>>  
>> -	/*
>> -	 * Align sections to the device zone size
>> -	 * and align F2FS zones to the device zones.
>> -	 */
>> -	if (c.zone_blocks) {
>> +	if (zoned) {
>> +		/*
>> +		 * Align sections to the device zone size
>> +		 * and align F2FS zones to the device zones.
>> +		 */
>>  		c.segs_per_sec = c.zone_blocks / DEFAULT_BLOCKS_PER_SEGMENT;
>>  		c.secs_per_zone = 1;
>>  	} else {
>>
> 


-- 
Damien Le Moal
Western Digital Research
