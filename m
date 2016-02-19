From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] f2fs: add new wraper function for reading inline data
Date: Fri, 19 Feb 2016 15:46:57 +0800
Message-ID: <56C6C871.50605@rock-chips.com>
References: <1455850210-31439-1-git-send-email-shawn.lin@rock-chips.com>
 <01ce01d16ae8$32023f20$9606bd60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01ce01d16ae8$32023f20$9606bd60$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: shawn.lin@rock-chips.com, shawn.lin@kernel-upstream.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/2/19 15:35, Chao Yu wrote:
> Hi Shawn,
>
>> -----Original Message-----
>> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
>> Sent: Friday, February 19, 2016 10:50 AM
>> To: Jaegeuk Kim; Changman Lee
>> Cc: Chao Yu; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; Shawn Lin
>> Subject: [PATCH] f2fs: add new wraper function for reading inline data
>>
>> This patch add __read_inline_data which will no check
>> PageUptodate and page->index. This can be reused by
>> f2fs_convert_inline_page to reduce the redundant code
>> copied from read_inline_data.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   fs/f2fs/inline.c | 26 ++++++++++++--------------
>>   1 file changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>> index d27347e..39eeff1 100644
>> --- a/fs/f2fs/inline.c
>> +++ b/fs/f2fs/inline.c
>> @@ -42,15 +42,11 @@ bool f2fs_may_inline_dentry(struct inode *inode)
>>   	return true;
>>   }
>>
>> -void read_inline_data(struct page *page, struct page *ipage)
>> +static inline void __read_inline_data(struct page *page,
>> +				      struct page *ipage)
>>   {
>>   	void *src_addr, *dst_addr;
>>
>> -	if (PageUptodate(page))
>> -		return;
>> -
>> -	f2fs_bug_on(F2FS_P_SB(page), page->index);
>> -
>>   	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
>>
>>   	/* Copy the whole inline data block */
>> @@ -61,6 +57,15 @@ void read_inline_data(struct page *page, struct page *ipage)
>>   	kunmap_atomic(dst_addr);
>>   	SetPageUptodate(page);
>>   }
>> +void read_inline_data(struct page *page, struct page *ipage)
>> +{
>> +	if (PageUptodate(page))
>> +		return;
>> +
>> +	f2fs_bug_on(F2FS_P_SB(page), page->index);
>> +
>> +	__read_inline_data(page, ipage);
>> +}
>>
>>   bool truncate_inline_inode(struct page *ipage, u64 from)
>>   {
>> @@ -128,15 +133,8 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
>>   	if (PageUptodate(page))
>>   		goto no_update;
>
> Seems we can remove above check and below 'no_update' tag completely
> if we use read_inline_data here.
>
> So what about using read_inline_data to clean up codes in
> f2fs_convert_inline_page?

yep, it does make sense. I will respin v2 to the list later.
Thanks for sharing your thought.

>
> Thanks,
>
>>
>> -	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
>> +	__read_inline_data(page, dn->inode_page);
>>
>> -	/* Copy the whole inline data block */
>> -	src_addr = inline_data_addr(dn->inode_page);
>> -	dst_addr = kmap_atomic(page);
>> -	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
>> -	flush_dcache_page(page);
>> -	kunmap_atomic(dst_addr);
>> -	SetPageUptodate(page);
>>   no_update:
>>   	set_page_dirty(page);
>>
>> --
>> 2.3.7
>>
>
>
>
>
>


-- 
Best Regards
Shawn Lin
