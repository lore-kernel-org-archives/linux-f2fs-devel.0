From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3 3/4] f2fs: Fix accounting for unusable
 blocks
Date: Tue, 4 Jun 2019 09:46:43 +0800
Message-ID: <2fbeda5b-50d6-a8c2-06a9-dddf5d466de8@huawei.com>
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-4-drosen@google.com>
 <c99079bd-99e1-e100-08f6-1e8adae5e722@huawei.com>
 <20190603202630.GB34729@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hXyXT-00030V-HI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jun 2019 01:46:59 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hXyXR-004vaC-Fq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jun 2019 01:46:59 +0000
In-Reply-To: <20190603202630.GB34729@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: Daniel Rosenberg <drosen@google.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, kernel-team@android.com

On 2019/6/4 4:26, Jaegeuk Kim wrote:
> On 06/03, Chao Yu wrote:
>> On 2019/5/30 8:49, Daniel Rosenberg wrote:
>>> Fixes possible underflows when dealing with unusable blocks.
>>>
>>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>>> ---
>>>  fs/f2fs/f2fs.h | 15 ++++++++++-----
>>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 9b3d9977cd1ef..a39cc4ffeb4b1 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1769,8 +1769,12 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>>>  
>>>  	if (!__allow_reserved_blocks(sbi, inode, true))
>>>  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
>>> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>>> -		avail_user_block_count -= sbi->unusable_block_count;
>>> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>>> +		if (avail_user_block_count > sbi->unusable_block_count)
>>> +			avail_user_block_count = 0;
>>
>> avail_user_block_count -= sbi->unusable_block_count;
>>
>>> +		else
>>> +			avail_user_block_count -= sbi->unusable_block_count;
>>
>> avail_user_block_count = 0;
>>
> 
> I fixed this.

Okay, if there is no v4, please add

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
>> Thanks,
>>
>>> +	}
>>>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>>>  		diff = sbi->total_valid_block_count - avail_user_block_count;
>>>  		if (diff > *count)
>>> @@ -1970,7 +1974,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>>  					struct inode *inode, bool is_inode)
>>>  {
>>>  	block_t	valid_block_count;
>>> -	unsigned int valid_node_count;
>>> +	unsigned int valid_node_count, user_block_count;
>>>  	int err;
>>>  
>>>  	if (is_inode) {
>>> @@ -1997,10 +2001,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>>  
>>>  	if (!__allow_reserved_blocks(sbi, inode, false))
>>>  		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
>>> +	user_block_count = sbi->user_block_count;
>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>>> -		valid_block_count += sbi->unusable_block_count;
>>> +		user_block_count -= sbi->unusable_block_count;
>>>  
>>> -	if (unlikely(valid_block_count > sbi->user_block_count)) {
>>> +	if (unlikely(valid_block_count > user_block_count)) {
>>>  		spin_unlock(&sbi->stat_lock);
>>>  		goto enospc;
>>>  	}
>>>
> .
> 
