From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add bug on back during flush nat
 entries
Date: Tue, 13 Feb 2018 18:04:33 +0800
Message-ID: <bbfed80e-4c8d-27cb-4e15-e20efa0fa588@huawei.com>
References: <1518406954-29047-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1elXRy-0005hD-V4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Feb 2018 10:04:34 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1elXRx-0005GL-Ge
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Feb 2018 10:04:34 +0000
In-Reply-To: <1518406954-29047-1-git-send-email-heyunlei@huawei.com>
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

On 2018/2/12 11:42, Yunlei He wrote:
> This patch add two bug on check back during flush nat entries,
> nat_tree_lock will prevent race from node block allocation
> in write_begin.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 833b46b..ced986d 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2519,10 +2519,9 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  	}
>  
>  	/* Allow dirty nats by node block allocation in write_begin */
> -	if (!set->entry_cnt) {
> -		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
> -		kmem_cache_free(nat_entry_set_slab, set);

During checkpoint, We allow buffered write which needs nid allocation, if we
rollback the codes here, we may encounter the BUG_ON?

Thanks,

> -	}
> +	f2fs_bug_on(sbi, set->entry_cnt);
> +	radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
> +	kmem_cache_free(nat_entry_set_slab, set);
>  }
>  
>  /*
> @@ -2566,8 +2565,8 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	list_for_each_entry_safe(set, tmp, &sets, set_list)
>  		__flush_nat_entry_set(sbi, set, cpc);
>  
> +	f2fs_bug_on(sbi, nm_i->dirty_nat_cnt);
>  	up_write(&nm_i->nat_tree_lock);
> -	/* Allow dirty nats by node block allocation in write_begin */
>  }
>  
>  static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
