From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: use __set_page_dirty_nobuffers
 directly
Date: Thu, 3 Nov 2016 17:50:34 +0800
Message-ID: <13561186-caab-79b4-325f-6d0514aa289b@huawei.com>
References: <20161021022847.55629-1-jaegeuk@kernel.org>
 <20161021022847.55629-2-jaegeuk@kernel.org>
 <4d3fd0f9-046e-82fc-3830-487a167e7700@huawei.com>
 <20161102172341.GB48728@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161102172341.GB48728@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/11/3 1:23, Jaegeuk Kim wrote:
> On Wed, Nov 02, 2016 at 03:34:32PM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2016/10/21 10:28, Jaegeuk Kim wrote:
>>> This patch replaces the copied code with original generic function.
>>
>> Will we plan to do further enhance inside f2fs_set_page_dirty_nobuffers, if we
>> don't it's better revert fe76b796fc5194cc3d57265002e3a748566d073f, as we don't
>> need to wrap __set_page_dirty_nobuffers.
> 
> Urg. I was confused something here.
> Please ignore this patch. I won't merge this patch.

Why? isn't __set_page_dirty_nobuffers more fit for f2fs' non-buffer management?

Thanks,

> 
>> BTW, does the original patch make memory cgroup functionality problematic?
> 
> I don't think there is a problem, since I just copied __set_page_dirty_buffers()
> except page_has_buffers' stuffs.
> 
> Thank you for pointing this out. :)
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/data.c | 29 -----------------------------
>>>  fs/f2fs/f2fs.h |  6 +++++-
>>>  2 files changed, 5 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 68edb47..3954315 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1801,35 +1801,6 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>>>  	return 1;
>>>  }
>>>  
>>> -/*
>>> - * This was copied from __set_page_dirty_buffers which gives higher performance
>>> - * in very high speed storages. (e.g., pmem)
>>> - */
>>> -void f2fs_set_page_dirty_nobuffers(struct page *page)
>>> -{
>>> -	struct address_space *mapping = page->mapping;
>>> -	unsigned long flags;
>>> -
>>> -	if (unlikely(!mapping))
>>> -		return;
>>> -
>>> -	spin_lock(&mapping->private_lock);
>>> -	lock_page_memcg(page);
>>> -	SetPageDirty(page);
>>> -	spin_unlock(&mapping->private_lock);
>>> -
>>> -	spin_lock_irqsave(&mapping->tree_lock, flags);
>>> -	WARN_ON_ONCE(!PageUptodate(page));
>>> -	account_page_dirtied(page, mapping);
>>> -	radix_tree_tag_set(&mapping->page_tree,
>>> -			page_index(page), PAGECACHE_TAG_DIRTY);
>>> -	spin_unlock_irqrestore(&mapping->tree_lock, flags);
>>> -	unlock_page_memcg(page);
>>> -
>>> -	__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>>> -	return;
>>> -}
>>> -
>>>  static int f2fs_set_data_page_dirty(struct page *page)
>>>  {
>>>  	struct address_space *mapping = page->mapping;
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 168f939..b66a04c 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1960,6 +1960,11 @@ static inline unsigned long f2fs_find_next_bit(const void *addr,
>>>  	return find_next_bit(addr, size, offset + 2);
>>>  }
>>>  
>>> +static inline void f2fs_set_page_dirty_nobuffers(struct page *page)
>>> +{
>>> +	__set_page_dirty_nobuffers(page);
>>> +}
>>> +
>>>  #define get_inode_mode(i) \
>>>  	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
>>>  	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
>>> @@ -2200,7 +2205,6 @@ struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
>>>  int do_write_data_page(struct f2fs_io_info *);
>>>  int f2fs_map_blocks(struct inode *, struct f2fs_map_blocks *, int, int);
>>>  int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
>>> -void f2fs_set_page_dirty_nobuffers(struct page *);
>>>  void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
>>>  int f2fs_release_page(struct page *, gfp_t);
>>>  #ifdef CONFIG_MIGRATION
>>>
> 
> .
> 
