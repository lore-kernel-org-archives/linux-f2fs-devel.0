From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
Date: Wed, 12 Sep 2018 09:13:04 +0800
Message-ID: <650f06f4-7ca3-a3ed-d149-88d1e9f93b7a@huawei.com>
References: <20180911201546.56566-1-jaegeuk@kernel.org>
 <7aa2e6f3-a4b2-dfdd-6205-f19c4bc952e6@kernel.org>
 <20180912000603.GA67662@jaegeuk-macbookpro.roam.corp.google.com>
 <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/12 8:27, Jaegeuk Kim wrote:
> On 09/11, Jaegeuk Kim wrote:
>> On 09/12, Chao Yu wrote:
>>> On 2018/9/12 4:15, Jaegeuk Kim wrote:
>>>> fsck.f2fs is able to recover the quota structure, since roll-forward recovery
>>>> can recover it based on previous user information.
>>>
>>> I didn't get it, both fsck and kernel recover quota file based all inodes'
>>> uid/gid/prjid, if {x}id didn't change, wouldn't those two recovery result be the
>>> same?
>>
>> I thought that, but had to add this, since I was encountering quota errors right
>> after getting some files recovered. And, I thought it'd make it more safe to do
>> fsck after roll-forward recovery.
>>
>> Anyway, let me test again without this patch for a while.
> 
> Hmm, I just got a fsck failure right after some files recovered.

To make sure, do you test with "f2fs: guarantee journalled quota data by
checkpoint"? if not, I think there is no guarantee that f2fs can recover
quote info into correct quote file, because, in last checkpoint, quota file
may was corrupted/inconsistent. Right?

Thanks,

> 
>>
>> Thanks,
>>
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> ---
>>>>  fs/f2fs/recovery.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>> index 95511ed11a22..1fde86a2107e 100644
>>>> --- a/fs/f2fs/recovery.c
>>>> +++ b/fs/f2fs/recovery.c
>>>> @@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>>>>  
>>>>  	need_writecp = true;
>>>>  
>>>> +	/* quota is not fully updated due to the lack of user information. */
>>>> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>> +
>>>>  	/* step #2: recover data */
>>>>  	err = recover_data(sbi, &inode_list, &dir_list);
>>>>  	if (!err)
>>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 
