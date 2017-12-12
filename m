From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: pass down write hints to block layer
 for bufferd write
Date: Tue, 12 Dec 2017 10:45:09 +0800
Message-ID: <85f7fc1b-5286-c66f-6833-af1a44c5130f@huawei.com>
References: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
 <d71418e1-d667-3dc6-9265-61db5d8f40bc@huawei.com>
 <5A2112A7.2070208@gmail.com>
 <1fa09755-7322-a886-c582-02e3d93d8f87@kernel.org> <5A2F3BC5.90803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5A2F3BC5.90803@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hyunchul Lee <hyc.lee@gmail.com>, Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, kernel-team@lge.com, linux-fsdevel@vger.kernel.org, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Hyunchul,

On 2017/12/12 10:15, Hyunchul Lee wrote:
> Hi Chao,
> 
> On 12/11/2017 10:15 PM, Chao Yu wrote:
>> Hi Hyunchul,
>>
>> On 2017/12/1 16:28, Hyunchul Lee wrote:
>>> Hi Chao,
>>>
>>> On 11/30/2017 04:06 PM, Chao Yu wrote:
>>>> Hi Hyunchul,
>>>>
>>>> On 2017/11/28 8:23, Hyunchul Lee wrote:
>>>>> From: Hyunchul Lee <cheol.lee@lge.com>
>>>>>
>>>>> This implements which hint is passed down to block layer
>>>>> for datas from the specific segment type.
>>>>>
>>>>> segment type                     hints
>>>>> ------------                     -----
>>>>> COLD_NODE & COLD_DATA            WRITE_LIFE_EXTREME
>>>>> WARM_DATA                        WRITE_LIFE_NONE
>>>>> HOT_NODE & WARM_NODE             WRITE_LIFE_LONG
>>>>> HOT_DATA                         WRITE_LIFE_MEDIUM
>>>>> META_DATA                        WRITE_LIFE_SHORT
>>>>
>>>> Just noticed, if our user do not give the hint via ioctl, f2fs can
>>>> provider hint to lower layer according to hot/cold separation ability,
>>>> it will be okay. But once user give his hint which may be more accurate
>>>> than filesystem, hint converted by f2fs may be wrong.
>>>>
>>>> So what do you think of adding an option to control whether filesystem
>>>> can convert hint user given?
>>>>
>>>
>>> I think it is okay for LIFE_SHORT and LIFE_EXTREME. because they are 
>>> converted to different hints.
>>
>> What I mean is introducing a mount option, e.g. fs_iohint,
>> a) w/o fs_iohint, propagate file/inode io_hint to low layer.
>> b) w/ fs_iohint, ignore file/inode io_hint, use io_hint which is generated
>> with filesystem's private rule.
>>
> 
> Okay, I will implement this option and send this patch again.

Let's wait for Jaegeuk's comments first?

> 
> Without fs_iohint, Even if data blocks are moved due to GC, 
> we should keep user hints. And if user hints are not given, 
> any hints are not passed down to block layer, right?

Hmm.. that will be a problem, IMO, we can store last user's io_hint into inode
layout, so later when we trigger GC, we can use the last io_hint in inode rather
than giving no hint or fs' hint.

I think it needs to discuss with original author of IO hint, what is the IO hint
policy when filesystem move block by itself after inode has been released in system.

Thanks,

> 
> Thank you for comments.
> 
>> Thanks,
>>
>>>
>>> file hint      segment type        io hint
>>> ---------      ------------        -------
>>> LIFE_SHORT     HOT_DATA            LIFE_MEDIUM
>>> LIFE_MEDIUM    WARM_DATA           LIFE_NONE
>>> LIFE_LONG      WARM_DATA           LIFE_NONE
>>> LIFE_EXTREME   COLD_DATA           LIFE_EXTREME
>>>
>>> the problem is that LIFE_MEDIUM and LIFE_LONG are converted to 
>>> the same hint, LIFE_NONE. I am not sure that the seperation between 
>>> LIFE_MEDIUM and LIFE_LONG is really needed. Because I guess that the 
>>> difference between them is a little ambigous for users, and if WARM_DATA 
>>> segment has two different hints, it can makes GC non-efficient.
>>>
>>> I wonder your thought about this.
>>>
>>> Thanks.
>>>
>>>> Thanks,
>>>>
>>>>
>>>
>>> ------------------------------------------------------------------------------
>>> Check out the vibrant tech community on one of the world's most
>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
>>
> 
> .
> 
