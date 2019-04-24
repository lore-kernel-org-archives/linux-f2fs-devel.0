From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Possible issues with fsck of f2fs root
Date: Wed, 24 Apr 2019 15:07:43 +0800
Message-ID: <f3094e40-13ff-ea31-faf1-9e78867f4a8d@huawei.com>
References: <CADoWrG-0GWtwqaW7rsPWLDYcoAsvXhwRa9zVib9bN94g1LLw6Q@mail.gmail.com>
 <20190416185353.GA56890@jaegeuk-macbookpro.roam.corp.google.com>
 <14c1ba5f-a636-27f6-9240-55cdef2c8c26@huawei.com>
 <20190421102703.GC7295@jaegeuk-macbookpro.roam.corp.google.com>
 <CADoWrG9FZ-MN5v2a9V3EZJ9Cj6L5CBadV836D2=MGockXsgQ_g@mail.gmail.com>
 <941621e2-465b-daa6-d323-0e40239e0981@huawei.com>
 <CADoWrG9y8y2KEh5FsppBYe_10kcCoFSY-JSvHqDfuLR70HDxSw@mail.gmail.com>
 <55150868-4d32-8eed-8d09-d27817360c86@huawei.com>
 <CADoWrG-M7fMyu2u7h3Dk7GFH+Bm=A2JpJteZotQCHCatfn05Pw@mail.gmail.com>
 <246f0e93-0637-c7a2-f9f0-9131308af76f@huawei.com>
 <CADoWrG9fmTx913OcyNL0NJn-wb6F+aq0a+AeAwfJZaRAuBL8iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hJC0W-0006ZH-JB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 07:07:52 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJC0U-009Xk1-ED
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 07:07:52 +0000
In-Reply-To: <CADoWrG9fmTx913OcyNL0NJn-wb6F+aq0a+AeAwfJZaRAuBL8iQ@mail.gmail.com>
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
To: Hagbard Celine <hagbardcelin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

On 2019/4/24 0:17, Hagbard Celine wrote:
> 2019-04-23 4:55 GMT+02:00, Chao Yu <yuchao0@huawei.com>:
>> On 2019/4/22 18:05, Hagbard Celine wrote:
>>> 2019-04-22 11:26 GMT+02:00, Chao Yu <yuchao0@huawei.com>:
>>>> On 2019/4/22 17:05, Hagbard Celine wrote:
>>>>> 2019-04-22 9:37 GMT+02:00, Chao Yu <yuchao0@huawei.com>:
>>>>>> On 2019/4/22 15:11, Hagbard Celine wrote:
>>>>>>> With this patch the one problem with opening the device in RO mode is
>>>>>>> fixed.
>>>>>>
>>>>>> Oops, with default preen mode fsck should not open ro mounted image,
>>>>>> that's
>>>>>> the
>>>>>> rule we keep line with ext4...
>>>>>>
>>>>>> How about changing to use -f in your scenario ( on RO mounted root
>>>>>> image
>>>>>> )?
>>>>>
>>>>> This was with -f. Without -f it still refuses to open the device.
>>>>
>>>> What I mean is we'd better to keep line with ext4, just refusing to open
>>>> ro
>>>> mounted device without -f, since triggering fsck and repair on a mounted
>>>> device
>>>> is dangerous, it can easily make inconsistency in between in-memory data
>>>> and
>>>> on-disk data of filesystem. Refusing fsck without -f is to make user
>>>> being
>>>> aware
>>>> of such danger.
>>>
>>> I am sorry, I've apparently added the -f after my first report. After
>>> re-testing it seems that fsck.f2fs is opening the RO partition even
>>> without this patch if I use -f. So the part about fsck.f2fs not being
>>> able to open RO mounted partition during boot was a user error.
>>
>> I've sent a patch for your second issue, could you please have a try with
>> it?
>>
>> [PATCH] fsck.f2fs: fix to repair ro mounted device w/ -f
>>
>> But one concern is that, with this patch, not like the fsck.ext4, fsck.f2fs
>> won't show any interaction with below reminding word to remind user to
>> decide
>> repair or not, it may increase the risk of damaging the device.
>>
>> Do you want to restore lost files into ./lost_found/?
>> Do you want to fix this partition? [Y/N]
>>
>> Jaegeuk, Hagbard,
>>
>> Any suggestion on this, in current scenario, how about implement:
>> 1. fsck.f2fs -f ro_mounted_device: check; show interaction words if there
>> is
>> corruption;
>> 2. fsck.f2fs -f -a ro_moutned_device: check and repair automatically;
> 
> I answered this all too quickly and did not think it trough properly.
> As it stands today, if I run "fsck.f2fs -f /dev/some_unmounted_disk"
> it will always do a full fsck.
> If I on the other hand do "fsck.f2fs -f -a /dev/some_unmounted_disk"
> it sometimes only reads the checkpoint state and returns with: "Info:
> No errors was reported".
> I do not have a ext4 partition with errors to test, but I have a fat

It can easily be generated by debugfs with:

debugfs:  open /dev/zram0 -w
debugfs:  sif file extra_isize 19

> partition that comes up with "Free cluster summary wrong" on every run
> of fsck.fat and there fsck asks for confirmation when run with "-f"
> and autofixes without asking when running with "-f -a".

For some_unmounted_disk, fsck.ext4 shows the same behavior like fsck.fat:

