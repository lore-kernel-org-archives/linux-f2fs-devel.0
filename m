From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH 1/2] f2fs: pass down write hints to block
 layer for bufferd write
Date: Tue, 12 Dec 2017 11:15:33 +0900
Message-ID: <5A2F3BC5.90803@gmail.com>
References: <1511828607-624-1-git-send-email-hyc.lee@gmail.com>
 <d71418e1-d667-3dc6-9265-61db5d8f40bc@huawei.com>
 <5A2112A7.2070208@gmail.com>
 <1fa09755-7322-a886-c582-02e3d93d8f87@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hyc.lee@gmail.com>) id 1eOa6h-0007vb-Cc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Dec 2017 02:15:43 +0000
Received: from lgeamrelo11.lge.com ([156.147.23.51])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1eOa6f-0007dC-83
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Dec 2017 02:15:43 +0000
In-Reply-To: <1fa09755-7322-a886-c582-02e3d93d8f87@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, kernel-team@lge.com, linux-fsdevel@vger.kernel.org, Hyunchul Lee <cheol.lee@lge.com>

Hi Chao,

On 12/11/2017 10:15 PM, Chao Yu wrote:
> Hi Hyunchul,
> 
> On 2017/12/1 16:28, Hyunchul Lee wrote:
>> Hi Chao,
>>
>> On 11/30/2017 04:06 PM, Chao Yu wrote:
>>> Hi Hyunchul,
>>>
>>> On 2017/11/28 8:23, Hyunchul Lee wrote:
>>>> From: Hyunchul Lee <cheol.lee@lge.com>
>>>>
>>>> This implements which hint is passed down to block layer
>>>> for datas from the specific segment type.
>>>>
>>>> segment type                     hints
>>>> ------------                     -----
>>>> COLD_NODE & COLD_DATA            WRITE_LIFE_EXTREME
>>>> WARM_DATA                        WRITE_LIFE_NONE
>>>> HOT_NODE & WARM_NODE             WRITE_LIFE_LONG
>>>> HOT_DATA                         WRITE_LIFE_MEDIUM
>>>> META_DATA                        WRITE_LIFE_SHORT
>>>
>>> Just noticed, if our user do not give the hint via ioctl, f2fs can
>>> provider hint to lower layer according to hot/cold separation ability,
>>> it will be okay. But once user give his hint which may be more accurate
>>> than filesystem, hint converted by f2fs may be wrong.
>>>
>>> So what do you think of adding an option to control whether filesystem
>>> can convert hint user given?
>>>
>>
>> I think it is okay for LIFE_SHORT and LIFE_EXTREME. because they are 
>> converted to different hints.
> 
> What I mean is introducing a mount option, e.g. fs_iohint,
> a) w/o fs_iohint, propagate file/inode io_hint to low layer.
> b) w/ fs_iohint, ignore file/inode io_hint, use io_hint which is generated
> with filesystem's private rule.
> 

Okay, I will implement this option and send this patch again.

Without fs_iohint, Even if data blocks are moved due to GC, 
we should keep user hints. And if user hints are not given, 
any hints are not passed down to block layer, right?

Thank you for comments.

> Thanks,
> 
>>
>> file hint      segment type        io hint
>> ---------      ------------        -------
>> LIFE_SHORT     HOT_DATA            LIFE_MEDIUM
>> LIFE_MEDIUM    WARM_DATA           LIFE_NONE
>> LIFE_LONG      WARM_DATA           LIFE_NONE
>> LIFE_EXTREME   COLD_DATA           LIFE_EXTREME
>>
>> the problem is that LIFE_MEDIUM and LIFE_LONG are converted to 
>> the same hint, LIFE_NONE. I am not sure that the seperation between 
>> LIFE_MEDIUM and LIFE_LONG is really needed. Because I guess that the 
>> difference between them is a little ambigous for users, and if WARM_DATA 
>> segment has two different hints, it can makes GC non-efficient.
>>
>> I wonder your thought about this.
>>
>> Thanks.
>>
>>> Thanks,
>>>
>>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
