From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: relax EIO injection for quota file
Date: Sat, 28 Oct 2017 17:22:17 +0800
Message-ID: <369986d8-18f2-85b6-28cd-64dffea2f7a7@huawei.com>
References: <20171019165617.79128-1-jaegeuk@kernel.org>
 <20171019165617.79128-2-jaegeuk@kernel.org>
 <b8e70503-c0e3-22b2-a1fe-089f8fb206a6@kernel.org>
 <20171022165109.GA33676@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171022165109.GA33676@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/10/23 0:51, Jaegeuk Kim wrote:
> On 10/22, Chao Yu wrote:
>> On 2017/10/20 0:56, Jaegeuk Kim wrote:
>>> This case is not happening easily.
>>
>> Actually it can happen, so why not just keep it?
> 
> Okay, so let me keep this patch for local stress tests only.

May I ask which type and rate of fault injection you are using for
test now?

Thanks,

> 
> Thanks,
> 
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/f2fs.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index e0ef31cb2cc6..6301ccca8888 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1544,7 +1544,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>>>  		return ret;
>>>  
>>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>>> -	if (time_to_inject(sbi, FAULT_BLOCK)) {
>>> +	if (!IS_NOQUOTA(inode) && time_to_inject(sbi, FAULT_BLOCK)) {
>>>  		f2fs_show_injection_info(FAULT_BLOCK);
>>>  		release = *count;
>>>  		goto enospc;
>>>
> 
> .
> 
