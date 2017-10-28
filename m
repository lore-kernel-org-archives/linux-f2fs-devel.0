From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] f2fs: update dirty status for CURSEG as
 well
Date: Sat, 28 Oct 2017 23:58:28 +0800
Message-ID: <67a02221-4de9-c227-19c8-757e56528d23@huawei.com>
References: <1507728318-113117-1-git-send-email-yunlong.song@huawei.com>
 <1507900897-156286-1-git-send-email-yunlong.song@huawei.com>
 <72f5511f-dcd4-939b-661f-f333738ee691@kernel.org>
 <3c29460d-36c6-45d5-2c02-b38f0afa5ac2@huawei.com>
 <e7054aad-bfa6-703d-0c82-3068dd4bed78@huawei.com>
 <a8d849bb-d7c9-bd52-0cde-af0e41dd3f35@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yunlong.song@huawei.com>)
 id 1e8TWD-0005Bc-52
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 15:59:29 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e8TWA-000283-Qf
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 15:59:29 +0000
In-Reply-To: <a8d849bb-d7c9-bd52-0cde-af0e41dd3f35@kernel.org>
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
To: Chao Yu <chao@kernel.org>, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, miaoxie@huawei.com

Hi Chao,
     Thanks for your work. I send a v2 patch, which changes 
refresh_sit_entry to static.

On 2017/10/28 20:02, Chao Yu wrote:
> Hi Yunlong,
>
> I think you're so busy, I just help to refactor your patch, and send it out
> authored with you, please check that patch, if you have different opinion, let
> me know.
>
> Thanks,
>
> On 2017/10/16 11:43, Chao Yu wrote:
>> On 2017/10/14 20:53, Yunlong Song wrote:
>>> Oh, yes it is. I found that problem in a kernel tree which does not have
>>> commit
>>> c6f82fe90d7458e5fa190a6820bfc24f96b0de4e (Revert "f2fs: put allocate_segment
>>> after refresh_sit_entry"). In that kernel, the allocate_segment is still
>>> behind
>>> refresh_sit_entry. Now I understand the commit message:
>>> "This makes a leak to register dirty segments. I reproduced the issue by
>>>       modified postmark which injects a lot of file create/delete/update and
>>>       finally triggers huge number of SSR allocations."
>>>
>>> The reason is that if refresh_sit_entry is before allocate_segment, then the
>>> dirty status of CURSEG is not updated, as a result, the count of dirty
>>> segments
>>> is wrong, which is much smaller than its real value. Then the f2fs_gc
>>> can not
>>> do its work since it can not even get one victim, then the free segments are
>>> used up and then triggers much SSR. So Jay reverts the patch.
>>>
>>> It seems there are two options:
>>> (1) keep this patch ([PATCH v2] f2fs: update dirty status for CURSEG as
>>> well)
>>> and we can recover commit 3436c4bdb30de421d46f58c9174669fbcfd40ce0
>>> (f2fs: put allocate_segment after refresh_sit_entry)
>>> (2) remove this patch at all
>>>
>>> It seems (1) is robust, but (2) avoids unnecessary check.
>> What about reverting 5e443818fa0b ("f2fs: handle dirty segments inside
>> refresh_sit_entry") to keep the original order:
>>
>> 1. update sit info
>> 2. allocate new segment
>> 3. update dirty status of segment
>>
>> Thanks,
>>
>>> On 2017/10/14 8:14, Chao Yu wrote:
>>>> On 2017/10/13 21:21, Yunlong Song wrote:
>>>>> Without this patch, it will cause all the free segments using up in some
>>>>> corner case. For example, there are 100 segments, and 20 of them are
>>>>> reserved for ovp. If 79 segments are full of data, segment 80 becomes
>>>>> CURSEG segment, write 512 blocks and then delete 511 blocks. Since it is
>>>>> CURSEG segment, the __locate_dirty_segment will not update its dirty
>>>>> status. Then the dirty_segments(sbi) is 0, f2fs_gc will fail to
>>>>> get_victim, and f2fs_balance_fs will fail to trigger gc action. After
>>>>> f2fs_balance_fs returns, f2fs can continue to write data to segment 81.
>>>>> Again, segment 81 becomes CURSEG segment, write 512 blocks and delete
>>>>> 511 blocks, the dirty_segments(sbi) is 0 and f2fs_gc fail again. This
>>>>> can finally use up all the free segments and cause panic.
>>>> Look into this patch again, I found refresh_sit_entry is called after
>>>> ->allocate_segment, so if all 512 blocks were allocated, log header should
>>>> have been moved to another segment, so locate_dirty_segment in
>>>> refresh_sit_entry should update dirty status of previous segment correctly,
>>>> anything I'm missing?
>>>>
>>>> Thanks,
>>>>
>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>> ---
>>>>>    fs/f2fs/segment.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index bfbcff8..0fce076 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -687,7 +687,7 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>>>>>    	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>>>>>    
>>>>>    	/* need not be added */
>>>>> -	if (IS_CURSEG(sbi, segno))
>>>>> +	if (IS_CURSEG(sbi, segno) && dirty_type == PRE)
>>>>>    		return;
>>>>>    
>>>>>    	if (!test_and_set_bit(segno, dirty_i->dirty_segmap[dirty_type]))
>>>>> @@ -737,7 +737,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
>>>>>    	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>>>>>    	unsigned short valid_blocks;
>>>>>    
>>>>> -	if (segno == NULL_SEGNO || IS_CURSEG(sbi, segno))
>>>>> +	if (segno == NULL_SEGNO)
>>>>>    		return;
>>>>>    
>>>>>    	mutex_lock(&dirty_i->seglist_lock);
>>>>>
>>>> .
>>>>
> .
>

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
