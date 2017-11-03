From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: Separate nat entry mem alloc from
 nat_tree_locks
Date: Fri, 3 Nov 2017 23:04:13 +0800
Message-ID: <499d2c85-47df-481c-aa34-1f3259370e8a@kernel.org>
References: <1509705198-9457-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1eAdWU-00017S-Fc
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 15:04:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eAdWT-0001wq-Ds
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 15:04:42 +0000
In-Reply-To: <1509705198-9457-1-git-send-email-heyunlei@huawei.com>
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
Cc: morgan.wang@huawei.com

On 2017/11/3 18:33, Yunlei He wrote:
> This path separate nat_entry mem alloc from nat_tree_lock,
> which will benefit in some low mem case.>
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 48 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index fef5c68..5adefea 100644
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
> @@ -281,18 +274,36 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct nat_entry *e;
> +	struct nat_entry *e_new = grab_nat_entry(nm_i, nid, false);

rename e_new to new to keep the coding style?

>  
> +	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);

__GFP_NOFAIL make preloading not fail, so if our optimization scenario
aimed at low memory, what about avoiding preload?

> +	down_write(&nm_i->nat_tree_lock);
>  	e = __lookup_nat_cache(nm_i, nid);
>  	if (!e) {
> -		e = grab_nat_entry(nm_i, nid, false);
> -		if (e)
> -			node_info_from_raw_nat(&e->ni, ne);
> +		if (!e_new) {
> +			up_write(&nm_i->nat_tree_lock);

move this to bottom?

> +			return;

goto out;

> +		}
> +
> +		if (radix_tree_insert(&nm_i->nat_root, nid, e_new)) {
> +			kmem_cache_free(nat_entry_slab, e_new);
> +			radix_tree_preload_end();> +			up_write(&nm_i->nat_tree_lock)> +			return;

ditto

> +		}
> +
> +		radix_tree_preload_end();> +		list_add_tail(&e_new->list, &nm_i->nat_entries);
> +		nm_i->nat_cnt++;
> +		node_info_from_raw_nat(&e_new->ni, ne);
>  	} else {
>  		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
>  				nat_get_blkaddr(e) !=
>  					le32_to_cpu(ne->block_addr) ||
>  				nat_get_version(e) != ne->version);
> +		kmem_cache_free(nat_entry_slab, e_new);
>  	}

out:

> +	up_write(&nm_i->nat_tree_lock);>  }
>  
>  static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
> @@ -300,13 +311,17 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct nat_entry *e;
> +	struct nat_entry *e_new = grab_nat_entry(nm_i, ni->nid, true);
>  
>  	down_write(&nm_i->nat_tree_lock);
>  	e = __lookup_nat_cache(nm_i, ni->nid);
>  	if (!e) {
> -		e = grab_nat_entry(nm_i, ni->nid, true);
> -		copy_node_info(&e->ni, ni);

e = new

> +		f2fs_radix_tree_insert(&nm_i->nat_root, ni->nid, e_new);
> +		list_add_tail(&e_new->list, &nm_i->nat_entries);
> +		nm_i->nat_cnt++;
> +		copy_node_info(&e_new->ni, ni);
>  		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
> +		e = e_new;
>  	} else if (new_blkaddr == NEW_ADDR) {
>  		/*
>  		 * when nid is reallocated,
> @@ -315,7 +330,9 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  		 */
>  		copy_node_info(&e->ni, ni);
>  		f2fs_bug_on(sbi, ni->blk_addr != NULL_ADDR);
> -	}
> +		kmem_cache_free(nat_entry_slab, e_new);
> +	} else

} else {
	kmem_cache_free(nat_entry_slab, e_new);
}

Thanks,

> +		kmem_cache_free(nat_entry_slab, e_new);
>  
>  	/* sanity check */
>  	f2fs_bug_on(sbi, nat_get_blkaddr(e) != ni->blk_addr);
> @@ -424,9 +441,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
>  	f2fs_put_page(page, 1);
>  cache:
>  	/* cache nat entry */
> -	down_write(&nm_i->nat_tree_lock);
>  	cache_nat_entry(sbi, nid, &ne);
> -	up_write(&nm_i->nat_tree_lock);
>  }
>  
>  /*
> @@ -2375,6 +2390,9 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>  		ne = __lookup_nat_cache(nm_i, nid);
>  		if (!ne) {
>  			ne = grab_nat_entry(nm_i, nid, true);
> +			f2fs_radix_tree_insert(&nm_i->nat_root, nid, ne);
> +			list_add_tail(&ne->list, &nm_i->nat_entries);
> +			nm_i->nat_cnt++;
>  			node_info_from_raw_nat(&ne->ni, &raw_ne);
>  		}
>  
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
