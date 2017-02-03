From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: fix bad assignment of
 total_sectors for f2fs_configuration
Date: Fri, 3 Feb 2017 17:40:10 +0800
Message-ID: <58944FFA.5050907@huawei.com>
References: <130c919b-def1-33b1-0e16-e18e8de28d5c@gmail.com>
	<5886C4D0.8040601@huawei.com>
	<40f1d2bb-4454-8d65-14ba-b258055cce80@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1cZaMp-0004e9-QX
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Feb 2017 09:41:19 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cZaMd-00045E-Cs
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Feb 2017 09:41:19 +0000
In-Reply-To: <40f1d2bb-4454-8d65-14ba-b258055cce80@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net



On 2/3/2017 4:08 PM, Kinglong Mee wrote:
> On 1/24/2017 11:06, Sheng Yong wrote:
>> Hi, Kinglong
>>
>> On 1/24/2017 10:42 AM, Kinglong Mee wrote:
>>> wanted_total_sectors is introduced instead total_sectors,
>>> so that, the initialize is a fault, drop it.
>>>
>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>> ---
>>>  mkfs/f2fs_format_main.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
>>> index db1dc94..5bb1faf 100644
>>> --- a/mkfs/f2fs_format_main.c
>>> +++ b/mkfs/f2fs_format_main.c
>>> @@ -151,9 +151,6 @@ static void f2fs_parse_options(int argc, char *argv[])
>>>  		c.wanted_total_sectors = atoll(argv[optind+1]);
>>>  	}
>>>  
>>> -	if ((optind + 1) < argc)
>>> -		c.total_sectors = atoll(argv[optind+1]);
>>> -
>> Here we get the number of sectors specified by user, so that we could
>> create an image based on a specific size. There seems no fault. Could
>> you please give more detail :)
> 
> Sorry for the late reply.
> 
> Commit de7e07e011 "f2fs-tools: support multiple devices" changes the using of
> c.total_sectors, adds wanted_total_sectors instead it. 
> c.total_sectors must be initialized as zero (drop the fault assignment).
> 
Right. My bad that I didn't catch up with the latest dev-test branch, I was
reading the patch against dev branch :(

thanks,
Sheng

> Used as, 
> int get_device_info(struct device_info *dev)
> ...
> c.total_sectors += dev->total_sectors;
> 
> After that, mkfs.f2fs will fail with specified lager size than disk.
> # fdisk -ls /dev/sdb1
> 20970496
> # mkfs.f2fs /dev/sdb1 209704961
> 
>         F2FS-tools: mkfs.f2fs Ver: 1.7.0 (2017-01-13)
> 
> Info: Debug level = 0
> Info: Trim is enabled
> Info: [/dev/sdb1] Disk Model: VMware Virtual S1.0
> Info: total device sectors = 251645953 (in 512 bytes)
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 209704961 (102395 MB)
> Info: zone aligned segment0 blkaddr: 256
> Info: format version with
>   "Linux version 4.10.0-rc6+ (root@localhost) (gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC) ) #483 SMP Fri Feb 3 13:58:56 CST 2017"
> Info: [/dev/sdb1] Discarding device
> Info: This device doesn't support BLKSECDISCARD
> Info: This device doesn't support BLKDISCARD
>         Error: Failed to create the root directory!!!
>         Error: Could not format the device!!!
> 
> With this patch, mkfs.f2fs success as,
> #  mkfs.f2fs /dev/sdb1 209704961
> 
>         F2FS-tools: mkfs.f2fs Ver: 1.7.0 (2017-01-13)
> 
> Info: Debug level = 0
> Info: Trim is enabled
> Info: [/dev/sdb1] Disk Model: VMware Virtual S1.0
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 41940992 (20479 MB)
> Info: zone aligned segment0 blkaddr: 256
> Info: format version with
>   "Linux version 4.10.0-rc6+ (root@localhost) (gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC) ) #483 SMP Fri Feb 3 13:58:56 CST 2017"
> Info: [/dev/sdb1] Discarding device
> Info: This device doesn't support BLKSECDISCARD
> Info: This device doesn't support BLKDISCARD
> Info: Overprovision ratio = 1.400%
> Info: Overprovision segments = 290 (GC reserved = 150)
> Info: format successful
> 
> thanks,
> Kinglong Mee
> 
>> thanks,
>> Sheng
>>>  	if (c.zoned_mode)
>>>  		c.feature |= cpu_to_le32(F2FS_FEATURE_BLKZONED);
>>>  }
>>>
>>
>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
