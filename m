From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH 1/2] f2fs: pass down write hints to block
 layer for bufferd write
Date: Thu, 28 Dec 2017 14:05:45 +0900
Message-ID: <5A447BA9.4010008@gmail.com>
References: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
 <d71418e1-d667-3dc6-9265-61db5d8f40bc@huawei.com>
 <5A2112A7.2070208@gmail.com>
 <1fa09755-7322-a886-c582-02e3d93d8f87@kernel.org> <5A2F3BC5.90803@gmail.com>
 <85f7fc1b-5286-c66f-6833-af1a44c5130f@huawei.com> <5A31D507.70304@gmail.com>
 <20171215020612.GF35234@jaegeuk-macbookpro.roam.corp.google.com>
 <50574d6d-b1fa-291a-0aae-c9006d6671d4@huawei.com>
 <20171228032630.GE13490@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hyc.lee@gmail.com>) id 1eUQOB-0001Lv-U1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Dec 2017 05:05:55 +0000
Received: from lgeamrelo11.lge.com ([156.147.23.51])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1eUQO9-0000y0-9X
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Dec 2017 05:05:55 +0000
In-Reply-To: <20171228032630.GE13490@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, kernel-team@lge.com, linux-fsdevel@vger.kernel.org, Hyunchul Lee <cheol.lee@lge.com>

Hi Jaegeuk,

On 12/28/2017 12:26 PM, Jaegeuk Kim wrote:
> On 12/23, Chao Yu wrote:
>> On 2017/12/15 10:06, Jaegeuk Kim wrote:
>>> On 12/14, Hyunchul Lee wrote:
>>>> Hi Jaegeuk,
>>>>
>>>> I need your comment about the fs_iohint mount option.
>>>>
>>>> a) w/o fs_iohint, propagate user hints to low layer.
>>>> b) w/ fs_iohint, ignore user hints, and use hints which is generated
>>>> with F2FS.
>>>>
>>>> Chao suggests this option. because user hints are more accurate than
>>>> file system.
>>>>
>>>> This is resonable, But I have some concerns about this option. 
>>>> The first thing is that blocks of a segments have different hints. This
>>>> could make GC less effective. 
>>>> The second is that the separation between LIFE_MEDIUM and LIFE_LONG is 
>>>> really needed. I think that difference between them is a little ambigous 
>>>> for users, and LIFE_SHORT and LIFE_EXTREME is converted to different 
>>>> hints by F2FS.
>>>
>>> I think what we really can do would assign many user hints to our 3 DATA
>>> logs likewise rw_hint_to_seg_type(), since it's just hints for user data.
>>> Then, we can decide how to keep that as much as possible, since we have
>>> another filesystem metadata such as meta and nodes. In addition, I don't
>>> think we have to keep the original user-hints which makes F2FS logs be
>>> messed up.
>>>
>>> With that mind, I can think of the below cases. Especially, if user wants
>>> to keep their io_hints, we'd better recommend to use direct_io w/o fs_iohints.
>>
>>
>>
>>> In order to keep this policy, I think fs_iohints would be better to be a
>>> feature set by mkfs.f2fs and detected by sysfs entries for users.
>>>
>>> 1) w/ fs_iohints
>>>
>>> User                        F2FS               Block
>>> -------------------------------------------------------------------
>>>                             Meta               WRITE_LIFE_MEDIUM
>>>                             HOT_NODE           WRITE_LIFE_NOTSET
>>>                             WARM_NODE          -'
>>>                             COLD_NODE          WRITE_LIFE_NONE
>>> ioctl(cold)                 COLD_DATA          WRITE_LIFE_EXTREME
>>> extention list              -'                 -'
>>> WRITE_LIFE_EXTREME          -'                 -'
>>> WRITE_LIFE_SHORT            HOT_DATA           WRITE_LIFE_SHORT
>>>
>>> -- buffered_io
>>> WRITE_LIFE_NOT_SET          WARM_DATA          WRITE_LIFE_LONG
>>> WRITE_LIFE_NONE             -'                 -'
>>> WRITE_LIFE_MEDIUM           -'                 -'
>>> WRITE_LIFE_LONG             -'                 -'
>>>
>>> -- direct_io (Not recommendable)
>>> WRITE_LIFE_NOT_SET          WARM_DATA          WRITE_LIFE_NOT_SET
>>> WRITE_LIFE_NONE             -'                 WRITE_LIFE_NONE
>>> WRITE_LIFE_MEDIUM           -'                 WRITE_LIFE_MEDIUM
>>> WRITE_LIFE_LONG             -'                 WRITE_LIFE_LONG
>>
>> Agreed with above IO hint mapping rule.
>>
>>>
>>> 2) w/o fs_iohints
>>>
>>> User                        F2FS               Block
>>> -------------------------------------------------------------------
>>>                             Meta               -
>>>                             HOT_NODE           -
>>>                             WARM_NODE          -
>>>                             COLD_NODE          -
>>> ioctl(cold)                 COLD_DATA          -
>>> extention list              -'                 -
>>>
>>> -- buffered_io
>>> WRITE_LIFE_EXTREME          COLD_DATA          -
>>> WRITE_LIFE_SHORT            HOT_DATA           -
>>> WRITE_LIFE_NOT_SET          WARM_DATA          -
>>> WRITE_LIFE_NONE             -'                 -
>>> WRITE_LIFE_MEDIUM           -'                 -
>>> WRITE_LIFE_LONG             -'                 -
>>
>> Now we recommend direct_io if user wants to give IO hint for storage, I suspect
>> that user would suffer performance regression issue w/o buffered IO.
>>
>> Another problem is that, now, in Android, it will be very hard to prompt
>> application to migrate their IO pattern from buffered IO to direct IO, one
>> possible way is distinguishing user data lifetime from FWK, e.g. set
>> WRITE_LIFE_SHORT for cache file or tmp file, set WRITE_LIFE_EXTREME for media file.
>>
>> In order to support buffered_io, would it be better to change mapping as below?
>>
>> -- buffered_io
>> WRITE_LIFE_EXTREME          COLD_DATA          WRITE_LIFE_EXTREME
>> WRITE_LIFE_SHORT            HOT_DATA           WRITE_LIFE_SHORT
>> WRITE_LIFE_NOT_SET          WARM_DATA          WRITE_LIFE_NOT_SET
>> WRITE_LIFE_NONE             -'                 -'
>> WRITE_LIFE_MEDIUM           -'                 -'
>> WRITE_LIFE_LONG             -'                 -'
> 
> Agreed, and it makes more sense that we'd better keep the write hints on
> userdata given by applications.
> 
> BTW, since we couldn't get any performance numbers with these, how about
> adding a mount option like "-o iohints=MODE" where MODE may be one of
> "fs-based", "user-based", and "off"?
> 

