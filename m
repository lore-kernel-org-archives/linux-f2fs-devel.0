From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: introduce free nid bitmap
Date: Thu, 23 Feb 2017 10:21:09 +0800
Message-ID: <f2952fd7-6f9a-2e35-6cb1-d6cb37e084d8@huawei.com>
References: <20170221094203.22087-1-yuchao0@huawei.com>
	<20170222232608.GD4003@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cgj27-0004NV-A4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 02:21:27 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgj25-0006Kd-FZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 02:21:27 +0000
In-Reply-To: <20170222232608.GD4003@jaegeuk.local>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

Thanks for all your comments, let me fix these and send v2 patch. :)

Thanks,

On 2017/2/23 7:26, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 02/21, Chao Yu wrote:
>> In scenario of intensively node allocation, free nids will be ran out
>> soon, then it needs to stop to load free nids by traversing NAT blocks,
>> in worse case, if NAT blocks does not be cached in memory, it generates
>> IOs which slows down our foreground operations.
>>
>> In order to speed up node allocation, in this patch we introduce a new
>> free_nid_bitmap array, so there is an bitmap table for each NAT block,
>> Once the NAT block is loaded, related bitmap cache will be switched on,
>> and bitmap will be set during traversing nat entries in NAT block, later
>> we can query and update nid usage status in memory completely.
>>
>> With such implementation, I expect performance of node allocation can be
>> improved in the long-term after filesystem image is mounted.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h          |   2 +
>>  fs/f2fs/node.c          | 113 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  include/linux/f2fs_fs.h |   1 +
>>  3 files changed, 112 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 1c9f0cc8f027..659b63489c55 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -556,6 +556,8 @@ struct f2fs_nm_info {
>>  	unsigned int nid_cnt[MAX_NID_LIST];	/* the number of free node id */
>>  	spinlock_t nid_list_lock;	/* protect nid lists ops */
>>  	struct mutex build_lock;	/* lock for build free nids */
>> +	char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
>> +	char *nat_block_bitmap;
> 
> unsigned char *?
> 
>>  
>>  	/* for checkpoint */
>>  	char *nat_bitmap;		/* NAT bitmap pointer */
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index b63bdb85ad66..8cef083b509d 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1821,14 +1821,32 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
>>  		kmem_cache_free(free_nid_slab, i);
>>  }
>>  
>> +void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid, bool set)
>> +{
>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>> +	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
>> +	unsigned int nid_ofs = nid - START_NID(nid);
>> +
>> +	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
>> +		return;
>> +
>> +	if (set)
>> +		set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>> +	else
>> +		clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>> +}
>> +
>>  static void scan_nat_page(struct f2fs_sb_info *sbi,
>>  			struct page *nat_page, nid_t start_nid)
>>  {
>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>  	struct f2fs_nat_block *nat_blk = page_address(nat_page);
>>  	block_t blk_addr;
>> +	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
>>  	int i;
>>  
>> +	set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
>> +
>>  	i = start_nid % NAT_ENTRY_PER_BLOCK;
>>  
>>  	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
>> @@ -1838,9 +1856,56 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>>  
>>  		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
>>  		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
>> -		if (blk_addr == NULL_ADDR)
>> +		if (blk_addr == NULL_ADDR) {
>> +			update_free_nid_bitmap(sbi, start_nid, true);
>>  			add_free_nid(sbi, start_nid, true);
>> +		} else {
>> +			update_free_nid_bitmap(sbi, start_nid, false);
>> +		}
> 
> 		update_free_nid_bitmap(sbi, start_nid, blk_addr == NULL_ADDR);
> 
>> +	}
>> +}
>> +
>> +static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>> +{
>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>> +	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>> +	struct f2fs_journal *journal = curseg->journal;
>> +	unsigned int i, idx;
>> +	unsigned int target = FREE_NID_PAGES * NAT_ENTRY_PER_BLOCK;
>> +
>> +	down_read(&nm_i->nat_tree_lock);
>> +
>> +	for (i = 0; i < nm_i->nat_blocks; i++) {
>> +		if (!test_bit_le(i, nm_i->nat_block_bitmap))
>> +			continue;
>> +		for (idx = 0; idx < NAT_ENTRY_PER_BLOCK; idx++) {
>> +			nid_t nid;
>> +
>> +			if (!test_bit_le(idx, nm_i->free_nid_bitmap[i]))
>> +				continue;
>> +
>> +			nid = i * NAT_ENTRY_PER_BLOCK + idx;
>> +			add_free_nid(sbi, nid, true);
>> +
>> +			if (nm_i->nid_cnt[FREE_NID_LIST] >= target)
>> +				goto out;
>> +		}
>> +	}
>> +out:
>> +	down_read(&curseg->journal_rwsem);
>> +	for (i = 0; i < nats_in_cursum(journal); i++) {
>> +		block_t addr;
>> +		nid_t nid;
>> +
>> +		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
>> +		nid = le32_to_cpu(nid_in_journal(journal, i));
>> +		if (addr == NULL_ADDR)
>> +			add_free_nid(sbi, nid, true);
>> +		else
>> +			remove_free_nid(sbi, nid);
>>  	}
>> +	up_read(&curseg->journal_rwsem);
>> +	up_read(&nm_i->nat_tree_lock);
>>  }
>>  
>>  static int scan_nat_bits(struct f2fs_sb_info *sbi)
>> @@ -1910,9 +1975,17 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>>  	if (!sync && !available_free_memory(sbi, FREE_NIDS))
>>  		return;
>>  
>> -	/* try to find free nids with nat_bits */
>> -	if (!mount && !scan_nat_bits(sbi) && nm_i->nid_cnt[FREE_NID_LIST])
>> -		return;
>> +	if (!mount) {
>> +		/* try to find free nids in free_nid_bitmap */
>> +		scan_free_nid_bits(sbi);
>> +
>> +		if (nm_i->nid_cnt[FREE_NID_LIST])
>> +			return;
>> +
>> +		/* try to find free nids with nat_bits */
>> +		if (!scan_nat_bits(sbi) && nm_i->nid_cnt[FREE_NID_LIST])
>> +			return;
>> +	}
>>  
>>  	/* find next valid candidate */
>>  	if (is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) {
>> @@ -2005,6 +2078,9 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>>  		i->state = NID_ALLOC;
>>  		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
>>  		nm_i->available_nids--;
>> +
>> +		update_free_nid_bitmap(sbi, *nid, false);
>> +
>>  		spin_unlock(&nm_i->nid_list_lock);
>>  		return true;
>>  	}
>> @@ -2059,6 +2135,8 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
>>  
>>  	nm_i->available_nids++;
>>  
>> +	update_free_nid_bitmap(sbi, nid, true);
>> +
>>  	spin_unlock(&nm_i->nid_list_lock);
>>  
>>  	if (need_free)
>> @@ -2387,6 +2465,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>  			add_free_nid(sbi, nid, false);
>>  			spin_lock(&NM_I(sbi)->nid_list_lock);
>>  			NM_I(sbi)->available_nids++;
>> +			update_free_nid_bitmap(sbi, nid, true);
>> +			spin_unlock(&NM_I(sbi)->nid_list_lock);
>> +		} else {
>> +			spin_lock(&NM_I(sbi)->nid_list_lock);
>> +			update_free_nid_bitmap(sbi, nid, false);
>>  			spin_unlock(&NM_I(sbi)->nid_list_lock);
>>  		}
>>  	}
>> @@ -2556,6 +2639,21 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>>  	return 0;
>>  }
>>  
>> +int init_free_nid_cache(struct f2fs_sb_info *sbi)
>> +{
>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>> +
>> +	nm_i->free_nid_bitmap = f2fs_kvzalloc(nm_i->nat_blocks *
>> +					NAT_ENTRY_BITMAP_SIZE, GFP_KERNEL);
>> +	if (!nm_i->free_nid_bitmap)
>> +		return -ENOMEM;
>> +
>> +	nm_i->nat_block_bitmap = f2fs_kvzalloc(nm_i->nat_blocks, GFP_KERNEL);
>> +	if (!nm_i->nat_block_bitmap)
>> +		return -ENOMEM;
> 
> This leads to update memory footprint in debug.c.
> 
> Thanks,
> 
>> +	return 0;
>> +}
>> +
>>  int build_node_manager(struct f2fs_sb_info *sbi)
>>  {
>>  	int err;
>> @@ -2568,6 +2666,10 @@ int build_node_manager(struct f2fs_sb_info *sbi)
>>  	if (err)
>>  		return err;
>>  
>> +	err = init_free_nid_cache(sbi);
>> +	if (err)
>> +		return err;
>> +
>>  	build_free_nids(sbi, true, true);
>>  	return 0;
>>  }
>> @@ -2626,6 +2728,9 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
>>  	}
>>  	up_write(&nm_i->nat_tree_lock);
>>  
>> +	kvfree(nm_i->nat_block_bitmap);
>> +	kvfree(nm_i->free_nid_bitmap);
>> +
>>  	kfree(nm_i->nat_bitmap);
>>  	kfree(nm_i->nat_bits);
>>  #ifdef CONFIG_F2FS_CHECK_FS
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index 1c92ace2e8f8..e2d239ed4c60 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -279,6 +279,7 @@ struct f2fs_node {
>>   * For NAT entries
>>   */
>>  #define NAT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_nat_entry))
>> +#define NAT_ENTRY_BITMAP_SIZE	((NAT_ENTRY_PER_BLOCK + 7) / 8)
>>  
>>  struct f2fs_nat_entry {
>>  	__u8 version;		/* latest version of cached nat entry */
>> -- 
>> 2.8.2.295.g3f1c1d0
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
