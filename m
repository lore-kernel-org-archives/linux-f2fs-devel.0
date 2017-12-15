From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: uses the same naming scheme for struct
 nat_entry and f2fs_nat_entry
Date: Thu, 14 Dec 2017 18:10:34 -0800
Message-ID: <20171215021034.GG35234@jaegeuk-macbookpro.roam.corp.google.com>
References: <1513224017-20296-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ePfST-000193-Pp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 02:10:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ePfSS-0000qG-DZ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 02:10:41 +0000
Content-Disposition: inline
In-Reply-To: <1513224017-20296-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: ning.jia@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

Thank you for the work, however, when considering backporting effort, this would
be likely to generate somewhat merge conflicts.

Thanks,

On 12/14, Yunlei He wrote:
> Uses the same naming scheme for struct nat_entry and f2fs_nat_entry
> as in function __flush_nat_entry_set. No functional change.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 128 ++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index a9c340e..5645967 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -155,9 +155,9 @@ static struct nat_entry *__alloc_nat_entry(nid_t nid, bool no_fail)
>  	return new;
>  }
>  
> -static void __free_nat_entry(struct nat_entry *e)
> +static void __free_nat_entry(struct nat_entry *ne)
>  {
> -	kmem_cache_free(nat_entry_slab, e);
> +	kmem_cache_free(nat_entry_slab, ne);
>  }
>  
>  /* must be locked by nat_tree_lock */
> @@ -187,12 +187,12 @@ static unsigned int __gang_lookup_nat_cache(struct f2fs_nm_info *nm_i,
>  	return radix_tree_gang_lookup(&nm_i->nat_root, (void **)ep, start, nr);
>  }
>  
> -static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *e)
> +static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *ne)
>  {
> -	list_del(&e->list);
> -	radix_tree_delete(&nm_i->nat_root, nat_get_nid(e));
> +	list_del(&ne->list);
> +	radix_tree_delete(&nm_i->nat_root, nat_get_nid(ne));
>  	nm_i->nat_cnt--;
> -	__free_nat_entry(e);
> +	__free_nat_entry(ne);
>  }
>  
>  static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> @@ -244,14 +244,14 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
>  int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> -	struct nat_entry *e;
> +	struct nat_entry *ne;
>  	bool need = false;
>  
>  	down_read(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, nid);
> -	if (e) {
> -		if (!get_nat_flag(e, IS_CHECKPOINTED) &&
> -				!get_nat_flag(e, HAS_FSYNCED_INODE))
> +	ne = __lookup_nat_cache(nm_i, nid);
> +	if (ne) {
> +		if (!get_nat_flag(ne, IS_CHECKPOINTED) &&
> +				!get_nat_flag(ne, HAS_FSYNCED_INODE))
>  			need = true;
>  	}
>  	up_read(&nm_i->nat_tree_lock);
> @@ -261,12 +261,12 @@ int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
>  bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> -	struct nat_entry *e;
> +	struct nat_entry *ne;
>  	bool is_cp = true;
>  
>  	down_read(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, nid);
> -	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
> +	ne = __lookup_nat_cache(nm_i, nid);
> +	if (ne && !get_nat_flag(ne, IS_CHECKPOINTED))
>  		is_cp = false;
>  	up_read(&nm_i->nat_tree_lock);
>  	return is_cp;
> @@ -275,14 +275,14 @@ bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
>  bool need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> -	struct nat_entry *e;
> +	struct nat_entry *ne;
>  	bool need_update = true;
>  
>  	down_read(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, ino);
> -	if (e && get_nat_flag(e, HAS_LAST_FSYNC) &&
> -			(get_nat_flag(e, IS_CHECKPOINTED) ||
> -			 get_nat_flag(e, HAS_FSYNCED_INODE)))
> +	ne = __lookup_nat_cache(nm_i, ino);
> +	if (ne && get_nat_flag(ne, HAS_LAST_FSYNC) &&
> +			(get_nat_flag(ne, IS_CHECKPOINTED) ||
> +			 get_nat_flag(ne, HAS_FSYNCED_INODE)))
>  		need_update = false;
>  	up_read(&nm_i->nat_tree_lock);
>  	return need_update;
> @@ -290,26 +290,26 @@ bool need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
>  
>  /* must be locked by nat_tree_lock */
>  static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
> -						struct f2fs_nat_entry *ne)
> +						struct f2fs_nat_entry *raw_ne)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> -	struct nat_entry *new, *e;
> +	struct nat_entry *new, *ne;
>  
>  	new = __alloc_nat_entry(nid, false);
>  	if (!new)
>  		return;
>  
>  	down_write(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, nid);
> -	if (!e)
> -		e = __init_nat_entry(nm_i, new, ne, false);
> +	ne = __lookup_nat_cache(nm_i, nid);
> +	if (!ne)
> +		ne = __init_nat_entry(nm_i, new, raw_ne, false);
>  	else
> -		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
> -				nat_get_blkaddr(e) !=
> -					le32_to_cpu(ne->block_addr) ||
> -				nat_get_version(e) != ne->version);
> +		f2fs_bug_on(sbi, nat_get_ino(ne) != le32_to_cpu(raw_ne->ino) ||
> +				nat_get_blkaddr(ne) !=
> +					le32_to_cpu(raw_ne->block_addr) ||
> +				nat_get_version(ne) != raw_ne->version);
>  	up_write(&nm_i->nat_tree_lock);
> -	if (e != new)
> +	if (ne != new)
>  		__free_nat_entry(new);
>  }
>  
> @@ -317,14 +317,14 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  			block_t new_blkaddr, bool fsync_done)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> -	struct nat_entry *e;
> +	struct nat_entry *ne;
>  	struct nat_entry *new = __alloc_nat_entry(ni->nid, true);
>  
>  	down_write(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, ni->nid);
> -	if (!e) {
> -		e = __init_nat_entry(nm_i, new, NULL, true);
> -		copy_node_info(&e->ni, ni);
> +	ne = __lookup_nat_cache(nm_i, ni->nid);
> +	if (!ne) {
> +		ne = __init_nat_entry(nm_i, new, NULL, true);
> +		copy_node_info(&ne->ni, ni);
>  		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
>  	} else if (new_blkaddr == NEW_ADDR) {
>  		/*
> @@ -332,42 +332,42 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  		 * previous nat entry can be remained in nat cache.
>  		 * So, reinitialize it with new information.
>  		 */
> -		copy_node_info(&e->ni, ni);
> +		copy_node_info(&ne->ni, ni);
>  		f2fs_bug_on(sbi, ni->blk_addr != NULL_ADDR);
>  	}
>  	/* let's free early to reduce memory consumption */
> -	if (e != new)
> +	if (ne != new)
>  		__free_nat_entry(new);
>  
>  	/* sanity check */
> -	f2fs_bug_on(sbi, nat_get_blkaddr(e) != ni->blk_addr);
> -	f2fs_bug_on(sbi, nat_get_blkaddr(e) == NULL_ADDR &&
> +	f2fs_bug_on(sbi, nat_get_blkaddr(ne) != ni->blk_addr);
> +	f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NULL_ADDR &&
>  			new_blkaddr == NULL_ADDR);
> -	f2fs_bug_on(sbi, nat_get_blkaddr(e) == NEW_ADDR &&
> +	f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR &&
>  			new_blkaddr == NEW_ADDR);
> -	f2fs_bug_on(sbi, nat_get_blkaddr(e) != NEW_ADDR &&
> -			nat_get_blkaddr(e) != NULL_ADDR &&
> +	f2fs_bug_on(sbi, nat_get_blkaddr(ne) != NEW_ADDR &&
> +			nat_get_blkaddr(ne) != NULL_ADDR &&
>  			new_blkaddr == NEW_ADDR);
>  
>  	/* increment version no as node is removed */
> -	if (nat_get_blkaddr(e) != NEW_ADDR && new_blkaddr == NULL_ADDR) {
> -		unsigned char version = nat_get_version(e);
> -		nat_set_version(e, inc_node_version(version));
> +	if (nat_get_blkaddr(ne) != NEW_ADDR && new_blkaddr == NULL_ADDR) {
> +		unsigned char version = nat_get_version(ne);
> +		nat_set_version(ne, inc_node_version(version));
>  	}
>  
>  	/* change address */
> -	nat_set_blkaddr(e, new_blkaddr);
> +	nat_set_blkaddr(ne, new_blkaddr);
>  	if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
> -		set_nat_flag(e, IS_CHECKPOINTED, false);
> -	__set_nat_cache_dirty(nm_i, e);
> +		set_nat_flag(ne, IS_CHECKPOINTED, false);
> +	__set_nat_cache_dirty(nm_i, ne);
>  
>  	/* update fsync_mark if its inode nat entry is still alive */
>  	if (ni->nid != ni->ino)
> -		e = __lookup_nat_cache(nm_i, ni->ino);
> -	if (e) {
> +		ne = __lookup_nat_cache(nm_i, ni->ino);
> +	if (ne) {
>  		if (fsync_done && ni->nid == ni->ino)
> -			set_nat_flag(e, HAS_FSYNCED_INODE, true);
> -		set_nat_flag(e, HAS_LAST_FSYNC, fsync_done);
> +			set_nat_flag(ne, HAS_FSYNCED_INODE, true);
> +		set_nat_flag(ne, HAS_LAST_FSYNC, fsync_done);
>  	}
>  	up_write(&nm_i->nat_tree_lock);
>  }
> @@ -402,8 +402,8 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
>  	nid_t start_nid = START_NID(nid);
>  	struct f2fs_nat_block *nat_blk;
>  	struct page *page = NULL;
> -	struct f2fs_nat_entry ne;
> -	struct nat_entry *e;
> +	struct f2fs_nat_entry raw_ne;
> +	struct nat_entry *ne;
>  	pgoff_t index;
>  	int i;
>  
> @@ -411,23 +411,23 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
>  
>  	/* Check nat cache */
>  	down_read(&nm_i->nat_tree_lock);
> -	e = __lookup_nat_cache(nm_i, nid);
> -	if (e) {
> -		ni->ino = nat_get_ino(e);
> -		ni->blk_addr = nat_get_blkaddr(e);
> -		ni->version = nat_get_version(e);
> +	ne = __lookup_nat_cache(nm_i, nid);
> +	if (ne) {
> +		ni->ino = nat_get_ino(ne);
> +		ni->blk_addr = nat_get_blkaddr(ne);
> +		ni->version = nat_get_version(ne);
>  		up_read(&nm_i->nat_tree_lock);
>  		return;
>  	}
>  
> -	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
> +	memset(&raw_ne, 0, sizeof(struct f2fs_nat_entry));
>  
>  	/* Check current segment summary */
>  	down_read(&curseg->journal_rwsem);
>  	i = lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
>  	if (i >= 0) {
> -		ne = nat_in_journal(journal, i);
> -		node_info_from_raw_nat(ni, &ne);
> +		raw_ne = nat_in_journal(journal, i);
> +		node_info_from_raw_nat(ni, &raw_ne);
>  	}
>  	up_read(&curseg->journal_rwsem);
>  	if (i >= 0) {
> @@ -441,12 +441,12 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
>  
>  	page = get_meta_page(sbi, index);
>  	nat_blk = (struct f2fs_nat_block *)page_address(page);
> -	ne = nat_blk->entries[nid - start_nid];
> -	node_info_from_raw_nat(ni, &ne);
> +	raw_ne = nat_blk->entries[nid - start_nid];
> +	node_info_from_raw_nat(ni, &raw_ne);
>  	f2fs_put_page(page, 1);
>  cache:
>  	/* cache nat entry */
> -	cache_nat_entry(sbi, nid, &ne);
> +	cache_nat_entry(sbi, nid, &raw_ne);
>  }
>  
>  /*
> -- 
> 1.9.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
