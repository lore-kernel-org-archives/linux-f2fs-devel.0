From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: relax EIO injection for quota file
Date: Mon, 30 Oct 2017 17:43:04 +0800
Message-ID: <384897c7-111b-99cc-d99d-989fafaa6330@huawei.com>
References: <20171019165617.79128-1-jaegeuk@kernel.org>
 <20171019165617.79128-2-jaegeuk@kernel.org>
 <b8e70503-c0e3-22b2-a1fe-089f8fb206a6@kernel.org>
 <20171022165109.GA33676@jaegeuk-macbookpro.roam.corp.google.com>
 <369986d8-18f2-85b6-28cd-64dffea2f7a7@huawei.com>
 <20171030092114.GA26880@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e96bx-0004oJ-Mq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 09:44:01 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e96bv-0002gN-05
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 09:44:01 +0000
In-Reply-To: <20171030092114.GA26880@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/30 17:21, Jaegeuk Kim wrote:
> On 10/28, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/10/23 0:51, Jaegeuk Kim wrote:
>>> On 10/22, Chao Yu wrote:
>>>> On 2017/10/20 0:56, Jaegeuk Kim wrote:
>>>>> This case is not happening easily.
>>>>
>>>> Actually it can happen, so why not just keep it?
>>>
>>> Okay, so let me keep this patch for local stress tests only.
>>
>> May I ask which type and rate of fault injection you are using for
>> test now?
> 
> I select random value between 3000 and 5000, and 255 for type.

Got it, thanks for your sharing. :)

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/f2fs.h | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index e0ef31cb2cc6..6301ccca8888 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -1544,7 +1544,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>>>>>  		return ret;
>>>>>  
>>>>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>>>>> -	if (time_to_inject(sbi, FAULT_BLOCK)) {
>>>>> +	if (!IS_NOQUOTA(inode) && time_to_inject(sbi, FAULT_BLOCK)) {
>>>>>  		f2fs_show_injection_info(FAULT_BLOCK);
>>>>>  		release = *count;
>>>>>  		goto enospc;
>>>>>
>>>
>>> .
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
