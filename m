From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v5] f2fs: Separate nat entry mem alloc from
 nat_tree_locks
Date: Thu, 9 Nov 2017 10:04:43 -0800
Message-ID: <20171109180443.GD55844@jaegeuk-macbookpro.roam.corp.google.com>
References: <1510048045-10419-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eCrC9-0006nH-4Z
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Nov 2017 18:04:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eCrC8-0001pS-44
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Nov 2017 18:04:53 +0000
Content-Disposition: inline
In-Reply-To: <1510048045-10419-1-git-send-email-heyunlei@huawei.com>
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

On 11/07, Yunlei He wrote:
> This path separate nat_entry mem alloc from nat_tree_lock,
> which will benefit in some low mem case.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 56 +++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index fef5c68..c6aea33 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -257,22 +257,15 @@ static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid,
>  
>  	if (no_fail) {
>  		new = f2fs_kmem_cache_alloc(nat_entry_slab, GFP_NOFS);
> -		f2fs_radix_tree_insert(&nm_i->nat_root, nid, new);
>  	} else {
>  		new = kmem_cache_alloc(nat_entry_slab, GFP_NOFS);
>  		if (!new)
>  			return NULL;
> -		if (radix_tree_insert(&nm_i->nat_root, nid, new)) {
> -			kmem_cache_free(nat_entry_slab, new);
> -			return NULL;
> -		}
>  	}
>  
>  	memset(new, 0, sizeof(struct nat_entry));
>  	nat_set_nid(new, nid);
>  	nat_reset_flag(new);
> -	list_add_tail(&new->list, &nm_i->nat_entries);
> -	nm_i->nat_cnt++;
>  	return new;
>  }
>  
> @@ -282,17 +275,32 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct nat_entry *e;
>  
> +#ifdef CONFIG_F2FS_CHECK_FS
> +	down_read(&nm_i->nat_tree_lock);
>  	e = __lookup_nat_cache(nm_i, nid);
> -	if (!e) {
> -		e = grab_nat_entry(nm_i, nid, false);
> -		if (e)
> -			node_info_from_raw_nat(&e->ni, ne);
> -	} else {
> +	if (unlikely(e)) {
>  		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
> -				nat_get_blkaddr(e) !=
> -					le32_to_cpu(ne->block_addr) ||
> +			nat_get_blkaddr(e) != le32_to_cpu(ne->block_addr) ||
>  				nat_get_version(e) != ne->version);
> +		up_read(&nm_i->nat_tree_lock);
> +		return;
> +	}
> +	up_read(&nm_i->nat_tree_lock);
> +#endif

Please avoid #ifdef as much as possible, which is totally undesirable.
BTW, it'd be better to give the mallocated e to grab_nat_entry() to consolidate
initialization stuffs?

> +	e = grab_nat_entry(nm_i, nid, false);
> +	down_write(&nm_i->nat_tree_lock);
> +	if (!e)
> +		goto out;
> +
> +	if (!radix_tree_insert(&nm_i->nat_root, nid, e)) {
> +		list_add_tail(&e->list, &nm_i->nat_entries);
> +		nm_i->nat_cnt++;
> +		node_info_from_raw_nat(&e->ni, ne);
> +	} else {
> +		kmem_cache_free(nat_entry_slab, e);
>  	}
> +out:
> +	up_write(&nm_i->nat_tree_lock);
>  }
>  
>  static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
> @@ -300,11 +308,21 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct nat_entry *e;
> +	struct nat_entry *new = grab_nat_entry(nm_i, ni->nid, true);
>  
> +retry:
>  	down_write(&nm_i->nat_tree_lock);
>  	e = __lookup_nat_cache(nm_i, ni->nid);
>  	if (!e) {
> -		e = grab_nat_entry(nm_i, ni->nid, true);
> +		e = new;
> +		if (radix_tree_insert(&nm_i->nat_root, ni->nid, e)) {
> +			up_write(&nm_i->nat_tree_lock);
> +			cond_resched();
> +			goto retry;
> +		}
> +
> +		list_add_tail(&e->list, &nm_i->nat_entries);
> +		nm_i->nat_cnt++;
>  		copy_node_info(&e->ni, ni);
>  		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
>  	} else if (new_blkaddr == NEW_ADDR) {
> @@ -315,6 +333,9 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  		 */
>  		copy_node_info(&e->ni, ni);
>  		f2fs_bug_on(sbi, ni->blk_addr != NULL_ADDR);
> +		kmem_cache_free(nat_entry_slab, new);
> +	} else {
> +		kmem_cache_free(nat_entry_slab, new);
>  	}
>  
>  	/* sanity check */
> @@ -424,9 +445,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
>  	f2fs_put_page(page, 1);
>  cache:
>  	/* cache nat entry */
> -	down_write(&nm_i->nat_tree_lock);
>  	cache_nat_entry(sbi, nid, &ne);
> -	up_write(&nm_i->nat_tree_lock);
>  }
>  
>  /*
> @@ -2375,6 +2394,9 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  		ne = __lookup_nat_cache(nm_i, nid);
>  		if (!ne) {
>  			ne = grab_nat_entry(nm_i, nid, true);
> +			f2fs_radix_tree_insert(&nm_i->nat_root, nid, ne);
> +			list_add_tail(&ne->list, &nm_i->nat_entries);
> +			nm_i->nat_cnt++;
>  			node_info_from_raw_nat(&ne->ni, &raw_ne);
>  		}
>  
> -- 
> 1.9.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
