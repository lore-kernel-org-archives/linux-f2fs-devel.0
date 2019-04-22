From: Hagbard Celine <hagbardcelin@gmail.com>
Subject: Re: Possible issues with fsck of f2fs root
Date: Mon, 22 Apr 2019 12:05:36 +0200
Message-ID: <CADoWrG-M7fMyu2u7h3Dk7GFH+Bm=A2JpJteZotQCHCatfn05Pw@mail.gmail.com>
References: <CADoWrG-0GWtwqaW7rsPWLDYcoAsvXhwRa9zVib9bN94g1LLw6Q@mail.gmail.com>
 <20190416185353.GA56890@jaegeuk-macbookpro.roam.corp.google.com>
 <14c1ba5f-a636-27f6-9240-55cdef2c8c26@huawei.com>
 <20190421102703.GC7295@jaegeuk-macbookpro.roam.corp.google.com>
 <CADoWrG9FZ-MN5v2a9V3EZJ9Cj6L5CBadV836D2=MGockXsgQ_g@mail.gmail.com>
 <941621e2-465b-daa6-d323-0e40239e0981@huawei.com>
 <CADoWrG9y8y2KEh5FsppBYe_10kcCoFSY-JSvHqDfuLR70HDxSw@mail.gmail.com>
 <55150868-4d32-8eed-8d09-d27817360c86@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hagbardcelin@gmail.com>) id 1hIVpZ-0001Eq-Ml
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 10:05:45 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hIVpY-005smx-0y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 10:05:45 +0000
Received: by mail-lf1-f66.google.com with SMTP id j20so8589785lfh.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Apr 2019 03:05:43 -0700 (PDT)
In-Reply-To: <55150868-4d32-8eed-8d09-d27817360c86@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

2019-04-22 11:26 GMT+02:00, Chao Yu <yuchao0@huawei.com>:
> On 2019/4/22 17:05, Hagbard Celine wrote:
>> 2019-04-22 9:37 GMT+02:00, Chao Yu <yuchao0@huawei.com>:
>>> On 2019/4/22 15:11, Hagbard Celine wrote:
>>>> With this patch the one problem with opening the device in RO mode is
>>>> fixed.
>>>
>>> Oops, with default preen mode fsck should not open ro mounted image,
>>> that's
>>> the
>>> rule we keep line with ext4...
>>>
>>> How about changing to use -f in your scenario ( on RO mounted root image
>>> )?
>>
>> This was with -f. Without -f it still refuses to open the device.
>
> What I mean is we'd better to keep line with ext4, just refusing to open ro
> mounted device without -f, since triggering fsck and repair on a mounted
> device
> is dangerous, it can easily make inconsistency in between in-memory data
> and
> on-disk data of filesystem. Refusing fsck without -f is to make user being
> aware
> of such danger.

I am sorry, I've apparently added the -f after my first report. After
re-testing it seems that fsck.f2fs is opening the RO partition even
without this patch if I use -f. So the part about fsck.f2fs not being
able to open RO mounted partition during boot was a user error.

>
> Thanks,
>
>>
>>
>>> Thanks,
>>>
>>>> But as far as I can understand it will still only check the fs, not fix
>>>> it.
>>>>
>>>>
>>>> 2019-04-21 12:27 GMT+02:00, Jaegeuk Kim <jaegeuk@kernel.org>:
>>>>
>>>>>
>>>>> New version of the patch is:
>>>>>
>>>>> From 3221692b060649378f1f69b898ed85a814af3dbf Mon Sep 17 00:00:00 2001
>>>>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> Date: Tue, 16 Apr 2019 11:46:31 -0700
>>>>> Subject: [PATCH] fsck.f2fs: open ro disk if we want to check fs only
>>>>>
>>>>> This patch fixes the "open failure" issue on ro disk, reported by
>>>>> Hagbard.
>>>>>
>>>>> "
>>>>>  If I boot with kernel option "ro rootfstype=f2fs
>>>>>  I get the following halfway trough boot:
>>>>>
>>>>>   * Checking local filesystems  ...
>>>>>  Info: Use default preen mode
>>>>>  Info: Mounted device!
>>>>>  Info: Check FS only due to RO
>>>>>          Error: Failed to open the device!
>>>>>   * Filesystems couldn't be fixed
>>>>> "
>>>>>
>>>>> Reported-by: Hagbard Celine <hagbardcelin@gmail.com>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  lib/libf2fs.c | 25 +++++++++++++++++++++----
>>>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
>>>>> index d30047f..853e713 100644
>>>>> --- a/lib/libf2fs.c
>>>>> +++ b/lib/libf2fs.c
>>>>> @@ -789,6 +789,15 @@ void get_kernel_uname_version(__u8 *version)
>>>>>  #endif /* APPLE_DARWIN */
>>>>>
>>>>>  #ifndef ANDROID_WINDOWS_HOST
>>>>> +static int open_check_fs(char *path, int flag)
>>>>> +{
>>>>> +	if (c.func != FSCK || c.fix_on || c.auto_fix)
>>>>> +		return -1;
>>>>> +
>>>>> +	/* allow to open ro */
>>>>> +	return open(path, O_RDONLY | flag);
>>>>> +}
>>>>> +
>>>>>  int get_device_info(int i)
>>>>>  {
>>>>>  	int32_t fd = 0;
>>>>> @@ -810,8 +819,11 @@ int get_device_info(int i)
>>>>>  	if (c.sparse_mode) {
>>>>>  		fd = open(dev->path, O_RDWR | O_CREAT | O_BINARY, 0644);
>>>>>  		if (fd < 0) {
>>>>> -			MSG(0, "\tError: Failed to open a sparse file!\n");
>>>>> -			return -1;
>>>>> +			fd = open_check_fs(dev->path, O_BINARY);
>>>>> +			if (fd < 0) {
>>>>> +				MSG(0, "\tError: Failed to open a sparse file!\n");
>>>>> +				return -1;
>>>>> +			}
>>>>>  		}
>>>>>  	}
>>>>>
>>>>> @@ -825,10 +837,15 @@ int get_device_info(int i)
>>>>>  			return -1;
>>>>>  		}
>>>>>
>>>>> -		if (S_ISBLK(stat_buf->st_mode) && !c.force)
>>>>> +		if (S_ISBLK(stat_buf->st_mode) && !c.force) {
>>>>>  			fd = open(dev->path, O_RDWR | O_EXCL);
>>>>> -		else
>>>>> +			if (fd < 0)
>>>>> +				fd = open_check_fs(dev->path, O_EXCL);
>>>>> +		} else {
>>>>>  			fd = open(dev->path, O_RDWR);
>>>>> +			if (fd < 0)
>>>>> +				fd = open_check_fs(dev->path, 0);
>>>>> +		}
>>>>>  	}
>>>>>  	if (fd < 0) {
>>>>>  		MSG(0, "\tError: Failed to open the device!\n");
>>>>> --
>>>>> 2.19.0.605.g01d371f741-goog
>>>>>
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>> .
>>>>
>>>
>> .
>>
>
