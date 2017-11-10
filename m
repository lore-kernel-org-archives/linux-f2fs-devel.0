From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [RFC PATCH 0/2] apply write hints to select the type of segments
Date: Fri, 10 Nov 2017 09:23:32 +0900
Message-ID: <5A04F184.3000204@gmail.com>
References: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com> <1b0b44de-c724-5dc4-e9cb-79a894bdb611@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1b0b44de-c724-5dc4-e9cb-79a894bdb611@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello, Chao

On 11/09/2017 06:12 PM, Chao Yu wrote:
> On 2017/11/9 13:51, Hyunchul Lee wrote:
>> From: Hyunchul Lee <cheol.lee@lge.com>
>>
>> Using write hints[1], applications can inform the life time of the data
>> written to devices. and this[2] reported that the write hints patch
>> decreased writes in NAND by 25%.
>>
>> This hints help F2FS to determine the followings.
>>   1) the segment types where the data will be written.
>>   2) the hints that will be passed down to devices with the data of segments.
>>
>> This patch set implements the first mapping from write hints to segment types
>> as shown below.
>>
>>   hints                     segment type
>>   -----                     ------------
>>   WRITE_LIFE_SHORT          CURSEG_COLD_DATA
>>   WRITE_LIFE_EXTREME        CURSEG_HOT_DATA
>>   others                    CURSEG_WARM_DATA
>>
>> The F2FS poliy for hot/cold seperation has precedence over this hints, And
>> hints are not applied in in-place update.
> 
> Could we change to disable IPU if file/inode write hint is existing?
> 

I am afraid that this makes side effects. for example, this could cause
out-of-place updates even when there are not enough free segments. 
I can write the patch that handles these situations. But I wonder 
that this is required, and I am not sure which IPU polices can be disabled.

>>
>> Before the second mapping is implemented, write hints are not passed down
>> to devices. Because it is better that the data of a segment have the same 
>> hint.
>>
>> [1]: c75b1d9421f80f4143e389d2d50ddfc8a28c8c35
>> [2]: https://lwn.net/Articles/726477/
> 
> Could you write a patch to support passing write hint to block layer for
> buffered writes as below commit:
> 0127251c45ae ("ext4: add support for passing in write hints for buffered writes")
> 

Sure I will. I wrote it already ;)
I think that datas from the same segment should be passed down with the same
hint, and the following mapping is reasonable. I wonder what is your opinion
about it.

  segment type               hints
  ------------               -----
  CURSEG_COLD_DATA           WRITE_LIFE_EXTREME
  CURSEG_HOT_DATA            WRITE_LIFE_SHORT
  CURSEG_COLD_NODE           WRITE_LIFE_NORMAL
  CURSEG_HOT_NODE            WRITE_LIFE_MEDIUM
  others                     WRITE_LIFE_NONE
 
> Thanks,
> 
>>
>> Hyunchul Lee (2):
>>   f2fs: apply write hints to select the type of segments for buffered
>>     write
>>   f2fs: apply write hints to select the type of segment for direct write
>>
>>  fs/f2fs/data.c    | 101 ++++++++++++++++++++++++++++++++----------------------
>>  fs/f2fs/f2fs.h    |   1 +
>>  fs/f2fs/segment.c |  14 +++++++-
>>  3 files changed, 74 insertions(+), 42 deletions(-)
>>
> 
> 

Thanks
