From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] f2fs: add remount_fs callback support
Date: Thu, 06 Jun 2013 15:52:16 +0800
Message-ID: <51B03FB0.80306@cn.fujitsu.com>
References: <1370071212-7715-1-git-send-email-linkinjeon@gmail.com> <51AD698F.3020305@cn.fujitsu.com> <CAKYAXd_jFuG00-HWQREKieXdqBGEAs+W0imvYZjCpGAH5S4H9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKYAXd_jFuG00-HWQREKieXdqBGEAs+W0imvYZjCpGAH5S4H9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Namjae,

On 06/05/2013 12:34 PM, Namjae Jeon wrote:

> 2013/6/4 Gu Zheng <guz.fnst@cn.fujitsu.com>:
>> On 06/01/2013 03:20 PM, Namjae Jeon wrote:
>>
>>> From: Namjae Jeon <namjae.jeon@samsung.com>
>>>
>>> Add the f2fs_remount function call which will be used
>>> during the filesystem remounting. This function
>>> will help us to change the mount options specific to
>>> f2fs.
>>>
>>> Also modify the f2fs background_gc mount option, which
>>> will allow the user to dynamically trun on/off the
>>> garbage collection in f2fs based on the background_gc
>>> value. If background_gc=0, Garbage collection will
>>> be turned off & if background_gc=1, Garbage collection
>>> will be truned on.
>>
>>
>> Hi Namjae,
> Hi. Gu.
> 
>>   I think splitting these two changes into single ones seems better.
>> Refer to the inline comments.
> I don't think so. Mount option background_gc is changed to make
> remount_fs working in the correct way.

Yes, I know. Maybe you somewhat misread my words. 
Though remount_fs is dependent on changing background_gc option, but the change of background_gc option
and the adding remount_fs support are two different changes.
In order to make each patch simple and clear, maybe you need to split into single ones,
such as:
[PATCH 1/3] f2fs: Modify the f2fs background_gc mount option
[PATCH 2/3] f2fs: add remount_fs callback support
[PATCH 3/3] f2fs: reorganise the function get_victim_by_default

Just a personal suggestion, if you think it is worthless, please ignore it.:)


> 
>>
>> Thanks,
>> Gu
>>
>>
>> Though simply option show is enough, but I think the "background_gc=on/off" is more friendly.
> Yes, Agree. I will update.
> 
>>
>>> +
>>> +     /**
>>> +      * We stop the GC thread if FS is mounted as RO
>>> +      * or if background_gc = 0 is passed in mount
>>> +      * option. Also sync the filesystem.
>>> +      */
>>> +     if ((*flags & MS_RDONLY) || !test_opt(sbi, BG_GC)) {
>>
>>
>> Another condition: The old mount is not RO.
> I don't think that it is needed. I think current condition check can
> be covered about all cases.
> Am I missing something ?

Maybe. If the old mount is RO, so does the remount. It still can pass the judgement here, right?
Though the following stop_gc_thread() and f2fs_sync_fs() can handle this case well, but this
is unnecessary and needless. If we add additional judgement of whether old mount is not RO can avoid this.

Thanks,
Gu

> 
>>
>>> +             stop_gc_thread(sbi);
>>> +             f2fs_sync_fs(sb, 1);
>>> +     } else if (test_opt(sbi, BG_GC) && !sbi->gc_thread) {
>>> +             err = start_gc_thread(sbi);
>>> +             if (err)
>>> +                     goto restore_opts;
>>> +     }
>>> +
>>> +     /* Update the POSIXACL Flag */
>>> +      sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
>>> +             (test_opt(sbi, POSIX_ACL) ? MS_POSIXACL : 0);
>>
>>
>> Maybe you forget to update the flags with MS_RDONLY or ~MS_RDONLY, if the flags changed.
> No, we don't need to check this flags. sb-s_flags will be updated by
> MS_REMOUNT of vfs.(do_remount_sb)
> 
>>
>>> +     return 0;
>>> +
>>> +restore_opts:
>>> +     sb->s_flags = old_sb_flags;
>>
>>
>> There is no need to restore sb->s_flags, parse_options() did not change it.
>> no need to store the old sb->s_flags too.
> Yes, right, I will update.
> 
>>
>>>
>>> -     /* After POR, we can run background GC thread */
>>> -     err = start_gc_thread(sbi);
>>> -     if (err)
>>> -             goto fail;
>>> +     /* After POR, we can run background GC thread.*/
>>> +     if (!(sb->s_flags & MS_RDONLY)) {
>>> +             /**
>>> +              * If filesystem is mounted as read-only then
>>> +              * do not start the gc_thread.
>>> +              */
>>
>> It seems that the comment here is against with the logic.
> hum.. Okay, I will update comment to avoid some confusion.
> 
> Thanks for review :)
> I will post v2 patch including your opinion soon.
> 
