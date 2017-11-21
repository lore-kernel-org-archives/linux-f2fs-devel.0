From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: fix concurrent problem for
 updating free bitmap
Date: Tue, 21 Nov 2017 22:33:59 +0800
Message-ID: <05a94cfb-bcc8-916b-dc93-7e8d7b732d48@kernel.org>
References: <CGME20171114072951epcas5p17015caecd08127266436b5ef1bfd1762@epcas5p1.samsung.com>
 <002401d35d1a$5b8bae50$12a30af0$@samsung.com>
 <ebc759bd-ee8b-7bd8-845b-2cd9cb7c9ca2@huawei.com>
 <000b01d3629f$1c489fc0$54d9df40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000b01d3629f$1c489fc0$54d9df40$@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LiFan <fanofcode.li@samsung.com>, 'Chao Yu' <yuchao0@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/11/21 16:01, LiFan wrote:
> 
> 
>> -----Original Message-----
>> From: Chao Yu [mailto:yuchao0@huawei.com]
>> Sent: Monday, November 20, 2017 11:00 AM
>> To: LiFan; 'Chao Yu'; 'Jaegeuk Kim'
>> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
>> Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: fix concurrent problem for updating free bitmap
>>
>> Hi,
>>
>>> @@ -1870,6 +1895,11 @@ static bool add_free_nid(struct f2fs_sb_info
>>> *sbi, nid_t nid, bool build)
>>
>> Need to use radix_tree_preload(GFP_NOFS | __GFP_NOFAIL)， otherwise, for out-of-memory case, we may skip bitmap updating.
>>
>> Thanks,
>>
>>
> Yes, about this, in previous version, if we fail to read the radix, we will clear the free bitmap in scan_nat_page,
> But fail to read the radix tree indicates that we know nothing about current nid, so we probably shouldn't 
> change the bitmap, otherwise the status we change into may not be right, so I use current patch to correct
> that.
I don't think we can skip changing the bitmap. In scan_nat_page we will enable
in-memory free nid bitmap cache, then, free nid usage in that block will be
updated in memory all the time, which means we should also keep its update being
correct during initialization, otherwise if we skip changing bitmap due to fail
to call radix_tree_preload, we will lose chance to use that free nid until remount.

Thanks,

