From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: introduce a method to make nat
 journal more fresh
Date: Fri, 9 Mar 2018 22:30:01 +0800
Message-ID: <9d48f1e3-dcb9-fce0-7306-c04c3e9865c1@kernel.org>
References: <1520589197-30137-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1euJ2a-0000yd-7d
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 14:30:36 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1euJ2Y-00BthL-0I
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 14:30:36 +0000
In-Reply-To: <1520589197-30137-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/3/9 17:53, Yunlei He wrote:
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
>  fs/f2fs/node.c | 40 ++++++++++++++++++++++++++--------------
>  fs/f2fs/node.h |  2 ++
>  2 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 177c438..844bdda 100644
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
> @@ -207,9 +207,17 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>  		INIT_LIST_HEAD(&head->set_list);
>  		head->set = set;
>  		head->entry_cnt = 0;
> +		head->to_journal = false;
> +		head->cp_ver = cur_cp_version(F2FS_CKPT(sbi));
>  		f2fs_radix_tree_insert(&nm_i->nat_set_root, set, head);
>  	}
>  
> +	/* journal hit case, try to locate set in journal */
> +	if (!remove_journal && head->to_journal)
> +		head->cp_ver = div_u64(head->cp_ver, head->entry_cnt + 1) *
> +			head->entry_cnt + div_u64(cur_cp_version(F2FS_CKPT(sbi)),

If all entries were flushed into journal in last checkpoint, head->entry_cnt
will always be zero, so as calculating, head->cp_ver will be cur_cp_version().

> +				head->entry_cnt + 1);

How about

head->cp_ver = (NAT_ENTRY_PER_BLOCK - 1) *
		(head->cp_ver / NAT_ENTRY_PER_BLOCK) +
		1 * (cur_cp_version / NAT_ENTRY_PER_BLOCK);

> +
>  	if (get_nat_flag(ne, IS_DIRTY))
>  		goto refresh_list;
>  
> @@ -357,7 +365,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  	nat_set_blkaddr(e, new_blkaddr);
>  	if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
>  		set_nat_flag(e, IS_CHECKPOINTED, false);
> -	__set_nat_cache_dirty(nm_i, e);
> +	__set_nat_cache_dirty(sbi, false, nm_i, e);
>  
>  	/* update fsync_mark if its inode nat entry is still alive */
>  	if (ni->nid != ni->ino)
> @@ -2395,14 +2403,14 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
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
> @@ -2410,7 +2418,9 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
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
> @@ -2458,7 +2468,6 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>  	struct f2fs_journal *journal = curseg->journal;
>  	nid_t start_nid = set->set * NAT_ENTRY_PER_BLOCK;
> -	bool to_journal = true;
>  	struct f2fs_nat_block *nat_blk;
>  	struct nat_entry *ne, *cur;
>  	struct page *page = NULL;
> @@ -2468,11 +2477,14 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
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
> @@ -2488,7 +2500,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  
>  		f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR);
>  
> -		if (to_journal) {
> +		if (set->to_journal) {
>  			offset = lookup_journal_in_cursum(journal,
>  							NAT_JOURNAL, nid, 1);
>  			f2fs_bug_on(sbi, offset < 0);
> @@ -2509,7 +2521,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  		}
>  	}
>  
> -	if (to_journal) {
> +	if (set->to_journal) {
>  		up_write(&curseg->journal_rwsem);
>  	} else {
>  		__update_nat_bits(sbi, start_nid, page);
> @@ -2517,7 +2529,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  	}
>  
>  	/* Allow dirty nats by node block allocation in write_begin */
> -	if (!set->entry_cnt) {
> +	if (!set->to_journal || cpc->reason & CP_UMOUNT) {

if (!set->to_journal && !set->entry_cnt) ?

For CP_UMOUNT case, we will call destroy_node_manager to release nat set cache.

>  		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
>  		kmem_cache_free(nat_entry_set_slab, set);
>  	}
> @@ -2556,7 +2568,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		unsigned idx;
>  		set_idx = setvec[found - 1]->set + 1;
>  		for (idx = 0; idx < found; idx++)
> -			__adjust_nat_entry_set(setvec[idx], &sets,
> +			__adjust_nat_entry_set(sbi, setvec[idx], &sets,
>  						MAX_NAT_JENTRIES(journal));
>  	}
>  
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 081ef0d..76afb24 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -149,6 +149,8 @@ struct nat_entry_set {
>  	struct list_head entry_list;	/* link with dirty nat entries */
>  	nid_t set;			/* set number*/
>  	unsigned int entry_cnt;		/* the # of nat entries in set */
> +	__u64 cp_ver;			/* cp version of this set modify */
> +	bool to_journal;		/* set flush to journal */

How about restructuring as below to reduce memory cost:
	nid_t set;
	unsigned int entry_cnt:9
	unsigned int to_journal:1
	__u64 cp_ver;

Thanks,

>  };
>  
>  struct free_nid {
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
