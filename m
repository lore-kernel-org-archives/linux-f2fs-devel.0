From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [RFC PATCH 0/2] apply write hints to select the type
 of segments
Date: Thu, 16 Nov 2017 13:35:53 +0900
Message-ID: <5A0D15A9.3090706@gmail.com>
References: <5A08E657.8060807@gmail.com>
 <c3199798-cd5b-afca-845b-73817c77c902@huawei.com>
 <5A08F6CA.6040507@gmail.com>
 <5bd3945c-16f8-a718-a140-44589ceb490a@huawei.com> <5A090283.60206@gmail.com>
 <20171114042024.GA13008@jaegeuk-macbookpro.roam.corp.google.com>
 <3dd3f540-f5e5-2d58-99ef-6abf18bad923@huawei.com>
 <20171115162730.GC33528@jaegeuk-macbookpro.roam.corp.google.com>
 <5A0CE25A.9090506@gmail.com>
 <533fb91e-21af-513e-f587-619498b1f848@huawei.com>
 <20171116035858.GA73172@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hyc.lee@gmail.com>) id 1eFBuF-0007Ip-P2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 04:36:03 +0000
Received: from lgeamrelo13.lge.com ([156.147.23.53])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1eFBuD-0007hP-0F
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 04:36:03 +0000
In-Reply-To: <20171116035858.GA73172@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 11/16/2017 12:58 PM, Jaegeuk Kim wrote:
> On 11/16, Chao Yu wrote:
>> On 2017/11/16 8:56, Hyunchul Lee wrote:
>>>
>>> On 11/16/2017 01:27 AM, Jaegeuk Kim wrote:
>>>> On 11/14, Chao Yu wrote:
>>>>> On 2017/11/14 12:20, Jaegeuk Kim wrote:
>>>>>> On 11/13, Hyunchul Lee wrote:
>>>>>>> On 11/13/2017 10:59 AM, Chao Yu wrote:
>>>>>>>> On 2017/11/13 9:35, Hyunchul Lee wrote:
>>>>>>>>> On 11/13/2017 10:26 AM, Chao Yu wrote:
>>>>>>>>>> On 2017/11/13 8:24, Hyunchul Lee wrote:
>>>>>>>>>>> On 11/10/2017 03:42 PM, Chao Yu wrote:
>>>>>>>>>>>> On 2017/11/10 8:23, Hyunchul Lee wrote:
>>>>>>>>>>>>> Hello, Chao
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 11/09/2017 06:12 PM, Chao Yu wrote:
>>>>>>>>>>>>>> On 2017/11/9 13:51, Hyunchul Lee wrote:
>>>>>>>>>>>>>>> From: Hyunchul Lee <cheol.lee@lge.com>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Using write hints[1], applications can inform the life time of the data
>>>>>>>>>>>>>>> written to devices. and this[2] reported that the write hints patch
>>>>>>>>>>>>>>> decreased writes in NAND by 25%.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This hints help F2FS to determine the followings.
>>>>>>>>>>>>>>>   1) the segment types where the data will be written.
>>>>>>>>>>>>>>>   2) the hints that will be passed down to devices with the data of segments.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This patch set implements the first mapping from write hints to segment types
>>>>>>>>>>>>>>> as shown below.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>   hints                     segment type
>>>>>>>>>>>>>>>   -----                     ------------
>>>>>>>>>>>>>>>   WRITE_LIFE_SHORT          CURSEG_COLD_DATA
>>>>>>>>>>>>>>>   WRITE_LIFE_EXTREME        CURSEG_HOT_DATA
>>>>>>>>>>>>>>>   others                    CURSEG_WARM_DATA
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The F2FS poliy for hot/cold seperation has precedence over this hints, And
>>>>>>>>>>>>>>> hints are not applied in in-place update.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Could we change to disable IPU if file/inode write hint is existing?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I am afraid that this makes side effects. for example, this could cause
>>>>>>>>>>>>> out-of-place updates even when there are not enough free segments. 
>>>>>>>>>>>>> I can write the patch that handles these situations. But I wonder 
>>>>>>>>>>>>> that this is required, and I am not sure which IPU polices can be disabled.
>>>>>>>>>>>>
>>>>>>>>>>>> Oh, As I replied in another thread, I think IPU just affects filesystem
>>>>>>>>>>>> hot/cold separating, rather than this feature. So I think it will be okay
>>>>>>>>>>>> to not consider it.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Before the second mapping is implemented, write hints are not passed down
>>>>>>>>>>>>>>> to devices. Because it is better that the data of a segment have the same 
>>>>>>>>>>>>>>> hint.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [1]: c75b1d9421f80f4143e389d2d50ddfc8a28c8c35
>>>>>>>>>>>>>>> [2]: https://lwn.net/Articles/726477/
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Could you write a patch to support passing write hint to block layer for
>>>>>>>>>>>>>> buffered writes as below commit:
>>>>>>>>>>>>>> 0127251c45ae ("ext4: add support for passing in write hints for buffered writes")
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sure I will. I wrote it already ;)
>>>>>>>>>>>>
>>>>>>>>>>>> Cool, ;)
>>>>>>>>>>>>
>>>>>>>>>>>>> I think that datas from the same segment should be passed down with the same
>>>>>>>>>>>>> hint, and the following mapping is reasonable. I wonder what is your opinion
>>>>>>>>>>>>> about it.
>>>>>>>>>>>>>
>>>>>>>>>>>>>   segment type               hints
>>>>>>>>>>>>>   ------------               -----
>>>>>>>>>>>>>   CURSEG_COLD_DATA           WRITE_LIFE_EXTREME
>>>>>>>>>>>>>   CURSEG_HOT_DATA            WRITE_LIFE_SHORT
>>>>>>>>>>>>>   CURSEG_COLD_NODE           WRITE_LIFE_NORMAL
>>>>>>>>>>>>
>>>>>>>>>>>> We have WRITE_LIFE_LONG defined rather than WRITE_LIFE_NORMAL in fs.h?
>>>>>>>>>>>>
>>>>>>>>>>>>>   CURSEG_HOT_NODE            WRITE_LIFE_MEDIUM
>>>>>>>>>>>>
>>>>>>>>>>>> As I know, in scenario of cell phone, data of meta_inode is hottest, then hot
>>>>>>>>>>>> data, warm node, and cold node should be coldest. So I suggested we can define
>>>>>>>>>>>> as below:
>>>>>>>>>>>>
>>>>>>>>>>>> META_DATA			WRITE_LIFE_SHORT
>>>>>>>>>>>> HOT_DATA & WARM_NODE		WRITE_LIFE_MEDIUM
>>>>>>>>>>>> HOT_NODE & WARM_DATA		WRITE_LIFE_LONG
>>>>>>>>>>>> COLD_NODE & COLD_DATA		WRITE_LIFE_EXTREME
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I agree, But I am not sure that assigning the same hint to a node and data
>>>>>>>>>>> segment is good. Because NVMe is likely to write them in the same erase 
>>>>>>>>>>> block if they have the same hint.
>>>>>>>>>>
>>>>>>>>>> If we do not give the hint, they can still be written to the same erase block,
>>>>>>>>
>>>>>>>> I mean it's possible to write them to the same erase block. :)
>>>>>>>>
>>>>>>>>>> right? it will not be worse?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> If the hint is not given, I think that they could be written to 
>>>>>>>>> the same erase block, or not. But if we give the same hint, they are written
>>>>>>>>> to the same block.
>>>>>>>>
>>>>>>>> IMO, Only if underlying device can support more hint type or opened channels,
>>>>>>>> and actual temperature of data segment and node segment is quite different, we
>>>>>>>> can separate them.
>>>>>>>>
>>>>>>>
>>>>>>> Okay, If Jaegeuk Kim agrees with this, I will submit the patch that 
>>>>>>> implements your proposed mapping.
>>>>>>
>>>>>> How about this? We'd better to split data and node blocks as much as possible.
>>>>>>
>>>>>> segment type                    hints
>>>>>> ------------                    -----
>>>>>> COLD_NODE & COLD_DATA		WRITE_LIFE_NONE
>>>>>
>>>>> WRITE_LIFE_NONE means there is no hints about write life time.
>>>>>
>>>>> Shouldn't we define COLD_NODE & COLD_DATA as WRITE_LIFE_EXTERME?
>>>>
>>>> The assumption would be to split different types of blocks by flash firmware,
>>>> so I think we can use WRITE_LIFE_NONE as a type as well.
>>>>
>>>
>>> WRITE_LIFE_NONE means that no stream id is specified. It equals WRITE_LIFE_NOT_SET.
>>
>> Rgith, I just saw nvme implementation:
>>
>> nvme_assign_write_stream
>>
>> 	enum rw_hint streamid = req->write_hint;
>>
>> 	if (streamid == WRITE_LIFE_NOT_SET || streamid == WRITE_LIFE_NONE)
>> 		streamid = 0;
>> 	else {
>> 		streamid--;
>> ...
>>
>>> So I think that we can define WARM_DATA as WRITE_LIFE_NONE, and
>>> COLD_NODE & COLD_DATA as WRITE_LIFE_EXTREME.
> 
> What's the point?
> 
> segment type                 hints                streamid
> -------------                -----                -------
> COLD_NODE & COLD_DATA        WRITE_LIFE_NONE      0
> WARM_DATA                    WRITE_LIFE_EXTERME   4
> HOT_NODE & WARM_NODE         WRITE_LIFE_LONG      3
> HOT_DATA                     WRITE_LIFE_MEDIUM    2
> META_DATA                    WRITE_LIFE_SHORT     1
> 
> So, I don't think something is wrong. Again, I don't care about its hotness
> given to the naming, but do care how to split different types of blocks with
> different stream ids. Exceptions would be giving _SHORT or _MEDIUM which are
> likely to be latency-critical, since I guess firmware may be able to store them
> into SLC buffer.
> 
> Am I missing that _NONE has another meaning?
> 

What I am worried about is that datas with no hint have WRITE_LIFE_NOT_SET(id 0).
If block devices have swap partitions and anothor file systems, cold datas could
be mixed with datas from that. Does this seems way too much?

And I think that stream id 0 means disabling stream directives. 
Becasue NVME_RW_DTYPE_STREAMS is clear.

Thanks.

> Thanks,
> 
>>
>> I think that would be better.
>>
>> Thanks,
>>
>>>
>>> Thanks.
>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>> WARM_DATA			WRITE_LIFE_EXTERME
>>>>>> HOT_NODE & WARM_NODE		WRITE_LIFE_LONG
>>>>>> HOT_DATA			WRITE_LIFE_MEDIUM
>>>>>> META_DATA			WRITE_LIFE_SHORT
>>>>>>
>>>>>>>
>>>>>>> Thank you for comments ;)
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>> I am not sure ;)
>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Thanks.
>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>
>>>>>>>>>>>>>   others                     WRITE_LIFE_NONE
>>>>>>>>>>>>>  
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hyunchul Lee (2):
>>>>>>>>>>>>>>>   f2fs: apply write hints to select the type of segments for buffered
>>>>>>>>>>>>>>>     write
>>>>>>>>>>>>>>>   f2fs: apply write hints to select the type of segment for direct write
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>  fs/f2fs/data.c    | 101 ++++++++++++++++++++++++++++++++----------------------
>>>>>>>>>>>>>>>  fs/f2fs/f2fs.h    |   1 +
>>>>>>>>>>>>>>>  fs/f2fs/segment.c |  14 +++++++-
>>>>>>>>>>>>>>>  3 files changed, 74 insertions(+), 42 deletions(-)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks
>>>>>>>>>>>>>
>>>>>>>>>>>>> .
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> .
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> .
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>> .
>>>>>>
>>>>
>>>
>>> .
>>>
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
