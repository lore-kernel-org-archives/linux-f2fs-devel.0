From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: fix to account total free nid correctly
Date: Thu, 17 Nov 2016 17:42:09 +0800
Message-ID: <1baaeb63-4557-a209-3f6b-9090f44345e1@huawei.com>
References: <20161114112456.113074-1-yuchao0@huawei.com>
	<20161114204557.GA28366@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c7JDR-0003H4-HC
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 09:42:45 +0000
Received: from [58.251.152.179] (helo=szxga05-in.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c7JDP-0004x8-1h
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 09:42:45 +0000
In-Reply-To: <20161114204557.GA28366@jaegeuk>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



On 2016/11/15 4:45, Jaegeuk Kim wrote:
> On Mon, Nov 14, 2016 at 07:24:56PM +0800, Chao Yu wrote:
>> Thread A		Thread B		Thread C
>> - f2fs_create
>>  - f2fs_new_inode
>>   - f2fs_lock_op
>>    - alloc_nid
>>     alloc last nid
>>   - f2fs_unlock_op
>> 			- f2fs_create
>> 			 - f2fs_new_inode
>> 			  - f2fs_lock_op
>> 			   - alloc_nid
>> 			    as node count still not
>> 			    be increased, we will
>> 			    loop in alloc_nid
>> 						- f2fs_write_node_pages
>> 						 - f2fs_balance_fs_bg
>> 						  - f2fs_sync_fs
>> 						   - write_checkpoint
>> 						    - block_operations
>> 						     - f2fs_lock_all
>>  - f2fs_lock_op
>>
>> While creating new inode, we do not allocate and account nid atomically,
>> so that when there is almost no free nids left, we may encounter deadloop
>> like above stack.
>>
>> In order to avoid that, add nm_i::free_nid_cnt for accounting free nids
>> and do nid allocation atomically during node creation.
>
> How about using nm_i::avaiable_nids for this?
> It seems that we don't need both of variables at the same time.
>
> Thanks,
>
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h |  1 +
>>  fs/f2fs/node.c | 19 +++++++++++++++----
>>  2 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 6de1fbf..9de6f20 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -551,6 +551,7 @@ struct f2fs_nm_info {
>>  	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
>>  	struct list_head nid_list[MAX_NID_LIST];/* lists for free nids */
>>  	unsigned int nid_cnt[MAX_NID_LIST];	/* the number of free node id */
>> +	unsigned int free_nid_cnt;	/* the number of total free nid */
>>  	spinlock_t nid_list_lock;	/* protect nid lists ops */
>>  	struct mutex build_lock;	/* lock for build free nids */
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index d58438f..e412d0e 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1885,11 +1885,13 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>>  		return false;
>>  	}
>>  #endif
>> -	if (unlikely(sbi->total_valid_node_count + 1 > nm_i->available_nids))
>> -		return false;
>> -
>>  	spin_lock(&nm_i->nid_list_lock);
>>
>> +	if (unlikely(nm_i->free_nid_cnt == 0)) {
>> +		spin_unlock(&nm_i->nid_list_lock);
>> +		return false;
>> +	}
>> +
>>  	/* We should not use stale free nids created by build_free_nids */
>>  	if (nm_i->nid_cnt[FREE_NID_LIST] && !on_build_free_nids(nm_i)) {
>>  		f2fs_bug_on(sbi, list_empty(&nm_i->nid_list[FREE_NID_LIST]));
>> @@ -1900,6 +1902,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>>  		__remove_nid_from_list(sbi, i, FREE_NID_LIST, true);
>>  		i->state = NID_ALLOC;
>>  		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
>> +		nm_i->free_nid_cnt--;
>>  		spin_unlock(&nm_i->nid_list_lock);
>>  		return true;
>>  	}
>> @@ -1951,6 +1954,9 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
>>  		i->state = NID_NEW;
>>  		__insert_nid_to_list(sbi, i, FREE_NID_LIST, false);
>>  	}
>> +
>> +	nm_i->free_nid_cnt++;
>> +
>>  	spin_unlock(&nm_i->nid_list_lock);
>>
>>  	if (need_free)
>> @@ -2222,8 +2228,12 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>  		raw_nat_from_node_info(raw_ne, &ne->ni);
>>  		nat_reset_flag(ne);
>>  		__clear_nat_cache_dirty(NM_I(sbi), ne);
>> -		if (nat_get_blkaddr(ne) == NULL_ADDR)
>> +		if (nat_get_blkaddr(ne) == NULL_ADDR) {
>>  			add_free_nid(sbi, nid, false);
>> +			spin_lock(&NM_I(sbi)->nid_list_lock);
>> +			NM_I(sbi)->free_nid_cnt++;
Hi all,
	Here, we should consider clean NULL_ADDR nat entry in journal.

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dcfab29..b22ecb0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -158,6 +158,13 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
         if (get_nat_flag(ne, IS_DIRTY))
                 return;

+       if (ne->ni.blk_addr == NULL_ADDR) {
+               spin_lock(&nm_i->free_nid_list_lock);
+               nm_i->available_nids--;
+               spin_unlock(&nm_i->free_nid_list_lock);
+       }
+
+

Thanks.

>> +			spin_unlock(&NM_I(sbi)->nid_list_lock);
>> +		}
>>  	}
>>
>>  	if (to_journal)
>> @@ -2302,6 +2312,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>>  	nm_i->nid_cnt[FREE_NID_LIST] = 0;
>>  	nm_i->nid_cnt[ALLOC_NID_LIST] = 0;
>>  	nm_i->nat_cnt = 0;
>> +	nm_i->free_nid_cnt = nm_i->available_nids - sbi->total_valid_node_count;
>>  	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
>>  	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
>>  	nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
>> --
>> 2.8.2.311.gee88674
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> .
>


------------------------------------------------------------------------------
