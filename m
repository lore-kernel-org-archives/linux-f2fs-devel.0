From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: use __set_page_dirty_nobuffers
 directly
Date: Fri, 4 Nov 2016 23:51:46 +0800
Message-ID: <4e84d84d-34e6-5e1d-f0d8-fe20845f4987@kernel.org>
References: <20161021022847.55629-1-jaegeuk@kernel.org>
	<20161021022847.55629-2-jaegeuk@kernel.org>
	<4d3fd0f9-046e-82fc-3830-487a167e7700@huawei.com>
	<20161102172341.GB48728@jaegeuk>
	<13561186-caab-79b4-325f-6d0514aa289b@huawei.com>
	<20161103175704.GB76264@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1c2gmr-0005sC-0k
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Nov 2016 15:52:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2gmp-0007WW-MV
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Nov 2016 15:52:12 +0000
In-Reply-To: <20161103175704.GB76264@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/11/4 1:57, Jaegeuk Kim wrote:
> On Thu, Nov 03, 2016 at 05:50:34PM +0800, Chao Yu wrote:
>> On 2016/11/3 1:23, Jaegeuk Kim wrote:
>>> On Wed, Nov 02, 2016 at 03:34:32PM +0800, Chao Yu wrote:
>>>> Hi Jaegeuk,
>>>>
>>>> On 2016/10/21 10:28, Jaegeuk Kim wrote:
>>>>> This patch replaces the copied code with original generic function.
>>>>
>>>> Will we plan to do further enhance inside f2fs_set_page_dirty_nobuffers, if we
>>>> don't it's better revert fe76b796fc5194cc3d57265002e3a748566d073f, as we don't
>>>> need to wrap __set_page_dirty_nobuffers.
>>>
>>> Urg. I was confused something here.
>>> Please ignore this patch. I won't merge this patch.
>>
>> Why? isn't __set_page_dirty_nobuffers more fit for f2fs' non-buffer management?
> 
> For a while ago, when I tried to improve the performance on pmem, I could hit
> that __set_page_dirty_buffers() slightly improved the bandwidth comparing to
> __set_page_dirty_nobuffers().
> 
> When referencing the below comment written in __set_page_dirty_nobuffers(), it
> seems I could get that by adopting "top-down" approach instead of "bottom-up",
> which avoids lock contention as I guess. I couldn't do deep investigation on it
> though.
> 
> /*
>  * For address_spaces which do not use buffers.  Just tag the page as dirty in
>  * its radix tree.
>  *
>  * This is also used when a single buffer is being dirtied: we want to set the
>  * page dirty in that case, but not all the buffers.  This is a "bottom-up"
>  * dirtying, whereas __set_page_dirty_buffers() is a "top-down" dirtying.
>  *
>  * The caller must ensure this doesn't race with truncation.  Most will simply
>  * hold the page lock, but e.g. zap_pte_range() calls with the page mapped and
>  * the pte lock held, which also locks out truncation.
>  */
> 
> So, I measured the performance again with fxmark on ramdisk, 8 cores, DWAL,
> bufferedio case. I got 2683158 works/sec w/ "top-down" over 2512609 works/sec w/
> "bottom-up".

Thanks for letting me know the history, f2fs_set_page_dirty_nobuffers and
__set_page_dirty_nobuffers are almost the same except
f2fs_set_page_dirty_nobuffers tries to grab mapping::private_lock additionally.

Maybe holding the private_lock does help the performance on pmem which I can't
explain why it happens now...

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>>> BTW, does the original patch make memory cgroup functionality problematic?
>>>
>>> I don't think there is a problem, since I just copied __set_page_dirty_buffers()
>>> except page_has_buffers' stuffs.
>>>
>>> Thank you for pointing this out. :)
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/data.c | 29 -----------------------------
>>>>>  fs/f2fs/f2fs.h |  6 +++++-
>>>>>  2 files changed, 5 insertions(+), 30 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 68edb47..3954315 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -1801,35 +1801,6 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>>>>>  	return 1;
>>>>>  }
>>>>>  
>>>>> -/*
>>>>> - * This was copied from __set_page_dirty_buffers which gives higher performance
>>>>> - * in very high speed storages. (e.g., pmem)
>>>>> - */
>>>>> -void f2fs_set_page_dirty_nobuffers(struct page *page)
>>>>> -{
>>>>> -	struct address_space *mapping = page->mapping;
>>>>> -	unsigned long flags;
>>>>> -
>>>>> -	if (unlikely(!mapping))
>>>>> -		return;
>>>>> -
>>>>> -	spin_lock(&mapping->private_lock);
>>>>> -	lock_page_memcg(page);
>>>>> -	SetPageDirty(page);
>>>>> -	spin_unlock(&mapping->private_lock);
>>>>> -
>>>>> -	spin_lock_irqsave(&mapping->tree_lock, flags);
>>>>> -	WARN_ON_ONCE(!PageUptodate(page));
>>>>> -	account_page_dirtied(page, mapping);
>>>>> -	radix_tree_tag_set(&mapping->page_tree,
>>>>> -			page_index(page), PAGECACHE_TAG_DIRTY);
>>>>> -	spin_unlock_irqrestore(&mapping->tree_lock, flags);
>>>>> -	unlock_page_memcg(page);
>>>>> -
>>>>> -	__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>>>>> -	return;
>>>>> -}
>>>>> -
>>>>>  static int f2fs_set_data_page_dirty(struct page *page)
>>>>>  {
>>>>>  	struct address_space *mapping = page->mapping;
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index 168f939..b66a04c 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -1960,6 +1960,11 @@ static inline unsigned long f2fs_find_next_bit(const void *addr,
>>>>>  	return find_next_bit(addr, size, offset + 2);
>>>>>  }
>>>>>  
>>>>> +static inline void f2fs_set_page_dirty_nobuffers(struct page *page)
>>>>> +{
>>>>> +	__set_page_dirty_nobuffers(page);
>>>>> +}
>>>>> +
>>>>>  #define get_inode_mode(i) \
>>>>>  	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
>>>>>  	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
>>>>> @@ -2200,7 +2205,6 @@ struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
>>>>>  int do_write_data_page(struct f2fs_io_info *);
>>>>>  int f2fs_map_blocks(struct inode *, struct f2fs_map_blocks *, int, int);
>>>>>  int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
>>>>> -void f2fs_set_page_dirty_nobuffers(struct page *);
>>>>>  void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
>>>>>  int f2fs_release_page(struct page *, gfp_t);
>>>>>  #ifdef CONFIG_MIGRATION
>>>>>
>>>
>>> .
>>>
> 
> ------------------------------------------------------------------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today. http://sdm.link/xeonphi
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
