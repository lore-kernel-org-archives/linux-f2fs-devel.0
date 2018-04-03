From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] libf2fs: reset wanted_total_sectors by new
 sector_size
Date: Tue, 3 Apr 2018 13:56:38 +0800
Message-ID: <7c0c792f-93e1-a1c9-8ad3-5f94199bdba8@huawei.com>
References: <20180327171908.15092-1-jaegeuk@kernel.org>
 <7561e573-9d88-60f0-868f-4a4b59d588cb@huawei.com>
 <50951b88-ccfc-836c-34c0-7347ff1f747a@huawei.com>
 <d49db6fe-d3db-9dc6-d4ce-5955b0dd01c3@huawei.com>
 <d2baabc6-e4cb-0bdc-fccb-fe3b0cdc813e@huawei.com>
 <20180330153909.GA44823@jaegeuk-macbookpro.roam.corp.google.com>
 <f9465bc9-714d-2a9c-684d-0351ceb82724@huawei.com>
 <20180402200336.GA19195@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f3EwT-0004TG-Rh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Apr 2018 05:57:13 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3EwP-006pv4-Jy
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Apr 2018 05:57:13 +0000
In-Reply-To: <20180402200336.GA19195@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: katao <katao@xiaomi.com>, Jaegeuk Kim <jaegeuk@google.com>, linux-f2fs-devel@lists.sourceforge.net

On 2018/4/3 4:03, Jaegeuk Kim wrote:
> On 04/02, Chao Yu wrote:
>> On 2018/3/30 23:39, Jaegeuk Kim wrote:
>>> On 03/30, Junling Zheng wrote:
>>>> On 2018/3/30 19:26, Chao Yu wrote:
>>>>> On 2018/3/30 18:51, Junling Zheng wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 2018/3/30 17:28, Chao Yu wrote:
>>>>>>> Hi All,
>>>>>>>
>>>>>>> On 2018/3/28 1:19, Jaegeuk Kim wrote:
>>>>>>>> From: katao <katao@xiaomi.com>
>>>>>>>>
>>>>>>>> The args of wanted_total_sectors is calculated based
>>>>>>>> on the DEFAULT_SECTOR_SIZE(512Bytes).get_device_info(i)
>>>>>>>> may be reset dev_sector_size, we should reset the number
>>>>>>>> of wanted_total_sectors.
>>>>>>>>
>>>>>>>> This bug was reported to Google Issue Tracker.
>>>>>>>> Link: https://issuetracker.google.com/issues/76407663
>>>>>>>
>>>>>>> I don't think this is the right way, since now we have changed previous
>>>>>>> sector_counter's meaning, some applications, for example, like xfstests will get
>>>>>>> device's real sector size via blockdev --getsize64, then calculate total wanted
>>>>>>> sector count by total_wanted_size / real_sector_size, if we changed default
>>>>>>> sector size to 512bytes, xfstests will pass a wrong sector number, result in
>>>>>>> getting wrong partition size.
>>>>>>>
>>>>>>> For something worse, in order to get the correct sector number, we have to
>>>>>>> change the way of calculation method of xfstests for new mkfs, but how can
>>>>>>> xfstests know the current version of mkfs is new or old...
>>>>>>>
>>>>>>> I think the change didn't consider backward compatibility of mkfs, so, in order
>>>>>>> to keep that, we'd better to let user pass the right sector number based on
>>>>>>> their device, or we can introduce a new parameter to indicate user wanted total
>>>>>>> size.
>>>>>>>
>>>>>>> How do you think?
>>>>>>>
>>>>>>
>>>>>> Agree. It's not backward-compatible. Most users can pass the correct sector number
>>>>>> calculated by the real sector size. For those very few users using 512B despite of
>>>>>> the actual sector size, all we need to do is informing them the real sector size.
>>>>>
>>>>> The problem is via passed sector number, we can't know user has already knew the
>>>>> real sector size or not, so we don't have any chance to info them.
>>>>>
>>>>
>>>> Yeah, we can't guess users' behaviors. And only when wanted size is over device size,
>>>> we can inform users the real sector size.
>>>
>>> So, current problem would be that wanted_total_sectors is given by:
>>> - device sector size in xfstests
>>> - 4KB in fs_mgr in Android
>>> - 512B in recovery in Android
>>>
>>> And, my concern is why user always needs to think about sector_size to give
>>> target image size, and I thought 512B would be good to set as a default smallest
>>> value.
>>
>> Of course, IMO, the most direct way is let user pass image size to mkfs.f2fs
>> instead of caculated sector size, I think that will make all happy.
> 
> No, it can become too large number.
> 
>>
>>>
>>> Setting it 512B by default can give some confusion to users tho, it won't hurt
>>> the existing partitions or images. So, I bet users will get noticed quickly,
>>> when formatting new partition under this rule.
>>
>> For those f2fs users, who makes image based on non-512B sector device, once they
>> upgrade mkfs.f2fs, they will encounter this issue, that may make bad reputation.
>>
>> For interface in f2fs private ioctl, sysfs entry, or syscall, we keep the rule
>> that once we want to do some change on it, we will not change the old interface
>> directly, instead, introduce a new one to keep backward compatibility of old
>> one. Still, I hope we can keep that rule in mkfs.f2fs parameter.
> 
> Okay, so in order to give more flexible ways, it'd be fine to add
> wanted_sector_size by "-w" so that we could blow out all the existing concern
> like this.

That's better.

> 
> From: katao <katao@xiaomi.com>
> Date: Tue, 27 Mar 2018 13:25:46 +0800
> Subject: [PATCH] libf2fs,mkfs.f2fs: add wanted_sector_size for
>  wanted_total_sectors
> 
> The wanted_total_sectors was determined by device sector size, but sometimes
> we don't know precise sector_size by default. So, let's give wanted_sector_size
> in such the ambiguous situation.
> 
> Signed-off-by: katao <katao@xiaomi.com>
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
