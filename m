From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix race condition in between free
 nid allocator/initializer
Date: Wed, 22 Mar 2017 14:30:10 +0800
Message-ID: <72715a7c-b07b-a8d9-dfb9-23d758931c9c@huawei.com>
References: <20170321120831.75813-1-yuchao0@huawei.com>
	<20170321161307.GA61126@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqZmz-0001qM-9f
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 06:30:33 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqZmw-0005p9-2q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 06:30:33 +0000
In-Reply-To: <20170321161307.GA61126@jaegeuk.local>
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

On 2017/3/22 0:13, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 03/21, Chao Yu wrote:
>> In below concurrent case, allocated nid can be loaded into free nid cache
>> and be allocated again.
>>
>> Thread A				Thread B
>> - f2fs_create
>>  - f2fs_new_inode
>>   - alloc_nid
>>    - __insert_nid_to_list(ALLOC_NID_LIST)
>> 					- f2fs_balance_fs_bg
>> 					 - build_free_nids
>> 					  - __build_free_nids
>> 					   - scan_nat_page
>> 					    - add_free_nid
>> 					     - __lookup_nat_cache
>>  - f2fs_add_link
>>   - init_inode_metadata
>>    - new_inode_page
>>     - new_node_page
>>      - set_node_addr
>>  - alloc_nid_done
>>   - __remove_nid_from_list(ALLOC_NID_LIST)
>> 					     - __insert_nid_to_list(FREE_NID_LIST)
>>
>> This patch uses build_lock covering free nid allocation and initialization
>> to avoid this race condition.
> 
> I have a concern about mutex contention.

Alright, till now I haven't caught any other race problem, so I think it would
be OK as well.

> How about this?

I change it a bit to avoid unneeded radix-tree operation, see below.

> 
> ---
>  fs/f2fs/node.c | 60 ++++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 347aa30ef0cf..25bc47087f91 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1759,40 +1759,64 @@ static void __remove_nid_from_list(struct f2fs_sb_info *sbi,
>  static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> -	struct free_nid *i;
> +	struct free_nid *i, *e;
>  	struct nat_entry *ne;
> -	int err;
> +	int err = -EINVAL;
> +	bool ret = false;
>  
>  	/* 0 nid should not be used */
>  	if (unlikely(nid == 0))
>  		return false;
>  
> -	if (build) {
> -		/* do not add allocated nids */
> -		ne = __lookup_nat_cache(nm_i, nid);
> -		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
> -				nat_get_blkaddr(ne) != NULL_ADDR))
> -			return false;
> -	}
> -
>  	i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
>  	i->nid = nid;
>  	i->state = NID_NEW;
>  
> -	if (radix_tree_preload(GFP_NOFS)) {
> -		kmem_cache_free(free_nid_slab, i);
> -		return true;
> -	}
> +	if (radix_tree_preload(GFP_NOFS))
> +		goto err;
>  
>  	spin_lock(&nm_i->nid_list_lock);
> +
> +	if (build) {
> +		/*
> +		 *   Thread A             Thread B
> +		 *  - f2fs_create
> +		 *   - f2fs_new_inode
> +		 *    - alloc_nid
> +		 *     - __insert_nid_to_list(ALLOC_NID_LIST)
> +		 *                     - f2fs_balance_fs_bg
> +		 *                      - build_free_nids
> +		 *                       - __build_free_nids
> +		 *                        - scan_nat_page
> +		 *                         - add_free_nid
> +		 *                          - __lookup_nat_cache
> +		 *  - f2fs_add_link
> +		 *   - init_inode_metadata
> +		 *    - new_inode_page
> +		 *     - new_node_page
> +		 *      - set_node_addr
> +		 *  - alloc_nid_done
> +		 *   - __remove_nid_from_list(ALLOC_NID_LIST)
> +		 *                         - __insert_nid_to_list(FREE_NID_LIST)
> +		 */
> +		ne = __lookup_nat_cache(nm_i, nid);
> +		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
> +				nat_get_blkaddr(ne) != NULL_ADDR))
> +			goto err_out;
> +
> +		e = __lookup_free_nid_list(nm_i, nid);
> +		if (e && e->state == NID_ALLOC)

		e = __lookup_free_nid_list(nm_i, nid);
		if (e) {
			if (e->state == NID_NEW)
				ret = true;
			goto err_out;
		}

Thanks,

> +			goto err_out;
> +	}
> +	ret = true;
>  	err = __insert_nid_to_list(sbi, i, FREE_NID_LIST, true);
> +err_out:
>  	spin_unlock(&nm_i->nid_list_lock);
>  	radix_tree_preload_end();
> -	if (err) {
> +err:
> +	if (err)
>  		kmem_cache_free(free_nid_slab, i);
> -		return true;
> -	}
> -	return true;
> +	return ret;
>  }
>  
>  static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
