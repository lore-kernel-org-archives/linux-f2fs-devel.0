From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix data corruption issue with hardware
 encryption
Date: Mon, 15 Oct 2018 20:26:20 +0800
Message-ID: <405c1a13-5c1e-2f5a-3924-54f8c55afdfe@huawei.com>
References: <1539149182-12729-1-git-send-email-stummala@codeaurora.org>
 <20181010213402.GA52406@jaegeuk-macbookpro.roam.corp.google.com>
 <20181011002935.GA24669@codeaurora.org>
 <20181011021506.GA78526@jaegeuk-macbookpro.roam.corp.google.com>
 <20181011030544.GA82403@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011030544.GA82403@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Sahitya Tummala <stummala@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/10/11 11:05, Jaegeuk Kim wrote:
> On 10/10, Jaegeuk Kim wrote:
>> On 10/11, Sahitya Tummala wrote:
>>> On Wed, Oct 10, 2018 at 02:34:02PM -0700, Jaegeuk Kim wrote:
>>>> On 10/10, Sahitya Tummala wrote:
>>>>> Direct IO can be used in case of hardware encryption. The following
>>>>> scenario results into data corruption issue in this path -
>>>>>
>>>>> Thread A -                          Thread B-
>>>>> -> write file#1 in direct IO
>>>>>                                     -> GC gets kicked in
>>>>>                                     -> GC submitted bio on meta mapping
>>>>> 				       for file#1, but pending completion
>>>>> -> write file#1 again with new data
>>>>>    in direct IO
>>>>>                                     -> GC bio gets completed now
>>>>>                                     -> GC writes old data to the new
>>>>>                                        location and thus file#1 is
>>>>> 				       corrupted.
>>>>>
>>>>> Fix this by submitting and waiting for pending io on meta mapping
>>>>> for direct IO case in f2fs_map_blocks().
>>>>>
>>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>>> ---
>>>>>  fs/f2fs/data.c | 12 ++++++++++++
>>>>>  1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 9ef6f1f..7b2fef0 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -1028,6 +1028,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>>>  		map->m_pblk = ei.blk + pgofs - ei.fofs;
>>>>>  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
>>>>>  		map->m_flags = F2FS_MAP_MAPPED;
>>>>> +		/* for HW encryption, but to avoid potential issue in future */
>>>>> +		if (flag == F2FS_GET_BLOCK_DIO) {
>>>>> +			blkaddr = map->m_pblk;
>>>>> +			for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
>>>>> +				f2fs_wait_on_block_writeback(sbi, blkaddr);
>>>>
>>>> Do we need this? IIRC, DIO would give create=1.
>>>
>>> Yes, we need it. When we are overwriting an existing file, DIO calls
>>> f2fs_map_blocks() with create=0. From the DIO code, I see that this happens
>>> because blockdev_direct_IO() passes this dio flag DIO_SKIP_HOLES. And then
>>> in get_more_blocks(), below code updates create=0, when we are overwriting
>>> an existing file.
>>>
>>>                 create = dio->op == REQ_OP_WRITE;
>>>                 if (dio->flags & DIO_SKIP_HOLES) {
>>>                         if (fs_startblk <= ((i_size_read(dio->inode) - 1) >>
>>>                                                         i_blkbits))
>>>                                 create = 0;
>>>                 }
>>>
>>>                 ret = (*sdio->get_block)(dio->inode, fs_startblk,
>>>                                                 map_bh, create);
>>>
>>
>> Got it.
>> How about this?
>>
> 
> Sorry, this is v2.
> 
>>From b78dd7b2e0317be18716b9496269e9792829f63e Mon Sep 17 00:00:00 2001
> From: Sahitya Tummala <stummala@codeaurora.org>
> Date: Wed, 10 Oct 2018 10:56:22 +0530
> Subject: [PATCH] f2fs: fix data corruption issue with hardware encryption
> 
> Direct IO can be used in case of hardware encryption. The following
> scenario results into data corruption issue in this path -
> 
> Thread A -                          Thread B-
> -> write file#1 in direct IO
>                                     -> GC gets kicked in
>                                     -> GC submitted bio on meta mapping
> 				       for file#1, but pending completion
> -> write file#1 again with new data
>    in direct IO
>                                     -> GC bio gets completed now
>                                     -> GC writes old data to the new
>                                        location and thus file#1 is
> 				       corrupted.
> 
> Fix this by submitting and waiting for pending io on meta mapping
> for direct IO case in f2fs_map_blocks().
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Nice catch!

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
