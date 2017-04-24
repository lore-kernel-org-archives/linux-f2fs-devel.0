From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: seperate read nat page from
	nat_tree_lock
Date: Mon, 24 Apr 2017 14:55:37 +0800
Message-ID: <a8c3b869-fc3e-ced2-a85e-8b3fd2ad6d86@huawei.com>
References: <20170422100626.21995-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d2Xuj-0000Ws-8o
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 06:56:01 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d2Xui-0006jr-1W
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 06:56:01 +0000
In-Reply-To: <20170422100626.21995-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/4/22 18:06, Yunlei He wrote:
> This patch seperate nat page read io from nat_tree_lock.
> 
> -lock_page
> 	-get_node_info()
> 		-current_nat_addr
> 
> 			......           	->       write_checkpoint
> 
> 			-get_meta_page
> 
> Because we lock node page, we can make sure no other threads
> modify this nid concurrently. So we just obtain current_nat_addr
> under nat_tree_lock, node info is always same in both nat pack.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/node.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index ad54e90..b99e318 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -376,6 +376,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
>  	struct page *page = NULL;
>  	struct f2fs_nat_entry ne;
>  	struct nat_entry *e;
> +	pgoff_t index;
>  	int i;
>  
>  	ni->nid = nid;
> @@ -401,17 +402,21 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
>  		node_info_from_raw_nat(ni, &ne);
>  	}
>  	up_read(&curseg->journal_rwsem);
> -	if (i >= 0)
> +	if (i >= 0) {
> +		up_read(&nm_i->nat_tree_lock);
>  		goto cache;
> +	}
>  
>  	/* Fill node_info from nat page */
> -	page = get_current_nat_page(sbi, start_nid);
> +	index = current_nat_addr(sbi, nid);
> +	up_read(&nm_i->nat_tree_lock);
> +
> +	page = get_meta_page(sbi, index);
>  	nat_blk = (struct f2fs_nat_block *)page_address(page);
>  	ne = nat_blk->entries[nid - start_nid];
>  	node_info_from_raw_nat(ni, &ne);
>  	f2fs_put_page(page, 1);
>  cache:
> -	up_read(&nm_i->nat_tree_lock);
>  	/* cache nat entry */
>  	down_write(&nm_i->nat_tree_lock);
>  	cache_nat_entry(sbi, nid, &ne);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
