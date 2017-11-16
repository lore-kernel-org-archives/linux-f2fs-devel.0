From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [RFC PATCH 0/2] apply write hints to select the type
 of segments
Date: Thu, 16 Nov 2017 09:56:58 +0900
Message-ID: <5A0CE25A.9090506@gmail.com>
References: <1b0b44de-c724-5dc4-e9cb-79a894bdb611@huawei.com>
 <5A04F184.3000204@gmail.com>
 <edf62076-a125-11e2-b2e6-fd32d5e6118f@huawei.com>
 <5A08E657.8060807@gmail.com>
 <c3199798-cd5b-afca-845b-73817c77c902@huawei.com>
 <5A08F6CA.6040507@gmail.com>
 <5bd3945c-16f8-a718-a140-44589ceb490a@huawei.com> <5A090283.60206@gmail.com>
 <20171114042024.GA13008@jaegeuk-macbookpro.roam.corp.google.com>
 <3dd3f540-f5e5-2d58-99ef-6abf18bad923@huawei.com>
 <20171115162730.GC33528@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hyc.lee@gmail.com>) id 1eF8UP-00035n-0s
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 00:57:09 +0000
Received: from lgeamrelo12.lge.com ([156.147.23.52])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1eF8UM-00053q-Bb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 00:57:08 +0000
In-Reply-To: <20171115162730.GC33528@jaegeuk-macbookpro.roam.corp.google.com>
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


On 11/16/2017 01:27 AM, Jaegeuk Kim wrote:
> On 11/14, Chao Yu wrote:
>> On 2017/11/14 12:20, Jaegeuk Kim wrote:
>>> On 11/13, Hyunchul Lee wrote:
>>>> On 11/13/2017 10:59 AM, Chao Yu wrote:
>>>>> On 2017/11/13 9:35, Hyunchul Lee wrote:
>>>>>> On 11/13/2017 10:26 AM, Chao Yu wrote:
>>>>>>> On 2017/11/13 8:24, Hyunchul Lee wrote:
>>>>>>>> On 11/10/2017 03:42 PM, Chao Yu wrote:
>>>>>>>>> On 2017/11/10 8:23, Hyunchul Lee wrote:
>>>>>>>>>> Hello, Chao
>>>>>>>>>>
>>>>>>>>>> On 11/09/2017 06:12 PM, Chao Yu wrote:
>>>>>>>>>>> On 2017/11/9 13:51, Hyunchul Lee wrote:
>>>>>>>>>>>> From: Hyunchul Lee <cheol.lee@lge.com>
>>>>>>>>>>>>
>>>>>>>>>>>> Using write hints[1], applications can inform the life time of the data
>>>>>>>>>>>> written to devices. and this[2] reported that the write hints patch
>>>>>>>>>>>> decreased writes in NAND by 25%.
>>>>>>>>>>>>
>>>>>>>>>>>> This hints help F2FS to determine the followings.
>>>>>>>>>>>>   1) the segment types where the data will be written.
>>>>>>>>>>>>   2) the hints that will be passed down to devices with the data of segments.
>>>>>>>>>>>>
>>>>>>>>>>>> This patch set implements the first mapping from write hints to segment types
>>>>>>>>>>>> as shown below.
>>>>>>>>>>>>
>>>>>>>>>>>>   hints                     segment type
>>>>>>>>>>>>   -----                     ------------
>>>>>>>>>>>>   WRITE_LIFE_SHORT          CURSEG_COLD_DATA
>>>>>>>>>>>>   WRITE_LIFE_EXTREME        CURSEG_HOT_DATA
>>>>>>>>>>>>   others                    CURSEG_WARM_DATA
>>>>>>>>>>>>
>>>>>>>>>>>> The F2FS poliy for hot/cold seperation has precedence over this hints, And
>>>>>>>>>>>> hints are not applied in in-place update.
>>>>>>>>>>>
>>>>>>>>>>> Could we change to disable IPU if file/inode write hint is existing?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I am afraid that this makes side effects. for example, this could cause
>>>>>>>>>> out-of-place updates even when there are not enough free segments. 
>>>>>>>>>> I can write the patch that handles these situations. But I wonder 
>>>>>>>>>> that this is required, and I am not sure which IPU polices can be disabled.
>>>>>>>>>
>>>>>>>>> Oh, As I replied in another thread, I think IPU just affects filesystem
>>>>>>>>> hot/cold separating, rather than this feature. So I think it will be okay
>>>>>>>>> to not consider it.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Before the second mapping is implemented, write hints are not passed down
>>>>>>>>>>>> to devices. Because it is better that the data of a segment have the same 
>>>>>>>>>>>> hint.
>>>>>>>>>>>>
>>>>>>>>>>>> [1]: c75b1d9421f80f4143e389d2d50ddfc8a28c8c35
>>>>>>>>>>>> [2]: https://lwn.net/Articles/726477/
>>>>>>>>>>>
>>>>>>>>>>> Could you write a patch to support passing write hint to block layer for
>>>>>>>>>>> buffered writes as below commit:
>>>>>>>>>>> 0127251c45ae ("ext4: add support for passing in write hints for buffered writes")
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Sure I will. I wrote it already ;)
>>>>>>>>>
>>>>>>>>> Cool, ;)
>>>>>>>>>
>>>>>>>>>> I think that datas from the same segment should be passed down with the same
>>>>>>>>>> hint, and the following mapping is reasonable. I wonder what is your opinion
>>>>>>>>>> about it.
>>>>>>>>>>
>>>>>>>>>>   segment type               hints
>>>>>>>>>>   ------------               -----
>>>>>>>>>>   CURSEG_COLD_DATA           WRITE_LIFE_EXTREME
>>>>>>>>>>   CURSEG_HOT_DATA            WRITE_LIFE_SHORT
>>>>>>>>>>   CURSEG_COLD_NODE           WRITE_LIFE_NORMAL
>>>>>>>>>
>>>>>>>>> We have WRITE_LIFE_LONG defined rather than WRITE_LIFE_NORMAL in fs.h?
>>>>>>>>>
>>>>>>>>>>   CURSEG_HOT_NODE            WRITE_LIFE_MEDIUM
>>>>>>>>>
>>>>>>>>> As I know, in scenario of cell phone, data of meta_inode is hottest, then hot
>>>>>>>>> data, warm node, and cold node should be coldest. So I suggested we can define
>>>>>>>>> as below:
>>>>>>>>>
>>>>>>>>> META_DATA			WRITE_LIFE_SHORT
>>>>>>>>> HOT_DATA & WARM_NODE		WRITE_LIFE_MEDIUM
>>>>>>>>> HOT_NODE & WARM_DATA		WRITE_LIFE_LONG
>>>>>>>>> COLD_NODE & COLD_DATA		WRITE_LIFE_EXTREME
>>>>>>>>>
>>>>>>>>
>>>>>>>> I agree, But I am not sure that assigning the same hint to a node and data
>>>>>>>> segment is good. Because NVMe is likely to write them in the same erase 
>>>>>>>> block if they have the same hint.
>>>>>>>
>>>>>>> If we do not give the hint, they can still be written to the same erase block,
>>>>>
>>>>> I mean it's possible to write them to the same erase block. :)
>>>>>
>>>>>>> right? it will not be worse?
>>>>>>>
>>>>>>
>>>>>> If the hint is not given, I think that they could be written to 
>>>>>> the same erase block, or not. But if we give the same hint, they are written
>>>>>> to the same block.
>>>>>
>>>>> IMO, Only if underlying device can support more hint type or opened channels,
>>>>> and actual temperature of data segment and node segment is quite different, we
>>>>> can separate them.
>>>>>
>>>>
>>>> Okay, If Jaegeuk Kim agrees with this, I will submit the patch that 
>>>> implements your proposed mapping.
>>>
>>> How about this? We'd better to split data and node blocks as much as possible.
>>>
>>> segment type                    hints
>>> ------------                    -----
>>> COLD_NODE & COLD_DATA		WRITE_LIFE_NONE
>>
>> WRITE_LIFE_NONE means there is no hints about write life time.
>>
>> Shouldn't we define COLD_NODE & COLD_DATA as WRITE_LIFE_EXTERME?
> 
> The assumption would be to split different types of blocks by flash firmware,
> so I think we can use WRITE_LIFE_NONE as a type as well.
> 

