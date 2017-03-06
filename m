From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH RFC] f2fs: combine nat_bits and
	free_nid_bitmap cache
Date: Mon, 6 Mar 2017 18:31:01 +0800
Message-ID: <212d3f0f-02a7-cab6-0e33-f3dd1fcdf98f@huawei.com>
References: <20170301091013.82838-1-yuchao0@huawei.com>
	<20170302191006.GA4151@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ckpvL-0006dc-RT
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 10:31:27 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ckpvK-0004Ai-1x
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 10:31:27 +0000
In-Reply-To: <20170302191006.GA4151@jaegeuk.local>
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

On 2017/3/3 3:10, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 03/01, Chao Yu wrote:
>> Both nat_bits cache and free_nid_bitmap cache provide same functionality
>> as a intermediate cache between free nid cache and disk, but with
>> different granularity of indicating free nid range, and different
>> persistence policy. nat_bits cache provides better persistence ability,
>> and free_nid_bitmap provides better granularity.
>>
>> In this patch we combine advantage of both caches, so finally policy of
>> the intermediate cache would be:
>> - init: load free nid status from nat_bits into free_nid_bitmap
>> - lookup: scan free_nid_bitmap before load NAT blocks
>> - update: update free_nid_bitmap in real-time
>> - persistence: udpate and persist nat_bits in checkpoint
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/node.c | 109 +++++++++++++++++++++------------------------------------
>>  1 file changed, 39 insertions(+), 70 deletions(-)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 1a759d45b7e4..6c027b6833f4 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -338,9 +338,6 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>>  		set_nat_flag(e, IS_CHECKPOINTED, false);
>>  	__set_nat_cache_dirty(nm_i, e);
>>  
>> -	if (enabled_nat_bits(sbi, NULL) && new_blkaddr == NEW_ADDR)
>> -		clear_bit_le(NAT_BLOCK_OFFSET(ni->nid), nm_i->empty_nat_bits);
>> -
>>  	/* update fsync_mark if its inode nat entry is still alive */
>>  	if (ni->nid != ni->ino)
>>  		e = __lookup_nat_cache(nm_i, ni->ino);
>> @@ -1920,58 +1917,6 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>>  	up_read(&nm_i->nat_tree_lock);
>>  }
>>  
>> -static int scan_nat_bits(struct f2fs_sb_info *sbi)
>> -{
>> -	struct f2fs_nm_info *nm_i = NM_I(sbi);
>> -	struct page *page;
>> -	unsigned int i = 0;
>> -	nid_t nid;
>> -
>> -	if (!enabled_nat_bits(sbi, NULL))
>> -		return -EAGAIN;
>> -
>> -	down_read(&nm_i->nat_tree_lock);
>> -check_empty:
>> -	i = find_next_bit_le(nm_i->empty_nat_bits, nm_i->nat_blocks, i);
>> -	if (i >= nm_i->nat_blocks) {
>> -		i = 0;
>> -		goto check_partial;
>> -	}
>> -
>> -	for (nid = i * NAT_ENTRY_PER_BLOCK; nid < (i + 1) * NAT_ENTRY_PER_BLOCK;
>> -									nid++) {
>> -		if (unlikely(nid >= nm_i->max_nid))
>> -			break;
>> -		add_free_nid(sbi, nid, true);
>> -	}
>> -
>> -	if (nm_i->nid_cnt[FREE_NID_LIST] >= MAX_FREE_NIDS)
>> -		goto out;
>> -	i++;
>> -	goto check_empty;
>> -
>> -check_partial:
>> -	i = find_next_zero_bit_le(nm_i->full_nat_bits, nm_i->nat_blocks, i);
>> -	if (i >= nm_i->nat_blocks) {
>> -		disable_nat_bits(sbi, true);
>> -		up_read(&nm_i->nat_tree_lock);
>> -		return -EINVAL;
>> -	}
>> -
>> -	nid = i * NAT_ENTRY_PER_BLOCK;
>> -	page = get_current_nat_page(sbi, nid);
>> -	scan_nat_page(sbi, page, nid);
>> -	f2fs_put_page(page, 1);
>> -
>> -	if (nm_i->nid_cnt[FREE_NID_LIST] < MAX_FREE_NIDS) {
>> -		i++;
>> -		goto check_partial;
>> -	}
>> -out:
>> -	up_read(&nm_i->nat_tree_lock);
>> -	return 0;
>> -}
>> -
>>  static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>>  {
>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>> @@ -1993,21 +1938,6 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>>  
>>  		if (nm_i->nid_cnt[FREE_NID_LIST])
>>  			return;
>> -
>> -		/* try to find free nids with nat_bits */
>> -		if (!scan_nat_bits(sbi) && nm_i->nid_cnt[FREE_NID_LIST])
>> -			return;
>> -	}
>> -
>> -	/* find next valid candidate */
>> -	if (enabled_nat_bits(sbi, NULL)) {
>> -		int idx = find_next_zero_bit_le(nm_i->full_nat_bits,
>> -					nm_i->nat_blocks, 0);
>> -
>> -		if (idx >= nm_i->nat_blocks)
>> -			set_sbi_flag(sbi, SBI_NEED_FSCK);
>> -		else
>> -			nid = idx * NAT_ENTRY_PER_BLOCK;
>>  	}
>>  
>>  	/* readahead nat pages to be scanned */
>> @@ -2590,6 +2520,41 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>>  	return 0;
>>  }
>>  
>> +inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
>> +{
>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>> +	unsigned int i = 0;
>> +	nid_t nid, last_nid;
>> +
>> +	for (i = 0; i < nm_i->nat_blocks; i++) {
>> +		i = find_next_bit_le(nm_i->empty_nat_bits, nm_i->nat_blocks, i);
>> +		if (i >= nm_i->nat_blocks)
>> +			break;
>> +
>> +		set_bit_le(i, nm_i->nat_block_bitmap);
>> +
>> +		nid = i * NAT_ENTRY_PER_BLOCK;
>> +		last_nid = (i + 1) * NAT_ENTRY_PER_BLOCK;
>> +
>> +		for (; nid < last_nid; nid++)
>> +			update_free_nid_bitmap(sbi, nid, true, true);
>> +	}
>> +
>> +	for (i = 0; i < nm_i->nat_blocks; i++) {
>> +		i = find_next_bit_le(nm_i->full_nat_bits, nm_i->nat_blocks, i);
>> +		if (i >= nm_i->nat_blocks)
>> +			break;
>> +
>> +		set_bit_le(i, nm_i->nat_block_bitmap);
>> +
>> +		nid = i * NAT_ENTRY_PER_BLOCK;
>> +		last_nid = (i + 1) * NAT_ENTRY_PER_BLOCK;
>> +
>> +		for (; nid < last_nid; nid++)
>> +			update_free_nid_bitmap(sbi, nid, false, true);
>> +	}
>> +}
>> +
>>  static int init_node_manager(struct f2fs_sb_info *sbi)
>>  {
>>  	struct f2fs_super_block *sb_raw = F2FS_RAW_SUPER(sbi);
>> @@ -2672,6 +2637,10 @@ int init_free_nid_cache(struct f2fs_sb_info *sbi)
>>  
>>  	spin_lock_init(&nm_i->free_nid_lock);
>>  
>> +	/* load free nid status from nat_bits table */
>> +	if (enabled_nat_bits(sbi, NULL))
>> +		load_free_nid_bitmap(sbi);
> 
> This should be done after init_free_nid_cache() to avoid NULL pointer access.

OK, let me move it to build_node_manager.

> And, it shows little bit long latency during mount, so needs to take a look at
> bit ops.

Could you describe your environment please?

Below optimizations may help to improve performance of free nid bitmap building:
a. use __set_bit_le instead of set_bit_le.
b. remove clear_bit_le since bitmap was built as zeroed.

Thanks,

> 
> Thanks,
> 
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.8.2.295.g3f1c1d0
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
