From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH V2] f2fs: introduce free nid bitmap
Date: Mon, 27 Feb 2017 11:11:21 +0800
Message-ID: <78bcc379-08b5-063f-d2a5-ce1740499a71@huawei.com>
References: <20170223025349.104160-1-yuchao0@huawei.com>
	<c13a289e-5d46-70f3-5f49-eb88864bfa3d@huawei.com>
	<20170225190255.GD51627@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciBjK-0007BD-Hu
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 03:12:06 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciBjJ-0002rP-BK
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 03:12:06 +0000
In-Reply-To: <20170225190255.GD51627@jaegeuk.local>
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

On 2017/2/26 3:02, Jaegeuk Kim wrote:
> On 02/25, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> I added below diff code into this patch in order to fix incorrectly nid status
>> updating to reduce large latency of generic/251 in fstest, could you help to
>> review code below?
> 
> Understand the problem, and how about this?
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 52db02396878..83b305689913 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1765,7 +1765,7 @@ static void __remove_nid_from_list(struct f2fs_sb_info *sbi,
>  		radix_tree_delete(&nm_i->free_nid_root, i->nid);
>  }
>  
> -static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
> +static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct free_nid *i;
> @@ -1774,14 +1774,14 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>  
>  	/* 0 nid should not be used */
>  	if (unlikely(nid == 0))
> -		return 0;
> +		return false;
>  
>  	if (build) {
>  		/* do not add allocated nids */
>  		ne = __lookup_nat_cache(nm_i, nid);
>  		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
>  				nat_get_blkaddr(ne) != NULL_ADDR))
> -			return 0;
> +			return false;
>  	}
>  
>  	i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
> @@ -1790,7 +1790,7 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>  
>  	if (radix_tree_preload(GFP_NOFS)) {
>  		kmem_cache_free(free_nid_slab, i);
> -		return 0;
> +		return false;

If there is no memory, actually current free nid is still available, we need to
return true (or other value -1?), then caller can set free_nid_bitmap correctly.

>  	}
>  
>  	spin_lock(&nm_i->nid_list_lock);
> @@ -1799,9 +1799,9 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>  	radix_tree_preload_end();
>  	if (err) {
>  		kmem_cache_free(free_nid_slab, i);
> -		return 0;
> +		return false;

ditto.

Thanks,

>  	}
> -	return 1;
> +	return true;
>  }
>  
>  static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
> @@ -1851,6 +1851,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>  	i = start_nid % NAT_ENTRY_PER_BLOCK;
>  
>  	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
> +		bool freed = false;
>  
>  		if (unlikely(start_nid >= nm_i->max_nid))
>  			break;
> @@ -1858,8 +1859,8 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>  		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
>  		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
>  		if (blk_addr == NULL_ADDR)
> -			add_free_nid(sbi, start_nid, true);
> -		update_free_nid_bitmap(sbi, start_nid, blk_addr == NULL_ADDR);
> +			freed = add_free_nid(sbi, start_nid, true);
> +		update_free_nid_bitmap(sbi, start_nid, freed);
>  	}
>  }
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