"fs-based" equals "with fs_iohints", "user-based" equals "without fs_iohints"
+ Chao's suggest, and "off" means not passing down hints to block layer. right?

Thanks.

> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> -- direct_io
>>> WRITE_LIFE_EXTREME          COLD_DATA          WRITE_LIFE_EXTREME
>>> WRITE_LIFE_SHORT            HOT_DATA           WRITE_LIFE_SHORT
>>> WRITE_LIFE_NOT_SET          WARM_DATA          WRITE_LIFE_NOT_SET
>>> WRITE_LIFE_NONE             -'                 WRITE_LIFE_NONE
>>> WRITE_LIFE_MEDIUM           -'                 WRITE_LIFE_MEDIUM
>>> WRITE_LIFE_LONG             -'                 WRITE_LIFE_LONG
>>>
>>>
>>> Note that, I don't much care about how to manipulate streamid in nvme driver
>>> in terms of LIFE_NONE or LIFE_NOTSET, since other drivers can handle them
>>> in different ways. Taking a look at the definition, at least, we don't need
>>> to assume that those are same at all. For example, if we can expolit this in
>>> UFS driver, we can pass all the stream ids to the device as context ids.
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks.
>>>>
>>>> On 12/12/2017 11:45 AM, Chao Yu wrote:
>>>>> Hi Hyunchul,
>>>>>
>>>>> On 2017/12/12 10:15, Hyunchul Lee wrote:
>>>>>> Hi Chao,
>>>>>>
>>>>>> On 12/11/2017 10:15 PM, Chao Yu wrote:
>>>>>>> Hi Hyunchul,
>>>>>>>
>>>>>>> On 2017/12/1 16:28, Hyunchul Lee wrote:
>>>>>>>> Hi Chao,
>>>>>>>>
>>>>>>>> On 11/30/2017 04:06 PM, Chao Yu wrote:
>>>>>>>>> Hi Hyunchul,
>>>>>>>>>
>>>>>>>>> On 2017/11/28 8:23, Hyunchul Lee wrote:
>>>>>>>>>> From: Hyunchul Lee <cheol.lee@lge.com>
>>>>>>>>>>
>>>>>>>>>> This implements which hint is passed down to block layer
>>>>>>>>>> for datas from the specific segment type.
>>>>>>>>>>
>>>>>>>>>> segment type                     hints
>>>>>>>>>> ------------                     -----
>>>>>>>>>> COLD_NODE & COLD_DATA            WRITE_LIFE_EXTREME
>>>>>>>>>> WARM_DATA                        WRITE_LIFE_NONE
>>>>>>>>>> HOT_NODE & WARM_NODE             WRITE_LIFE_LONG
>>>>>>>>>> HOT_DATA                         WRITE_LIFE_MEDIUM
>>>>>>>>>> META_DATA                        WRITE_LIFE_SHORT
>>>>>>>>>
>>>>>>>>> Just noticed, if our user do not give the hint via ioctl, f2fs can
>>>>>>>>> provider hint to lower layer according to hot/cold separation ability,
>>>>>>>>> it will be okay. But once user give his hint which may be more accurate
>>>>>>>>> than filesystem, hint converted by f2fs may be wrong.
>>>>>>>>>
>>>>>>>>> So what do you think of adding an option to control whether filesystem
>>>>>>>>> can convert hint user given?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think it is okay for LIFE_SHORT and LIFE_EXTREME. because they are 
>>>>>>>> converted to different hints.
>>>>>>>
>>>>>>> What I mean is introducing a mount option, e.g. fs_iohint,
>>>>>>> a) w/o fs_iohint, propagate file/inode io_hint to low layer.
>>>>>>> b) w/ fs_iohint, ignore file/inode io_hint, use io_hint which is generated
>>>>>>> with filesystem's private rule.
>>>>>>>
>>>>>>
>>>>>> Okay, I will implement this option and send this patch again.
>>>>>
>>>>> Let's wait for Jaegeuk's comments first?
>>>>>
>>>>>>
>>>>>> Without fs_iohint, Even if data blocks are moved due to GC, 
>>>>>> we should keep user hints. And if user hints are not given, 
>>>>>> any hints are not passed down to block layer, right?
>>>>>
>>>>> Hmm.. that will be a problem, IMO, we can store last user's io_hint into inode
>>>>> layout, so later when we trigger GC, we can use the last io_hint in inode rather
>>>>> than giving no hint or fs' hint.
>>>>>
>>>>> I think it needs to discuss with original author of IO hint, what is the IO hint
>>>>> policy when filesystem move block by itself after inode has been released in system.
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>> Thank you for comments.
>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>> file hint      segment type        io hint
>>>>>>>> ---------      ------------        -------
>>>>>>>> LIFE_SHORT     HOT_DATA            LIFE_MEDIUM
>>>>>>>> LIFE_MEDIUM    WARM_DATA           LIFE_NONE
>>>>>>>> LIFE_LONG      WARM_DATA           LIFE_NONE
>>>>>>>> LIFE_EXTREME   COLD_DATA           LIFE_EXTREME
>>>>>>>>
>>>>>>>> the problem is that LIFE_MEDIUM and LIFE_LONG are converted to 
>>>>>>>> the same hint, LIFE_NONE. I am not sure that the seperation between 
>>>>>>>> LIFE_MEDIUM and LIFE_LONG is really needed. Because I guess that the 
>>>>>>>> difference between them is a little ambigous for users, and if WARM_DATA 
>>>>>>>> segment has two different hints, it can makes GC non-efficient.
>>>>>>>>
>>>>>>>> I wonder your thought about this.
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> ------------------------------------------------------------------------------
>>>>>>>> Check out the vibrant tech community on one of the world's most
>>>>>>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>>>>>>> _______________________________________________
>>>>>>>> Linux-f2fs-devel mailing list
>>>>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> .
>>>>>>
>>>>>
>>>>>
>>>>> ------------------------------------------------------------------------------
>>>>> Check out the vibrant tech community on one of the world's most
>>>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>
>>>
>>> .
>>>
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
