From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3] f2fs: add bitmaps for empty or full NAT
 blocks
Date: Mon, 27 Feb 2017 11:03:51 +0800
Message-ID: <bd7345dc-b408-bdf8-ef0c-416ca3057aaa@huawei.com>
References: <20170214020644.18189-1-jaegeuk@kernel.org>
	<20170214020644.18189-2-jaegeuk@kernel.org>
	<1ecf0acf-2ae7-c547-6d7b-350bd356d48c@huawei.com>
	<20170223225449.GG2026@jaegeuk.local>
	<9c15f4dc-37ab-d94d-c62e-0aded8ea848f@huawei.com>
	<20170225183419.GB51627@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciBbi-0001ob-4U
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 03:04:14 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciBbc-0005YN-Ke
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 03:04:14 +0000
In-Reply-To: <20170225183419.GB51627@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/2/26 2:34, Jaegeuk Kim wrote:
> On 02/25, Chao Yu wrote:
>> On 2017/2/24 6:54, Jaegeuk Kim wrote:
>>> On 02/23, Chao Yu wrote:
>>>> On 2017/2/14 10:06, Jaegeuk Kim wrote:
> ...
>>>
>>>>> +static int scan_nat_bits(struct f2fs_sb_info *sbi)
>>>>> +{
>>>>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>> +	struct page *page;
>>>>> +	unsigned int i = 0;
>>>>> +	nid_t target = FREE_NID_PAGES * NAT_ENTRY_PER_BLOCK;
>>>>> +	nid_t nid;
>>>>> +
>>>>> +	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
>>>>> +		return -EAGAIN;
>>>>> +
>>>>> +	down_read(&nm_i->nat_tree_lock);
>>>>> +check_empty:
>>>>> +	i = find_next_bit_le(nm_i->empty_nat_bits, nm_i->nat_blocks, i);
>>>>> +	if (i >= nm_i->nat_blocks) {
>>>>> +		i = 0;
>>>>> +		goto check_partial;
>>>>> +	}
>>>>> +
>>>>> +	for (nid = i * NAT_ENTRY_PER_BLOCK; nid < (i + 1) * NAT_ENTRY_PER_BLOCK;
>>>>> +									nid++) {
>>>>> +		if (unlikely(nid >= nm_i->max_nid))
>>>>> +			break;
>>>>> +		add_free_nid(sbi, nid, true);
>>>>> +	}
>>>>> +
>>>>> +	if (nm_i->nid_cnt[FREE_NID_LIST] >= target)
>>>>> +		goto out;
>>>>> +	i++;
>>>>> +	goto check_empty;
>>>>> +
>>>>> +check_partial:
>>>>> +	i = find_next_zero_bit_le(nm_i->full_nat_bits, nm_i->nat_blocks, i);
>>>>> +	if (i >= nm_i->nat_blocks) {
>>>>> +		disable_nat_bits(sbi, true);
>>>>
>>>> Can this happen in real world? Should be a bug in somewhere?
>>>
>>> It happens, since current design handles full_nat_bits optionally in order
>>> to avoid scanning a whole NAT page to set it back as 1 from 0.
>>
>> All 0 value in full_nat_bits means the NAT block has at least one free nid,
>> right? so if we traverse all such NAT blocks, and still haven't collect enough
>> *target* number of free nids, we don't have to disable nat bit cache, we can
>> just break out here.
> 
> No, I'm seeing this case:
> 1. mount with full=0, empty=0, which indicates some free nids.
> 2. allocate all there-in free nids, but still full=0, empty=0.
> 3. allocate more free nids.
> ...
> ... checkpoint makes full=1, empty=0
> 
> If there is no checkpoint and it consumes all the free nids, we can see all 0
> value in full_nat_bits which is quite impossible. In that case, I'd prefer
> to stop nat_bits and give fsck.f2fs to revive it back.

Yeah, I can understand that, but what I concern is when there is few free nids
(< target), we still try to load nids of 8 NAT blocks until ending the loop of
caching free nids, so it will be very easy to enter the case of disabling
nid_bits cache here, so how about doing more check?

if (i >= nm_i->nat_blocks &&
	nm_i->nid_cnt[FREE_NID_LIST] != nm_i->available_nids)
	disable_nat_bits

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>>>
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	nid = i * NAT_ENTRY_PER_BLOCK;
>>>>> +	page = get_current_nat_page(sbi, nid);
>>>>> +	scan_nat_page(sbi, page, nid);
>>>>> +	f2fs_put_page(page, 1);
>>>>> +
>>>>> +	if (nm_i->nid_cnt[FREE_NID_LIST] < target) {
>>>>> +		i++;
>>>>> +		goto check_partial;
>>>>> +	}
>>>>> +out:
>>>>> +	up_read(&nm_i->nat_tree_lock);
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>>>>>  {
>>>>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>>>>> @@ -1854,6 +1911,20 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
>>>>>  	if (!sync && !available_free_memory(sbi, FREE_NIDS))
>>>>>  		return;
>>>>>  
>>>>> +	/* try to find free nids with nat_bits */
>>>>> +	if (!mount && !scan_nat_bits(sbi) && nm_i->nid_cnt[FREE_NID_LIST])
>>>>> +		return;
>>>>> +
>>>>> +	/* find next valid candidate */
>>>>
>>>> This is just for mount case?
>>>
>>> Yup, it reuses free nids in dirty NAT blocks, so that we can make them as full
>>> NAT pages.
>>>
>>> Thanks,
>>>
>>>>
>>>>> +	if (is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) {
>>>>> +		int idx = find_next_zero_bit_le(nm_i->full_nat_bits,
>>>>> +					nm_i->nat_blocks, 0);
>>>>> +		if (idx >= nm_i->nat_blocks)
>>>>> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>> +		else
>>>>> +			nid = idx * NAT_ENTRY_PER_BLOCK;
>>>>> +	}
>>>>> +
>>>>>  	/* readahead nat pages to be scanned */
>>>>>  	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
>>>>>  							META_NAT, true);
>>>>> @@ -1896,10 +1967,10 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
>>>>>  					nm_i->ra_nid_pages, META_NAT, false);
>>>>>  }
>>>>>  
>>>>> -void build_free_nids(struct f2fs_sb_info *sbi, bool sync)
>>>>> +void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>>>>>  {
>>>>>  	mutex_lock(&NM_I(sbi)->build_lock);
>>>>> -	__build_free_nids(sbi, sync);
>>>>> +	__build_free_nids(sbi, sync, mount);
>>>>>  	mutex_unlock(&NM_I(sbi)->build_lock);
>>>>>  }
>>>>>  
>>>>> @@ -1941,7 +2012,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>>>>>  	spin_unlock(&nm_i->nid_list_lock);
>>>>>  
>>>>>  	/* Let's scan nat pages and its caches to get free nids */
>>>>> -	build_free_nids(sbi, true);
>>>>> +	build_free_nids(sbi, true, false);
>>>>>  	goto retry;
>>>>>  }
>>>>>  
>>>>> @@ -2233,8 +2304,39 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
>>>>>  	list_add_tail(&nes->set_list, head);
>>>>>  }
>>>>>  
>>>>> +void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>>>>> +						struct page *page)
>>>>> +{
>>>>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>> +	unsigned int nat_index = start_nid / NAT_ENTRY_PER_BLOCK;
>>>>> +	struct f2fs_nat_block *nat_blk = page_address(page);
>>>>> +	int valid = 0;
>>>>> +	int i;
>>>>> +
>>>>> +	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
>>>>> +		return;
>>>>> +
>>>>> +	for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
>>>>> +		if (start_nid == 0 && i == 0)
>>>>> +			valid++;
>>>>> +		if (nat_blk->entries[i].block_addr)
>>>>> +			valid++;
>>>>> +	}
>>>>> +	if (valid == 0) {
>>>>> +		test_and_set_bit_le(nat_index, nm_i->empty_nat_bits);
>>>>> +		test_and_clear_bit_le(nat_index, nm_i->full_nat_bits);
>>>>
>>>> set_bit_le/clear_bit_le
>>>>
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	test_and_clear_bit_le(nat_index, nm_i->empty_nat_bits);
>>>>
>>>> ditto
>>>>
>>>>> +	if (valid == NAT_ENTRY_PER_BLOCK)
>>>>> +		test_and_set_bit_le(nat_index, nm_i->full_nat_bits);
>>>>> +	else
>>>>> +		test_and_clear_bit_le(nat_index, nm_i->full_nat_bits);
>>>>
>>>> ditto
>>>>
>>>>> +}
>>>>> +
>>>>>  static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>> -					struct nat_entry_set *set)
>>>>> +		struct nat_entry_set *set, struct cp_control *cpc)
>>>>>  {
>>>>>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>>>>>  	struct f2fs_journal *journal = curseg->journal;
>>>>> @@ -2249,7 +2351,8 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>>  	 * #1, flush nat entries to journal in current hot data summary block.
>>>>>  	 * #2, flush nat entries to nat page.
>>>>>  	 */
>>>>> -	if (!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
>>>>> +	if (cpc->reason == CP_UMOUNT ||
>>>>
>>>> if ((cpc->reason == CP_UMOUNT && is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) ||
>>>>
>>>>> +		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
>>>>>  		to_journal = false;
>>>>>  
>>>>>  	if (to_journal) {
>>>>> @@ -2289,10 +2392,12 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> -	if (to_journal)
>>>>> +	if (to_journal) {
>>>>>  		up_write(&curseg->journal_rwsem);
>>>>> -	else
>>>>> +	} else {
>>>>> +		__update_nat_bits(sbi, start_nid, page);
>>>>>  		f2fs_put_page(page, 1);
>>>>> +	}
>>>>>  
>>>>>  	f2fs_bug_on(sbi, set->entry_cnt);
>>>>>  
>>>>> @@ -2303,7 +2408,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>>  /*
>>>>>   * This function is called during the checkpointing process.
>>>>>   */
>>>>> -void flush_nat_entries(struct f2fs_sb_info *sbi)
>>>>> +void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>  {
>>>>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>>>>> @@ -2324,7 +2429,8 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
>>>>>  	 * entries, remove all entries from journal and merge them
>>>>>  	 * into nat entry set.
>>>>>  	 */
>>>>> -	if (!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
>>>>> +	if (cpc->reason == CP_UMOUNT ||
>>>>
>>>> if ((cpc->reason == CP_UMOUNT && is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) ||
>>>>
>>>>> +		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
>>>>>  		remove_nats_in_journal(sbi);
>>>>>  
>>>>>  	while ((found = __gang_lookup_nat_set(nm_i,
>>>>> @@ -2338,27 +2444,72 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
>>>>>  
>>>>>  	/* flush dirty nats in nat entry set */
>>>>>  	list_for_each_entry_safe(set, tmp, &sets, set_list)
>>>>> -		__flush_nat_entry_set(sbi, set);
>>>>> +		__flush_nat_entry_set(sbi, set, cpc);
>>>>>  
>>>>>  	up_write(&nm_i->nat_tree_lock);
>>>>>  
>>>>>  	f2fs_bug_on(sbi, nm_i->dirty_nat_cnt);
>>>>>  }
>>>>>  
>>>>> +static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>>>>> +{
>>>>> +	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>>>>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>> +	unsigned int nat_bits_bytes = nm_i->nat_blocks / BITS_PER_BYTE;
>>>>> +	unsigned int i;
>>>>> +	__u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
>>>>
>>>> __u64 cp_ver = cur_cp_version(ckpt);
>>>>
>>>> Thanks,
>>>>
>>>>> +	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
>>>>> +	__u64 crc = le32_to_cpu(*((__le32 *)
>>>>> +				((unsigned char *)ckpt + crc_offset)));
>>>>> +	block_t nat_bits_addr;
>>>>> +
>>>>> +	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
>>>>> +		return 0;
>>>>> +
>>>>> +	nm_i->nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) + 8 +
>>>>> +						F2FS_BLKSIZE - 1);
>>>>> +	nm_i->nat_bits = kzalloc(nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS,
>>>>> +						GFP_KERNEL);
>>>>> +	if (!nm_i->nat_bits)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
>>>>> +						nm_i->nat_bits_blocks;
>>>>> +	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
>>>>> +		struct page *page = get_meta_page(sbi, nat_bits_addr++);
>>>>> +
>>>>> +		memcpy(nm_i->nat_bits + (i << F2FS_BLKSIZE_BITS),
>>>>> +					page_address(page), F2FS_BLKSIZE);
>>>>> +		f2fs_put_page(page, 1);
>>>>> +	}
>>>>> +
>>>>> +	cp_ver |= (crc << 32);
>>>>> +	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
>>>>> +		disable_nat_bits(sbi, true);
>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +	nm_i->full_nat_bits = nm_i->nat_bits + 8;
>>>>> +	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
>>>>> +
>>>>> +	f2fs_msg(sbi->sb, KERN_NOTICE, "Found nat_bits in checkpoint");
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>  static int init_node_manager(struct f2fs_sb_info *sbi)
>>>>>  {
>>>>>  	struct f2fs_super_block *sb_raw = F2FS_RAW_SUPER(sbi);
>>>>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>>  	unsigned char *version_bitmap;
>>>>> -	unsigned int nat_segs, nat_blocks;
>>>>> +	unsigned int nat_segs;
>>>>> +	int err;
>>>>>  
>>>>>  	nm_i->nat_blkaddr = le32_to_cpu(sb_raw->nat_blkaddr);
>>>>>  
>>>>>  	/* segment_count_nat includes pair segment so divide to 2. */
>>>>>  	nat_segs = le32_to_cpu(sb_raw->segment_count_nat) >> 1;
>>>>> -	nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
>>>>> -
>>>>> -	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
>>>>> +	nm_i->nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
>>>>> +	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nm_i->nat_blocks;
>>>>>  
>>>>>  	/* not used nids: 0, node, meta, (and root counted as valid node) */
>>>>>  	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
>>>>> @@ -2392,6 +2543,10 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>>>>>  	if (!nm_i->nat_bitmap)
>>>>>  		return -ENOMEM;
>>>>>  
>>>>> +	err = __get_nat_bitmaps(sbi);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +
>>>>>  #ifdef CONFIG_F2FS_CHECK_FS
>>>>>  	nm_i->nat_bitmap_mir = kmemdup(version_bitmap, nm_i->bitmap_size,
>>>>>  					GFP_KERNEL);
>>>>> @@ -2414,7 +2569,7 @@ int build_node_manager(struct f2fs_sb_info *sbi)
>>>>>  	if (err)
>>>>>  		return err;
>>>>>  
>>>>> -	build_free_nids(sbi, true);
>>>>> +	build_free_nids(sbi, true, true);
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> @@ -2473,6 +2628,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
>>>>>  	up_write(&nm_i->nat_tree_lock);
>>>>>  
>>>>>  	kfree(nm_i->nat_bitmap);
>>>>> +	kfree(nm_i->nat_bits);
>>>>>  #ifdef CONFIG_F2FS_CHECK_FS
>>>>>  	kfree(nm_i->nat_bitmap_mir);
>>>>>  #endif
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index df2ff5cfe8f4..8e1ec248c653 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -386,7 +386,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>>>>>  	if (!available_free_memory(sbi, FREE_NIDS))
>>>>>  		try_to_free_nids(sbi, MAX_FREE_NIDS);
>>>>>  	else
>>>>> -		build_free_nids(sbi, false);
>>>>> +		build_free_nids(sbi, false, false);
>>>>>  
>>>>>  	if (!is_idle(sbi))
>>>>>  		return;
>>>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>>>> index f0748524ca8c..1c92ace2e8f8 100644
>>>>> --- a/include/linux/f2fs_fs.h
>>>>> +++ b/include/linux/f2fs_fs.h
>>>>> @@ -114,6 +114,7 @@ struct f2fs_super_block {
>>>>>  /*
>>>>>   * For checkpoint
>>>>>   */
>>>>> +#define CP_NAT_BITS_FLAG	0x00000080
>>>>>  #define CP_CRC_RECOVERY_FLAG	0x00000040
>>>>>  #define CP_FASTBOOT_FLAG	0x00000020
>>>>>  #define CP_FSCK_FLAG		0x00000010
>>>>>
>>>>
>>>>
>>>> ------------------------------------------------------------------------------
>>>> Check out the vibrant tech community on one of the world's most
>>>> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
>>> .
>>>
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
