From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: clear get_ssr_cost
Date: Mon, 4 Sep 2017 10:48:43 +0800
Message-ID: <c04dc1c1-daeb-ce6e-66c6-8d81ddf03ab8@huawei.com>
References: <1504268075-81858-1-git-send-email-yunlong.song@huawei.com>
 <2503831f-3868-4037-307d-1e5fb4833a29@huawei.com>
 <e78cb8f1-99ee-672b-ffc0-1a5fdf9df908@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dohRn-00068T-E9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Sep 2017 02:49:11 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dohRl-0001CP-NV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Sep 2017 02:49:11 +0000
In-Reply-To: <e78cb8f1-99ee-672b-ffc0-1a5fdf9df908@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/9/4 9:54, Yunlong Song wrote:
> The update_sit_entry provides this:
> ...
> 1658     if (!f2fs_test_bit(offset, se->ckpt_valid_map))
> 1659         se->ckpt_valid_blocks += del;
> ...
> As a result, the ckpt_valid_blocks is always larger than valid_blocks. 
> If not correct, can you provide
> the case valid_blocks larger than ckpt_valid_blocks?

Oh, I just nit-pick, :), how about using 'se->ckpt_valid_blocks will never be
smaller than se->valid_blocks' instead?

And could you just revert Yunlei's patch and add above commit log?

Thanks,

> 
> On 2017/9/4 9:17, Chao Yu wrote:
>> On 2017/9/1 20:14, Yunlong Song wrote:
>>> se->ckpt_valid_blocks is always larger than se->valid_blocks, so
>>> get_ssr_cost can be cleared.
>> I think this is not correct.
>>
>> Thanks,
>>
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>   fs/f2fs/gc.c | 11 +----------
>>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index cd147e7..b226760 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -277,20 +277,11 @@ static unsigned int get_greedy_cost(struct f2fs_sb_info *sbi,
>>>   				valid_blocks * 2 : valid_blocks;
>>>   }
>>>   
>>> -static unsigned int get_ssr_cost(struct f2fs_sb_info *sbi,
>>> -						unsigned int segno)
>>> -{
>>> -	struct seg_entry *se = get_seg_entry(sbi, segno);
>>> -
>>> -	return se->ckpt_valid_blocks > se->valid_blocks ?
>>> -				se->ckpt_valid_blocks : se->valid_blocks;
>>> -}
>>> -
>>>   static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
>>>   			unsigned int segno, struct victim_sel_policy *p)
>>>   {
>>>   	if (p->alloc_mode == SSR)
>>> -		return get_ssr_cost(sbi, segno);
>>> +		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
>>>   
>>>   	/* alloc_mode == LFS */
>>>   	if (p->gc_mode == GC_GREEDY)
>>>
>>
>> .
>>
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