WRITE_LIFE_NONE means that no stream id is specified. It equals WRITE_LIFE_NOT_SET.
So I think that we can define WARM_DATA as WRITE_LIFE_NONE, and
COLD_NODE & COLD_DATA as WRITE_LIFE_EXTREME.

Thanks.

> Thanks,
> 
>>
>> Thanks,
>>
>>> WARM_DATA			WRITE_LIFE_EXTERME
>>> HOT_NODE & WARM_NODE		WRITE_LIFE_LONG
>>> HOT_DATA			WRITE_LIFE_MEDIUM
>>> META_DATA			WRITE_LIFE_SHORT
>>>
>>>>
>>>> Thank you for comments ;)
>>>>
>>>>> Thanks,
>>>>>
>>>>>> I am not sure ;)
>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>>>   others                     WRITE_LIFE_NONE
>>>>>>>>>>  
>>>>>>>>>>> Thanks,
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Hyunchul Lee (2):
>>>>>>>>>>>>   f2fs: apply write hints to select the type of segments for buffered
>>>>>>>>>>>>     write
>>>>>>>>>>>>   f2fs: apply write hints to select the type of segment for direct write
>>>>>>>>>>>>
>>>>>>>>>>>>  fs/f2fs/data.c    | 101 ++++++++++++++++++++++++++++++++----------------------
>>>>>>>>>>>>  fs/f2fs/f2fs.h    |   1 +
>>>>>>>>>>>>  fs/f2fs/segment.c |  14 +++++++-
>>>>>>>>>>>>  3 files changed, 74 insertions(+), 42 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks
>>>>>>>>>>
>>>>>>>>>> .
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> .
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> .
>>>>>>
>>>>>
>>>>>
>>>
>>> .
>>>
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
