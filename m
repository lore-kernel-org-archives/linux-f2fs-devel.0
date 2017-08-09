From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/1] f2fs: merge equivalent flags
 F2FS_GET_BLOCK_[READ|DIO]
Date: Wed, 9 Aug 2017 09:13:19 +0800
Message-ID: <75d6efdd-a4a6-2c00-150f-458a00b3892f@huawei.com>
References: <1502188039-25453-1-git-send-email-sunqiuyang@huawei.com>
 <c2528da6-36c8-0f58-e18e-4ba97c1f5ebf@huawei.com>
 <8ce0003f-780a-a349-e30e-218fdf61488d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8ce0003f-780a-a349-e30e-218fdf61488d@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sun Qiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/8 19:41, Sun Qiuyang wrote:
> 
> 
>> On 2017/8/8 18:27, sunqiuyang wrote:
>>> From: Qiuyang Sun <sunqiuyang@huawei.com>
>>>
>>> Currently, the two flags F2FS_GET_BLOCK_[READ|DIO] are totally equivalent
>>> and can be used interchangably in all scenarios they are involved in. This
>>> patch deletes F2FS_GET_BLOCK_READ and uses F2FS_GET_BLOCK_DIO instead.
>>
>> Seems weird from readability point of view, so how about keeping
>> F2FS_GET_BLOCK_READ alive but sharing defined value with F2FS_GET_BLOCK_DIO?
>>
>> enum {
>> 	F2FS_GET_BLOCK_DIO,
>> 	F2FS_GET_BLOCK_READ = F2FS_GET_BLOCK_DIO,
>> 	F2FS_GET_BLOCK_FIEMAP,
>> 	...
>> }
>>
>> Thanks,
> How about renaming both of them F2FS_GET_BLOCK_DEFAULT? Actually neither 
> READ nor DIO is explicitly referenced in f2fs_map_blocks(); it is just 
> the "default" case. We have no reason to limit the use of this flag to 
> "read" or "direct IO" only.

Better. :)

Thanks,

> 
> Thanks,
>>
>>>
>>> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
>>> ---
>>>  fs/f2fs/data.c | 2 +-
>>>  fs/f2fs/f2fs.h | 1 -
>>>  fs/f2fs/file.c | 4 ++--
>>>  3 files changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index c43262d..e0a59bf 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1244,7 +1244,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>>>  			map.m_len = last_block - block_in_file;
>>>
>>>  			if (f2fs_map_blocks(inode, &map, 0,
>>> -						F2FS_GET_BLOCK_READ))
>>> +						F2FS_GET_BLOCK_DIO))
>>>  				goto set_error_page;
>>>  		}
>>>  got_it:
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index cea329f..0593ca7 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -514,7 +514,6 @@ struct f2fs_map_blocks {
>>>  };
>>>
>>>  /* for flag in get_data_block */
>>> -#define F2FS_GET_BLOCK_READ		0
>>>  #define F2FS_GET_BLOCK_DIO		1
>>>  #define F2FS_GET_BLOCK_FIEMAP		2
>>>  #define F2FS_GET_BLOCK_BMAP		3
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index e2b33b8..8271cb5 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -2074,7 +2074,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>>>  	 */
>>>  	while (map.m_lblk < pg_end) {
>>>  		map.m_len = pg_end - map.m_lblk;
>>> -		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
>>> +		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DIO);
>>>  		if (err)
>>>  			goto out;
>>>
>>> @@ -2116,7 +2116,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>>>
>>>  do_map:
>>>  		map.m_len = pg_end - map.m_lblk;
>>> -		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
>>> +		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DIO);
>>>  		if (err)
>>>  			goto clear_out;
>>>
>>>
>>
>>
>> .
>>
> 
> 
> .
> 
