From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: introduce a method to make nat
 journal more fresh
Date: Fri, 16 Mar 2018 16:49:09 +0800
Message-ID: <e5b8cdfa-6ca2-fb1b-04fd-d595d1812741@huawei.com>
References: <1521009209-3956-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ewl3H-0002oZ-DH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Mar 2018 08:49:27 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ewl3E-00EtDK-7H
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Mar 2018 08:49:27 +0000
In-Reply-To: <1521009209-3956-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com



On 2018/3/14 14:33, Yunlei He wrote:
> This patch introduce a method to make nat journal more fresh:
> i.  sort set list using dirty entry number and cp version
>     average value.
> ii. if meet with cache hit, update average version valus with
>     current cp version.
> 
> With this patch, newly modified nat set will flush to journal,
> and flush old nat set with same dirty entry number to nat area.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 45 ++++++++++++++++++++++++++-------------------
>  fs/f2fs/node.h |  4 +++-
>  2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 177c438..74f6079 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -193,8 +193,8 @@ static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *e)
>  	__free_nat_entry(e);
>  }
>  
> -static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> -						struct nat_entry *ne)
> +static void __set_nat_cache_dirty(struct f2fs_sb_info *sbi, bool remove_journal,
> +			struct f2fs_nm_info *nm_i, struct nat_entry *ne)
>  {
>  	nid_t set = NAT_BLOCK_OFFSET(ne->ni.nid);
>  	struct nat_entry_set *head;
> @@ -207,9 +207,15 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>  		INIT_LIST_HEAD(&head->set_list);
>  		head->set = set;
>  		head->entry_cnt = 0;
> +		head->cp_ver = 0;
>  		f2fs_radix_tree_insert(&nm_i->nat_set_root, set, head);
>  	}
>  
> +	/* journal hit case, try to locate set in journal */
> +	if (!remove_journal && head->entry_cnt <= NAT_JOURNAL_ENTRIES)
> +		head->cp_ver += div_u64(cur_cp_version(F2FS_CKPT(sbi)),
> +							NAT_JOURNAL_ENTRIES);
> +
>  	if (get_nat_flag(ne, IS_DIRTY))
>  		goto refresh_list;

	else {
		update head version here?
	}

>  
> @@ -217,10 +223,7 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>  	head->entry_cnt++;
>  	set_nat_flag(ne, IS_DIRTY, true);
>  refresh_list:
> -	if (nat_get_blkaddr(ne) == NEW_ADDR)
> -		list_del_init(&ne->list);
> -	else
> -		list_move_tail(&ne->list, &head->entry_list);
> +	list_move_tail(&ne->list, &head->entry_list);

For NEW_ADDR case, why we need to track this nat entry in entry_list?

>  }
>  
>  static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> @@ -357,7 +360,8 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  	nat_set_blkaddr(e, new_blkaddr);
>  	if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
>  		set_nat_flag(e, IS_CHECKPOINTED, false);
> -	__set_nat_cache_dirty(nm_i, e);
> +	if (new_blkaddr != NEW_ADDR)
> +		__set_nat_cache_dirty(sbi, false, nm_i, e);
>  
>  	/* update fsync_mark if its inode nat entry is still alive */
>  	if (ni->nid != ni->ino)
> @@ -2395,14 +2399,14 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  			spin_unlock(&nm_i->nid_list_lock);
>  		}
>  
> -		__set_nat_cache_dirty(nm_i, ne);
> +		__set_nat_cache_dirty(sbi, true, nm_i, ne);
>  	}
>  	update_nats_in_cursum(journal, -i);
>  	up_write(&curseg->journal_rwsem);
>  }
>  
> -static void __adjust_nat_entry_set(struct nat_entry_set *nes,
> -						struct list_head *head, int max)
> +static void __adjust_nat_entry_set(struct f2fs_sb_info *sbi,
> +		struct nat_entry_set *nes, struct list_head *head, int max)
>  {
>  	struct nat_entry_set *cur;
>  
> @@ -2410,7 +2414,9 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
>  		goto add_out;
>  
>  	list_for_each_entry(cur, head, set_list) {
> -		if (cur->entry_cnt >= nes->entry_cnt) {
> +		if (cur->entry_cnt > nes->entry_cnt ||
> +			(cur->entry_cnt == nes->entry_cnt &&
> +			cur->cp_ver < nes->cp_ver)) {
>  			list_add(&nes->set_list, cur->set_list.prev);
>  			return;
>  		}
> @@ -2458,7 +2464,6 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>  	struct f2fs_journal *journal = curseg->journal;
>  	nid_t start_nid = set->set * NAT_ENTRY_PER_BLOCK;
> -	bool to_journal = true;
>  	struct f2fs_nat_block *nat_blk;
>  	struct nat_entry *ne, *cur;
>  	struct page *page = NULL;
> @@ -2468,11 +2473,14 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  	 * #1, flush nat entries to journal in current hot data summary block.
>  	 * #2, flush nat entries to nat page.
>  	 */
> +
> +	set->to_journal = true;
> +
>  	if (enabled_nat_bits(sbi, cpc) ||
>  		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
> -		to_journal = false;
> +		set->to_journal = false;
>  
> -	if (to_journal) {
> +	if (set->to_journal) {
>  		down_write(&curseg->journal_rwsem);
>  	} else {
>  		page = get_next_nat_page(sbi, start_nid);
> @@ -2488,7 +2496,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  
>  		f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR);
>  
> -		if (to_journal) {
> +		if (set->to_journal) {
>  			offset = lookup_journal_in_cursum(journal,
>  							NAT_JOURNAL, nid, 1);
>  			f2fs_bug_on(sbi, offset < 0);
> @@ -2509,7 +2517,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  		}
>  	}
>  
> -	if (to_journal) {
> +	if (set->to_journal) {
>  		up_write(&curseg->journal_rwsem);
>  	} else {
>  		__update_nat_bits(sbi, start_nid, page);
> @@ -2517,7 +2525,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  	}
>  
>  	/* Allow dirty nats by node block allocation in write_begin */
> -	if (!set->entry_cnt) {
> +	if (!set->to_journal) {

if (!set->to_journal && !set->entry_cnt) ?

Thanks,

>  		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
>  		kmem_cache_free(nat_entry_set_slab, set);
>  	}
> @@ -2556,7 +2564,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		unsigned idx;
>  		set_idx = setvec[found - 1]->set + 1;
>  		for (idx = 0; idx < found; idx++)
> -			__adjust_nat_entry_set(setvec[idx], &sets,
> +			__adjust_nat_entry_set(sbi, setvec[idx], &sets,
>  						MAX_NAT_JENTRIES(journal));
>  	}
>  
> @@ -2565,7 +2573,6 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		__flush_nat_entry_set(sbi, set, cpc);
>  
>  	up_write(&nm_i->nat_tree_lock);
> -	/* Allow dirty nats by node block allocation in write_begin */
>  }
>  
>  static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 081ef0d..3cf9c8b6 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -148,7 +148,9 @@ struct nat_entry_set {
>  	struct list_head set_list;	/* link with other nat sets */
>  	struct list_head entry_list;	/* link with dirty nat entries */
>  	nid_t set;			/* set number*/
> -	unsigned int entry_cnt;		/* the # of nat entries in set */
> +	unsigned int entry_cnt:9;	/* the # of nat entries in set */
> +	unsigned int to_journal:1;	/* set flush to journal */
> +	__u64 cp_ver;			/* cp version of this set modify */
>  };
>  
>  struct free_nid {
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