> But __GFP_NOFAIL may still be useful for __flush_nat_entry_set case where we update the free bitmap
> Anyway.
> 
>> On 2017/11/14 15:28, LiFan wrote:
>>> alloc_nid_failed and scan_nat_page can be called at the same time, and
>>> we haven't protected add_free_nid and update_free_nid_bitmap with the
>>> same nid_list_lock. That could lead to
>>>
>>> Thread A				Thread B
>>> - __build_free_nids
>>>  - scan_nat_page
>>>   - add_free_nid
>>> 					- alloc_nid_failed
>>> 					 - update_free_nid_bitmap
>>>   - update_free_nid_bitmap
>>>
>>> scan_nat_page will clear the free bitmap since the nid is
>>> PREALLOC_NID, but alloc_nid_failed needs to set the free bitmap. This
>>> results in free nid with free bitmap cleared.
>>> This patch update the bitmap under the same nid_list_lock in add_free_nid.
>>>
>>> Signed-off-by: Fan li <fanofcode.li@samsung.com>
>>> ---
>>>  fs/f2fs/node.c | 82
>>> ++++++++++++++++++++++++++++++----------------------------
>>>  1 file changed, 42 insertions(+), 40 deletions(-)
>>>
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index b965a53..0a217d2
>>> 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -1811,8 +1811,33 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
>>>  	}
>>>  }
>>>
>>> +static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
>>> +							bool set, bool build)
>>> +{
>>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>> +	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
>>> +	unsigned int nid_ofs = nid - START_NID(nid);
>>> +
>>> +	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
>>> +		return;
>>> +
>>> +	if (set) {
>>> +		if (test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
>>> +			return;
>>> +		__set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>>> +		nm_i->free_nid_count[nat_ofs]++;
>>> +	} else {
>>> +		if (!test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
>>> +			return;
>>> +		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>>> +		if (!build)
>>> +			nm_i->free_nid_count[nat_ofs]--;
>>> +	}
>>> +}
>>> +
>>>  /* return if the nid is recognized as free */ -static bool
>>> add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>>> +static bool add_free_nid(struct f2fs_sb_info *sbi,
>>> +				nid_t nid, bool build, bool update)
>>>  {
>>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>  	struct free_nid *i, *e;
>>> @@ -1870,6 +1895,11 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>>>  	ret = true;
>>>  	err = __insert_free_nid(sbi, i, FREE_NID);
>>>  err_out:
>>> +	if (update) {
>>> +		update_free_nid_bitmap(sbi, nid, ret, build);
>>> +		if (!build)
>>> +			nm_i->available_nids++;
>>> +	}
>>>  	spin_unlock(&nm_i->nid_list_lock);
>>>  	radix_tree_preload_end();
>>>  err:
>>> @@ -1896,30 +1926,6 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
>>>  		kmem_cache_free(free_nid_slab, i);
>>>  }
>>>
>>> -static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
>>> -							bool set, bool build)
>>> -{
>>> -	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>> -	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
>>> -	unsigned int nid_ofs = nid - START_NID(nid);
>>> -
>>> -	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
>>> -		return;
>>> -
>>> -	if (set) {
>>> -		if (test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
>>> -			return;
>>> -		__set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>>> -		nm_i->free_nid_count[nat_ofs]++;
>>> -	} else {
>>> -		if (!test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
>>> -			return;
>>> -		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>>> -		if (!build)
>>> -			nm_i->free_nid_count[nat_ofs]--;
>>> -	}
>>> -}
>>> -
>>>  static void scan_nat_page(struct f2fs_sb_info *sbi,
>>>  			struct page *nat_page, nid_t start_nid)  { @@ -1937,18 +1943,18 @@
>>> static void scan_nat_page(struct f2fs_sb_info *sbi,
>>>  	i = start_nid % NAT_ENTRY_PER_BLOCK;
>>>
>>>  	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
>>> -		bool freed = false;
>>> -
>>>  		if (unlikely(start_nid >= nm_i->max_nid))
>>>  			break;
>>>
>>>  		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
>>>  		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
>>> -		if (blk_addr == NULL_ADDR)
>>> -			freed = add_free_nid(sbi, start_nid, true);
>>> -		spin_lock(&NM_I(sbi)->nid_list_lock);
>>> -		update_free_nid_bitmap(sbi, start_nid, freed, true);
>>> -		spin_unlock(&NM_I(sbi)->nid_list_lock);
>>> +		if (blk_addr == NULL_ADDR) {
>>> +			add_free_nid(sbi, start_nid, true, true);
>>> +		} else {
>>> +			spin_lock(&NM_I(sbi)->nid_list_lock);
>>> +			update_free_nid_bitmap(sbi, start_nid, false, true);
>>> +			spin_unlock(&NM_I(sbi)->nid_list_lock);
>>> +		}
>>>  	}
>>>  }
>>>
>>> @@ -1974,7 +1980,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>>>  				break;
>>>
>>>  			nid = i * NAT_ENTRY_PER_BLOCK + idx;
>>> -			add_free_nid(sbi, nid, true);
>>> +			add_free_nid(sbi, nid, true, false);
>>>
>>>  			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
>>>  				goto out;
>>> @@ -1988,7 +1994,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>>>  		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
>>>  		nid = le32_to_cpu(nid_in_journal(journal, i));
>>>  		if (addr == NULL_ADDR)
>>> -			add_free_nid(sbi, nid, true);
>>> +			add_free_nid(sbi, nid, true, false);
>>>  		else
>>>  			remove_free_nid(sbi, nid);
>>>  	}
>>> @@ -2053,7 +2059,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>>>  		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
>>>  		nid = le32_to_cpu(nid_in_journal(journal, i));
>>>  		if (addr == NULL_ADDR)
>>> -			add_free_nid(sbi, nid, true);
>>> +			add_free_nid(sbi, nid, true, false);
>>>  		else
>>>  			remove_free_nid(sbi, nid);
>>>  	}
>>> @@ -2499,11 +2505,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>  		nat_reset_flag(ne);
>>>  		__clear_nat_cache_dirty(NM_I(sbi), set, ne);
>>>  		if (nat_get_blkaddr(ne) == NULL_ADDR) {
>>> -			add_free_nid(sbi, nid, false);
>>> -			spin_lock(&NM_I(sbi)->nid_list_lock);
>>> -			NM_I(sbi)->available_nids++;
>>> -			update_free_nid_bitmap(sbi, nid, true, false);
>>> -			spin_unlock(&NM_I(sbi)->nid_list_lock);
>>> +			add_free_nid(sbi, nid, false, true);
>>>  		} else {
>>>  			spin_lock(&NM_I(sbi)->nid_list_lock);
>>>  			update_free_nid_bitmap(sbi, nid, false, false);
>>>
>>
> 
> 
> 
