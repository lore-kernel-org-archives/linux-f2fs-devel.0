From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 5/5] f2fs-tools: Fix multi-device format with
 zoned devices
Date: Thu, 21 Mar 2019 09:30:05 +0000
Message-ID: <BYAPR04MB58163DCF97DC43BB35240FC7E7420@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190318063959.21369-1-damien.lemoal@wdc.com>
 <20190318063959.21369-6-damien.lemoal@wdc.com>
 <4bbfbf65-a265-5ce2-9e4a-ebd2a88c0feb@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9769e70d0=Damien.LeMoal@wdc.com>)
 id 1h6u1e-0004ab-VX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 09:30:15 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h6u1c-0008wp-Sx
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 09:30:14 +0000
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

On 2019/03/21 17:41, Chao Yu wrote:
> On 2019/3/18 14:39, Damien Le Moal wrote:
>> There is no need to require conventional zones for a zoned block device
>> that is not the first device of a multi-device volume. So exclude the
>> check on the number of conventional zones of the device if the device
>> index is not 0.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  lib/libf2fs_zoned.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
>> index 1a6c5df..2d8244f 100644
>> --- a/lib/libf2fs_zoned.c
>> +++ b/lib/libf2fs_zoned.c
>> @@ -204,7 +204,7 @@ int f2fs_check_zones(int j)
>>  		goto out;
>>  	}
>>  
> 
> How about adding one line comment here to describe why we handle condition
> as below for better readability? I guess using your commit message here is
> enough... :)

Indeed, that would be better. Will add that. Thanks !

> 
>> -	if (dev->zoned_model == F2FS_ZONED_HM &&
>> +	if (j == 0 && dev->zoned_model == F2FS_ZONED_HM &&
>>  			!dev->nr_rnd_zones) {
>>  		ERR_MSG("No conventional zone for super block\n");
>>  		ret = -1;
>>
> 


-- 
Damien Le Moal
Western Digital Research
