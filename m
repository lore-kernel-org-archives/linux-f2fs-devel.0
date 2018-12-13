From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add an ioctl() to explicitly trigger
 fsck later
Date: Thu, 13 Dec 2018 14:30:11 +0800
Message-ID: <4dbbef1b-037c-0129-8485-a9f908835ec2@huawei.com>
References: <20181129015257.95036-1-jaegeuk@kernel.org>
 <16b92898-0d8b-8edf-17f4-36b112b25add@huawei.com>
 <20181130203611.GC71781@jaegeuk-macbookpro.roam.corp.google.com>
 <a50a7612-7429-4cc7-c9bb-56a054826a03@huawei.com>
 <20181213035631.GB33959@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213035631.GB33959@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/13 11:56, Jaegeuk Kim wrote:
> On 12/07, Chao Yu wrote:
>> On 2018/12/1 4:36, Jaegeuk Kim wrote:
>>> On 11/30, Chao Yu wrote:
>>>> On 2018/11/29 9:52, Jaegeuk Kim wrote:
>>>>> This adds an option in ioctl(F2FS_IOC_SHUTDOWN) in order to trigger fsck by
>>>>> setting a NEED_FSCK flag.
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/f2fs.h | 1 +
>>>>>  fs/f2fs/file.c | 7 +++++++
>>>>>  2 files changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index aa500239baf2..7cec897146a3 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -417,6 +417,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>>>>>  #define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
>>>>>  #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
>>>>>  #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
>>>>> +#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
>>>>
>>>> Why not add a new ioctl interface for this? F2FS_GOING_DOWN_ prefix implies
>>>> filesystem will shutdown, IMO, we'd better to keep all sub-interfaces being
>>>> consistent in f2fs_ioc_shutdown().
>>>
>>> I'm thinking to use this for QA as device shutdown tests.
>>>
>>>>
>>>>>  
>>>>>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>>>>>  /*
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index ff82350a2c55..ca9bdbb8651b 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -1966,6 +1966,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>>>  		f2fs_stop_checkpoint(sbi, false);
>>>>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>>>  		break;
>>>>> +	case F2FS_GOING_DOWN_NEED_FSCK:
>>>>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>> +		/* do checkpoint only */
>>>>> +		ret = f2fs_sync_fs(sb, 1);
>>>>> +		if (ret)
>>>>> +			goto out;
>>>>
>>>> In large-sized image, it may take long time to trigger full scan during
>>>> boot, so I'd like to ask how often we set this flag?
>>>
>>> Based on the use of shutdown ioctl, I'll use this for testing purpose, so it
>>> won't be used for regular cases.
>>
>> How about adding some commit messages or comments on
>> F2FS_GOING_DOWN_NEED_FSCK marco definition to give a bit hint for f2fs
>> developers to know the usage of the interface?
> 
> Done. :P
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev

Looks good to me now. ;)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>> +		break;
>>>>>  	default:
>>>>>  		ret = -EINVAL;
>>>>>  		goto out;
>>>>>
>>>
>>> .
>>>
> 
> .
> 