# fsck.ext4 /dev/zram0 -f
e2fsck 1.45.0 (6-Mar-2019)
Pass 1: Checking inodes, blocks, and sizes
Inode 12 has a extra size (19) which is invalid
Fix<y>?
/dev/zram0: e2fsck canceled.

# fsck.ext4 /dev/zram0 -f -a
/dev/zram0: Inode 12 has a extra size (19) which is invalid
FIXED.

Also on a RO_mounted_disk, the behavior of fsck.ext4 is the same, so, it looks
like we actually need another patch to fix fsck.f2fs' behavior for "-f" and "-f
-a" on umounted/ro_mounted device.

Thanks,

> 
> Considering this I believe the proposed solution would be
> counter-intuitive, unless fsck.ext4 behaves opposite of fsck.fat
> already.
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>> But as far as I can understand it will still only check the fs, not
>>>>>>> fix
>>>>>>> it.
>>>>>>>
>>>>>>>
>>>>>>> 2019-04-21 12:27 GMT+02:00, Jaegeuk Kim <jaegeuk@kernel.org>:
>>>>>>>
>>>>>>>>
>>>>>>>> New version of the patch is:
>>>>>>>>
>>>>>>>> From 3221692b060649378f1f69b898ed85a814af3dbf Mon Sep 17 00:00:00
>>>>>>>> 2001
>>>>>>>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>> Date: Tue, 16 Apr 2019 11:46:31 -0700
>>>>>>>> Subject: [PATCH] fsck.f2fs: open ro disk if we want to check fs only
>>>>>>>>
>>>>>>>> This patch fixes the "open failure" issue on ro disk, reported by
>>>>>>>> Hagbard.
>>>>>>>>
>>>>>>>> "
>>>>>>>>  If I boot with kernel option "ro rootfstype=f2fs
>>>>>>>>  I get the following halfway trough boot:
>>>>>>>>
>>>>>>>>   * Checking local filesystems  ...
>>>>>>>>  Info: Use default preen mode
>>>>>>>>  Info: Mounted device!
>>>>>>>>  Info: Check FS only due to RO
>>>>>>>>          Error: Failed to open the device!
>>>>>>>>   * Filesystems couldn't be fixed
>>>>>>>> "
>>>>>>>>
>>>>>>>> Reported-by: Hagbard Celine <hagbardcelin@gmail.com>
>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>> ---
>>>>>>>>  lib/libf2fs.c | 25 +++++++++++++++++++++----
>>>>>>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
>>>>>>>> index d30047f..853e713 100644
>>>>>>>> --- a/lib/libf2fs.c
>>>>>>>> +++ b/lib/libf2fs.c
>>>>>>>> @@ -789,6 +789,15 @@ void get_kernel_uname_version(__u8 *version)
>>>>>>>>  #endif /* APPLE_DARWIN */
>>>>>>>>
>>>>>>>>  #ifndef ANDROID_WINDOWS_HOST
>>>>>>>> +static int open_check_fs(char *path, int flag)
>>>>>>>> +{
>>>>>>>> +	if (c.func != FSCK || c.fix_on || c.auto_fix)
>>>>>>>> +		return -1;
>>>>>>>> +
>>>>>>>> +	/* allow to open ro */
>>>>>>>> +	return open(path, O_RDONLY | flag);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  int get_device_info(int i)
>>>>>>>>  {
>>>>>>>>  	int32_t fd = 0;
>>>>>>>> @@ -810,8 +819,11 @@ int get_device_info(int i)
>>>>>>>>  	if (c.sparse_mode) {
>>>>>>>>  		fd = open(dev->path, O_RDWR | O_CREAT | O_BINARY, 0644);
>>>>>>>>  		if (fd < 0) {
>>>>>>>> -			MSG(0, "\tError: Failed to open a sparse file!\n");
>>>>>>>> -			return -1;
>>>>>>>> +			fd = open_check_fs(dev->path, O_BINARY);
>>>>>>>> +			if (fd < 0) {
>>>>>>>> +				MSG(0, "\tError: Failed to open a sparse file!\n");
>>>>>>>> +				return -1;
>>>>>>>> +			}
>>>>>>>>  		}
>>>>>>>>  	}
>>>>>>>>
>>>>>>>> @@ -825,10 +837,15 @@ int get_device_info(int i)
>>>>>>>>  			return -1;
>>>>>>>>  		}
>>>>>>>>
>>>>>>>> -		if (S_ISBLK(stat_buf->st_mode) && !c.force)
>>>>>>>> +		if (S_ISBLK(stat_buf->st_mode) && !c.force) {
>>>>>>>>  			fd = open(dev->path, O_RDWR | O_EXCL);
>>>>>>>> -		else
>>>>>>>> +			if (fd < 0)
>>>>>>>> +				fd = open_check_fs(dev->path, O_EXCL);
>>>>>>>> +		} else {
>>>>>>>>  			fd = open(dev->path, O_RDWR);
>>>>>>>> +			if (fd < 0)
>>>>>>>> +				fd = open_check_fs(dev->path, 0);
>>>>>>>> +		}
>>>>>>>>  	}
>>>>>>>>  	if (fd < 0) {
>>>>>>>>  		MSG(0, "\tError: Failed to open the device!\n");
>>>>>>>> --
>>>>>>>> 2.19.0.605.g01d371f741-goog
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Linux-f2fs-devel mailing list
>>>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>>> .
>>>>>>>
>>>>>>
>>>>> .
>>>>>
>>>>
>>> .
>>>
>>
> .
> 
