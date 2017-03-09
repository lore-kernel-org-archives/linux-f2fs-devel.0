From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: don't overwrite node block by SSR
Date: Thu, 9 Mar 2017 20:07:48 +0800
Message-ID: <9a3cfd97-150e-e1b8-8c22-1ddc475b492e@huawei.com>
References: <20170306215102.3807-1-jaegeuk@kernel.org>
 <20170306215102.3807-2-jaegeuk@kernel.org>
 <2be8ba18-21ed-a990-70d1-12be80ed13d2@huawei.com>
 <20170308213955.GC5483@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170308213955.GC5483@jaegeuk.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/3/9 5:39, Jaegeuk Kim wrote:
> On 03/08, Chao Yu wrote:
>> On 2017/3/7 5:51, Jaegeuk Kim wrote:
>>> This patch fixes that SSR can overwrite previous warm node block consisting of
>>> a node chain since the last checkpoint.
>>
>> Good catch!
>>
>> Need to consider the impact to other accesser, e.g. is_checkpointed_data,
>> add_discard_addrs?
> 
> I've checked them. is_checkpointed_data() has nothing to do with this warm node
> and this prevents add_discard_addrs to issue discard command.

That's right.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Fixes: 5b6c6be2d878 ("f2fs: use SSR for warm node as well")
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/segment.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 2ae36d04d03e..684b869e1861 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1177,6 +1177,12 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>>>  		if (f2fs_discard_en(sbi) &&
>>>  			!f2fs_test_and_set_bit(offset, se->discard_map))
>>>  			sbi->discard_blks--;
>>> +
>>> +		/* don't overwrite by SSR to keep node chain */
>>> +		if (se->type == CURSEG_WARM_NODE) {
>>> +			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
>>> +				se->ckpt_valid_blocks++;
>>> +		}
>>>  	} else {
>>>  		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map)) {
>>>  #ifdef CONFIG_F2FS_CHECK_FS
>>>
> 
> .
> 
