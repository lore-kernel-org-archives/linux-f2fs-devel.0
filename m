From: Chao Yu <chao@kernel.org>
Subject: Re: Fwd: Re: [PATCH 1/1] f2fs: simplify the calculation
 of fggc_threshold
Date: Fri, 27 Oct 2017 20:31:07 +0800
Message-ID: <f210342a-36ba-9fa9-623d-826828fed941@kernel.org>
References: <6b8c7cee-3806-3b3a-e6c9-9f22857e9ae8@huawei.com>
 <249859c1-668d-5236-ec6f-1f35b9843f42@huawei.com>
 <b42d5510-5d11-c2d9-f4de-126d95e85d4a@huawei.com>
 <20171027114214.GE96994@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e83nL-0002JK-0a
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Oct 2017 12:31:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e83nI-0000UQ-Ra
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Oct 2017 12:31:26 +0000
In-Reply-To: <20171027114214.GE96994@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Sun Qiuyang <sunqiuyang@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 2017/10/27 19:42, Jaegeuk Kim wrote:
> On 10/27, Chao Yu wrote:
>> On 2017/10/27 11:43, Sun Qiuyang wrote:
>>>
>>> Hi Jaegeuk,
>>>
>>> I noticed that the log of the commit:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=7e515b31d44dcd20a98c938dfdc21877a30042a0
>>>
>>> used a new expression as follows:
>>>
>>> sbi->fggc_threshold = div_u64((u64)(main_count - ovp_count) *
>>> 			BLKS_PER_SEC(sbi), (main_count - resv_count));
>>>
>>> This might originate from my patch below, which has been merged into the 
>>> f2fs-dev branch of kernel/git/chao/linux.git, but not 
>>> kernel/git/jaegeuk/f2fs.git yet.
>>>
>>> So, would you like to consider merging my patch as well?
>>
>> As you see, I have reviewed this patch, since it looks good to me. ;)
>> But forgot to remind Jaegeuk to merge this, sorry.
> 
> So, why do we have to do this? We're calculating this based on # of blocks.
> If we don't use this patch, didn't we need the Chao's patch as well?

Only connection of these two patches is that comments in my patch referenced
codes which Qiuyang's patch modified:

sbi->fggc_threshold = div_u64((u64)(main_count - ovp_count) *
			BLKS_PER_SEC(sbi), (main_count - resv_count));

For content of two patches, they are irrelevant.

Thanks,

> 
> Thanks,
> 
>>
>> Anyway, how do you think of this cleanup? Jaegeuk.
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>
>>>> On 2017/10/17 20:42, sunqiuyang wrote:
>>>>> From: Qiuyang Sun <sunqiuyang@huawei.com>
>>>>>
>>>>> Do not need to convert segment counts to blocks for this calculation.
>>>>>
>>>>> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
>>>>
>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> Thanks,
>>>>
>>>>> ---
>>>>>  fs/f2fs/gc.c | 10 +++++-----
>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index 197ebf4..9df8cae 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -1073,16 +1073,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>>
>>>>>  void build_gc_manager(struct f2fs_sb_info *sbi)
>>>>>  {
>>>>> -	u64 main_count, resv_count, ovp_count;
>>>>> +	unsigned int main_count, resv_count, ovp_count;
>>>>>
>>>>>  	DIRTY_I(sbi)->v_ops = &default_v_ops;
>>>>>
>>>>>  	/* threshold of # of valid blocks in a section for victims of FG_GC */
>>>>> -	main_count = SM_I(sbi)->main_segments << sbi->log_blocks_per_seg;
>>>>> -	resv_count = SM_I(sbi)->reserved_segments << sbi->log_blocks_per_seg;
>>>>> -	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
>>>>> +	main_count = SM_I(sbi)->main_segments;
>>>>> +	resv_count = SM_I(sbi)->reserved_segments;
>>>>> +	ovp_count = SM_I(sbi)->ovp_segments;
>>>>>
>>>>> -	sbi->fggc_threshold = div64_u64((main_count - ovp_count) *
>>>>> +	sbi->fggc_threshold = div_u64((u64)(main_count - ovp_count) *
>>>>>  				BLKS_PER_SEC(sbi), (main_count - resv_count));
>>>>>
>>>>>  	/* give warm/cold data area from slower device */
>>>>>
>>>>
>>>> .
>>>>
>>>
>>>
>>> .
>>>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
